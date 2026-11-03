#!/usr/bin/env python3
"""
把 VeneraX（漫画阅读器，Flutter）合进 Nagisaland 手机版，做成一个 APK。

做法：以 VeneraX 发布版 APK 反编译出来的工程为底，把 Nagisaland 的 smali / assets / lib / 资源 / manifest 加进去，
包名改成 com.nagisaland.mobile（覆盖安装原来的 Nagisaland，用 Nagisaland 的签名），桌面只有 Nagisaland 一个图标，
Nagisaland 底部「漫画」按钮打开 VeneraX 界面（io.github.kyosee.venera.MainActivity）；
如果是 suite APK（VeneraX + Kazumi 合成版），底部再加「番剧」按钮打开 KazumiActivity。

build.py 会自动调用：venerax/ 里放一个 VeneraX 的 arm64-v8a APK 就会合并；不想带漫画就加 --no-comic。
VeneraX 是 GPL-3.0：合并后的 APK 自己用 / 给朋友用没问题；公开发布的话需要按 GPL 提供对应源码。
"""
import os, re, shutil, subprocess, sys

PKG = 'com.nagisaland.mobile'
VX_PKG = 'io.github.kyosee.venera'
VX_MAIN = VX_PKG + '.MainActivity'


KZ_ACT = VX_PKG + '.kazumi.KazumiActivity'
SWITCH = VX_PKG + '.suite.SuiteSwitchActivity'   # suite 常驻底栏版才有：分区切换不跳转
NAGI_MAIN = PKG + '.MainActivity'
H_ACT = 'com.yenaly.han1meviewer.ui.activity.MainActivity'   # H 分区（Han1meViewer）
SUITE_OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'NagiBuild', 'out')


def _ok(f):
    return f.lower().endswith('.apk') and '勿用' not in f and '缺' not in f


def find_apk(folder):
    """优先用合成版 suite APK（VeneraX + Kazumi，文件名带 NagiSuite），在 venerax/ 和 NagiBuild/out/ 里找最新的；
    没有的话退回原来的单独 VeneraX APK。"""
    suites = []
    for d in (folder, SUITE_OUT):
        if os.path.isdir(d):
            suites += [os.path.join(d, f) for f in os.listdir(d) if _ok(f) and 'nagisuite' in f.lower() and 'arm64' in f.lower()]
    if suites:
        return max(suites, key=os.path.getmtime)
    if not os.path.isdir(folder):
        return None
    apks = sorted(f for f in os.listdir(folder) if _ok(f) and 'venera' in f.lower())
    # 优先自己编译的优化版（文件名带 -nagi-），其次官方 arm64，最后通用包
    pick = ([f for f in apks if '-nagi-' in f.lower() and 'arm64' in f.lower()]
            or [f for f in apks if 'arm64' in f.lower()] or apks)
    return os.path.join(folder, pick[-1]) if pick else None


def _read(p):
    with open(p, encoding='utf-8') as f:
        return f.read()


def _write(p, s):
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


def merge(nagi, vx_apk, work, apktool, log=print):
    """nagi：Nagisaland 工程目录（app/ 的副本）；返回合并后的工程目录"""
    vx = os.path.join(work, 'vx')
    log('反编译 VeneraX：' + os.path.basename(vx_apk))
    r = subprocess.run(['java', '-jar', apktool, 'd', '-f', vx_apk, '-o', vx], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    if r.returncode:
        print(r.stdout)
        sys.exit('VeneraX 反编译失败')
    shutil.rmtree(os.path.join(vx, 'original'), ignore_errors=True)
    shutil.copyfile(os.path.join(vx, 'apktool.yml'), os.path.join(work, 'vx_apktool_orig.yml'))

    # ---------- smali：Nagisaland 单独放一个 dex，避免超 65536 方法 ----------
    n = 2
    while os.path.isdir(os.path.join(vx, f'smali_classes{n}')):
        n += 1
    shutil.copytree(os.path.join(nagi, 'smali'), os.path.join(vx, f'smali_classes{n}'))
    # WebView.pauseTimers() 会暂停整个进程里所有 WebView 的 JS 计时器。Nagisaland 主界面 onPause 时调用它，
    # 合并后切到番剧/漫画/H，它们的后台浏览器（番剧解析视频、漫画验证、H 登录）就全被冻住 → 番剧大量源「视频解析超时」。
    # 合并时去掉这一句（单个 WebView 的 onPause() 保留）。
    ma = os.path.join(vx, f'smali_classes{n}', 'com', 'nagisaland', 'mobile', 'MainActivity.smali')
    t = _read(ma)
    t2 = re.sub(r'\n\s*invoke-virtual \{\w+\}, Landroid/webkit/WebView;->pauseTimers\(\)V', '', t)
    if t2 != t:
        _write(ma, t2)
    log('Nagisaland onPause 不再暂停全局 WebView 计时器（去掉 %d 处 pauseTimers）' % t.count('pauseTimers()V'))

    # ---------- assets / lib ----------
    for name in os.listdir(os.path.join(nagi, 'assets')):
        src, dst = os.path.join(nagi, 'assets', name), os.path.join(vx, 'assets', name)
        if os.path.exists(dst):
            sys.exit('assets 冲突：' + name)
        (shutil.copytree if os.path.isdir(src) else shutil.copyfile)(src, dst)
    vx_abis = set(os.listdir(os.path.join(vx, 'lib'))) if os.path.isdir(os.path.join(vx, 'lib')) else set()
    for abi in os.listdir(os.path.join(nagi, 'lib')):
        if vx_abis and abi not in vx_abis:
            continue   # VeneraX 没这个架构（Flutter 起不来），不带
        for so in os.listdir(os.path.join(nagi, 'lib', abi)):
            os.makedirs(os.path.join(vx, 'lib', abi), exist_ok=True)
            shutil.copyfile(os.path.join(nagi, 'lib', abi, so), os.path.join(vx, 'lib', abi, so))

    # ---------- 资源：改名避免和 VeneraX 的 AppTheme / app_name / ic_launcher 冲突 ----------
    shutil.copyfile(os.path.join(nagi, 'res', 'drawable-xxxhdpi', 'ic_launcher.png'),
                    os.path.join(vx, 'res', 'drawable-xxxhdpi', 'nagisa_launcher.png'))

    def add_values(sub, xml):
        p = os.path.join(vx, 'res', sub, 'nagisa.xml')
        _write(p, '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n' + xml + '</resources>\n')

    add_values('values', '    <string name="nagisa_app_name">Nagisaland</string>\n'
               '    <style name="NagisaTheme" parent="@android:style/Theme.Black.NoTitleBar.Fullscreen">\n'
               '        <item name="android:windowBackground">@android:color/black</item>\n    </style>\n')
    add_values('values-v28', '    <style name="NagisaTheme" parent="@android:style/Theme.Black.NoTitleBar.Fullscreen">\n'
               '        <item name="android:windowBackground">@android:color/black</item>\n'
               '        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>\n    </style>\n')

    # ---------- manifest ----------
    mp = os.path.join(vx, 'AndroidManifest.xml')
    m = _read(mp)
    nm = _read(os.path.join(nagi, 'AndroidManifest.xml'))
    m = m.replace(f'package="{VX_PKG}"', f'package="{PKG}"')
    # authorities / 权限名 / 图标别名 都跟着新包名走（代码里是 getPackageName() 拼出来的）
    # 所有 provider 的 authority（插件代码里都是 getPackageName() + 后缀）
    m = m.replace('android:authorities="' + VX_PKG + '.', 'android:authorities="' + PKG + '.')
    m = m.replace(VX_PKG + '.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION', PKG + '.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION')
    m = re.sub(r'android:name="' + re.escape(VX_PKG) + r'\.(Icon\w+)"', r'android:name="' + PKG + r'.\1"', m)
    # 别名去掉桌面入口，桌面只留 Nagisaland 一个图标
    m = re.sub(r'(<activity-alias[^>]*>)(.*?)(</activity-alias>)',
               lambda mm: mm.group(1) + re.sub(r'\s*<intent-filter>.*?</intent-filter>', '', mm.group(2), flags=re.S) + mm.group(3), m, flags=re.S)
    # VeneraX 界面放进 Nagisaland 的任务栈：返回键回到 Nagisaland
    m = m.replace('android:taskAffinity="" ', '')
    # 番剧（suite APK 才有）：同样放进 Nagisaland 的任务栈，返回键回到 Nagisaland
    has_kz = KZ_ACT in m
    if has_kz:
        m = re.sub(r'(<activity [^>]*android:name="' + re.escape(KZ_ACT) + r'"[^>]*>)',
                   lambda mm: re.sub(r'\s*android:taskAffinity="[^"]*"', '', mm.group(1)), m)
    # 去掉 VeneraX 的「打开 http/https 链接」入口：否则 Nagisaland 打开网盘链接时系统会把自己也列成浏览器
    m = re.sub(r'\s*<intent-filter>\s*<action android:name="android.intent.action.VIEW"/>\s*<category android:name="android.intent.category.DEFAULT"/>\s*'
               r'<category android:name="android.intent.category.BROWSABLE"/>\s*<data android:scheme="http"/>\s*<data android:scheme="https"/>\s*</intent-filter>', '', m, count=1)
    # 权限：补上 Nagisaland 要的
    have = set(re.findall(r'<uses-permission[^>]*android:name="([^"]+)"', m))
    extra = ''
    for perm in re.findall(r'<uses-permission[^>]*android:name="([^"]+)"', nm):
        if perm not in have:
            extra += f'    <uses-permission android:name="{perm}"/>\n'
    m = m.replace('<queries>', extra + '    <queries>', 1)
    # application 属性
    app_tag = re.search(r'<application [^>]*>', m).group(0)
    new_tag = app_tag
    new_tag = re.sub(r'android:icon="[^"]*"', 'android:icon="@drawable/nagisa_launcher"', new_tag)
    new_tag = re.sub(r'android:label="[^"]*"', 'android:label="@string/nagisa_app_name"', new_tag)
    add = ' android:allowBackup="true" android:hardwareAccelerated="true" android:largeHeap="true" android:requestLegacyExternalStorage="true" android:theme="@style/NagisaTheme" android:usesCleartextTraffic="true"'
    add = ''.join(' ' + a for a in add.split() if a.split('=')[0] not in new_tag)   # 已有的属性不重复加
    new_tag = new_tag[:-1] + add + '>'
    m = m.replace(app_tag, new_tag)
    # Nagisaland 的组件原样加进去（主界面 + 识屏服务 + 文件 provider）
    body = re.search(r'<application[^>]*>(.*)</application>', nm, re.S).group(1)
    m = m.replace('</application>', body.rstrip() + '\n    </application>')
    # 常驻底栏版：各分区界面同在一个任务里常驻，切换时提到最前。
    # singleTask 被再次启动时会清掉压在它上面的界面，所以 Nagisaland 主界面和番剧都改成 singleTop
    has_switch = SWITCH in m
    if has_switch:
        for act in (NAGI_MAIN, KZ_ACT):
            m = re.sub(r'(<activity [^>]*android:name="' + re.escape(act) + r'"[^>]*>)',
                       lambda mm: mm.group(1).replace('android:launchMode="singleTask"', 'android:launchMode="singleTop"'), m)
    _write(mp, m)

    # ---------- apktool.yml：版本号用 Nagisaland 的，targetSdk 保持 Nagisaland 的 ----------
    ny, vy = _read(os.path.join(nagi, 'apktool.yml')), os.path.join(vx, 'apktool.yml')
    y = _read(vy)
    for key in ['versionCode', 'versionName', 'targetSdkVersion']:
        y = re.sub(key + r': .+', re.search(key + r': .+', ny).group(0), y)
    y = re.sub(r'apkFileName: .+', 'apkFileName: nagisaland-mobile.apk', y)
    if '- apk\n' not in y:
        y = y.replace('doNotCompress:\n', 'doNotCompress:\n- apk\n', 1)
    _write(vy, y)

    # VeneraX 读到的版本号要是它自己的（不是 Nagisaland 的）：
    # 漫画源的 minAppVersion 检查和「检查更新」都用它。改 package_info_plus 插件里读 versionName 的那一处。
    vx_ver = re.search(r'versionName: (.+)', _read(os.path.join(work, 'vx_apktool_orig.yml'))).group(1).strip().strip("'\"")
    patched = 0
    smali_dirs = [os.path.join(vx, d) for d in os.listdir(vx) if d.startswith('smali') and d != f'smali_classes{n}']
    for root, _, files in (w for d in smali_dirs for w in os.walk(d)):
        for fn in files:
            if not fn.endswith('.smali'):
                continue
            fp = os.path.join(root, fn)
            t = _read(fp)
            if '"buildNumber"' not in t or '"packageName"' not in t or 'PackageInfo;->versionName' not in t:
                continue
            t2 = re.sub(r'(const-string (\w+), "version"\s+(?:\.line \d+\s+)*)iget-object (\w+), \w+, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;',
                        lambda mm: mm.group(1) + f'const-string {mm.group(3)}, "{vx_ver}"', t, count=1)
            if t2 != t:
                _write(fp, t2)
                patched += 1
    log(f'VeneraX 版本号固定为 {vx_ver}（改了 {patched} 处）')
    if patched != 1:
        sys.exit('没找到 package_info_plus 读版本号的位置，VeneraX 版本变化太大，需要手动适配')

    # VeneraX「立即更新」：不直接装独立版 VeneraX（会装成第二个 App），改成弹窗提示去电脑运行「更新漫画.bat」
    hooked = 0
    for root, _, files in (w for d in smali_dirs for w in os.walk(d)):
        for fn in files:
            if not fn.endswith('.smali'):
                continue
            fp = os.path.join(root, fn)
            t = _read(fp)
            if '"installApk"' not in t or 'application/vnd.android.package-archive' not in t:
                continue
            i = t.index('application/vnd.android.package-archive')
            mm = re.compile(r'invoke-virtual \{(\w+), \w+\}, Landroid/content/(?:Context|Activity);->startActivity\(Landroid/content/Intent;\)V').search(t, i)
            if mm:
                t = t[:mm.start()] + 'invoke-static {%s}, Lcom/nagisaland/mobile/ComicUpdate;->notice(Landroid/content/Context;)V' % mm.group(1) + t[mm.end():]
                _write(fp, t)
                hooked += 1
    log(f'VeneraX「立即更新」改为提示（改了 {hooked} 处）')
    if hooked != 1:
        sys.exit('没找到 VeneraX 安装更新包的位置，VeneraX 版本变化太大，需要手动适配')

    # 让启动器知道漫画可用
    src = os.path.basename(vx_apk)
    def entry(cls, to):
        if has_switch:   # 经中转界面切换：不跳转、状态保留
            return {'cls': SWITCH, 'extras': {'to': to}, 'src': src}
        return {'cls': cls, 'src': src}
    import json
    _write(os.path.join(vx, 'assets', 'launcher', 'comic.json'), json.dumps(entry(VX_MAIN, 'comic'), ensure_ascii=False) + '\n')
    if has_kz:
        _write(os.path.join(vx, 'assets', 'launcher', 'anime.json'), json.dumps(entry(KZ_ACT, 'anime'), ensure_ascii=False) + '\n')
    has_h = H_ACT in m and has_switch
    if has_h:
        _write(os.path.join(vx, 'assets', 'launcher', 'h.json'), json.dumps(entry(H_ACT, 'h'), ensure_ascii=False) + '\n')
    log('H（Han1meViewer）：' + ('已合并，底栏显示「H」' if has_h else '这个 APK 里没有，不显示'))
    log('番剧（Kazumi）：' + ('已合并，底栏显示「番剧」' if has_kz else '这个 APK 里没有，不显示'))
    log('分区切换：' + ('常驻底栏（不跳转）' if has_switch else '打开新界面（旧版 suite / VeneraX）'))
    return vx
