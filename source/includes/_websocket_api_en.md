# Websocket共通

## Webソケットの接続 (SSL)

> wss://api-cloud.huobi.co.jp/ws


## データ

すべての戻りデータは解凍する必要があります。

リンク: [pako](https://github.com/nodeca/pako)

## ライブラリー

リンク: [ws](https://github.com/websockets/ws) by Node.js

## Topic

リクエストや購読には、`topic`を使います。主なトピックは下記の通りです。

| type      | topic                     | description                                       |
| ------------- | ---------------------------- | ---------------------------------------- |
| KLine         | market.$symbol.kline.$period | $period ：{ 1min, 5min, 15min, 30min, 60min, 1day, 1mon, 1week, 1year } |
| Market Depth  | market.$symbol.depth.$type   | $type ：{ step0, step1, step2, step3, step4, step5 } （depths 0-5）|
| Trade Detail  | market.$symbol.trade.detail  |                                          |
| Market Detail | market.$symbol.detail        |                                          |
| Market Tickers | market.tickers        |
`$symbol` ： { ethbtc, ltcbtc, etcbtc, bccbtc ... }

## ハートビート


> WebSocket Client Request

```json
{
    "ping": 18212558000
}
```

> WebSocket Server response

```json
{
    "pong": 18212558000
}
```

> 要求メッセージの種類が`LONG`でない場合、websocketサーバーは次のように応答します。

```json
{
  "ts": 1492420473027,
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "invalid ping"
}
```

<aside class="success">
接続状態を維持するために、クライアントおよびサーバーは定期的にハートビートを送り合います。
</aside>

## リクエスト

> リクエストを送信する

```json
{
  "req": "topic to req",
  "id": "id generate by client"
}
```

<aside class="sucess">
リクエストは上述のトピックのように使えます。
</aside>

> 正しいリクエスト

```json
{
  "req": "market.ethbtc.kline.1min",
  "id": "id10"
}
```

> Response

```json
{
  "status": "ok",
  "rep": "market.btccny.kline.1min",
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

> 間違ったリクエスト

```json
{
  "req": "market.invalidsymbo.kline.1min",
  "id": "id10"
}
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "status": "error",
  "id": "id10",
  "err-code": "bad-request",
  "err-msg": "invalid topic market.invalidsymbol.trade.detail",
  "ts": 1494483996521
}
```


## トピックの購読

> 購読メッセージ

```json
{
   "sub": "market.btccny.kline.1min",
   "id": "id1"
}
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "id": "id1",
  "status": "ok",
  "subbed": "market.btccny.kline.1min",
  "ts": 1489474081631
}
```

<aside class="success">
データを受信するには、まず「sub」メッセージを送信する必要があります。
購読した後、サーバー側で変更や更新があった場合、そのデータを自動的に受信できます。
</aside>


> 受信するメッセージは次のようなJSONが返されます。

```json
{
  "ch": "market.btccny.kline.1min",
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

> シンボルが間違った場合は、下記のようなエラーメッセージが返ってきます。

```json
{
  "id": "id2",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "invalid topic market.invalidsymbol.kline.1min",
  "ts": 1494301904959
}
```

> Topicが間違った場合は、下記のようなエラーメッセージになります。

```json
{
  "id": "id3",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "invalid topic market.btccny.kline.3min",
  "ts": 1494310283622
}
```

## 購読の解除


> 解除コマンドは下記のようなメッセージです。

```json
{
  "unsub": "topic to unsub",
  "id": "id generate by client"
}
```

> 成功したリクエスト

```json
{
  "unsub": "market.btcjpy.trade.detail",
  "id": "id4"
}
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "id": "id4",
  "status": "ok",
  "unsubbed": "market.btccny.trade.detail",
  "ts": 1494326028889
}
```

> すでに解除済みの場合は、下記のようなエラーメッセージを返します。

```json
{
  "id": "id5",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "unsub with not subbed topic market.btccny.trade.detail",
  "ts": 1494326217428
}
```

> 存在しないトピックを解除する場合は、下記のようなエラーメッセージを返します。

```json
{
  "id": "id5",
  "status": "error",
  "err-code": "bad-request",
  "err-msg": "unsub with not subbed topic not-exists-topic",
  "ts": 1494326318809
}
```

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

## KLineデータ 




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






