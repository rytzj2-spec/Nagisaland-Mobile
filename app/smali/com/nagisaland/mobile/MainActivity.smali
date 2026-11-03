.class public Lcom/nagisaland/mobile/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# static fields
.field public static final ENGINES:Ljava/util/concurrent/ConcurrentHashMap;

.field public static final GAMES:Ljava/util/concurrent/ConcurrentHashMap;

.field public static final LAUNCHER:Ljava/lang/String; = "https://app.nagisaland.game/index.html"

.field public static final MIME:[Ljava/lang/String;


# instance fields
.field public webView:Landroid/webkit/WebView;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/16 v1, 0x32

    new-array v0, v1, [Ljava/lang/String;

    const/16 v1, 0x0

    const-string v2, ".js"

    aput-object v2, v0, v1

    const/16 v1, 0x1

    const-string v2, "application/javascript"

    aput-object v2, v0, v1

    const/16 v1, 0x2

    const-string v2, ".mjs"

    aput-object v2, v0, v1

    const/16 v1, 0x3

    const-string v2, "application/javascript"

    aput-object v2, v0, v1

    const/16 v1, 0x4

    const-string v2, ".json"

    aput-object v2, v0, v1

    const/16 v1, 0x5

    const-string v2, "application/json"

    aput-object v2, v0, v1

    const/16 v1, 0x6

    const-string v2, ".html"

    aput-object v2, v0, v1

    const/16 v1, 0x7

    const-string v2, "text/html"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, ".htm"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "text/html"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, ".css"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "text/css"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, ".wasm"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "application/wasm"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, ".png"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "image/png"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, ".jpg"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "image/jpeg"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, ".jpeg"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "image/jpeg"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, ".webp"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "image/webp"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, ".gif"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "image/gif"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, ".svg"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "image/svg+xml"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, ".ico"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "image/x-icon"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, ".ogg"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "audio/ogg"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, ".m4a"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "audio/mp4"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, ".mp3"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "audio/mpeg"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, ".wav"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "audio/wav"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, ".webm"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "video/webm"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, ".mp4"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "video/mp4"

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, ".woff2"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "font/woff2"

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    const-string v2, ".woff"

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    const-string v2, "font/woff"

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    const-string v2, ".ttf"

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    const-string v2, "font/ttf"

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    const-string v2, ".otf"

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    const-string v2, "font/otf"

    aput-object v2, v0, v1

    const/16 v1, 0x30

    const-string v2, ".txt"

    aput-object v2, v0, v1

    const/16 v1, 0x31

    const-string v2, "text/plain"

    aput-object v2, v0, v1

    sput-object v0, Lcom/nagisaland/mobile/MainActivity;->MIME:[Ljava/lang/String;

    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/nagisaland/mobile/MainActivity;->GAMES:Ljava/util/concurrent/ConcurrentHashMap;

    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/nagisaland/mobile/MainActivity;->ENGINES:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private hideSystemUi()V
    .locals 2

    invoke-virtual {p0}, Lcom/nagisaland/mobile/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x1706

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    return-void
.end method

.method public static mimeFor(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x0

    sget-object v1, Lcom/nagisaland/mobile/MainActivity;->MIME:[Ljava/lang/String;

    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_1

    aget-object v2, v1, v0

    invoke-virtual {p0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v0, v0, 0x1

    aget-object v2, v1, v0

    return-object v2

    :cond_0
    add-int/lit8 v0, v0, 0x2

    goto :goto_0

    :cond_1
    const-string v2, "application/octet-stream"

    return-object v2
.end method


# virtual methods
.method public goHome()V
    .locals 2

    iget-object v0, p0, Lcom/nagisaland/mobile/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    const/4 v1, -0x1

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/MainActivity;->setRequestedOrientation(I)V

    const-string v1, "https://app.nagisaland.game/index.html"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    invoke-static {p0, p1, p2, p3}, Lcom/nagisaland/mobile/OcrOverlay;->onActivityResult(Landroid/app/Activity;IILandroid/content/Intent;)V

    return-void
.end method

.method public onBackPressed()V
    .locals 3

    iget-object v0, p0, Lcom/nagisaland/mobile/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    const-string v1, "if(window.__galportBack){window.__galportBack()}else{location.href=\'galport://exit\'}"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/nagisaland/mobile/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x480

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    new-instance v0, Landroid/webkit/WebView;

    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/nagisaland/mobile/MainActivity;->webView:Landroid/webkit/WebView;

    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V

    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    const/16 v2, 0x64

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setTextZoom(I)V

    new-instance v1, Lcom/nagisaland/mobile/GameClient;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/GameClient;-><init>(Lcom/nagisaland/mobile/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    new-instance v1, Landroid/webkit/WebChromeClient;

    invoke-direct {v1}, Landroid/webkit/WebChromeClient;-><init>()V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    new-instance v1, Lcom/nagisaland/mobile/Bridge;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/Bridge;-><init>(Lcom/nagisaland/mobile/MainActivity;)V

    const-string v2, "NagisaNative"

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setOverScrollMode(I)V

    invoke-virtual {p0, v0}, Lcom/nagisaland/mobile/MainActivity;->setContentView(Landroid/view/View;)V

    invoke-direct {p0}, Lcom/nagisaland/mobile/MainActivity;->hideSystemUi()V

    const-string v1, "https://app.nagisaland.game/index.html"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    iget-object v0, p0, Lcom/nagisaland/mobile/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method protected onPause()V
    .locals 1

    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    iget-object v0, p0, Lcom/nagisaland/mobile/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/webkit/WebView;->onPause()V

    invoke-virtual {v0}, Landroid/webkit/WebView;->pauseTimers()V

    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 3

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    iget-object v0, p0, Lcom/nagisaland/mobile/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/webkit/WebView;->onResume()V

    invoke-virtual {v0}, Landroid/webkit/WebView;->resumeTimers()V

    const-string v1, "window.__nagisaResume&&window.__nagisaResume()"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_0
    invoke-direct {p0}, Lcom/nagisaland/mobile/MainActivity;->hideSystemUi()V

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/nagisaland/mobile/MainActivity;->hideSystemUi()V

    :cond_0
    return-void
.end method
