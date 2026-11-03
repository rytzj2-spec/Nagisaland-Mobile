.class Lcom/nagisaland/mobile/OcrService$9$1;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService$9;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/nagisaland/mobile/OcrService$9;

.field final synthetic val$h:I

.field final synthetic val$w:I

.field final synthetic val$x:I

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService$9;IIII)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 318
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iput p2, p0, Lcom/nagisaland/mobile/OcrService$9$1;->val$x:I

    iput p3, p0, Lcom/nagisaland/mobile/OcrService$9$1;->val$y:I

    iput p4, p0, Lcom/nagisaland/mobile/OcrService$9$1;->val$w:I

    iput p5, p0, Lcom/nagisaland/mobile/OcrService$9$1;->val$h:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 319
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->bg:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$9$1$1;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrService$9$1$1;-><init>(Lcom/nagisaland/mobile/OcrService$9$1;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
