.class Lcom/nagisaland/mobile/OcrService$2$1;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService$2;->onStop()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/nagisaland/mobile/OcrService$2;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService$2;)V
    .locals 0

    .line 124
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$2$1;->this$1:Lcom/nagisaland/mobile/OcrService$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .line 124
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$2$1;->this$1:Lcom/nagisaland/mobile/OcrService$2;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$2;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->stopSelf()V

    return-void
.end method
