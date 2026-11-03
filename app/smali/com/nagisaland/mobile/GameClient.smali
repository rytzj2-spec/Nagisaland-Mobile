.class public Lcom/nagisaland/mobile/GameClient;
.super Landroid/webkit/WebViewClient;
.source "GameClient.java"


# static fields
.field static final CORS:Ljava/util/HashMap;


# instance fields
.field private final activity:Lcom/nagisaland/mobile/MainActivity;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-string v1, "Access-Control-Allow-Origin"

    const-string v2, "*"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sput-object v0, Lcom/nagisaland/mobile/GameClient;->CORS:Ljava/util/HashMap;

    return-void
.end method

.method public constructor <init>(Lcom/nagisaland/mobile/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    iput-object p1, p0, Lcom/nagisaland/mobile/GameClient;->activity:Lcom/nagisaland/mobile/MainActivity;

    return-void
.end method

.method static notFound()Landroid/webkit/WebResourceResponse;
    .locals 7

    new-instance v0, Landroid/webkit/WebResourceResponse;

    const-string v1, "text/plain"

    const-string v2, "UTF-8"

    const/16 v3, 0x194

    const-string v4, "Not Found"

    sget-object v5, Lcom/nagisaland/mobile/GameClient;->CORS:Ljava/util/HashMap;

    const/4 v6, 0x0

    invoke-direct/range {v0 .. v6}, Landroid/webkit/WebResourceResponse;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/util/Map;Ljava/io/InputStream;)V

    return-object v0
.end method

.method public static readAll(Ljava/io/InputStream;)[B
    .locals 4

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v1, 0x2000

    new-array v1, v1, [B

    :goto_0
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-ltz v2, :cond_0

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method asset(Ljava/lang/String;)Landroid/webkit/WebResourceResponse;
    .locals 4

    iget-object v0, p0, Lcom/nagisaland/mobile/GameClient;->activity:Lcom/nagisaland/mobile/MainActivity;

    invoke-virtual {v0}, Lcom/nagisaland/mobile/MainActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    :try_start_0
    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-static {p1}, Lcom/nagisaland/mobile/MainActivity;->mimeFor(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Landroid/webkit/WebResourceResponse;

    const-string v3, "UTF-8"

    invoke-direct {v2, v1, v3, v0}, Landroid/webkit/WebResourceResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V

    sget-object v1, Lcom/nagisaland/mobile/GameClient;->CORS:Ljava/util/HashMap;

    invoke-virtual {v2, v1}, Landroid/webkit/WebResourceResponse;->setResponseHeaders(Ljava/util/Map;)V

    return-object v2

    :catch_0
    invoke-static {}, Lcom/nagisaland/mobile/GameClient;->notFound()Landroid/webkit/WebResourceResponse;

    move-result-object v0

    return-object v0
.end method

.method index(Ljava/io/File;Ljava/lang/String;)Landroid/webkit/WebResourceResponse;
    .locals 9

    invoke-virtual {p0, p1}, Lcom/nagisaland/mobile/GameClient;->openFile(Ljava/io/File;)Ljava/io/InputStream;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/nagisaland/mobile/GameClient;->notFound()Landroid/webkit/WebResourceResponse;

    move-result-object v0

    return-object v0

    :cond_0
    :try_start_0
    invoke-static {v0}, Lcom/nagisaland/mobile/GameClient;->readAll(Ljava/io/InputStream;)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    new-instance v1, Ljava/lang/String;

    const-string v2, "UTF-8"

    invoke-direct {v1, v0, v2}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    sget-object v2, Lcom/nagisaland/mobile/MainActivity;->ENGINES:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2, p2}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_1

    const-string v2, "generic"

    :cond_1
    check-cast v2, Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<script src=\"/__nagisaland/bridge-"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ".js\"></script>\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "<script"

    invoke-virtual {v1, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-gez v4, :cond_2

    const/4 v4, 0x0

    :cond_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v6, 0x0

    invoke-virtual {v1, v6, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "UTF-8"

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v5

    new-instance v6, Ljava/io/ByteArrayInputStream;

    invoke-direct {v6, v5}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    new-instance v7, Landroid/webkit/WebResourceResponse;

    const-string v8, "text/html"

    const-string v5, "UTF-8"

    invoke-direct {v7, v8, v5, v6}, Landroid/webkit/WebResourceResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V

    sget-object v5, Lcom/nagisaland/mobile/GameClient;->CORS:Ljava/util/HashMap;

    invoke-virtual {v7, v5}, Landroid/webkit/WebResourceResponse;->setResponseHeaders(Ljava/util/Map;)V

    return-object v7

    :catch_0
    invoke-static {}, Lcom/nagisaland/mobile/GameClient;->notFound()Landroid/webkit/WebResourceResponse;

    move-result-object v0

    return-object v0
.end method

.method openFile(Ljava/io/File;)Ljava/io/InputStream;
    .locals 3

    iget-object v0, p0, Lcom/nagisaland/mobile/GameClient;->activity:Lcom/nagisaland/mobile/MainActivity;

    invoke-virtual {v0}, Lcom/nagisaland/mobile/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    :try_start_0
    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    const/4 v2, 0x0

    return-object v2
.end method

.method public shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .locals 9

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v2, ".nagisaland.game"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    const/4 v2, 0x0

    return-object v2

    :cond_1
    invoke-virtual {v0}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    :cond_2
    const-string v2, "/index.html"

    :cond_3
    const-string v3, "app.nagisaland.game"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "launcher"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/nagisaland/mobile/GameClient;->asset(Ljava/lang/String;)Landroid/webkit/WebResourceResponse;

    move-result-object v3

    return-object v3

    :cond_4
    const-string v3, "/__nagisaland/"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    const/16 v3, 0xe

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/nagisaland/mobile/GameClient;->asset(Ljava/lang/String;)Landroid/webkit/WebResourceResponse;

    move-result-object v3

    return-object v3

    :cond_5
    sget-object v3, Lcom/nagisaland/mobile/MainActivity;->GAMES:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v3, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_6

    invoke-static {}, Lcom/nagisaland/mobile/GameClient;->notFound()Landroid/webkit/WebResourceResponse;

    move-result-object v3

    return-object v3

    :cond_6
    check-cast v3, Ljava/lang/String;

    new-instance v4, Ljava/io/File;

    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v3, v5}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v5, "/index.html"

    invoke-virtual {v5, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-virtual {p0, v4, v1}, Lcom/nagisaland/mobile/GameClient;->index(Ljava/io/File;Ljava/lang/String;)Landroid/webkit/WebResourceResponse;

    move-result-object v5

    return-object v5

    :cond_7
    invoke-virtual {v4}, Ljava/io/File;->isFile()Z

    move-result v5

    if-nez v5, :cond_8

    invoke-static {}, Lcom/nagisaland/mobile/GameClient;->notFound()Landroid/webkit/WebResourceResponse;

    move-result-object v5

    return-object v5

    :cond_8
    invoke-virtual {p0, v4}, Lcom/nagisaland/mobile/GameClient;->openFile(Ljava/io/File;)Ljava/io/InputStream;

    move-result-object v5

    if-nez v5, :cond_9

    invoke-static {}, Lcom/nagisaland/mobile/GameClient;->notFound()Landroid/webkit/WebResourceResponse;

    move-result-object v5

    return-object v5

    :cond_9
    invoke-static {v2}, Lcom/nagisaland/mobile/MainActivity;->mimeFor(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Landroid/webkit/WebResourceResponse;

    const-string v8, "UTF-8"

    invoke-direct {v7, v6, v8, v5}, Landroid/webkit/WebResourceResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V

    sget-object v6, Lcom/nagisaland/mobile/GameClient;->CORS:Ljava/util/HashMap;

    invoke-virtual {v7, v6}, Landroid/webkit/WebResourceResponse;->setResponseHeaders(Ljava/util/Map;)V

    return-object v7
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Z
    .locals 4

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v1

    const-string v2, "galport"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p1}, Landroid/webkit/WebView;->getUrl()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v2, "//app.nagisaland.game"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/nagisaland/mobile/GameClient;->activity:Lcom/nagisaland/mobile/MainActivity;

    invoke-virtual {v2}, Lcom/nagisaland/mobile/MainActivity;->finishAndRemoveTask()V

    const/4 v2, 0x1

    return v2

    :cond_0
    iget-object v2, p0, Lcom/nagisaland/mobile/GameClient;->activity:Lcom/nagisaland/mobile/MainActivity;

    invoke-virtual {v2}, Lcom/nagisaland/mobile/MainActivity;->goHome()V

    const/4 v2, 0x1

    return v2

    :cond_1
    invoke-virtual {v0}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    const-string v2, ".nagisaland.game"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v2, 0x0

    return v2

    :cond_2
    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v2, v3, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const/high16 v3, 0x10000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    iget-object v3, p0, Lcom/nagisaland/mobile/GameClient;->activity:Lcom/nagisaland/mobile/MainActivity;

    :try_start_0
    invoke-virtual {v3, v2}, Lcom/nagisaland/mobile/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v2, 0x1

    return v2
.end method
