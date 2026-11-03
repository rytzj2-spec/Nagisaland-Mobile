.class public Lcom/nagisaland/mobile/HttpJob;
.super Ljava/lang/Object;
.source "HttpJob.java"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field static final RESULTS:Ljava/util/concurrent/ConcurrentHashMap;


# instance fields
.field private final body:Ljava/lang/String;

.field private final headers:Ljava/lang/String;

.field private final id:Ljava/lang/String;

.field private final method:Ljava/lang/String;

.field private final url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/nagisaland/mobile/HttpJob;->RESULTS:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/nagisaland/mobile/HttpJob;->id:Ljava/lang/String;

    iput-object p2, p0, Lcom/nagisaland/mobile/HttpJob;->method:Ljava/lang/String;

    iput-object p3, p0, Lcom/nagisaland/mobile/HttpJob;->url:Ljava/lang/String;

    iput-object p4, p0, Lcom/nagisaland/mobile/HttpJob;->headers:Ljava/lang/String;

    iput-object p5, p0, Lcom/nagisaland/mobile/HttpJob;->body:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/nagisaland/mobile/HttpJob;->method:Ljava/lang/String;

    iget-object v1, p0, Lcom/nagisaland/mobile/HttpJob;->url:Ljava/lang/String;

    iget-object v2, p0, Lcom/nagisaland/mobile/HttpJob;->headers:Ljava/lang/String;

    iget-object v3, p0, Lcom/nagisaland/mobile/HttpJob;->body:Ljava/lang/String;

    :try_start_0
    invoke-static {v0, v1, v2, v3}, Lcom/nagisaland/mobile/Ops;->http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v4

    invoke-static {v4}, Lcom/nagisaland/mobile/Bridge;->errJson(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v4

    :goto_0
    sget-object v5, Lcom/nagisaland/mobile/HttpJob;->RESULTS:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v0, p0, Lcom/nagisaland/mobile/HttpJob;->id:Ljava/lang/String;

    invoke-virtual {v5, v0, v4}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
