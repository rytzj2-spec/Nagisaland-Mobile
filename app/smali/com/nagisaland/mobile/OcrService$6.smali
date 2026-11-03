.class Lcom/nagisaland/mobile/OcrService$6;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->setTouchable(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field final synthetic val$on:Z


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 290
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iput-boolean p2, p0, Lcom/nagisaland/mobile/OcrService$6;->val$on:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 291
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 292
    :cond_0
    iget-boolean v0, p0, Lcom/nagisaland/mobile/OcrService$6;->val$on:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v1, v1, -0x11

    :goto_0
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v1, v1, 0x10

    goto :goto_0

    .line 293
    :goto_1
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iget-boolean v1, p0, Lcom/nagisaland/mobile/OcrService$6;->val$on:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    new-instance v2, Lcom/nagisaland/mobile/OcrService$FrameDrag;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {v2, v1}, Lcom/nagisaland/mobile/OcrService$FrameDrag;-><init>(Lcom/nagisaland/mobile/OcrService;)V

    :cond_2
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 294
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v1, v1, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$6;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, p0}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
