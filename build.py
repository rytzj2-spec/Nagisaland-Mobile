#!/usr/bin/env python3
"""
构建 Nagisaland 手机版 APK。

需要：Java 11+，tools/apktool.jar，tools/uber-apk-signer.jar
（没有的话会自动从 GitHub 下载这两个 jar）

用法：python build.py [版本号，如 0.2.1] [--lite] [--no-comic]
  ci/、venerax/、NagiBuild/out/ 里有统一版 APK（Nagisaland-v*-arm64-v8a.apk）时直接交给 sign_release.py，下面的合并流程不用了
  emulators/ 里的所有 .apk 会被打包进去（App 里「模拟器」页一键安装）；--lite 不带模拟器
  venerax/ 里的 VeneraX APK 会合并进来（底部「漫画」）；--no-comic 不合并（见 merge_venerax.py）
输出：dist/Nagisaland_v<版本>.apk
签名：nagisaland-mobile.keystore（首次自动生成；以后更新必须用同一个，请备份）
"""
import json, os, re, shutil, subprocess, sys, tempfile, urllib.request, zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
TOOLS = os.path.join(HERE, 'tools')
APP = os.path.join(HERE, 'app')
DIST = os.path.join(HERE, 'dist')
KEYSTORE = os.path.join(HERE, 'nagisaland-mobile.keystore')
def _read_key_props():
    # 签名别名/密码放在 key.properties（已被 .gitignore 排除，不进 Git）
    p = os.path.join(HERE, 'key.properties'); d = {}
    if os.path.exists(p):
        for line in open(p, encoding='utf-8'):
            if '=' in line and not line.lstrip().startswith('#'):
                k, v = line.split('=', 1); d[k.strip()] = v.strip()
    alias = d.get('keyAlias') or os.environ.get('NAGI_KEY_ALIAS')
    pw = d.get('storePassword') or os.environ.get('NAGI_KEY_PASS')
    if not alias or not pw:
        sys.exit('缺少 key.properties（keyAlias / storePassword），或环境变量 NAGI_KEY_ALIAS / NAGI_KEY_PASS')
    return alias, pw
ALIAS, PASS = _read_key_props()
EMUS = os.path.join(HERE, 'emulators')
VENERAX = os.path.join(HERE, 'venerax')   # 放 VeneraX 的 arm64-v8a APK，合并成带「漫画」的版本
sys.path.insert(0, HERE)
import merge_venerax
# 包名/名字 → App 里的模拟器编号（和 assets/launcher/core.js 的 APPS 对应）
KEYS = [('kirikiroid', r'kirikiroid|kirikiri2|吉里吉里'), ('joiplay', r'joiplay'), ('easyrpg', r'easyrpg'), ('onscripter', r'onscripter'),
        ('ppsspp', r'ppsspp'), ('winlator', r'winlator'), ('emuera', r'emuera'), ('qsp', r'quest ?navigator|qsp'), ('mkxp', r'mkxp'),
        ('zarchiver', r'zarchiver')]
JARS = {
    'apktool.jar': 'https://github.com/iBotPeaches/Apktool/releases/download/v3.0.3/apktool_3.0.3.jar',
    'uber-apk-signer.jar': 'https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar',
}


def run(cmd):
    print('>', ' '.join(cmd), flush=True)
    r = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    out = '\n'.join(l for l in r.stdout.splitlines() if not l.startswith('Picked up JAVA_TOOL_OPTIONS'))
    if out.strip():
        print(out)
    if r.returncode:
        sys.exit('失败')


def aapt2():
    """从 apktool.jar 里取出本机能用的 aapt2，用来读模拟器 APK 的包名和版本"""
    plat = 'windows' if os.name == 'nt' else ('macosx' if sys.platform == 'darwin' else 'linux')
    cache = os.path.join(tempfile.gettempdir(), 'nagisaland-build')   # 放临时目录：有的盘不允许直接运行程序
    os.makedirs(cache, exist_ok=True)
    exe = os.path.join(cache, 'aapt2.exe' if os.name == 'nt' else 'aapt2')
    if not os.path.isfile(exe):
        with zipfile.ZipFile(os.path.join(TOOLS, 'apktool.jar')) as z:
            with z.open(f'prebuilt/{plat}/' + os.path.basename(exe)) as src, open(exe, 'wb') as dst:
                shutil.copyfileobj(src, dst)
        os.chmod(exe, 0o755)
    return exe


def emulator_info(apk):
    out = subprocess.run([aapt2(), 'dump', 'badging', apk], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True, encoding='utf-8', errors='replace').stdout
    pkg = re.search(r"package: name='([^']+)'.*?versionName='([^']*)'", out)
    label = re.search(r"application-label(?:-zh-CN|-zh)?:'([^']*)'", out) or re.search(r"application-label:'([^']*)'", out)
    info = {'file': os.path.basename(apk), 'size': os.path.getsize(apk), 'pkg': pkg.group(1) if pkg else '',
            'version': pkg.group(2) if pkg else '', 'label': label.group(1) if label else os.path.basename(apk)}
    hay = (info['pkg'] + ' ' + info['label'] + ' ' + info['file']).lower()
    info['key'] = next((k for k, rx in KEYS if re.search(rx, hay, re.I)), '')
    return info


def main():
    os.makedirs(TOOLS, exist_ok=True)
    for name, url in JARS.items():
        p = os.path.join(TOOLS, name)
        if not os.path.isfile(p):
            print('下载', name)
            urllib.request.urlretrieve(url, p)

    lite = '--lite' in sys.argv
    # 统一版（VeneraX-nagi 一次编出完整 App）：不再反编译合并，只加模拟器 + 正式签名（版本号以 APK 里的为准）
    import sign_release
    unified = None if '--no-comic' in sys.argv else sign_release.find_ci_apk()
    if unified:
        print('找到统一版 APK，交给 sign_release.py（版本号用 APK 自己的，忽略命令行版本号）：' + unified, flush=True)
        sign_release.run(unified, lite)
        return
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    yml = os.path.join(APP, 'apktool.yml')
    s = open(yml, encoding='utf-8').read()
    if args:
        ver = args[0]
        code = int(re.search(r'versionCode: (\d+)', s).group(1)) + 1
        s = re.sub(r'versionCode: \d+', f'versionCode: {code}', s)
        s = re.sub(r'versionName: .+', f'versionName: {ver}', s)
        open(yml, 'w', encoding='utf-8').write(s)
    ver = re.search(r'versionName: (.+)', s).group(1).strip()

    if not os.path.isfile(KEYSTORE):
        print('首次构建：生成签名密钥', KEYSTORE)
        run(['keytool', '-genkeypair', '-keystore', KEYSTORE, '-alias', ALIAS, '-keyalg', 'RSA', '-keysize', '2048',
             '-validity', '36500', '-storepass', PASS, '-keypass', PASS, '-dname', 'CN=Nagisaland'])

    work = tempfile.mkdtemp(prefix='nagisa_')
    try:
        # 工程复制一份再往里放模拟器，源码目录保持干净
        proj = os.path.join(work, 'app')
        shutil.copytree(APP, proj, ignore=shutil.ignore_patterns('build', 'dist'))
        emus = []
        if not lite and os.path.isdir(EMUS):
            dst = os.path.join(proj, 'assets', 'emulators')
            os.makedirs(dst, exist_ok=True)
            for f in sorted(os.listdir(EMUS)):
                if f.lower().endswith('.apk'):
                    shutil.copyfile(os.path.join(EMUS, f), os.path.join(dst, f))
                    emus.append(emulator_info(os.path.join(EMUS, f)))
                    print(f'  内置模拟器：{emus[-1]["label"]} {emus[-1]["version"]}（{emus[-1]["pkg"]}，{emus[-1]["size"] // 1048576} MB）')
        with open(os.path.join(proj, 'assets', 'launcher', 'emulators.json'), 'w', encoding='utf-8') as fh:
            json.dump(emus, fh, ensure_ascii=False, indent=1)
        # 漫画：venerax/ 里有 VeneraX 的 APK 就合并进来（--no-comic 不合并）
        vx_apk = None if '--no-comic' in sys.argv else merge_venerax.find_apk(VENERAX)
        if vx_apk:
            proj = merge_venerax.merge(proj, vx_apk, work, os.path.join(TOOLS, 'apktool.jar'))
        unsigned = os.path.join(work, 'app.apk')
        run(['java', '-jar', os.path.join(TOOLS, 'apktool.jar'), 'b', proj, '-o', unsigned])
        run(['java', '-jar', os.path.join(TOOLS, 'uber-apk-signer.jar'), '-a', unsigned, '-o', work,
             '--ks', KEYSTORE, '--ksAlias', ALIAS, '--ksPass', PASS, '--ksKeyPass', PASS])
        signed = [f for f in os.listdir(work) if f.endswith('-signed.apk')][0]
        os.makedirs(DIST, exist_ok=True)
        out = os.path.join(DIST, f'Nagisaland_v{ver}' + ('_lite' if lite or not emus else '') + '.apk')
        shutil.copyfile(os.path.join(work, signed), out)
        print('完成：', out, os.path.getsize(out), 'bytes')
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    main()
