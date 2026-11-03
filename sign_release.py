#!/usr/bin/env python3
"""
统一版 Nagisaland（VeneraX-nagi 仓库 suite / unify-* 分支一次编出的完整 com.nagisaland.mobile）出正式包。

CI 编出来的 APK 已经是完整 App（主界面 + 漫画 + 番剧 + H），只是：
  - 用的是 CI 的一次性临时密钥签名（装不上覆盖不了手机上的 Nagisaland）
  - 不带内置模拟器（emulators/ 里的 APK 不进 Git）
这个脚本做两件事：把 emulators/*.apk 放进 assets/emulators/ 并生成 assets/launcher/emulators.json，
再用 nagisaland-mobile.keystore 重新签名（uber-apk-signer 会先 zipalign）。

用法：python sign_release.py [CI 的 APK 路径] [--lite]
  不给路径：在 ci/、venerax/、../NagiBuild/out/、../NagiBuild/build/app/outputs/… 里找最新的 Nagisaland-*-arm64-v8a.apk
  --lite：不带模拟器
输出：dist/Nagisaland_v<版本>[_lite].apk（版本号来自 APK 本身，即 VeneraX-nagi 的 android/nagisaland.properties）
需要：Java 11+；key.properties（keyAlias / storePassword）；tools/ 里的 apktool.jar（取 aapt2）和 uber-apk-signer.jar（没有会自动下载）
"""
import json, os, re, shutil, subprocess, sys, tempfile, urllib.request, zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
TOOLS = os.path.join(HERE, 'tools')
DIST = os.path.join(HERE, 'dist')
EMUS = os.path.join(HERE, 'emulators')
KEYSTORE = os.path.join(HERE, 'nagisaland-mobile.keystore')
# CI 下载的放 ci\；本地编译（NagiBuild 里 flutter build apk）的直接从输出目录找
SEARCH = [os.path.join(HERE, 'ci'), os.path.join(HERE, 'venerax'), os.path.join(HERE, '..', 'NagiBuild', 'out'),
          os.path.join(HERE, '..', 'NagiBuild', 'build', 'app', 'outputs', 'apk', 'release'),
          os.path.join(HERE, '..', 'NagiBuild', 'build', 'app', 'outputs', 'flutter-apk')]
JARS = {
    'apktool.jar': 'https://github.com/iBotPeaches/Apktool/releases/download/v3.0.3/apktool_3.0.3.jar',
    'uber-apk-signer.jar': 'https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar',
}
UNIFIED_RX = re.compile(r'^Nagisaland-v?[\d.]+.*arm64-v8a\.apk$', re.I)   # CI：Nagisaland-v0.19.0-…；本地：Nagisaland-0.19.0-arm64-v8a.apk


def is_unified(apk):
    """统一版 APK：主界面网页就在包里（旧的 suite APK 没有，要走 merge_venerax.py）"""
    try:
        with zipfile.ZipFile(apk) as z:
            return 'assets/launcher/index.html' in z.namelist()
    except (OSError, zipfile.BadZipFile):
        return False


def find_ci_apk():
    found = []
    for d in SEARCH:
        if os.path.isdir(d):
            found += [os.path.join(d, f) for f in os.listdir(d) if UNIFIED_RX.match(f)]
    return max(found, key=os.path.getmtime) if found else None


def ensure_tools():
    os.makedirs(TOOLS, exist_ok=True)
    for name, url in JARS.items():
        p = os.path.join(TOOLS, name)
        if not os.path.isfile(p):
            print('下载', name, flush=True)
            urllib.request.urlretrieve(url, p)


def key_props():
    p = os.path.join(HERE, 'key.properties')
    d = {}
    if os.path.exists(p):
        for line in open(p, encoding='utf-8'):
            if '=' in line and not line.lstrip().startswith('#'):
                k, v = line.split('=', 1)
                d[k.strip()] = v.strip()
    alias = d.get('keyAlias') or os.environ.get('NAGI_KEY_ALIAS')
    pw = d.get('storePassword') or os.environ.get('NAGI_KEY_PASS')
    if not alias or not pw:
        sys.exit('缺少 key.properties（keyAlias / storePassword），或环境变量 NAGI_KEY_ALIAS / NAGI_KEY_PASS')
    if not os.path.isfile(KEYSTORE):
        sys.exit('没找到 nagisaland-mobile.keystore（必须用原来那个，不然覆盖安装不了）')
    return alias, pw


def badging(apk):
    import build   # 复用 build.py 的 aapt2 / 模拟器识别
    out = subprocess.run([build.aapt2(), 'dump', 'badging', apk], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
                         text=True, encoding='utf-8', errors='replace').stdout
    m = re.search(r"package: name='([^']+)' versionCode='(\d+)' versionName='([^']*)'", out)
    if not m:
        sys.exit('读不出 APK 的包名 / 版本：' + apk)
    return m.group(1), int(m.group(2)), m.group(3)


def emulator_list(lite):
    if lite or not os.path.isdir(EMUS):
        return []
    import build
    emus = []
    for f in sorted(os.listdir(EMUS)):
        if f.lower().endswith('.apk'):
            info = build.emulator_info(os.path.join(EMUS, f))
            emus.append(info)
            print(f'  内置模拟器：{info["label"]} {info["version"]}（{info["pkg"]}，{info["size"] // 1048576} MB）', flush=True)
    return emus


def repack(src, dst, emus):
    """复制 CI 的 APK：去掉旧签名，换上 emulators.json，加进模拟器 APK（不压缩，安装时直接读）"""
    skip = re.compile(r'^META-INF/(MANIFEST\.MF|[^/]+\.(SF|RSA|DSA|EC))$|^assets/emulators/|^assets/launcher/emulators\.json$')
    with zipfile.ZipFile(src) as zin, zipfile.ZipFile(dst, 'w') as zout:
        for info in zin.infolist():
            if skip.match(info.filename):
                continue
            zout.writestr(info, zin.read(info.filename), compress_type=info.compress_type)
        zout.writestr('assets/launcher/emulators.json', json.dumps(emus, ensure_ascii=False, indent=1), compress_type=zipfile.ZIP_DEFLATED)
        for e in emus:
            zout.write(os.path.join(EMUS, e['file']), 'assets/emulators/' + e['file'], compress_type=zipfile.ZIP_STORED)


def run(apk, lite=False):
    ensure_tools()
    alias, pw = key_props()
    if not is_unified(apk):
        sys.exit('这不是统一版 APK（包里没有 assets/launcher/）：' + apk + '\n旧的 suite APK 请用 build.py（会调用 merge_venerax.py 合并）')
    pkg, code, ver = badging(apk)
    if pkg != 'com.nagisaland.mobile':
        sys.exit(f'包名是 {pkg}，不是 com.nagisaland.mobile')
    print(f'CI 包：{os.path.basename(apk)}（Nagisaland {ver}，versionCode {code}）', flush=True)
    emus = emulator_list(lite)
    work = tempfile.mkdtemp(prefix='nagisign_')
    try:
        unsigned = os.path.join(work, 'app.apk')
        repack(apk, unsigned, emus)
        r = subprocess.run(['java', '-jar', os.path.join(TOOLS, 'uber-apk-signer.jar'), '-a', unsigned, '-o', work,
                            '--allowResign', '--ks', KEYSTORE, '--ksAlias', alias, '--ksPass', pw, '--ksKeyPass', pw],
                           stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='replace')
        print('\n'.join(l for l in r.stdout.splitlines() if not l.startswith('Picked up JAVA_TOOL_OPTIONS')), flush=True)
        signed = [f for f in os.listdir(work) if f.endswith('-signed.apk')]
        if r.returncode or not signed:
            sys.exit('签名失败')
        os.makedirs(DIST, exist_ok=True)
        out = os.path.join(DIST, f'Nagisaland_v{ver}' + ('_lite' if not emus else '') + '.apk')
        shutil.copyfile(os.path.join(work, signed[0]), out)
        print(f'完成：{out}（{os.path.getsize(out) // 1048576} MB）\n拷到手机覆盖安装即可，游戏库、漫画、番剧、H 的数据都不会丢。', flush=True)
        return out
    finally:
        shutil.rmtree(work, ignore_errors=True)


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    apk = args[0] if args else find_ci_apk()
    if not apk:
        sys.exit('没找到 CI 的 APK：把 Actions 里下载的 Nagisaland-v*-arm64-v8a.apk 放进 ci\\ 文件夹，或者把路径传给我')
    run(apk, '--lite' in sys.argv)


if __name__ == '__main__':
    main()
