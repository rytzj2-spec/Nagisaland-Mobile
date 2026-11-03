# 交给云端会话：Nagisaland 手机版重构（2026-11-03 23:20）

先通读本文件和 rytzj2-spec/VeneraX-nagi 仓库 `suite` 分支的 `NAGISALAND.md`，再动手。回答用中文，操作完用简短的话解释干了什么、命令什么意思。

## 现状
- `rytzj2-spec/VeneraX-nagi`
  - `local-v0.17.2`：用户真机验证过的 v0.17.2 原样。
  - `suite`（03c3ad9）：本地 v0.17.2 + 云端修复的合并版（取舍见 NAGISALAND.md 末尾「2026-11-03 合并」）。用户电脑本地已编译通过。
- `rytzj2-spec/Nagisaland-Mobile`（本仓库，`main`）：Nagisaland 主界面 apktool 工程 `app/`（smali + `assets/launcher` 网页启动器 + lib7zz）、`build.py`（打包签名）、`merge_venerax.py`（把 suite APK 反编译拼进来）、`panel.py` / `update_venerax.py`（电脑上的更新面板）。
  - 已修「新手机点去授予权限不跳转」：`Bridge.smali` 的 `requestStorage` 原来 SDK 判断写反了。
- 最新整包：用户电脑 `Nagisaland安卓端\dist\Nagisaland_v0.18.0.apk`（suite 03c3ad9 + 权限修复），**还没真机测**。

## 铁律
- 永远不往 Kyosee/VeneraX、Predidit/Kazumi、Mlr111/Han1meViewer 提交；不要 force push `suite` / `main`，新工作开新分支。
- 包名 `com.nagisaland.mobile`、签名 `nagisaland-mobile.keystore` 不能变；任何密钥（keystore、key.properties、dart_defines.txt、panel_config.json）不进 Git。CI 只用临时密钥，正式签名在用户电脑上做。
- 只自己用，不分发。
- 云端没有真机：改动标「未真机验证」，交给用户在 realme GT8 Pro（Android 17）上测。hanime1 封云端 IP，H 解析只能用手机存的 `内部存储/Nagisaland/debug/h-*.html` 验证。

## 任务 1：统一成用户自己的一个应用
1. 把 Nagisaland 主界面收进 suite 工程（VeneraX-nagi），一次编出完整 `com.nagisaland.mobile`，替代 merge_venerax.py 的反编译拼接。
   - 主界面原生部分只有 smali（Bridge / Ops / Files / HttpJob / OcrService 等，Java 源码丢了）：改写成 Kotlin 放进 app 模块；WebView 启动器网页 `app/assets/launcher/` 直接复用（JS 通过 `window.N` 调 Bridge 的 @JavascriptInterface 方法，接口名保持不变）。
   - 把 merge_venerax.py 合并时做的事搬进源码：provider authority 用包名（`.fileprovider`、`.androidx-startup`、H 的 `.fileProvider`）；Nagisaland 主界面和 KazumiActivity 用 singleTop、去掉 Kazumi 的 taskAffinity；Nagisaland 主界面不调用 `WebView.pauseTimers()`（全局的，会冻结番剧解析）；comic / anime / h 入口（现在 comic/anime/h.json 指向 SuiteSwitchActivity，extra `to`）。
   - 内置模拟器 APK（电脑上 emulators/，不进 Git）和 7-Zip so（lib7zz.so）照旧打包；CI 产物 + 电脑上一个签名脚本出正式包。
2. 统一主题：Nagisaland 深色（背景 #0f0f12、文字 #a1a1aa / #fafaf9、选中渐变 #e879a9→#a78bfa）。漫画、番剧同一个 Flutter 工程共用主题；H 是原生 Views，改它的主题色。底栏以现在的 SuiteNavBar（图标 + 文字，用户真机认可）为准。
3. 不接受上游云端更新（漫画、番剧、H 的检查更新都已关）。写一份上游同步流程说明：拉 Kyosee/VeneraX、Predidit/Kazumi、Mlr111 或 misaka10032w/Han1meViewer，看 diff，挑着合。

## 任务 2：新增「影视」分区（参考 Hills）
- Hills（Emby / Jellyfin / 飞牛影视客户端，底栏：服务器｜聚合视界｜设置）闭源，只参考功能自己写。
- 先做 Emby + Jellyfin（接口基本相同），飞牛影视查到接口再加；播放器复用番剧的 media_kit；用统一主题；接进底栏和 Nagisaland 主界面。
