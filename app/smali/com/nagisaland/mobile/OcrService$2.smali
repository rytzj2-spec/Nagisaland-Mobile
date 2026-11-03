.class Lcom/nagisaland/mobile/OcrService$2;
.super Landroid/media/projection/MediaProjection$Callback;
.source "OcrService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->onStartCommand(Landroid/content/Intent;II)I
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

    .line 123
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$2;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {p0}, Landroid/media/projection/MediaProjection$Callback;-><init>()V

    return-void
.end method


# virtual methods
.method public onStop()V
    .locals 2

    .line 124
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$2;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$2$1;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrService$2$1;-><init>(Lcom/nagisaland/mobile/OcrService$2;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
