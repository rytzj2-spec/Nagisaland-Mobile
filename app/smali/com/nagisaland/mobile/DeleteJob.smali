.class public Lcom/nagisaland/mobile/DeleteJob;
.super Ljava/lang/Object;
.source "DeleteJob.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final id:Ljava/lang/String;

.field private final path:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/nagisaland/mobile/DeleteJob;->id:Ljava/lang/String;

    iput-object p2, p0, Lcom/nagisaland/mobile/DeleteJob;->path:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/nagisaland/mobile/DeleteJob;->path:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    :try_start_0
    invoke-static {v0}, Lcom/nagisaland/mobile/Ops;->deleteTree(Ljava/io/File;)I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v2, -0x1

    :goto_0
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lcom/nagisaland/mobile/HttpJob;->RESULTS:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v0, p0, Lcom/nagisaland/mobile/DeleteJob;->id:Ljava/lang/String;

    invoke-virtual {v3, v0, v2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
