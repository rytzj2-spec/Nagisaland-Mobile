.class Lcom/nagisaland/mobile/OcrService$8;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->eval(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;

.field final synthetic val$js:Ljava/lang/String;

.field final synthetic val$which:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 307
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$8;->this$0:Lcom/nagisaland/mobile/OcrService;

    iput-object p2, p0, Lcom/nagisaland/mobile/OcrService$8;->val$which:Ljava/lang/String;

    iput-object p3, p0, Lcom/nagisaland/mobile/OcrService$8;->val$js:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 308
    const-string v0, "frame"

    iget-object v1, p0, Lcom/nagisaland/mobile/OcrService$8;->val$which:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$8;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->frame:Landroid/webkit/WebView;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$8;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ctl:Landroid/webkit/WebView;

    .line 309
    :goto_0
    if-eqz v0, :cond_1

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$8;->val$js:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_1
    return-void
.end method
