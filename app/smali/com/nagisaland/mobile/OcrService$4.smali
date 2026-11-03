.class Lcom/nagisaland/mobile/OcrService$4;
.super Landroid/webkit/WebViewClient;
.source "OcrService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->makeWeb(Ljava/lang/String;)Landroid/webkit/WebView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;)V
    .locals 0

    .line 192
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$4;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .locals 2

    .line 194
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object p1

    .line 195
    const-string p2, "app.nagisaland.game"

    invoke-virtual {p1}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    const/4 v0, 0x0

    if-nez p2, :cond_0

    return-object v0

    .line 196
    :cond_0
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p2

    if-nez p2, :cond_1

    const-string p1, ""

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p1

    const-string p2, "^/+"

    const-string v1, ""

    invoke-virtual {p1, p2, v1}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 198
    :goto_0
    :try_start_0
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$4;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "launcher/"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p0

    .line 199
    const-string p2, ".js"

    invoke-virtual {p1, p2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    const-string p1, "application/javascript"

    goto :goto_1

    :cond_2
    const-string p2, ".css"

    invoke-virtual {p1, p2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    const-string p1, "text/css"

    goto :goto_1

    :cond_3
    const-string p2, ".png"

    invoke-virtual {p1, p2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    const-string p1, "image/png"

    goto :goto_1

    :cond_4
    const-string p1, "text/html"

    .line 200
    :goto_1
    new-instance p2, Landroid/webkit/WebResourceResponse;

    const-string v1, "UTF-8"

    invoke-direct {p2, p1, v1, p0}, Landroid/webkit/WebResourceResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V

    move-object v0, p2

    :catch_0
    return-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
.end method
