.class Lcom/nagisaland/mobile/OcrBridge$1;
.super Ljava/lang/Object;
.source "OcrBridge.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nagisaland/mobile/OcrBridge;->http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nagisaland/mobile/OcrBridge;

.field final synthetic val$body:Ljava/lang/String;

.field final synthetic val$headers:Ljava/lang/String;

.field final synthetic val$id:Ljava/lang/String;

.field final synthetic val$method:Ljava/lang/String;

.field final synthetic val$url:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/nagisaland/mobile/OcrBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 48
    iput-object p1, p0, Lcom/nagisaland/mobile/OcrBridge$1;->this$0:Lcom/nagisaland/mobile/OcrBridge;

    iput-object p2, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$url:Ljava/lang/String;

    iput-object p3, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$method:Ljava/lang/String;

    iput-object p4, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$headers:Ljava/lang/String;

    iput-object p5, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$body:Ljava/lang/String;

    iput-object p6, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$id:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 49
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 51
    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Ljava/net/URL;

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$url:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;

    .line 52
    const/16 v3, 0x4e20

    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    const v3, 0x15f90

    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 53
    iget-object v3, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$method:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 54
    iget-object v3, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$headers:Ljava/lang/String;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$headers:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 55
    new-instance v3, Lorg/json/JSONObject;

    iget-object v4, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$headers:Ljava/lang/String;

    invoke-direct {v3, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 56
    invoke-virtual {v3}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 57
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 59
    :cond_0
    iget-object v3, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$body:Ljava/lang/String;

    if-eqz v3, :cond_1

    .line 60
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 61
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v3

    iget-object v4, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$body:Ljava/lang/String;

    const-string v5, "UTF-8"

    invoke-virtual {v4, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v3}, Ljava/io/OutputStream;->close()V

    .line 63
    :cond_1
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    .line 64
    const/16 v4, 0x190

    if-lt v3, v4, :cond_2

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    .line 65
    :goto_1
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 66
    if-eqz v2, :cond_4

    const/16 v5, 0x2000

    new-array v5, v5, [B

    :goto_2
    invoke-virtual {v2, v5}, Ljava/io/InputStream;->read([B)I

    move-result v6

    if-lez v6, :cond_3

    invoke-virtual {v4, v5, v1, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_2

    :cond_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 67
    :cond_4
    const-string v2, "status"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v2, "body"

    new-instance v3, Ljava/lang/String;

    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-direct {v3, v4, v5}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 68
    :catch_0
    move-exception v2

    .line 69
    :try_start_1
    const-string v3, "status"

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "error"

    invoke-virtual {v2}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 71
    :catch_1
    :goto_3
    sget-object v1, Lcom/nagisaland/mobile/HttpJob;->RESULTS:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object p0, p0, Lcom/nagisaland/mobile/OcrBridge$1;->val$id:Ljava/lang/String;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, p0, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
