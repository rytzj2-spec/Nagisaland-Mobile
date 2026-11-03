.class Lcom/nagisaland/mobile/OcrService$FrameDrag;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/nagisaland/mobile/OcrService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "FrameDrag"
.end annotation


# instance fields
.field h0:I

.field rx:F

.field ry:F

.field size:Z

.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field w0:I

.field x0:I

.field y0:I


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;)V
    .locals 0

    .line 229
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 7

    .line 232
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result p1

    const/4 v0, 0x0

    const/4 v1, 0x1

    packed-switch p1, :pswitch_data_0

    return v1

    .line 238
    :pswitch_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result p1

    iget v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->rx:F

    sub-float/2addr p1, v2

    float-to-int p1, p1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result p2

    iget v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->ry:F

    sub-float/2addr p2, v2

    float-to-int p2, p2

    .line 239
    iget-boolean v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->size:Z

    const/high16 v3, 0x42200000    # 40.0f

    if-eqz v2, :cond_0

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v2, v2, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v4, 0x42700000    # 60.0f

    mul-float/2addr v2, v4

    float-to-int v2, v2

    iget v4, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->w0:I

    add-int/2addr p1, v4

    invoke-static {v2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v0, v0, Lcom/nagisaland/mobile/OcrService;->density:F

    mul-float/2addr v0, v3

    float-to-int v0, v0

    iget v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->h0:I

    add-int/2addr p2, v2

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->height:I

    goto :goto_0

    .line 240
    :cond_0
    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v4, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v4, v4, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->width:I

    neg-int v4, v4

    div-int/lit8 v4, v4, 0x2

    iget-object v5, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v5, v5, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget-object v6, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v6, v6, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v6, v6, Landroid/view/WindowManager$LayoutParams;->width:I

    div-int/lit8 v6, v6, 0x2

    sub-int/2addr v5, v6

    iget v6, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->x0:I

    add-int/2addr p1, v6

    invoke-static {v5, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-static {v4, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v2, v2, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget-object v4, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v4, v4, Lcom/nagisaland/mobile/OcrService;->density:F

    mul-float/2addr v3, v4

    float-to-int v3, v3

    sub-int/2addr v2, v3

    iget v3, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->y0:I

    add-int/2addr p2, v3

    invoke-static {v2, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 241
    :goto_0
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object p2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p2, p2, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {p1, p2, p0}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return v1

    .line 245
    :pswitch_1
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->saveFrame()V

    return v1

    .line 234
    :pswitch_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result p1

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->rx:F

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result p1

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->ry:F

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->x0:I

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->y0:I

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->width:I

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->w0:I

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->height:I

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->h0:I

    .line 235
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    int-to-float v2, v2

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v3, v3, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v4, 0x42600000    # 56.0f

    mul-float/2addr v3, v4

    sub-float/2addr v2, v3

    cmpl-float p1, p1, v2

    if-lez p1, :cond_1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    iget-object p2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p2, p2, Lcom/nagisaland/mobile/OcrService;->fp:Landroid/view/WindowManager$LayoutParams;

    iget p2, p2, Landroid/view/WindowManager$LayoutParams;->height:I

    int-to-float p2, p2

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v2, v2, Lcom/nagisaland/mobile/OcrService;->density:F

    mul-float/2addr v2, v4

    sub-float/2addr p2, v2

    cmpl-float p1, p1, p2

    if-lez p1, :cond_1

    move v0, v1

    :cond_1
    iput-boolean v0, p0, Lcom/nagisaland/mobile/OcrService$FrameDrag;->size:Z

    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
