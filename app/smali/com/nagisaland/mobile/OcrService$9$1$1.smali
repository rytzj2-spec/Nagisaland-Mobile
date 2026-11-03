.class Lcom/nagisaland/mobile/OcrService$9$1$1;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService$9$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$2:Lcom/nagisaland/mobile/OcrService$9$1;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService$9$1;)V
    .locals 0

    .line 319
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 321
    :try_start_0
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v1, v0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget v2, v0, Lcom/nagisaland/mobile/OcrService$9$1;->val$x:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget v3, v0, Lcom/nagisaland/mobile/OcrService$9$1;->val$y:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget v4, v0, Lcom/nagisaland/mobile/OcrService$9$1;->val$w:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget v5, v0, Lcom/nagisaland/mobile/OcrService$9$1;->val$h:I

    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget v6, v0, Lcom/nagisaland/mobile/OcrService$9;->val$maxW:I

    invoke-static/range {v1 .. v6}, Lcom/nagisaland/mobile/OcrService;->access$000(Lcom/nagisaland/mobile/OcrService;IIIII)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :catch_0
    move-exception v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 322
    :goto_0
    sget-object v1, Lcom/nagisaland/mobile/HttpJob;->RESULTS:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v2, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v2, v2, Lcom/nagisaland/mobile/OcrService$9;->val$id:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 323
    iget-object v0, p0, Lcom/nagisaland/mobile/OcrService$9$1$1;->this$2:Lcom/nagisaland/mobile/OcrService$9$1;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9$1;->this$1:Lcom/nagisaland/mobile/OcrService$9;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService$9;->this$0:Lcom/nagisaland/mobile/OcrService;

    iget-object v0, v0, Lcom/nagisaland/mobile/OcrService;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/nagisaland/mobile/OcrService$9$1$1$1;

    invoke-direct {v1, p0}, Lcom/nagisaland/mobile/OcrService$9$1$1$1;-><init>(Lcom/nagisaland/mobile/OcrService$9$1$1;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
