.class public Lcom/nagisaland/mobile/OcrService;
.super Landroid/app/Service;
.source "OcrService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/nagisaland/mobile/OcrService$CtlDrag;,
        Lcom/nagisaland/mobile/OcrService$FrameDrag;
    }
.end annotation


# static fields
.field static volatile running:Z

.field static self:Lcom/nagisaland/mobile/OcrService;


# instance fields
.field bg:Landroid/os/Handler;

.field cp:Landroid/view/WindowManager$LayoutParams;

.field ctl:Landroid/webkit/WebView;

.field density:F

.field dpi:I

.field fp:Landroid/view/WindowManager$LayoutParams;

.field frame:Landroid/webkit/WebView;

.field last:Landroid/media/Image;

.field final lock:Ljava/lang/Object;

.field projection:Landroid/media/projection/MediaProjection;

.field reader:Landroid/media/ImageReader;

.field sh:I

.field sw:I

.field thread:Landroid/os/HandlerThread;

.field ui:Landroid/os/Handler;

.field vdisplay:Landroid/hardware/display/VirtualDisplay;

.field wm:Landroid/view/WindowManager;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 48
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 60
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->lock:Ljava/lang/Object;

    return-void
.end method

.method static synthetic access$000(Lcom/nagisaland/mobile/OcrService;IIIII)Ljava/lang/String;
    .locals 0

    .line 48
    invoke-direct/range {p0 .. p5}, Lcom/nagisaland/mobile/OcrService;->grab(IIIII)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private createWindows()V
    .locals 8

    .line 210
    const-string v0, "frame"

    invoke-direct {p0, v0}, Lcom/nagisaland/mobile/OcrService;->makeWeb(Ljava/lang/String;)Landroid/webkit/WebView;

    move-result-object v0

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    .line 211
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {p0}, Lcom/nagisaland/mobile/OcrService;->overlayType()I

    move-result v4

    const/16 v3, 0x64

    const/16 v5, 0x218

    const/4 v6, -0x3

    move-object v1, v0

    move v2, v3

    invoke-direct/range {v1 .. v6}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    .line 214
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    const/16 v1, 0x33

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 215
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->placeFrame()V

    .line 216
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v2, v3}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 218
    const-string v0, "ctl"

    invoke-direct {p0, v0}, Lcom/nagisaland/mobile/OcrService;->makeWeb(Ljava/lang/String;)Landroid/webkit/WebView;

    move-result-object v0

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    .line 219
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v3, 0x43960000    # 300.0f

    mul-float/2addr v2, v3

    float-to-int v3, v2

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v4, 0x42400000    # 48.0f

    mul-float/2addr v2, v4

    float-to-int v4, v2

    invoke-direct {p0}, Lcom/nagisaland/mobile/OcrService;->overlayType()I

    move-result v5

    const/4 v7, -0x3

    const v6, 0x40208

    move-object v2, v0

    invoke-direct/range {v2 .. v7}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    .line 222
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 223
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->placeCtl()V

    .line 224
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 225
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$CtlDrag;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrService$CtlDrag;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    return-void
.end method

.method private goForeground()V
    .locals 5

    .line 141
    const-string v0, "nl_ocr"

    .line 143
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    .line 144
    const-string v1, "notification"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    .line 145
    new-instance v2, Landroid/app/NotificationChannel;

    const-string v3, "\u8bc6\u5c4f\u7ffb\u8bd1"

    const/4 v4, 0x2

    invoke-direct {v2, v0, v3, v4}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    invoke-virtual {v1, v2}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 146
    new-instance v1, Landroid/app/Notification$Builder;

    invoke-direct {v1, p0, v0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 148
    :cond_0
    new-instance v1, Landroid/app/Notification$Builder;

    invoke-direct {v1, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    .line 150
    :goto_0
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget v0, v0, Landroid/content/pm/ApplicationInfo;->icon:I

    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v0

    const-string v1, "Nagisaland \u8bc6\u5c4f\u7ffb\u8bd1"

    .line 151
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    const-string v1, "\u6b63\u5728\u663e\u793a\u7ffb\u8bd1\u6d6e\u7a97\uff0c\u70b9\u5de5\u5177\u6761\u4e0a\u7684 \u2715 \u5173\u95ed"

    .line 152
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 153
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    .line 154
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x4f43

    const/16 v3, 0x1d

    if-lt v1, v3, :cond_1

    const/16 v1, 0x20

    invoke-virtual {p0, v2, v0, v1}, Lcom/nagisaland/mobile/OcrService;->startForeground(ILandroid/app/Notification;I)V

    return-void

    .line 155
    :cond_1
    invoke-virtual {p0, v2, v0}, Lcom/nagisaland/mobile/OcrService;->startForeground(ILandroid/app/Notification;)V

    return-void
.end method

.method private grab(IIIII)Ljava/lang/String;
    .locals 6

    .line 334
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 335
    :try_start_0
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    if-nez v1, :cond_0

    const-string p0, "!\u8fd8\u6ca1\u6709\u753b\u9762\uff08\u7a0d\u7b49\u4e00\u4e0b\u518d\u8bd5\uff09"

    monitor-exit v0

    return-object p0

    .line 336
    :cond_0
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    invoke-virtual {v1}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v1

    const/4 v2, 0x0

    aget-object v1, v1, v2

    .line 337
    invoke-virtual {v1}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 338
    invoke-virtual {v1}, Landroid/media/Image$Plane;->getPixelStride()I

    move-result v4

    invoke-virtual {v1}, Landroid/media/Image$Plane;->getRowStride()I

    move-result v1

    .line 339
    div-int/2addr v1, v4

    .line 340
    iget-object v4, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    invoke-virtual {v4}, Landroid/media/Image;->getHeight()I

    move-result v4

    sget-object v5, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v4, v5}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 341
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/ByteBuffer;

    .line 342
    invoke-virtual {v1, v3}, Landroid/graphics/Bitmap;->copyPixelsFromBuffer(Ljava/nio/Buffer;)V

    .line 343
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 344
    invoke-static {v2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-static {v2, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 345
    iget p0, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-static {p0, v0}, Ljava/lang/Math;->min(II)I

    move-result p0

    sub-int/2addr p0, p1

    invoke-static {p3, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p3

    sub-int/2addr p3, p2

    invoke-static {p4, p3}, Ljava/lang/Math;->min(II)I

    move-result p3

    .line 346
    if-lez p0, :cond_3

    if-gtz p3, :cond_1

    goto :goto_0

    .line 347
    :cond_1
    invoke-static {v1, p1, p2, p0, p3}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;

    move-result-object p0

    .line 348
    if-lez p5, :cond_2

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p1

    if-le p1, p5, :cond_2

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p1

    mul-int/2addr p1, p5

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p2

    div-int/2addr p1, p2

    const/4 p2, 0x1

    invoke-static {p2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-static {p0, p5, p1, p2}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p0

    .line 349
    :cond_2
    new-instance p1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 350
    sget-object p2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 p3, 0x55

    invoke-virtual {p0, p2, p3, p1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 351
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    const/4 p1, 0x2

    invoke-static {p0, p1}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_3
    :goto_0
    const-string p0, "!\u6846\u5728\u5c4f\u5e55\u5916\u9762"

    return-object p0

    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private makeWeb(Ljava/lang/String;)Landroid/webkit/WebView;
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetJavaScriptEnabled"
        }
    .end annotation

    .line 187
    new-instance v0, Landroid/webkit/WebView;

    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    .line 188
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 189
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    .line 190
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 191
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 192
    new-instance v1, Lcom/nagisaland/mobile/OcrService$4;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrService$4;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 204
    new-instance v1, Lcom/nagisaland/mobile/OcrBridge;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrBridge;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    const-string p0, "Ocr"

    invoke-virtual {v0, v1, p0}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 205
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://app.nagisaland.game/ocr.html?w="

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-object v0
.end method

.method private overlayType()I
    .locals 3

    .line 182
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x7d2

    const/16 v1, 0x7f6

    const/16 v2, 0x1a

    if-lt p0, v2, :cond_0

    return v1

    :cond_0
    move v1, v0

    return v1
.end method

.method private startCapture()V
    .locals 9

    .line 176
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->newReader()V

    .line 177
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->projection:Landroid/media/projection/MediaProjection;

    const-string v1, "nagisaland-ocr"

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget v3, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget v4, p0, Lcom/nagisaland/mobile/OcrService;->dpi:I

    iget-object v5, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    .line 178
    invoke-virtual {v5}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v6

    iget-object v8, p0, Lcom/nagisaland/mobile/OcrService;->bg:Landroid/os/Handler;

    .line 177
    const/16 v5, 0x10

    const/4 v7, 0x0

    invoke-virtual/range {v0 .. v8}, Landroid/media/projection/MediaProjection;->createVirtualDisplay(Ljava/lang/String;IIIILandroid/view/Surface;Landroid/hardware/display/VirtualDisplay$Callback;Landroid/os/Handler;)Landroid/hardware/display/VirtualDisplay;

    move-result-object v0

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->vdisplay:Landroid/hardware/display/VirtualDisplay;

    return-void
.end method


# virtual methods
.method capture(Ljava/lang/String;ZI)V
    .locals 2

    .line 315
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$9;

    invoke-direct {v1, p0, p2, p3, p1}, Lcom/nagisaland/mobile/OcrService$9;-><init>(Lcom/nagisaland/mobile/OcrService;ZILjava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method ctlPos()Ljava/lang/String;
    .locals 2

    .line 305
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget p0, p0, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method eval(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 307
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$8;

    invoke-direct {v1, p0, p1, p2}, Lcom/nagisaland/mobile/OcrService$8;-><init>(Lcom/nagisaland/mobile/OcrService;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method frameRect()Ljava/lang/String;
    .locals 2

    .line 288
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method k(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 68
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget p0, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    if-le v1, p0, :cond_0

    const-string p0, "L"

    goto :goto_0

    :cond_0
    const-string p0, "P"

    :goto_0
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method moveCtl(II)V
    .locals 2

    .line 298
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$7;

    invoke-direct {v1, p0, p1, p2}, Lcom/nagisaland/mobile/OcrService$7;-><init>(Lcom/nagisaland/mobile/OcrService;II)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method newReader()V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "WrongConstant"
        }
    .end annotation

    .line 160
    iget v0, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    const/4 v2, 0x1

    const/4 v3, 0x2

    invoke-static {v0, v1, v2, v3}, Landroid/media/ImageReader;->newInstance(IIII)Landroid/media/ImageReader;

    move-result-object v0

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    .line 161
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$3;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrService$3;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->bg:Landroid/os/Handler;

    invoke-virtual {v0, v1, p0}, Landroid/media/ImageReader;->setOnImageAvailableListener(Landroid/media/ImageReader$OnImageAvailableListener;Landroid/os/Handler;)V

    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p0, 0x0

    return-object p0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 3

    .line 74
    invoke-super {p0, p1}, Landroid/app/Service;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 75
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v0, Lcom/nagisaland/mobile/OcrService$1;

    invoke-direct {v0, p0}, Lcom/nagisaland/mobile/OcrService$1;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    const-wide/16 v1, 0x12c

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 3

    .line 356
    const/4 v0, 0x0

    sput-boolean v0, Lcom/nagisaland/mobile/OcrService;->running:Z

    .line 357
    const/4 v0, 0x0

    sput-object v0, Lcom/nagisaland/mobile/OcrService;->self:Lcom/nagisaland/mobile/OcrService;

    .line 358
    :try_start_0
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    invoke-interface {v1, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->destroy()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 359
    :catch_0
    :cond_0
    :try_start_1
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    invoke-interface {v1, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->destroy()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 360
    :catch_1
    :cond_1
    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    .line 361
    :try_start_2
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->vdisplay:Landroid/hardware/display/VirtualDisplay;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->vdisplay:Landroid/hardware/display/VirtualDisplay;

    invoke-virtual {v1}, Landroid/hardware/display/VirtualDisplay;->release()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 362
    :catch_2
    :cond_2
    :try_start_3
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    .line 363
    :catch_3
    :cond_3
    :try_start_4
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->projection:Landroid/media/projection/MediaProjection;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->projection:Landroid/media/projection/MediaProjection;

    invoke-virtual {v1}, Landroid/media/projection/MediaProjection;->stop()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    .line 364
    :catch_4
    :cond_4
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->lock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_5
    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    invoke-virtual {v2}, Landroid/media/Image;->close()V

    iput-object v0, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    :cond_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 365
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->thread:Landroid/os/HandlerThread;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quitSafely()Z

    .line 366
    :cond_6
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void

    :catchall_0
    move-exception p0

    :try_start_6
    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    throw p0
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    .line 111
    if-eqz p1, :cond_1

    sget-boolean p2, Lcom/nagisaland/mobile/OcrService;->running:Z

    if-eqz p2, :cond_0

    goto/16 :goto_0

    .line 112
    :cond_0
    sput-object p0, Lcom/nagisaland/mobile/OcrService;->self:Lcom/nagisaland/mobile/OcrService;

    .line 113
    new-instance p2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object p3

    invoke-direct {p2, p3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p2, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    .line 114
    invoke-direct {p0}, Lcom/nagisaland/mobile/OcrService;->goForeground()V

    .line 116
    :try_start_0
    const-string p2, "code"

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p2

    .line 117
    const-string p3, "data"

    invoke-virtual {p1, p3}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Landroid/content/Intent;

    .line 118
    const-string p3, "media_projection"

    invoke-virtual {p0, p3}, Lcom/nagisaland/mobile/OcrService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Landroid/media/projection/MediaProjectionManager;

    .line 119
    invoke-virtual {p3, p2, p1}, Landroid/media/projection/MediaProjectionManager;->getMediaProjection(ILandroid/content/Intent;)Landroid/media/projection/MediaProjection;

    move-result-object p1

    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService;->projection:Landroid/media/projection/MediaProjection;

    .line 120
    new-instance p1, Landroid/os/HandlerThread;

    const-string p2, "nl-ocr"

    invoke-direct {p1, p2}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService;->thread:Landroid/os/HandlerThread;

    .line 121
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService;->thread:Landroid/os/HandlerThread;

    invoke-virtual {p1}, Landroid/os/HandlerThread;->start()V

    .line 122
    new-instance p1, Landroid/os/Handler;

    iget-object p2, p0, Lcom/nagisaland/mobile/OcrService;->thread:Landroid/os/HandlerThread;

    invoke-virtual {p2}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService;->bg:Landroid/os/Handler;

    .line 123
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService;->projection:Landroid/media/projection/MediaProjection;

    new-instance p2, Lcom/nagisaland/mobile/OcrService$2;

    invoke-direct {p2, p0}, Lcom/nagisaland/mobile/OcrService$2;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    iget-object p3, p0, Lcom/nagisaland/mobile/OcrService;->bg:Landroid/os/Handler;

    invoke-virtual {p1, p2, p3}, Landroid/media/projection/MediaProjection;->registerCallback(Landroid/media/projection/MediaProjection$Callback;Landroid/os/Handler;)V

    .line 126
    const-string p1, "window"

    invoke-virtual {p0, p1}, Lcom/nagisaland/mobile/OcrService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/WindowManager;

    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    .line 127
    new-instance p1, Landroid/util/DisplayMetrics;

    invoke-direct {p1}, Landroid/util/DisplayMetrics;-><init>()V

    .line 128
    iget-object p2, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    invoke-interface {p2}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    .line 129
    iget p2, p1, Landroid/util/DisplayMetrics;->widthPixels:I

    iput p2, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget p2, p1, Landroid/util/DisplayMetrics;->heightPixels:I

    iput p2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget p2, p1, Landroid/util/DisplayMetrics;->densityDpi:I

    iput p2, p0, Lcom/nagisaland/mobile/OcrService;->dpi:I

    iget p1, p1, Landroid/util/DisplayMetrics;->density:F

    iput p1, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    .line 130
    invoke-direct {p0}, Lcom/nagisaland/mobile/OcrService;->startCapture()V

    .line 131
    invoke-direct {p0}, Lcom/nagisaland/mobile/OcrService;->createWindows()V

    .line 132
    const/4 p1, 0x1

    sput-boolean p1, Lcom/nagisaland/mobile/OcrService;->running:Z

    goto :goto_0

    .line 133
    :catch_0
    move-exception p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 134
    const-string p2, "nl-ocr"

    const-string p3, "start failed"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 135
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->stopSelf()V

    :cond_1
    :goto_0
    const/4 p0, 0x2

    return p0
.end method

.method placeCtl()V
    .locals 6

    .line 102
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 103
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->width:I

    sub-int/2addr v2, v3

    const-string v3, "cx"

    invoke-virtual {p0, v3}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v5, 0x41400000    # 12.0f

    mul-float/2addr v4, v5

    float-to-int v4, v4

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    const/4 v3, 0x0

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 104
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget-object v4, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->height:I

    sub-int/2addr v2, v4

    const-string v4, "cy"

    invoke-virtual {p0, v4}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iget p0, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v5, 0x42a00000    # 80.0f

    mul-float/2addr p0, v5

    float-to-int p0, p0

    invoke-interface {v0, v4, p0}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p0

    invoke-static {v2, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    invoke-static {v3, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    iput p0, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    return-void
.end method

.method placeFrame()V
    .locals 8

    .line 93
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 94
    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-le v1, v2, :cond_0

    goto :goto_0

    :cond_0
    move v4, v3

    .line 96
    :goto_0
    if-eqz v4, :cond_1

    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    int-to-double v1, v1

    const-wide v5, 0x3fe6666666666666L    # 0.7

    :goto_1
    mul-double/2addr v1, v5

    double-to-int v1, v1

    goto :goto_2

    :cond_1
    iget v1, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    int-to-double v1, v1

    const-wide v5, 0x3feccccccccccccdL    # 0.9

    goto :goto_1

    :goto_2
    if-eqz v4, :cond_2

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    int-to-double v4, v2

    const-wide v6, 0x3fd3333333333333L    # 0.3

    :goto_3
    mul-double/2addr v4, v6

    double-to-int v2, v4

    goto :goto_4

    :cond_2
    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    int-to-double v4, v2

    const-wide v6, 0x3fd1eb851eb851ecL    # 0.28

    goto :goto_3

    .line 97
    :goto_4
    iget-object v4, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    const-string v5, "fw"

    invoke-virtual {p0, v5}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    iget v5, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    invoke-static {v1, v5}, Ljava/lang/Math;->min(II)I

    move-result v1

    iput v1, v4, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    const-string v4, "fh"

    invoke-virtual {p0, v4}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v4, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    iget v4, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    invoke-static {v2, v4}, Ljava/lang/Math;->min(II)I

    move-result v2

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 98
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    neg-int v2, v2

    div-int/lit8 v2, v2, 0x2

    iget v4, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget-object v5, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v5, v5, Landroid/view/WindowManager$LayoutParams;->width:I

    div-int/lit8 v5, v5, 0x2

    sub-int/2addr v4, v5

    const-string v5, "fx"

    invoke-virtual {p0, v5}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iget v6, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget-object v7, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v7, v7, Landroid/view/WindowManager$LayoutParams;->width:I

    sub-int/2addr v6, v7

    div-int/lit8 v6, v6, 0x2

    invoke-interface {v0, v5, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v5

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v2, v4}, Ljava/lang/Math;->max(II)I

    move-result v2

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 99
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget v4, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v5, 0x42200000    # 40.0f

    mul-float/2addr v4, v5

    float-to-int v4, v4

    sub-int/2addr v2, v4

    const-string v4, "fy"

    invoke-virtual {p0, v4}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iget v5, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget-object v6, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v6, v6, Landroid/view/WindowManager$LayoutParams;->height:I

    sub-int/2addr v5, v6

    iget p0, p0, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v6, 0x41800000    # 16.0f

    mul-float/2addr p0, v6

    float-to-int p0, p0

    sub-int p0, v5, p0

    invoke-interface {v0, v4, p0}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p0

    invoke-static {v2, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    invoke-static {v3, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    iput p0, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    return-void
.end method

.method prefs()Landroid/content/SharedPreferences;
    .locals 2

    .line 69
    const-string v0, "ocr"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/nagisaland/mobile/OcrService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    return-object p0
.end method

.method reconfig()V
    .locals 5

    .line 78
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->vdisplay:Landroid/hardware/display/VirtualDisplay;

    if-nez v0, :cond_0

    return-void

    .line 79
    :cond_0
    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    .line 80
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    .line 81
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    if-ne v1, v2, :cond_1

    iget v1, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    if-ne v1, v2, :cond_1

    return-void

    .line 82
    :cond_1
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v1, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget v1, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v1, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    iput v0, p0, Lcom/nagisaland/mobile/OcrService;->dpi:I

    .line 83
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    .line 84
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->lock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    invoke-virtual {v2}, Landroid/media/Image;->close()V

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    :cond_2
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 85
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->newReader()V

    .line 86
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->vdisplay:Landroid/hardware/display/VirtualDisplay;

    iget v2, p0, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget v3, p0, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget v4, p0, Lcom/nagisaland/mobile/OcrService;->dpi:I

    invoke-virtual {v1, v2, v3, v4}, Landroid/hardware/display/VirtualDisplay;->resize(III)V

    .line 87
    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->vdisplay:Landroid/hardware/display/VirtualDisplay;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    invoke-virtual {v2}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/hardware/display/VirtualDisplay;->setSurface(Landroid/view/Surface;)V

    .line 88
    :try_start_1
    invoke-virtual {v0}, Landroid/media/ImageReader;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    .line 89
    :catch_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->placeFrame()V

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 90
    :cond_3
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->placeCtl()V

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, p0}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void

    :catchall_0
    move-exception p0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0

    :cond_4
    return-void
.end method

.method saveCtl()V
    .locals 3

    .line 107
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "cx"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "cy"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget p0, p0, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-interface {v0, v1, p0}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method saveFrame()V
    .locals 3

    .line 106
    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "fx"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "fy"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "fw"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "fh"

    invoke-virtual {p0, v1}, Lcom/nagisaland/mobile/OcrService;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget p0, p0, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-interface {v0, v1, p0}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method setFrame(IIII)V
    .locals 8

    .line 281
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v7, Lcom/nagisaland/mobile/OcrService$5;

    move-object v1, v7

    move-object v2, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lcom/nagisaland/mobile/OcrService$5;-><init>(Lcom/nagisaland/mobile/OcrService;IIII)V

    invoke-virtual {v0, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method setTouchable(Z)V
    .locals 2

    .line 290
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$6;

    invoke-direct {v1, p0, p1}, Lcom/nagisaland/mobile/OcrService$6;-><init>(Lcom/nagisaland/mobile/OcrService;Z)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
