.class Lcom/nagisaland/mobile/OcrService$5;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->setFrame(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field final synthetic val$h:I

.field final synthetic val$w:I

.field final synthetic val$x:I

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;IIII)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 281
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iput p2, p0, Lcom/nagisaland/mobile/OcrService$5;->val$x:I

    iput p3, p0, Lcom/nagisaland/mobile/OcrService$5;->val$y:I

    iput p4, p0, Lcom/nagisaland/mobile/OcrService$5;->val$w:I

    iput p5, p0, Lcom/nagisaland/mobile/OcrService$5;->val$h:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 282
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 283
    :cond_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, p0, Lcom/nagisaland/mobile/OcrService$5;->val$x:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v1, p0, Lcom/nagisaland/mobile/OcrService$5;->val$y:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v1, v1, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v2, 0x42700000    # 60.0f

    mul-float/2addr v1, v2

    float-to-int v1, v1

    iget v2, p0, Lcom/nagisaland/mobile/OcrService$5;->val$w:I

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v1, v1, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v2, 0x42200000    # 40.0f

    mul-float/2addr v1, v2

    float-to-int v1, v1

    iget v2, p0, Lcom/nagisaland/mobile/OcrService$5;->val$h:I

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 284
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v1, v1, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 285
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$5;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->saveFrame()V

    return-void
.end method
