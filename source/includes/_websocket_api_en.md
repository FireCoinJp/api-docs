# Websocket共通

## 概要

WebSocket規格とはTCPに基づいた新しいコンピューターネットワーク用の通信規格である。1つのtcpコネクションでのクライアントとサーバ間の双方向通信を実装しています。サーバ側からクライアントにデータをプッシュ配信できるため、頻繁な認証等のオーバーヘッドを削減できる。主なメリットが2つ挙げられます。

+ 2者間のヘッダデータサイズが約2Byteと非常に小さくなります。

+ サーバ側はクライアント側からの送信要求を受けてからデータを送信するのではなく、クライアントに新しいデータをプッシュ配信できます。

以上のことからWebSocketプロトコルは、暗号資産相場やその取引のようなリアルタイム性が求められる通信の要件を満たすには最適なインターフェースです。

# リクエストとサブスクリプションについて

## 1. アドレス

+ URL : `wss://api-cloud.huobi.co.jp/ws`

## 2. データ圧縮

+ WebSocket API 経由で返されるデータはすべてGZIP圧縮されており、データ受信者側のクライアントにて解凍する必要があります。Pakoを使用することをお勧めします。（[pako](https://github.com/nodeca/pako)  とは圧縮・解凍できるGZIPのリポジトリである）

## 3. WebSocketライブラリ

+ [ws](https://github.com/websockets/ws) のWebSocketライブラリになります。

## 4. ハートビート


> WebSocket Server がpingを送信する

```json
{
    "ping": 18212558000
}
```

> WebSocket Client がpongを返信する

```json
{
    "pong": 18212558000
}
```


> 注："pong"の応答値は"ping" の受信時の値と同一の値となります。

>  WebSocket Client がpingを送信する

```json
{"ping": 18212553000}
```

> 注：必ずLong型の"ping"を送信しなければなりません。そうしなければ、誤ったデータが返信されます

```json
{
  "ts": 1492420473027,
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "invalid ping"
}
```

> WebSocket Server がpongを返信する

```json
{"pong": 18212553000}
```

> 注：返信される"pong" の応答値は受信した"ping"` の値と同一の値となります。
  
>  エラー時の返信フォーマット

```json
{
  "id": "id generate by client",
  "status": "error",
  "err-code": "err-code",
  "err-msg": "err-message",
  "ts": 1487152091345
}
```
> 注：tsは誤ったデータより生成されたタイムスタンプになります。単位：ミリ秒


<aside class="success">
WebSocket API は双方向のハートビートが可能です。 Server または Client のどちらかがping messageを送信することが可能であり、相手よりpong messageが返信されます。
</aside>


WebSocket Client と WebSocket Server との間でコネクション確立後、WebSocket Server は 5s（変更の可能性がある）ごとに WebSocket Client にpingを送信し、WebSocket Client より2回連続Pingへの応答がなければ、WebSocket Server はコネクションを切断します。WebSocket Clientが直近2回のPingのうちの1つのpingに応答すれば、WebSocket Serverはコネクションを維持します。


<img src="/images/pong.png" style="margin:auto; width: 100%">


`注：WebSocket Clientが直近2回のmessageのうちの1つのpingを送信すれば、WebSocket Serverはコネクションを維持します。`

<img src="/images/ping.png" style="margin:auto; width: 100%">


`注：2回連続WebSocket Client からの応答がなければ、WebSocket Server はコネクションを切断します。`
  

## 5. Topicのフォーマット

+ データのサブスクリプションとリクエストともにtopicを使います。topic の構文は以下になります。

| topic タイプ | topic 文法 | sub/req | 説明 |
|----------------|------------------------------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| KLine | market.$symbol.kline.$period | sub/req | チャート データ　单位時間内の始値、終値、最高値、最安値、取引量、取引高、約定回数等のデータを含む $period 選択可能な値：{ 1min, 5min, 15min, 30min, 60min, 4hour,1day, 1mon, 1week, 1year } |
| Market Depth | market.$symbol.depth.$type | sub/req | 板の精度、異なる stepで買いⅠ、買いⅡ、買いⅢ等及び売りⅠ、売りⅡ、売りⅢ等の価格を纏める$type 選択できるstep：{ step0, step1, step2, step3, step4, step5, percent10 } （精度0-5）；step0の場合，異なる価格の注文を纏めない |
| Trade Detail | market.$symbol.trade.detail | sub/req | 取引履歴、約定価格、取引量、買/売等の情報を含む |
| Market Detail | market.$symbol.detail | sub/req | 直近24時間の取引量、取引高、始値、終値、最高値、最安値、約定回数等 |
| Market Tickers | market.tickers | sub | 公開したすべての通貨ペアの1日のチャート、直近24時間の取引量等の情報 |

+ `$symbol` とは通貨ペアのことである。選択可能な值： { ethbtc, ltcbtc, etcbtc, bchbtc...... }
+ ユーザーが「精度」を選ぶと、同じ精度範囲内の注文は纏まって表示される。ただし、表示の仕方に影響が出るのみであり、実際の約定価格に影響しない。

## 6. データリクエスト(req)

> データリクエストのフォーマット

```json
{
  "req": "topic to req",
  "id": "id generate by client"
}
```



> データリクエストの正しい例

```json
{
  "req": "market.ethbtc.kline.1min",
  "id": "id10"
}
```

> 返信データ例

```json
{
  "status": "ok",
  "rep": "market.btcusdt.kline.1min",
  "tick": [
    {
      "amount": 1.6206,
      "count":  3,
      "id":     1494465840,
      "open":   9887.00,
      "close":  9885.00,
      "low":    9885.00,
      "high":   9887.00,
      "vol":    16021.632026
    },
    {
      "amount": 2.2124,
      "count":  6,
      "id":     1494465900,
      "open":   9885.00,
      "close":  9880.00,
      "low":    9880.00,
      "high":   9885.00,
      "vol":    21859.023500
    }
  ]
}
```

>  データリクエストのエラー例

```json
{
  "req": "market.invalidsymbo.kline.1min",
  "id": "id10"
}
```

> エラーメッセージ応答例

```json
{
  "status": "error",
  "id": "id10",
  "err-code": "bad-request",
  "err-msg": "invalid topic market.invalidsymbol.trade.detail",
  "ts": 1494483996521
}
```

<aside class="success">
"req" の値はtopic である。「5. Topicのフォーマット」のtopicフォーマットに参照してください。
</aside>

## 7.データのサブスクリプション(sub)


> + データのサブスクリプションのフォーマット

> WebSocket API とのコネクションを行った後、 Serverに以下のフォーマットのデータを送信することにより、データを購読する

```json
{
  "id": "id generate by client",
  "sub": "topic to sub",
  "freq-ms": 1000
}
```

> 注：idのパラメータは選択可能です
> 注：freq-msのパラメータは選択可能であり、選択値は{ 1000, 2000, 3000, 4000, 5000 }になります。freq-ms をアップロードしない限り、デフォルト値を0はとなり、データが更新された際、直ちにClientにプッシュ配信されることになります。 Server のプッシュ配信の頻度はfreq-msにて調整できます。

> サブスクリプションの正しい例

```json
{
  "sub": "market.btcusdt.kline.1min",
  "id": "id1"
}
```

> "sub"の値はtopicであり、「5. Topicのフォーマット」の**topic のフォーマット**参照

> + サブスクリプション完了後、データを返信された例

```json
{
  "id": "id1",
  "status": "ok",
  "subbed": "market.btcusdt.kline.1min",
  "ts": 1489474081631
}
```
> その後、 KLineが更新されるごとに、clientはデータを受信する

```json
{
  "ch": "market.btcusdt.kline.1min",
  "ts": 1489474082831,
  "tick": {
    "id": 1489464480,
    "amount": 0.0,
    "count": 0,
    "open": 7962.62,
    "close": 7962.62,
    "low": 7962.62,
    "high": 7962.62,
    "vol": 0.0
  }
}
```



+ データのサブスクリプション(sub)及びサブスクリプションデータ受信の流れ
 

<img src="/images/sub.png" style="margin:auto; width: 100%">

`注： topic のサブスクリプション完了後、 topicのデータが更新された際、 Server は一定の頻度でtopicの更新データを Clientにプッシュ配信する`



> + tick の説明

```json

{
  "tick": {
    "id": "チャートid",
    "amount": "取引量",
    "count": "約定回数",
    "open": "始値",
    "close": "終値 最後の一本のKラインは最新の約定価格である",
    "low": "最安値",
    "high": "最高値",
    "vol": "取引高, 取引価格*約定の量＝取引量合計"
  }
}
```

> + 誤ったサブスクリプション（誤った symbol）

```json
{
  "sub": "market.invalidsymbol.kline.1min",
  "id": "id2"
}
```

> サブスクリプションが失敗した場合、データが返送された例：
  
```json
{
  "id": "id2",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "invalid topic market.invalidsymbol.kline.1min",
  "ts": 1494301904959
}
```

> + 誤ったサブスクリプション（間違った topic）：

```json
{
  "sub": "market.btcusdt.kline.3min",
  "id": "id3"
}
```

> サブスクリプションが失敗した場合、データが返信された例：

```json
{
  "id": "id3",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "invalid topic market.btcusdt.kline.3min",
  "ts": 1494310283622
}
```

## 8.サブスクライブの停止(unsub)

> + サブスクライブの停止フォーマット

> サブスクライブ停止のフォーマットについては以下のとおりとなります。

```json
{
  "unsub": "topic to unsub",
  "id": "id generate by client"
}
```

> サブスクライブ停止の正しい例。

```json
{
  "unsub": "market.btcusdt.trade.detail",
  "id": "id4"
}
```

> サブスクライブ停止完了後、データが返信された例。

```json
{
  "id": "id4",
  "status": "ok",
  "unsubbed": "market.btcusdt.trade.detail",
  "ts": 1494326028889
}
```

> サブスクライブ停止の誤った例（未購読のtopicを中止する）

```json
{
  "unsub": "market.btcusdt.trade.detail",
  "id": "id5"
}
```

> 誤ったデータが返信された例
  
```json
{
  "id": "id5",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "unsub with not subbed topic market.btcusdt.trade.detail",
  "ts": 1494326217428
}
```

> + サブスクライブ停止の誤った例（存在しないtopicを中止する）

```json
{
  "unsub": "not-exists-topic",
  "id": "id5"
}
```

> 誤ったデータが返信された例

```json
{
  "id": "id5",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "unsub with not subbed topic not-exists-topic",
  "ts": 1494326318809
}
```
  

WebSocket Client はデータのサブスクライブ後、そのデータのサブスクライブの停止が可能です。停止後は、WebSocket Serverは 当該topicのデータをプッシュしなくなります。

チャンネルからのデータ受信を停止するには、「unsub」メッセージを送信する必要があります。

# Websocketリファレンス

## ローソク足 データ



> コマンド送信

```json
{
  "sub": "market.symbol.kline.period",
  "id": "id generate by client"
}
```



```json
{
  "sub": "market.ethbtc.kline.1min",
  "id": "id1"
}
```


> 購読結果レスポンス

```json
{
  "id": "id1",
  "status": "ok",
  "subbed": "market.ethbtc.kline.1min",
  "ts": 1489474081631
}
```

> データ受信

```json
{
  "ch": "market.ethbtc.kline.1min",
  "ts": 1489474082831,
  "tick": {
    "id": 1489464480,
    "amount": 0.0,
    "count": 0,
    "open": 7962.62,
    "close": 7962.62,
    "low": 7962.62,
    "high": 7962.62,
    "vol": 0.0
  }
}
```

### `market.$symbol$.kline.$period$`

| key         | necessary  | type     | description   | value |
| --- | ---  | --- | --- | --- |
| symbol | true  | string | Pairs | ethbtc, ltcbtc...|
| period | true | string | KLine period | 1min, 5min, 15min, 30min, 60min, 1day, 1mon, 1week, 1year |

## KLine Chatデータ 

> コマンド送信

```json
{
  "req": "market.ethbtc.kline.1min",
  "id": "id10"
}
```

> データ受信

```json
{
  "rep": "market.ethbtc.kline.1min",
  "status": "ok",
  "id": "id10",
  "tick": [
    {
      "amount": 17.4805,
      "count":  27,
      "id":     1494478080,
      "open":   10050.00,
      "close":  10058.00,
      "low":    10050.00,
      "high":   10058.00,
      "vol":    175798.757708
    },
    {
      "amount": 15.7389,
      "count":  28,
      "id":     1494478140,
      "open":   10058.00,
      "close":  10060.00,
      "low":    10056.00,
      "high":   10065.00,
      "vol":    158331.348600
    },
    // more KLine data here
  ]
}
```

### `market.$symbol$.kline.$period$`  

### usage

| key         | description 
| --- | ---
| req |  market.$symbol.kline.$period
| id | クライアントによって生成されたID
| from | 任意, 範囲: [t1..t5]
| to | 任意, 範囲: [t2..t5]


<aside class="success">
from, toは任意入力です、組み合わせは下記に参照してください
</aside>

* from: t1, to: t5, return [t1, t5].
* from: t5, to: t1, which t5 > t1, return [].
* from: t5, return [t5].
* from: t3, return [t3, t5].
* to: t5, return [t1, t5].
* from: t which t3 < t <t4, return [t4, t5].
* to: t which t3 < t <t4, return [t1, t3].
* from: t1 and to: t2, should satisfy 1325347200 < t1 < t2 < 2524579200.


## マーケットデプスを購読する

> コマンド送信

```json
{
  "sub": "market.ethbtc.depth.step0",
  "id": "id1"
}
```

> 購読結果レスポンス

```json
{
  "id": "id1",
  "status": "ok",
  "subbed": "market.ethbtc.depth.step0",
  "ts": 1489474081631
}
```

> データ受信

```json
{
  "ch": "market.ethbtc.depth.step0",
  "ts": 1489474082831,
  "data": {
    "bids": [
      [9999.3900,0.0098], // [price, amount]
      [9992.5947,0.0560],
    ],
    "asks": [
      [10010.9800,0.0099],
      [10011.3900,2.0000]
      //more data here
    ]
  }
}
```

### `market.$symbol$.depth.$type$` 

### usage 

| key         | description 
| --- | ---
| req |  market.$symbol.depth.$period
| id | クライアントによって生成されたID

### 変数の説明

| key | necessary| type | description | value |
| --- | --- | --- | --- | --- |
| symbol | true  | string | Pairs | ethbtc, ltcbtc, etcbtc, bccbtc... |
| type | true| string | Market depth | step0, step1, step2, step3, step4, step5 |

## マーケットデプスのリクエスト

> コマンド送信

```json
{
  "req": "market.ethbtc.depth.step0",
  "id": "id10"
}
```

> データ受信

```json
{
  "rep": "market.ethbtc.depth.step0",
  "status": "ok",
  "id": "id10",
  "data": {
    "bids": [
    [9999.3900,0.0098], // [price, amount]
    [9992.5947,0.0560],
    ],
    "asks": [
    [10010.9800,0.0099],
    [10011.3900,2.0000]
    ]
  }
}
```

### `market.$symbol$.depth.$type$` 

| key         | description 
| --- | ---
| req |  market.$symbol.depth.$type"
| id | クライアントによって生成されたID

## 取引の詳細


> コマンド送信

```json
{
  "sub": "market.ethbtc.trade.detail",
  "id": "id1"
}
```

> 購読結果レスポンス

```json
{
  "id": "id1",
  "status": "ok",
  "subbed": "market.ethbtc.trade.detail",
  "ts": 1489474081631
}
```

> デーた受信

```json
{
  "ch": "market.ethbtc.trade.detail",
  "ts": 1489474082831,
  "data": [
            {
                "amount": 0.0099,
                "ts": 1533265950234,
                "id": 146507451359183894799,
                "price": 401.74,
                "direction": "buy"
            },
            // more Trade Detail data here
        ]
}
```

### `market.$symbol$.trade.detail`  

| key         | description 
| --- | ---
| req |  market.$symbol.trade.detail"
| id | クライアントによって生成されたID

## 取引詳細のリクエスト



> リクエスト送信

```json
{
  "req": "market.ethbtc.trade.detail",
  "id": "id11"
}
```

> データ受信

```json
{
  "rep": "market.ethbtc.trade.detail",
  "status": "ok",
  "id": "id11",
  "data": [
    {
      "id":        601595424,
      "price":     10195.64,
      "time":      1494495766,
      "amount":    0.2943,
      "direction": "buy",
      "tradeId":   601595424,
      "ts":        1494495766000
    },
    {
      "id":        601595423,
      "price":     10195.64,
      "time":      1494495711,
      "amount":    0.2430,
      "direction": "buy",
      "tradeId":   601595423,
      "ts":        1494495711000
    },
    // more Trade Detail data here
  ]
}
```

### `market.$symbol$.trade.detail` 

| key         | description 
| --- | ---
| req |  market.$symbol.trade.detail"
| id | クライアントによって生成されたID

<aside class="success">
最大データ量: 300
</aside>

## マーケット詳細のリクエスト

> リクエスト送信

```json
{
  "req": "market.ethbtc.detail",
  "id": "id12"
}
```

> データ受信

```json
{
  "rep": "market.ethbtc.detail",
  "status": "ok",
  "id": "id12",
  "tick": {
    "amount": 12224.2922,
    "open":   9790.52,
    "close":  10195.00,
    "high":   10300.00,
    "ts":     1494496390000,
    "id":     1494496390,
    "count":  15195,
    "low":    9657.00,
    "vol":    121906001.754751
  }
}
```

### `market.$symbol$.detail` 

| key         | description 
| --- | ---
| req |  market.$symbol.detail"
| id | クライアントによって生成されたID

<aside class="success">
最近のマーケット詳細情報を返します
</aside>






