.class Lcom/nagisaland/mobile/OcrService$1;
.super Ljava/lang/Object;
.source "OcrService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrService;->onConfigurationChanged(Landroid/content/res/Configuration;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrService;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrService;)V
    .locals 0

    .line 75
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrService$1;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .line 75
    iget-object p0, p0, Lcom/nagisaland/mobile/OcrService$1;->this$0:Lcom/nagisaland/mobile/OcrService;

    invoke-virtual {p0}, Lcom/nagisaland/mobile/OcrService;->reconfig()V

    return-void
.end method
