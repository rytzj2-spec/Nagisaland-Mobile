.class Lcom/nagisaland/mobile/OcrService$7;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->moveCtl(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field final synthetic val$x:I

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 298
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iput p2, p0, Lcom/nagisaland/mobile/OcrService$7;->val$x:I

    iput p3, p0, Lcom/nagisaland/mobile/OcrService$7;->val$y:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 299
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 300
    :cond_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v1, v1, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    sub-int/2addr v1, v2

    iget v2, p0, Lcom/nagisaland/mobile/OcrService$7;->val$x:I

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    const/4 v2, 0x0

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v1, v1, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v3, v3, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    sub-int/2addr v1, v3

    iget v3, p0, Lcom/nagisaland/mobile/OcrService$7;->val$y:I

    invoke-static {v1, v3}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 301
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v1, v1, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 302
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$7;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->saveCtl()V

    return-void
.end method
