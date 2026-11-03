#!/usr/bin/env python3
"""
Nagisaland 漫画更新面板 —— 双击「漫画更新面板.bat」打开（浏览器里的本地网页，只监听 127.0.0.1）。

流程：
  ① 云端合并编译：让私有仓库 rytzj2-spec/VeneraX-nagi 的 Actions 把 Kyosee/VeneraX 最新版合进来
     （保留 Nagisaland 的加载优化）并编译，APK 放到 apk 分支
  ② 下载优化版：从 apk 分支下载 VeneraX-<版本>-nagi-arm64-v8a.apk 到 venerax/（旧的挪到 venerax/旧版/）
  ③ 打包 Nagisaland：运行 build.py（版本号末位 +1），新 APK 在 dist/
  缺 Java 时自动下载便携版 Java 17 到 tools/jre（不用安装）

只用 Python 标准库。设置（GitHub 令牌、代理）存在同目录 panel_config.json，只在本机。
"""
import http.client, json, os, re, shutil, subprocess, sys, threading, time, traceback, urllib.error, urllib.request, webbrowser, zipfile
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HERE = os.path.dirname(os.path.abspath(__file__))
VX = os.path.join(HERE, 'venerax')
DIST = os.path.join(HERE, 'dist')
TOOLS = os.path.join(HERE, 'tools')
JRE_DIR = os.path.join(TOOLS, 'jre')
CFG_FILE = os.path.join(HERE, 'panel_config.json')
REPO = 'rytzj2-spec/VeneraX-nagi'
UPSTREAM = 'Kyosee/VeneraX'
WORKFLOW = 'nagi_offline.yml'
JRE_URL = 'https://api.adoptium.net/v3/binary/latest/17/ga/windows/x64/jre/hotspot/normal/eclipse'

# ---------------------------------------------------------------- 设置 / 日志

def load_cfg():
    try:
        with open(CFG_FILE, encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return {}


def save_cfg(cfg):
    with open(CFG_FILE, 'w', encoding='utf-8') as f:
        json.dump(cfg, f, ensure_ascii=False, indent=1)


CFG = load_cfg()
LOG = []          # [(序号, 文本)]
LOG_LOCK = threading.Lock()
JOB = {'name': None, 'progress': None, 'result': None}


def log(*a):
    text = ' '.join(str(x) for x in a)
    with LOG_LOCK:
        for line in text.splitlines() or ['']:
            LOG.append((len(LOG), line))
        if len(LOG) > 5000:
            del LOG[:1000]
    try:
        print(text, flush=True)
    except Exception:
        pass


def set_progress(p):
    JOB['progress'] = p


class Stop(Exception):
    pass


# ---------------------------------------------------------------- 网络

def opener():
    proxy = (CFG.get('proxy') or '').strip()
    if proxy:
        if '://' not in proxy:
            proxy = 'http://' + proxy
        return urllib.request.build_opener(urllib.request.ProxyHandler({'http': proxy, 'https': proxy}))
    return urllib.request.build_opener()   # 默认读系统代理（Clash 开了系统代理就会走）


def token():
    t = (CFG.get('token') or '').strip()
    if t:
        return t
    try:   # 装了 GitHub CLI 并登录过的话直接借用
        r = subprocess.run(['gh', 'auth', 'token'], capture_output=True, text=True, timeout=10)
        if r.returncode == 0 and r.stdout.strip():
            return r.stdout.strip()
    except Exception:
        pass
    return ''


def gh(path, method='GET', body=None, auth=True, raw=False, timeout=30):
    url = path if path.startswith('http') else 'https://api.github.com' + path
    headers = {'User-Agent': 'nagisaland-panel', 'X-GitHub-Api-Version': '2022-11-28',
               'Accept': 'application/vnd.github.raw' if raw else 'application/vnd.github+json'}
    if auth:
        t = token()
        if not t:
            raise Stop('还没填 GitHub 令牌（页面最下面「设置」里填）')
        headers['Authorization'] = 'Bearer ' + t
    data = None
    if body is not None:
        data = json.dumps(body).encode()
        headers['Content-Type'] = 'application/json'
    # 走代理时偶尔会断一下（SSL EOF / 连接被重置），GET 请求自动重试；POST 不重试，免得重复提交
    tries = 5 if method == 'GET' else 1
    for i in range(tries):
        try:
            return _gh_once(url, data, headers, method, raw, timeout)
        except Retry as e:
            if i == tries - 1:
                raise Stop(f'连不上 GitHub：{e}\n（开着 Clash 的系统代理，或在设置里填代理 127.0.0.1:7897）')
            time.sleep(2 * (i + 1))


class Retry(Exception):
    pass


def _gh_once(url, data, headers, method, raw, timeout):
    req = urllib.request.Request(url, data=data, headers=headers, method=method)
    try:
        resp = opener().open(req, timeout=timeout)
    except urllib.error.HTTPError as e:
        if e.code in (500, 502, 503, 504):
            raise Retry(f'GitHub 暂时出错 {e.code}')
        msg = e.read().decode('utf-8', 'replace')[:300]
        if e.code in (401, 403) and auth:
            raise Stop(f'GitHub 拒绝访问（{e.code}）：令牌无效或权限不够。需要对 VeneraX-nagi 的 Actions 读写 + Contents 只读。\n{msg}')
        if e.code == 404 and auth:
            raise Stop(f'GitHub 返回 404：{url}\n（令牌没有这个私有仓库的权限，或者 apk 分支里还没有东西）')
        raise Stop(f'GitHub 出错 {e.code}：{msg}')
    except urllib.error.URLError as e:
        raise Retry(e.reason)
    except (OSError, http.client.HTTPException) as e:   # ssl.SSLError、ConnectionReset、RemoteDisconnected、超时
        raise Retry(e)
    if raw:
        return resp
    try:
        with resp:
            txt = resp.read().decode('utf-8')
    except (OSError, http.client.HTTPException) as e:
        raise Retry(e)
    return json.loads(txt) if txt.strip() else None


def download(resp, dst, total=None, label='下载'):
    total = total or int(resp.headers.get('Content-Length') or 0)
    part = dst + '.part'
    got, last = 0, 0
    with resp, open(part, 'wb') as f:
        while True:
            b = resp.read(1 << 20)
            if not b:
                break
            f.write(b)
            got += len(b)
            if total:
                set_progress(got / total)
            if time.time() - last > 2:
                last = time.time()
                log(f'  {label} {got / 1048576:.1f}' + (f' / {total / 1048576:.1f} MB' if total else ' MB'))
    if total and got != total:
        os.remove(part)
        raise Stop(f'下载不完整（{got}/{total} 字节），再试一次')
    os.replace(part, dst)
    set_progress(None)
    return got


# ---------------------------------------------------------------- 版本信息

def vtuple(v):
    return tuple(int(x) for x in re.findall(r'\d+', v or '')[:3])


def local_vx():
    """venerax/ 里会被 build.py 选中的 APK"""
    if not os.path.isdir(VX):
        return None
    apks = [f for f in os.listdir(VX) if f.lower().endswith('.apk') and 'venera' in f.lower()]
    nagi = [f for f in apks if '-nagi-' in f.lower() and 'arm64' in f.lower()]
    pick = sorted(nagi or apks, key=lambda f: vtuple(f))[-1:] or [None]
    f = pick[0]
    if not f:
        return None
    m = re.search(r'(\d+\.\d+\.\d+)', f)
    return {'file': f, 'version': m.group(1) if m else '?', 'nagi': '-nagi-' in f.lower(), 'all': sorted(apks)}


def app_version():
    try:
        s = open(os.path.join(HERE, 'app', 'apktool.yml'), encoding='utf-8').read()
        return re.search(r'versionName: (\S+)', s).group(1)
    except Exception:
        return '?'


def latest_dist():
    if not os.path.isdir(DIST):
        return None
    fs = [f for f in os.listdir(DIST) if re.match(r'Nagisaland_v[\d.]+(_lite)?\.apk$', f)]
    if not fs:
        return None
    f = max(fs, key=lambda f: os.path.getmtime(os.path.join(DIST, f)))
    p = os.path.join(DIST, f)
    return {'file': f, 'size': os.path.getsize(p), 'time': time.strftime('%Y-%m-%d %H:%M', time.localtime(os.path.getmtime(p)))}


def java_cmd():
    """能用的 java（11 以上）；返回 (java 可执行文件, 版本) 或 (None, None)"""
    cands = []
    if os.path.isdir(JRE_DIR):
        for d in sorted(os.listdir(JRE_DIR)):
            exe = os.path.join(JRE_DIR, d, 'bin', 'java.exe' if os.name == 'nt' else 'java')
            if os.path.isfile(exe):
                cands.append(exe)
    cands.append('java')
    if os.name == 'nt':
        import glob
        for pat in [r'C:\Program Files\Eclipse Adoptium\*\bin\java.exe', r'C:\Program Files\Java\*\bin\java.exe',
                    r'C:\Program Files\Microsoft\jdk*\bin\java.exe', r'C:\Program Files\Android\Android Studio\jbr\bin\java.exe']:
            cands += sorted(glob.glob(pat), reverse=True)
    for c in cands:
        try:
            r = subprocess.run([c, '-version'], capture_output=True, text=True, timeout=20,
                               creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
        except Exception:
            continue
        m = re.search(r'version "(\d+)(?:\.(\d+))?', r.stderr + r.stdout)
        if r.returncode == 0 and m:
            major = int(m.group(1)) if m.group(1) != '1' else int(m.group(2) or 0)
            if major >= 11:
                return c, major
    return None, None


STATUS_CACHE = {'t': 0, 'remote': {}}


def remote_status(force=False):
    if not force and time.time() - STATUS_CACHE['t'] < 120:
        return STATUS_CACHE['remote']
    out = {}
    try:
        rel = gh(f'/repos/{UPSTREAM}/releases/latest', auth=False, timeout=15)
        out['upstream'] = {'version': rel['tag_name'].lstrip('vV'), 'date': rel['published_at'][:10], 'url': rel['html_url']}
    except Exception as e:
        out['upstream_err'] = str(e).splitlines()[0]
    if token():
        try:
            with gh(f'/repos/{REPO}/contents/nagi-info.json?ref=apk', raw=True, timeout=15) as r:
                out['nagi'] = json.loads(r.read().decode('utf-8'))
        except Exception as e:
            # 老的 apk 分支没有 nagi-info.json，看文件名
            try:
                lst = gh(f'/repos/{REPO}/contents?ref=apk', timeout=15)
                apk = next((x for x in lst if x['name'].endswith('.apk')), None)
                if apk:
                    out['nagi'] = {'file': apk['name'], 'size': apk['size'],
                                   'version': (re.search(r'(\d+\.\d+\.\d+)', apk['name']) or [None, '?'])[1]}
                else:
                    out['nagi_err'] = 'apk 分支里没有 APK'
            except Exception as e2:
                out['nagi_err'] = str(e2).splitlines()[0]
        try:
            runs = gh(f'/repos/{REPO}/actions/workflows/{WORKFLOW}/runs?per_page=1', timeout=15)['workflow_runs']
            if runs:
                r = runs[0]
                out['run'] = {'status': r['status'], 'conclusion': r['conclusion'], 'url': r['html_url'],
                              'title': r['display_title'], 'created': r['created_at'], 'id': r['id']}
        except Exception:
            pass
    else:
        out['nagi_err'] = '没填 GitHub 令牌'
    STATUS_CACHE.update(t=time.time(), remote=out)
    return out


def status(force=False):
    jv, jmaj = java_cmd()
    return {
        'remote': remote_status(force),
        'local': local_vx(),
        'app': app_version(),
        'dist': latest_dist(),
        'java': {'ok': bool(jv), 'version': jmaj, 'portable': bool(jv and jv.startswith(JRE_DIR))},
        'token': bool(token()),
        'proxy': CFG.get('proxy', ''),
        'job': JOB,
    }


# ---------------------------------------------------------------- 各个动作

def _ts(iso):
    import calendar
    return calendar.timegm(time.strptime(iso, '%Y-%m-%dT%H:%M:%SZ'))


def act_cloud(force=False):
    """触发云端合并编译，等它跑完；返回 True 表示 apk 分支有了新 APK"""
    log('▶ 云端合并编译：让 VeneraX-nagi 同步上游最新版并编译')
    t0 = time.time()
    recent = gh(f'/repos/{REPO}/actions/workflows/{WORKFLOW}/runs?per_page=5')['workflow_runs']
    running = [r for r in recent if r['status'] != 'completed']
    if running:
        # 已经有一次在编（比如上次面板断线了但云端还在跑）：接着等它，不重复提交
        run = running[-1]
        log(f'  云端已经有一次编译在进行，直接接着等它：{run["html_url"]}')
        if len(running) > 1:
            log(f'  （还有 {len(running) - 1} 次在排队，可以在 GitHub 上取消多余的）')
        t0 = _ts(run['created_at'])
    else:
        before_id = recent[0]['id'] if recent else 0
        gh(f'/repos/{REPO}/actions/workflows/{WORKFLOW}/dispatches', 'POST',
           {'ref': 'main', 'inputs': {'sync': 'true', 'force': 'true' if force else 'false'}})
        log('  已提交，等 GitHub 排上队…')
        run = None
        for _ in range(40):
            time.sleep(3)
            try:
                runs = gh(f'/repos/{REPO}/actions/workflows/{WORKFLOW}/runs?per_page=5&event=workflow_dispatch')['workflow_runs']
            except Stop:
                continue
            run = next((r for r in runs if r['id'] > before_id), None)
            if run:
                break
        if not run:
            raise Stop('提交了但 2 分钟内没看到新的运行，去 GitHub 的 Actions 页面看看（别急着再点，可能只是 GitHub 慢）')
        log(f'  运行中：{run["html_url"]}')
    last_step = None
    fails = 0
    while True:
        try:
            r = gh(f'/repos/{REPO}/actions/runs/{run["id"]}')
            jobs = gh(f'/repos/{REPO}/actions/runs/{run["id"]}/jobs').get('jobs', [])
            fails = 0
        except Stop as e:
            # 网络断一会儿不要紧，云端照样在编；连续断 10 分钟才放弃
            fails += 1
            if fails == 1:
                log(f'  （网络断了一下，继续等…）')
            if fails >= 40:
                raise Stop(f'{e}\n云端可能还在编，网好了再点一次①会接着等这一次，不会重复提交：{run["html_url"]}')
            time.sleep(15)
            continue
        steps = jobs[0].get('steps', []) if jobs else []
        cur = next((s for s in steps if s['status'] == 'in_progress'), None)
        done = sum(1 for s in steps if s['status'] == 'completed')
        if steps:
            set_progress(done / len(steps))
        name = cur['name'] if cur else None
        if name and name != last_step:
            last_step = name
            log(f'  [{int(time.time() - t0) // 60} 分] {name}')
        if r['status'] == 'completed':
            break
        time.sleep(15)
    set_progress(None)
    STATUS_CACHE['t'] = 0
    skipped = any(s['name'].startswith('Run subosito') and s['conclusion'] == 'skipped' for s in steps) or \
              any(s['name'] == 'Free disk' and s['conclusion'] == 'skipped' for s in steps)
    if r['conclusion'] != 'success':
        bad = next((s['name'] for s in steps if s['conclusion'] == 'failure'), '?')
        hint = '（上游改到了优化涉及的代码，需要手动合并——把这个链接发给 Claude）' if bad == 'Sync upstream' else '（把这个链接发给 Claude 看日志）'
        raise Stop(f'云端失败，出错步骤：{bad}{hint}\n{run["html_url"]}')
    if skipped:
        log('✔ 上游没有新版本，优化版已经是最新的（想强制重编，勾「强制重新编译」）')
        return False
    log(f'✔ 云端编译完成，用时 {int(time.time() - t0) // 60} 分钟')
    return True


def act_download():
    log('▶ 下载优化版 VeneraX')
    STATUS_CACHE['t'] = 0
    info = remote_status(True).get('nagi')
    if not info:
        raise Stop('apk 分支里没找到 APK：' + remote_status().get('nagi_err', ''))
    name = info['file']
    cur = local_vx()
    os.makedirs(VX, exist_ok=True)
    dst = os.path.join(VX, name)
    if os.path.isfile(dst) and (not info.get('size') or os.path.getsize(dst) == info['size']):
        log(f'  本地已经有 {name}，跳过下载')
    else:
        log(f'  {name}（{(info.get("size") or 0) / 1048576:.1f} MB）')
        for i in range(3):
            try:
                resp = gh(f'/repos/{REPO}/contents/{urllib.request.quote(name)}?ref=apk', raw=True, timeout=120)
                download(resp, dst, info.get('size'))
                break
            except (OSError, http.client.HTTPException, Stop) as e:
                if i == 2:
                    raise Stop(f'下载失败：{e}')
                log(f'  下载中断（{e}），重试…')
                time.sleep(3)
    old = os.path.join(VX, '旧版')
    for f in os.listdir(VX):
        if f.lower().endswith('.apk') and f != name:
            os.makedirs(old, exist_ok=True)
            shutil.move(os.path.join(VX, f), os.path.join(old, f))
            log(f'  旧的 {f} → venerax\\旧版\\')
    log(f'✔ venerax\\ 里现在是 {name}' + (f'（原来 {cur["version"]}）' if cur else ''))


def act_java():
    jv, maj = java_cmd()
    if jv:
        log(f'✔ 已有 Java {maj}：{jv}')
        return jv
    if os.name != 'nt':
        raise Stop('没找到 Java 11+，请先安装')
    log('▶ 没找到 Java，下载便携版 Java 17（约 45 MB，放在 tools\\jre，不用安装）')
    os.makedirs(JRE_DIR, exist_ok=True)
    zp = os.path.join(TOOLS, 'jre17.zip')
    for i in range(3):
        try:
            req = urllib.request.Request(JRE_URL, headers={'User-Agent': 'nagisaland-panel'})
            download(opener().open(req, timeout=60), zp, label='Java')
            break
        except (OSError, http.client.HTTPException, Stop) as e:
            if i == 2:
                raise Stop(f'下载 Java 失败：{e}\n（开着 Clash 再试，或自己装 adoptium.net 的 Java 17）')
            log(f'  下载中断（{e}），重试…')
            time.sleep(3)
    log('  解压…')
    with zipfile.ZipFile(zp) as z:
        z.extractall(JRE_DIR)
    os.remove(zp)
    jv, maj = java_cmd()
    if not jv:
        raise Stop('Java 解压了但运行不了，看看 tools\\jre 里的内容')
    log(f'✔ Java {maj} 就绪：{jv}')
    return jv


def act_build(full=False):
    jv = act_java()
    cur = app_version()
    nv = [int(x) for x in re.findall(r'\d+', cur)[:3]]
    nv[2] += 1
    new = '.'.join(map(str, nv))
    vx = local_vx()
    log(f'▶ 打包 Nagisaland {new}（原 {cur}；漫画 {vx["file"] if vx else "无"}；{"完整版带模拟器" if full else "lite"}）这一步要几分钟')
    env = dict(os.environ, PYTHONIOENCODING='utf-8', PYTHONUNBUFFERED='1')
    if jv != 'java':
        env['PATH'] = os.path.dirname(jv) + os.pathsep + env.get('PATH', '')
    args = [sys.executable, '-u', os.path.join(HERE, 'build.py'), new] + ([] if full else ['--lite'])
    p = subprocess.Popen(args, cwd=HERE, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                         creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
    for raw in p.stdout:
        line = raw.decode('utf-8', 'replace').rstrip()
        if line.startswith('Picked up JAVA_TOOL_OPTIONS'):
            continue
        log('  ' + line)
    if p.wait():
        raise Stop('打包失败，看上面的出错信息（可以整段复制给 Claude）')
    name = f'Nagisaland_v{new}' + ('' if full else '_lite') + '.apk'
    log(f'✔ 完成！dist\\{name}\n  拷到手机覆盖安装即可，游戏库和漫画数据都不会丢。')


def act_all(force=False, full=False):
    st = remote_status(True)
    up = st.get('upstream', {}).get('version')
    nagi = st.get('nagi', {}).get('version')
    if up and nagi and vtuple(nagi) >= vtuple(up) and not force:
        log(f'云端优化版已是最新（{nagi}），跳过云端编译')
    else:
        act_cloud(force)
    act_download()
    act_build(full)


ACTIONS = {
    'cloud': lambda o: act_cloud(o.get('force')),
    'download': lambda o: act_download(),
    'java': lambda o: act_java(),
    'build': lambda o: act_build(o.get('full')),
    'all': lambda o: act_all(o.get('force'), o.get('full')),
}
NAMES = {'cloud': '云端合并编译', 'download': '下载优化版', 'java': '准备 Java', 'build': '打包 Nagisaland', 'all': '一键全部'}


def start(name, opts):
    if JOB['name']:
        return False
    JOB.update(name=name, progress=None, result=None)

    def run():
        try:
            ACTIONS[name](opts)
            JOB['result'] = 'ok'
        except Stop as e:
            log('✘ ' + str(e))
            JOB['result'] = 'fail'
        except Exception:
            log('✘ 出错了：\n' + traceback.format_exc())
            JOB['result'] = 'fail'
        finally:
            log('')
            JOB.update(name=None, progress=None)
            STATUS_CACHE['t'] = 0
    threading.Thread(target=run, daemon=True).start()
    return True


def open_folder(sub):
    p = os.path.join(HERE, sub)
    os.makedirs(p, exist_ok=True)
    if os.name == 'nt':
        os.startfile(p)


# ---------------------------------------------------------------- 网页

PAGE = r'''<!doctype html><html lang="zh-CN"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>漫画更新面板</title>
<style>
:root{--bg:#f6f5f2;--card:#fff;--ink:#22201c;--mute:#7a756c;--line:#e6e2da;--acc:#c2185b;--acc2:#fce4ec;--ok:#2e7d32;--warn:#b26a00;--bad:#c62828;--log:#1d1b18;--logink:#e8e4dc}
@media (prefers-color-scheme:dark){:root{--bg:#161513;--card:#201f1c;--ink:#ece8e0;--mute:#9a948a;--line:#34312c;--acc:#f06292;--acc2:#3a2230;--ok:#81c784;--warn:#ffb74d;--bad:#ef5350;--log:#0f0e0d}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--ink);font:14px/1.6 "Microsoft YaHei UI","PingFang SC",system-ui,sans-serif}
main{max-width:920px;margin:0 auto;padding:24px 16px 48px}
h1{font-size:22px;margin:0 0 4px}h1 small{font-size:13px;color:var(--mute);font-weight:400;margin-left:8px}
.sub{color:var(--mute);margin:0 0 20px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:12px;margin-bottom:16px}
.card{background:var(--card);border:1px solid var(--line);border-radius:12px;padding:14px 16px}
.card .k{color:var(--mute);font-size:12px}.card .v{font-size:20px;font-weight:600;margin:2px 0}.card .d{font-size:12px;color:var(--mute);word-break:break-all}
.ok{color:var(--ok)}.warn{color:var(--warn)}.bad{color:var(--bad)}
.flow{display:flex;gap:10px;flex-wrap:wrap;align-items:stretch;margin:8px 0 12px}
button{font:inherit;border:1px solid var(--line);background:var(--card);color:var(--ink);border-radius:10px;padding:10px 16px;cursor:pointer}
button:hover:not(:disabled){border-color:var(--acc)}button:disabled{opacity:.45;cursor:default}
button.main{background:var(--acc);border-color:var(--acc);color:#fff;font-weight:600;padding:12px 22px}
button.step{display:flex;flex-direction:column;align-items:flex-start;min-width:160px;flex:1}
button.step b{font-size:15px}button.step span{font-size:12px;color:var(--mute)}
.opts{display:flex;gap:18px;flex-wrap:wrap;color:var(--mute);margin-bottom:12px}.opts label{cursor:pointer}
.bar{height:6px;background:var(--line);border-radius:3px;overflow:hidden;margin:6px 0 10px;visibility:hidden}.bar i{display:block;height:100%;background:var(--acc);width:0;transition:width .4s}
#job{min-height:22px;font-weight:600}
pre{background:var(--log);color:var(--logink);border-radius:12px;padding:12px 14px;height:340px;overflow:auto;font:12px/1.55 Consolas,"Cascadia Mono",monospace;white-space:pre-wrap;word-break:break-all;margin:0}
details{margin-top:18px}summary{cursor:pointer;color:var(--mute)}
.set{display:grid;gap:10px;margin-top:10px}.set input{width:100%;font:inherit;padding:8px 10px;border:1px solid var(--line);border-radius:8px;background:var(--card);color:var(--ink)}
.set p{margin:0;color:var(--mute);font-size:12px}a{color:var(--acc)}
.links{display:flex;gap:10px;flex-wrap:wrap;margin-top:10px}.links button{padding:6px 12px;font-size:13px}
</style></head><body><main>
<h1>Nagisaland 漫画更新面板<small>VeneraX 优化版</small></h1>
<p class="sub">上游 VeneraX 出新版 → 云端合并加载优化并编译 → 下载 → 打包进 Nagisaland 手机版</p>
<div class="grid">
 <div class="card"><div class="k">官方 VeneraX 最新</div><div class="v" id="up">…</div><div class="d" id="upd"></div></div>
 <div class="card"><div class="k">云端优化版（apk 分支）</div><div class="v" id="ng">…</div><div class="d" id="ngd"></div></div>
 <div class="card"><div class="k">本地 venerax\ 里</div><div class="v" id="lc">…</div><div class="d" id="lcd"></div></div>
 <div class="card"><div class="k">Nagisaland 手机版</div><div class="v" id="ap">…</div><div class="d" id="apd"></div></div>
</div>
<div class="flow">
 <button class="main" data-a="all">一键全部更新</button>
 <button class="step" data-a="cloud"><b>① 云端合并编译</b><span>约 15–20 分钟</span></button>
 <button class="step" data-a="download"><b>② 下载优化版</b><span>到 venerax\</span></button>
 <button class="step" data-a="build"><b>③ 打包 Nagisaland</b><span>新 APK 在 dist\</span></button>
</div>
<div class="opts">
 <label><input type="checkbox" id="force"> 上游没新版也强制重新编译</label>
 <label><input type="checkbox" id="full"> 打包完整版（带模拟器，很大）</label>
 <span id="javast"></span>
</div>
<div id="job"></div><div class="bar" id="bar"><i></i></div>
<pre id="log"></pre>
<div class="links">
 <button onclick="post('/api/open',{dir:'dist'})">打开 dist 文件夹</button>
 <button onclick="post('/api/open',{dir:'venerax'})">打开 venerax 文件夹</button>
 <button onclick="refresh(true)">刷新状态</button>
 <button id="runlink" style="display:none"></button>
</div>
<details id="setd"><summary>设置（GitHub 令牌、代理）</summary>
<div class="set">
 <div><input id="tok" type="password" placeholder="GitHub 令牌（github_pat_… 或 ghp_…），留空不改"></div>
 <p>私有仓库要令牌才能触发编译和下载。到 <a href="https://github.com/settings/personal-access-tokens/new" target="_blank">GitHub → Fine-grained token</a> 新建：Repository access 选 <b>rytzj2-spec/VeneraX-nagi</b>；权限 <b>Actions：Read and write</b>、<b>Contents：Read-only</b>。令牌只存在本机 panel_config.json。</p>
 <div><input id="proxy" placeholder="代理（可空，默认用系统代理）例如 127.0.0.1:7897"></div>
 <div><button onclick="saveSet()">保存设置</button> <span id="setmsg"></span></div>
</div></details>
</main><script>
let since=0,busy=false;
const $=id=>document.getElementById(id);
async function post(u,b){const r=await fetch(u,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(b||{})});return r.json()}
function mb(n){return n?(n/1048576).toFixed(1)+' MB':''}
function cmp(a,b){a=(a||'').match(/\d+/g)||[];b=(b||'').match(/\d+/g)||[];for(let i=0;i<3;i++){const d=(+a[i]||0)-(+b[i]||0);if(d)return d}return 0}
async function refresh(force){
 const s=await (await fetch('/api/status'+(force?'?force=1':''))).json();
 const R=s.remote||{},up=R.upstream,ng=R.nagi,lc=s.local;
 $('up').textContent=up?up.version:'—';$('upd').textContent=up?('发布于 '+up.date):(R.upstream_err||'').slice(0,90);
 $('ng').textContent=ng?ng.version:'—';
 $('ng').className='v '+(ng&&up?(cmp(ng.version,up.version)>=0?'ok':'warn'):'');
 $('ngd').textContent=ng?((ng.date?ng.date.slice(0,10)+' · ':'')+mb(ng.size)+(up&&cmp(ng.version,up.version)<0?' · 落后上游，点①':'')):(R.nagi_err||'').slice(0,90);
 $('lc').textContent=lc?lc.version:'—';
 $('lc').className='v '+(lc&&ng?(cmp(lc.version,ng.version)>=0&&lc.nagi?'ok':'warn'):'');
 $('lcd').textContent=lc?(lc.file+(lc.nagi?'':' · 官方版，没有优化')+(ng&&cmp(lc.version,ng.version)<0?' · 点②':'')):'没有 VeneraX APK';
 $('ap').textContent=s.app;$('apd').textContent=s.dist?('最新包 '+s.dist.file+' · '+s.dist.time):'';
 $('javast').innerHTML=s.java.ok?('<span class="ok">Java '+s.java.version+(s.java.portable?'（便携版）':'')+' ✓</span>'):'<span class="warn">没有 Java——打包时会自动下载便携版</span>';
 if(!s.token)$('setd').open=true;
 $('proxy').placeholder=s.proxy?('当前：'+s.proxy):'代理（可空，默认用系统代理）例如 127.0.0.1:7897';
 if(R.run){const b=$('runlink');b.style.display='';b.textContent='最近一次云端编译：'+({success:'成功',failure:'失败',cancelled:'已取消'}[R.run.conclusion]||'进行中')+' ↗';b.onclick=()=>window.open(R.run.url)}
 setJob(s.job);
}
function setJob(j){
 busy=!!j.name;document.querySelectorAll('button[data-a]').forEach(b=>b.disabled=busy);
 $('job').innerHTML=busy?('正在：'+({cloud:'云端合并编译',download:'下载优化版',java:'准备 Java',build:'打包 Nagisaland',all:'一键全部更新'}[j.name])+' …'):(j.result==='ok'?'<span class="ok">完成 ✓</span>':j.result==='fail'?'<span class="bad">失败，看下面的日志</span>':'');
 const bar=$('bar');bar.style.visibility=busy&&j.progress!=null?'visible':'hidden';bar.firstChild.style.width=((j.progress||0)*100)+'%';
}
async function poll(){
 try{const r=await (await fetch('/api/log?since='+since)).json();
  if(r.lines.length){const el=$('log'),bottom=el.scrollTop+el.clientHeight>=el.scrollHeight-30;el.textContent+=r.lines.join('\n')+'\n';since=r.next;if(bottom)el.scrollTop=el.scrollHeight}
  const was=busy;setJob(r.job);if(was&&!busy)refresh(true);
 }catch(e){$('job').innerHTML='<span class="bad">面板已关闭（重新双击 漫画更新面板.bat）</span>'}
 setTimeout(poll,busy?700:2000);
}
document.querySelectorAll('button[data-a]').forEach(b=>b.onclick=async()=>{
 const r=await post('/api/run',{action:b.dataset.a,force:$('force').checked,full:$('full').checked});
 if(!r.ok)alert(r.msg||'有任务在跑');else{busy=true;setJob({name:b.dataset.a})}
});
async function saveSet(){const r=await post('/api/config',{token:$('tok').value,proxy:$('proxy').value});$('tok').value='';$('setmsg').textContent=r.msg;refresh(true)}
refresh(false);poll();
</script></body></html>'''


class H(BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass

    def send(self, obj, code=200, ctype='application/json; charset=utf-8'):
        data = obj.encode('utf-8') if isinstance(obj, str) else json.dumps(obj, ensure_ascii=False).encode('utf-8')
        self.send_response(code)
        self.send_header('Content-Type', ctype)
        self.send_header('Cache-Control', 'no-store')
        self.end_headers()
        self.wfile.write(data)

    def body(self):
        n = int(self.headers.get('Content-Length') or 0)
        return json.loads(self.rfile.read(n) or b'{}') if n else {}

    def do_GET(self):
        if self.path == '/' or self.path.startswith('/?'):
            return self.send(PAGE, ctype='text/html; charset=utf-8')
        if self.path.startswith('/api/status'):
            return self.send(status('force=1' in self.path))
        if self.path.startswith('/api/log'):
            m = re.search(r'since=(\d+)', self.path)
            since = int(m.group(1)) if m else 0
            with LOG_LOCK:
                lines = [t for i, t in LOG if i >= since]
                nxt = LOG[-1][0] + 1 if LOG else 0
            return self.send({'lines': lines, 'next': nxt, 'job': JOB})
        self.send({'error': 'not found'}, 404)

    def do_POST(self):
        # 只接受本页面发来的请求（防止别的网页跨站调用）
        origin = self.headers.get('Origin') or ''
        if origin and not re.match(r'https?://(127\.0\.0\.1|localhost)(:\d+)?$', origin):
            return self.send({'ok': False, 'msg': 'forbidden'}, 403)
        b = self.body()
        if self.path == '/api/run':
            a = b.get('action')
            if a not in ACTIONS:
                return self.send({'ok': False, 'msg': '未知操作'})
            if not start(a, b):
                return self.send({'ok': False, 'msg': f'「{NAMES.get(JOB["name"], JOB["name"])}」还在进行中'})
            return self.send({'ok': True})
        if self.path == '/api/config':
            if b.get('token', '').strip():
                CFG['token'] = b['token'].strip()
            if 'proxy' in b and (b['proxy'].strip() or CFG.get('proxy')):
                CFG['proxy'] = b['proxy'].strip()
            save_cfg(CFG)
            STATUS_CACHE['t'] = 0
            return self.send({'ok': True, 'msg': '已保存'})
        if self.path == '/api/open':
            d = b.get('dir')
            if d in ('dist', 'venerax'):
                open_folder(d)
            return self.send({'ok': True})
        self.send({'error': 'not found'}, 404)


def main():
    srv = None
    for port in range(28765, 28800):
        try:
            srv = ThreadingHTTPServer(('127.0.0.1', port), H)
            break
        except OSError:
            continue
    if not srv:
        sys.exit('找不到可用端口')
    url = f'http://127.0.0.1:{srv.server_address[1]}/'
    print(f'漫画更新面板：{url}\n（浏览器没自动打开就手动打开这个地址；关掉这个窗口面板就停止）')
    if '--no-browser' not in sys.argv:
        threading.Timer(0.8, lambda: webbrowser.open(url)).start()
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == '__main__':
    main()
