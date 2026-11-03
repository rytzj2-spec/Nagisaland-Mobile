.class Lcom/nagisaland/mobile/OcrService$9;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->capture(Ljava/lang/String;ZI)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field final synthetic val$hide:Z

.field final synthetic val$id:Ljava/lang/String;

.field final synthetic val$maxW:I


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;ZILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 315
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iput-boolean p2, p0, Lcom/nagisaland/mobile/OcrService$9;->val$hide:Z

    iput p3, p0, Lcom/nagisaland/mobile/OcrService$9;->val$maxW:I

    iput-object p4, p0, Lcom/nagisaland/mobile/OcrService$9;->val$id:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .line 316
    iget-boolean v0, p0, Lcom/nagisaland/mobile/OcrService$9;->val$hide:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    const/4 v1, 0x4

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    :cond_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 317
    :cond_1
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v3, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v4, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v5, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v6, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 318
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v7, Lcom/nagisaland/mobile/OcrService$9$1;

    move-object v1, v7

    move-object v2, p0

    invoke-direct/range {v1 .. v6}, Lcom/nagisaland/mobile/OcrService$9$1;-><init>(Lcom/nagisaland/mobile/OcrService$9;IIII)V

    .line 328
    iget-boolean p0, p0, Lcom/nagisaland/mobile/OcrService$9;->val$hide:Z

    const-wide/16 v1, 0xa

    const-wide/16 v3, 0xdc

    if-eqz p0, :cond_2

    goto :goto_0

    :cond_2
    move-wide v3, v1

    .line 318
    :goto_0
    invoke-virtual {v0, v7, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
