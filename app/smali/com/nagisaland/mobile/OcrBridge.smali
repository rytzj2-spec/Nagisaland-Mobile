.class public Lcom/nagisaland/mobile/OcrBridge;
.super Ljava/lang/Object;
.source "OcrBridge.java"


# instance fields
.field private final s:Lcom/nagisaland/mobile/OcrService;


# direct methods
.method public constructor <init>(Lcom/nagisaland/mobile/OcrService;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    return-void
.end method


# virtual methods
.method public capture(Ljava/lang/String;ZI)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 29
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0, p1, p2, p3}, Lcom/nagisaland/mobile/OcrService;->capture(Ljava/lang/String;ZI)V

    return-void
.end method

.method public config()Ljava/lang/String;
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 36
    :try_start_0
    new-instance p0, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    const-string v1, "Nagisaland/translate.json"

    invoke-direct {p0, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 37
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 38
    new-instance p0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 39
    const/16 v1, 0x2000

    new-array v1, v1, [B

    .line 40
    :goto_0
    invoke-virtual {v0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_0

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 41
    :cond_0
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 42
    new-instance v0, Ljava/lang/String;

    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    const-string v1, "UTF-8"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 43
    :catch_0
    const-string v0, ""

    return-object v0
.end method

.method public ctlPos()Ljava/lang/String;
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 23
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->ctlPos()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 48
    new-instance v0, Ljava/lang/Thread;

    new-instance v8, Lcom/nagisaland/mobile/OcrBridge$1;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p3

    move-object v4, p2

    move-object v5, p4

    move-object v6, p5

    move-object v7, p1

    invoke-direct/range {v1 .. v7}, Lcom/nagisaland/mobile/OcrBridge$1;-><init>(Lcom/nagisaland/mobile/OcrBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v0, v8}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 72
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public moveCtl(II)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 26
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0, p1, p2}, Lcom/nagisaland/mobile/OcrService;->moveCtl(II)V

    return-void
.end method

.method public rect()Ljava/lang/String;
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 22
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->frameRect()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public result(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 30
    sget-object p0, Lcom/nagisaland/mobile/HttpJob;->RESULTS:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    return-object p0
.end method

.method public setFrame(IIII)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 24
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/nagisaland/mobile/OcrService;->setFrame(IIII)V

    return-void
.end method

.method public setTouchable(Z)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 25
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0, p1}, Lcom/nagisaland/mobile/OcrService;->setTouchable(Z)V

    return-void
.end method

.method public stop()V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 31
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->stopSelf()V

    return-void
.end method

.method public toCtl(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 28
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    const-string v0, "ctl"

    invoke-virtual {p0, v0, p1}, Lcom/nagisaland/mobile/OcrService;->eval(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public toFrame(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 27
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge;->s:Lcom/nagisaland/mobile/OcrService;

    const-string v0, "frame"

    invoke-virtual {p0, v0, p1}, Lcom/nagisaland/mobile/OcrService;->eval(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public which()Ljava/lang/String;
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 21
    const-string p0, ""

    return-object p0
.end method
