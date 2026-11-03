.class Lcom/nagisaland/mobile/OcrService$3;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Landroid/media/ImageReader$OnImageAvailableListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->newReader()V
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

    .line 161
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$3;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onImageAvailable(Landroid/media/ImageReader;)V
    .locals 3

    .line 164
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/media/ImageReader;->acquireLatestImage()Landroid/media/Image;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object v1, v0

    :goto_0
    if-nez v1, :cond_0

    return-void

    .line 166
    :cond_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$3;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 167
    :try_start_1
    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$3;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService;->reader:Landroid/media/ImageReader;

    if-eq p1, v2, :cond_1

    invoke-virtual {v1}, Landroid/media/Image;->close()V

    monitor-exit v0

    return-void

    .line 168
    :cond_1
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$3;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$3;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    invoke-virtual {p1}, Landroid/media/Image;->close()V

    .line 169
    :cond_2
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$3;->this$0:Lcom/nagisaland/mobile/OcrService;

    iput-object v1, p0, Lcom/nagisaland/mobile/OcrService;->last:Landroid/media/Image;

    .line 170
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method
