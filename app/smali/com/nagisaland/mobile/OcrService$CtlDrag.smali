.class Lcom/nagisaland/mobile/OcrService$CtlDrag;
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
    name = "CtlDrag"
.end annotation


# instance fields
.field drag:Z

.field rx:F

.field ry:F

.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field x0:I

.field y0:I


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;)V
    .locals 0

    .line 253
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 6

    .line 256
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result p1

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    const-string v1, "ctl"

    const-string v2, "window.onOutside&&onOutside()"

    invoke-virtual {v0, v1, v2}, Lcom/nagisaland/mobile/OcrService;->eval(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x1

    packed-switch p1, :pswitch_data_0

    .line 275
    iget-boolean v0, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->drag:Z

    return v0

    .line 263
    :pswitch_0
    iget-boolean p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->drag:Z

    if-nez p1, :cond_1

    return v0

    .line 264
    :cond_1
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v2, v2, Lcom/nagisaland/mobile/OcrService;->sw:I

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v3, v3, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->width:I

    sub-int/2addr v2, v3

    iget v3, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->x0:I

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v4

    iget v5, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->rx:F

    sub-float/2addr v4, v5

    float-to-int v4, v4

    add-int/2addr v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    iput v2, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 265
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v2, v2, Lcom/nagisaland/mobile/OcrService;->sh:I

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v3, v3, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    sub-int/2addr v2, v3

    iget v3, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->y0:I

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result p2

    iget v4, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->ry:F

    sub-float/2addr p2, v4

    float-to-int p2, p2

    add-int/2addr p2, v3

    invoke-static {v2, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 266
    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->wm:Landroid/view/WindowManager;

    iget-object p2, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p2, p2, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {p1, p2, p0}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_1

    .line 270
    :pswitch_1
    iget-boolean p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->drag:Z

    if-nez p1, :cond_2

    return v0

    .line 271
    :cond_2
    iput-boolean v0, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->drag:Z

    .line 272
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->saveCtl()V

    goto :goto_1

    .line 258
    :pswitch_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget v2, v2, Lcom/nagisaland/mobile/OcrService;->density:F

    const/high16 v3, 0x42000000    # 32.0f

    mul-float/2addr v2, v3

    cmpg-float p1, p1, v2

    if-gez p1, :cond_3

    move p1, v1

    goto :goto_0

    :cond_3
    move p1, v0

    :goto_0
    iput-boolean p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->drag:Z

    .line 259
    iget-boolean p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->drag:Z

    if-nez p1, :cond_4

    return v0

    .line 260
    :cond_4
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result p1

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->rx:F

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result p1

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->ry:F

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->x0:I

    iget-object p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object p1, p1, Lcom/nagisaland/mobile/OcrService;->cp:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput p1, p0, Lcom/nagisaland/mobile/OcrService$CtlDrag;->y0:I

    :goto_1
    move v0, v1

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
