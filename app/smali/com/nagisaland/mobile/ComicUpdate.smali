.class public final Lcom/nagisaland/mobile/ComicUpdate;
.super Ljava/lang/Object;
.source "ComicUpdate.java"

# 合并版里 VeneraX「立即更新」不直接安装独立版 VeneraX（那会装成第二个 App），改成提示去电脑上运行「更新漫画.bat」。
# merge_venerax.py 会把 VeneraX 里 installApk 的 startActivity 换成调用这里。

.field static final MSG:Ljava/lang/String; = "漫画部分（VeneraX）是合并在 Nagisaland 里的，不能在手机上直接更新。\n\n请在电脑上双击「Nagisaland安卓端\\更新漫画.bat」，它会下载最新版 VeneraX 并打包出新的 Nagisaland，把 dist 里的 APK 拷到手机覆盖安装即可，数据不会丢。"

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static notice(Landroid/content/Context;)V
    .locals 4

    :try_start_0
    instance-of v0, p0, Landroid/app/Activity;
    if-eqz v0, :cond_toast

    new-instance v0, Landroid/app/AlertDialog$Builder;
    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "有新版 VeneraX"
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    sget-object v1, Lcom/nagisaland/mobile/ComicUpdate;->MSG:Ljava/lang/String;
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const-string v1, "知道了"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :cond_toast

    return-void

    :cond_toast
    :try_start_1
    sget-object v0, Lcom/nagisaland/mobile/ComicUpdate;->MSG:Ljava/lang/String;
    const/4 v1, 0x1
    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
