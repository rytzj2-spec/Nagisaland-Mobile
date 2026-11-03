.class Lcom/nagisaland/mobile/OcrService$9$1$1$1;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService$9$1$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$3:Lcom/nagisaland/mobile/OcrService$9$1$1;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService$9$1$1;)V
    .locals 0

    .line 323
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$9$1$1$1;->this$3:Lcom/nagisaland/mobile/OcrService$9$1$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 324
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1$1;->this$3:Lcom/nagisaland/mobile/OcrService$9$1$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1$1;->this$3:Lcom/nagisaland/mobile/OcrService$9$1$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 325
    :cond_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1$1;->this$3:Lcom/nagisaland/mobile/OcrService$9$1$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    if-eqz v0, :cond_1

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1$1;->this$3:Lcom/nagisaland/mobile/OcrService$9$1$1;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    invoke-virtual {p0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    :cond_1
    return-void
.end method
