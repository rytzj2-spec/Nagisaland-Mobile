#!/usr/bin/env python3
"""
更新 Nagisaland 里的漫画部分（VeneraX）。「更新漫画.bat」调用它。

1. 查 GitHub 上 Kyosee/VeneraX 的最新版本，和 venerax/ 里现有的比
2. 有新版就下载 arm64-v8a 的 APK 到 venerax/（旧的挪到 venerax/旧版/）
3. Nagisaland 版本号末位 +1，调用 build.py 打包（默认 lite，不带模拟器；加 --full 带模拟器）
4. 新 APK 在 dist/，拷到手机覆盖安装，数据不会丢

用法：python update_venerax.py [--force 没新版也重新打包] [--full]
"""
import json, os, re, shutil, subprocess, sys, urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
VX = os.path.join(HERE, 'venerax')
API = 'https://api.github.com/repos/Kyosee/VeneraX/releases/latest'


def ver_tuple(v):
    return tuple(int(x) for x in re.findall(r'\d+', v)[:3])


def local_version():
    best = None
    if os.path.isdir(VX):
        for f in os.listdir(VX):
            m = re.match(r'VeneraX-(\d+\.\d+\.\d+).*arm64-v8a\.apk$', f, re.I)
            if m and (best is None or ver_tuple(m.group(1)) > ver_tuple(best[0])):
                best = (m.group(1), f)
    return best


def fetch(url, **kw):
    req = urllib.request.Request(url, headers={'User-Agent': 'nagisaland-updater', **kw})
    return urllib.request.urlopen(req, timeout=60)


def main():
    force, full = '--force' in sys.argv, '--full' in sys.argv
    print('查询 VeneraX 最新版本…')
    try:
        rel = json.load(fetch(API, Accept='application/vnd.github+json'))
    except Exception as e:
        sys.exit(f'连不上 GitHub：{e}\n（开着 Clash 的系统代理再试一次）')
    latest = rel['tag_name'].lstrip('vV')
    asset = next((a for a in rel.get('assets', []) if a['name'].lower().endswith('.apk') and 'arm64-v8a' in a['name'].lower()), None)
    if not asset:
        sys.exit(f'{latest} 里没找到 arm64-v8a 的 APK')
    cur = local_version()
    print(f'  最新：{latest}    当前：{cur[0] if cur else "无"}')

    if cur and ver_tuple(latest) <= ver_tuple(cur[0]) and not force:
        print('\n已经是最新版，不用更新。（想重新打包就加 --force）')
        return

    if not cur or ver_tuple(latest) > ver_tuple(cur[0]):
        nagi = [f for f in os.listdir(VX) if '-nagi-' in f.lower() and f.lower().endswith('.apk')] if os.path.isdir(VX) else []
        if nagi:
            print(f'\n注意：现在用的是自己编译的优化版（{nagi[0]}）。')
            print(f'官方 {latest} 不包含这些加载优化，换过去后漫画加载会回到原来的速度。')
            print('更好的做法：把优化合进新版源码后再编译一次。')
            if input('仍然换成官方新版？(y/N) ').strip().lower() != 'y':
                print('已取消。')
                return
        os.makedirs(VX, exist_ok=True)
        dst = os.path.join(VX, asset['name'])
        part = dst + '.part'
        print(f'下载 {asset["name"]}（{asset["size"] // 1048576} MB）…')
        with fetch(asset['browser_download_url']) as r, open(part, 'wb') as f:
            got = 0
            while True:
                b = r.read(1 << 20)
                if not b:
                    break
                f.write(b)
                got += len(b)
                print(f'\r  {got // 1048576} / {asset["size"] // 1048576} MB', end='', flush=True)
        print()
        if os.path.getsize(part) != asset['size']:
            os.remove(part)
            sys.exit('下载不完整，再试一次')
        old = os.path.join(VX, '旧版')
        for f in os.listdir(VX):
            if f.lower().endswith('.apk') and f != asset['name']:
                os.makedirs(old, exist_ok=True)
                shutil.move(os.path.join(VX, f), os.path.join(old, f))
        os.replace(part, dst)

    yml = open(os.path.join(HERE, 'app', 'apktool.yml'), encoding='utf-8').read()
    nv = [int(x) for x in re.search(r'versionName: (\d+)\.(\d+)\.(\d+)', yml).groups()]
    nv[2] += 1
    new = '.'.join(map(str, nv))
    print(f'\n打包 Nagisaland {new}（漫画 VeneraX {latest}）…这一步要一两分钟')
    args = [sys.executable, os.path.join(HERE, 'build.py'), new] + ([] if full else ['--lite'])
    r = subprocess.run(args, cwd=HERE)
    if r.returncode:
        sys.exit('打包失败，看上面的出错信息（可以整段发给 Claude）')
    name = f'Nagisaland_v{new}' + ('' if full else '_lite') + '.apk'
    print(f'\n完成！新安装包：{os.path.join(HERE, "dist", name)}')
    print('拷到手机上覆盖安装即可，游戏库和漫画数据都不会丢。')


if __name__ == '__main__':
    main()
