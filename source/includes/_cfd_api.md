
# CFD Public API 

<aside class="success">APIキーによる認証が不要</aside>

## 預かり保証金の情報

```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/common/coins"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "isMarginCoin": 1,
      "marginCoin": "jpy",
      "marginIntoAuthority": 1,
      "marginOutAuthority": 1,
      "quantityPrecision": 0,
      "tradeType": 1
    }
  ],
  "success": true
}
```

このエンドポイントは預かり保証金の情報を返します。

### HTTP Request

`GET /v1/user/common/coins`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
 |  | 


### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| isMarginCoin | int | 預かり保証金であるかどうか?
| marginCoin | string | 預かり保証金通貨名 
| marginIntoAuthority   | int | 振替入金権限, 1: 可能, 2: 不可 
| marginOutAuthority   | int | 振替出金権限, 1: 可能, 2: 不可
| quantityPrecision   | int | 数量精度
| tradeType | int | 取引タイプ, ex: 1: リアルマッケート, 2: シミュレーションマッケート

## コンタクトの情報

```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/common/contract"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "baseCoin": "btc",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "isOpenTrade": 1,
      "marginCoin": "jpy",
      "maximumOrderQuantity": "100.000000000000000000",
      "minimumOrderQuantity": "0.001000000000000000",
      "pricePrecision": 0,
      "quantityPrecision": 3,
      "quoteCoin": "jpy",
      "supportLeverages": [
        "1",
        "2",
        "3"
      ],
      "tradeType": 1
    },
    {
      "baseCoin": "eth",
      "contractCode": "ethjpy",
      "contractName": "ETH/JPY",
      "isOpenTrade": 1,
      "marginCoin": "jpy",
      "maximumOrderQuantity": "500.000000000000000000",
      "minimumOrderQuantity": "0.010000000000000000",
      "pricePrecision": 0,
      "quantityPrecision": 2,
      "quoteCoin": "jpy",
      "supportLeverages": [
        "2"
      ],
      "tradeType": 1
    }
  ],
  "success": true
}
```

このエンドポイントはコンタクトの情報を返します。

### HTTP Request

`GET /v1/user/common/contract`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
 |  | 

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| tradeType | int | 取引タイプ, ex: 1: リアルマッケート, 2: シミュレーションマッケート
| contractName | string | コンタクトの名前
| contractCode | string | コンタクトコード(ex: btcjpy)
| baseCoin | string | 基礎通貨, (ex: btc)
| quoteCoin   | string | 通貨単位, (ex: jpy)
| isOpenTrade | int |取引可能, 1:可能, 2:不能 
| marginCoin | string | 預かり保証金, (ex: jpy)
| maximumOrderQuantity | string | 最大注文数
| minimumOrderQuantity | string | 最小注文数
| pricePrecision | int | 価格の精度
| quantityPrecision | string | 数量の精度
| supportLeverages   | []int | レバレッジの配列, (ex, [1,2,3,4])

## CFD kline


```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/common/kline?symbol=btcjpy&side=ask&period=1&from=1577694600&to=1577704600"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "close": "429591.0",
      "high": "429592.0",
      "low": "429198.0",
      "open": "429245.0"
    },
    {
      "close": "430327.0",
      "high": "430511.0",
      "low": "430180.0",
      "open": "430286.0"
    },
    {
      "close": "430730.0",
      "high": "430828.0",
      "low": "430271.0",
      "open": "430328.0"
    },
    {
      "close": "429787.0",
      "high": "429977.0",
      "low": "429487.0",
      "open": "429962.0"
    },
    {
      "close": "429842.0",
      "high": "430179.0",
      "low": "429396.0",
      "open": "429788.0"
    },
    {
      "close": "429531.0",
      "high": "429865.0",
      "low": "429345.0",
      "open": "429460.0"
    },
    {
      "close": "428867.0",
      "high": "429640.0",
      "low": "428733.0",
      "open": "429532.0"
    },
    {
      "close": "430278.0",
      "high": "430282.0",
      "low": "428867.0",
      "open": "428867.0"
    },
    {
      "close": "429310.0",
      "high": "429418.0",
      "low": "429196.0",
      "open": "429246.0"
    }
  ],
  "success": true
}

```

このエンドポイントはKLINEの情報を返します。

### HTTP Request

`GET /v1/user/common/kline`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
symbol | true | 取引ペア, (ex: btcjpy)
side | true |  売買方向, [ask, bid]
period | true | 期間, [1,5,15,30,1h,4h,8h,12h,1d,7d,30d]
from | false | 開始時間, タイムスタンプ
to | false | 終了時間, タイムスタンプ


### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| id | int | タイムスタンプ
| open | string | 始値
| close | string | 終値
| high | string | 最高値
| low | string | 最低値

# CFD Private API

<aside class="notice">
APIキーによる認証が必要です。<br>
認証方法は<b>REST API共通情報</b>に参照してください
</aside>

## CFDアカウント情報


```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/account/info?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=NFGvm1ybWjCQRNKWSf5sAJ6Whvrq2cVfL0n26epN8gc%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A47%3A59"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "accountEquity": "83930.377060300000000000",
      "accountId": "1234567890",
      "dayProfitAndLoss": "-15388.132215800000000000",
      "floatPandl": "0.000000000000000000",
      "marginAvailableQuantity": "83930.377060300000000000",
      "marginCoin": "jpy",
      "marginDesirableQuantity": "83930.377060300000000000",
      "marginOccupyQuantity": "323.221333333333333333",
      "marketEquity": "0.000000000000000000",
      "monthProfitAndLoss": "-16059.467662300000000000",
      "orderFrozenQuantity": "429.925133733333333332",
      "userId": "12345678",
      "weekProfitAndLoss": "-16059.467662300000000000",
      "yearProfitAndLoss": "-16059.467662300000000000"
    }
  ],
  "success": true
}
```

このエンドポイントはユーザアカウントの情報を返します。

### HTTP Request

`GET /v1/user/account/info`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
marginCoin | false  | 預かり保証金の通貨

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| accountEquity | string | アカウント総資産
| accountId | string | アカウントID
| dayProfitAndLoss | string | 日損益
| floatPandl | string | 未確定益
| marginAvailableQuantity | string | 使える保証金 
| marginCoin | string | 保証金通貨
| marginDesirableQuantity | string | 出金できる保証金
| marginOccupyQuantity | string | 使っている保証金
| marketEquity | string | マーケット評価額
| monthProfitAndLoss | string | 月損益
| orderFrozenQuantity | string | 注文中保証金
| userId | string | ユーザID
| weekProfitAndLoss | string | 週損益
| yearProfitAndLoss | string | 年損益

## ポジション一覧

```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/position?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=1G1rZOSfnJFtSpO0gfj6Qv%2BWVidXg9mqwvP%2BvtboX5k%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A47%3A59&contractCode=btcjpy"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "accountId": "1234567890",
      "closePandl": "0",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "floatPandl": "-1",
      "leverage": "2.000",
      "longShortSide": 1,
      "marginCoin": "jpy",
      "marginOccupyQuantity": "323.221333333333333333",
      "openPrice": "969664",
      "openQuantity": "0.001",
      "orderFrozenQuantity": "0.000",
      "positionFee": "0.000000000000000000",
      "rowId": "222",
      "updateTimes": 198,
      "userId": "12345678"
    }
  ],
  "success": true
}
```

このエンドポイントはポジション一覧を返します。

### HTTP Request

`GET /v1/user/position`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
contractCode | false  | コンタクトコード, (ex: btcjpy)


### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| accountId | string | アカウントID
| closePandl | string | 確定損益
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| floatPandl | string | 未確定損益
| leverage | string | レバレッジ
| longShortSide | string | 売買方向
| marginCoin | string | 基礎通貨
| marginOccupyQuantity | string | 使用中の保証金
| openPrice | string | 新規価格
| openQuantity | string | 新規数量
| orderFrozenQuantity | string | 注文中使う保証金
| positionFee | string | 保有手数料
| rowId | string | id
| updateTimes | int | 更新回数
| userId | string | ユーザID

## ポジション詳細

```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/position/detail?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=niK0dWFMtkrVsuuh%2BpQK0uwDxjbX3JA3e1%2FcxkbtA%2B4%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A47%3A59&contractCodeStr=btcjpy&direct=1&from=1582724879&limit=1000&longShortSide=1"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "accountId": "1234567890",
      "closeDate": 0,
      "closeFee": "0.000000000000000000",
      "closePandl": "0",
      "closePrice": "0.000000000000000000",
      "closeQuantity": "0.000000000000000000",
      "closeStatus": 2,
      "closeTime": 0,
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "floatPandl": "-1",
      "leverage": "3.000",
      "longShortSide": 1,
      "marginCoin": "jpy",
      "marginOccupyQuantity": "323.221333333333333333",
      "openDate": 20200227,
      "openFee": "0.193932800000000000",
      "openPrice": "969664",
      "openQuantity": "0.001",
      "openTime": 214758,
      "orderFrozenQuantity": "0.000",
      "rowId": "193495",
      "updateTimes": 1,
      "userId": "12345678"
    }
  ],
  "success": true
}
```

このエンドポイントはポジションの詳細を返します。

### HTTP Request

`GET /v1/user/position/detail`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
contractCodeStr | false  | コンタクトコード, 複数可, カンマ区切り
longShortSide | false  | ポジション方向, [1:long,2:short]
from | false  | 開始時間、タイムスタンプ
direct | false  | 検索方向, [1:next, 2:prev] 
limit | false  | 件数

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| accountId | string | アカウントID
| closePandl | string | 確定損益
| closeFee | string | 決済手数料
| closePrice | string | 決済価格
| closeQuantity | string | 決済数量
| closeStatus | int | 決済ステータス, [1: 決済済, 2: 未決済]
| closeDate | int | 決済日
| closeTime | int | 決済時間
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| floatPandl | string | 未確定損益
| leverage | string | レバレッジ
| longShortSide | int | ポジション方向, [1:long,2:short]
| marginCoin | string | 基礎通貨
| marginOccupyQuantity | string | 使用中の保証金
| openDate | int | 新規日, (format: YYYYMMDD)
| openFee | string | 新規手数料
| openPrice | string | 新規価格
| openQuantity | string | 新規数量
| openTime | string | 新規時間
| orderFrozenQuantity | string | 注文中使う保証金
| rowId | string | id
| updateTimes | int | 更新回数
| userId | string | ユーザID

## 財務記録

```shell
curl -X GET \
      "https://api-cloud.huobi.co.jp/cfd/v1/user/finance/transfer/list?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=thP889DQ5qwaB8li2UXpyDpQhcL6EG8xS6DYXkgAKOc%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A47%3A59&businessFlag=16201&direct=1&from=1582724879&limit=1000&marginCoin=jpy&queryEndDate=20200220&queryStartDate=20200201&transferType=6"
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "createDate": "20200320",
      "createTime": "0",
      "userId": "12345678",
      "accountId": "1234567890",
      "rowId": "193495",
      "marginCoin": "jpy",
      "occurQuantity": "83930.377060300000000000",
      "transferType": "323.221333333333333333",
      "businessFlag": "0.000000000000000000",
      "occurEndQuantity": "-16059.467662300000000000",
      "resultInfo": "429.925133733333333332",
      "remarkInfo": "-16059.467662300000000000",
    }
  ],
  "success": true
}
```

このエンドポイントは財務記録を返します。

### HTTP Request

`GET /v1/user/finance/transfer/list`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
marginCoin | false  | 預かり保証金の通貨
transferType | false  | 振替タイプ
businessFlag | false  | 業務フラグ
queryStartDate | false  | 開始時間, (ex: 20190101)
queryEndDate | false  | 終了時間, (ex: 20190102)
from | false  | 開始ID
direct | false  | 検索方向, [1:next, 2:prev] 
limit | false  | 件数

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| accountId | string | アカウントID
| userId | string | ユーザID
| createDate | string | 作成日
| createTime | string | 作成時間
| rowId | string | Id
| marginCoin | string | 保証金通貨
| occurQuantity | string | 更新数量
| transferType | string | 振替タイプ, [3:ユーザ口座へ, 6:ポジション変動へ]
| businessFlag | string | ビジネスフラグ
| occurEndQuantity | string | 残り数量
| resultInfo | string | 結果説明
| remarkInfo | string | 備考


### businessFlagの説明 

| value | Description  
| ------ | -------  
| 16201 | 現物口座からレバレッジ口座へ
| 16202 | レバレッジ口座から現物口座
| 16216 | 保有手数料
| 16217 | 保有手数料キャッシュバック

## 注文API

```shell
curl -X POST \
    https://api-cloud.huobi.co.jp/cfd/v1/user/order/place?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=nNk3y1CdapV49vvJBr1RuWDkZtvL1OgsA5SnfI2yvRo%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A48%3A00 \
    --data {"contractCode":"btcjpy","leverage":3,"openCloseSide":1,"orderQuantity":0.1,"orderSide":1,"orderType":1,"tradeType":1}
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": {
    "orderIdStr": "3319395842654209"
  },
  "success": true
}
```

このエンドポイントは注文するAPIです。

### HTTP Request

`POST /v1/user/order/place`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
contractCode | true  | コンタクトコード, (ex: btcjpy)
leverage | true  | レバレッジ
tradeType | true  | 取引タイプ, [1:リアルマーケット, 2:シミュレーションマーケット]
orderType | true  | 注文方式, [1:Market,2:IFD,3:OCO,4:IFD-OCO,5:Limit]
orderSide | true  | 注文方向, [1:買う,2:売る]
openCloseSide | true | ポジション方向, [1:open, 2:close]
detailPositionId | false  | 検索方向, [1:next, 2:prev] 
pointPriceType | false  |  取引明細のID
orderPrice | false  |  指値価格
orderQuantity | false  |  注文数量
allowSlipPrice | false  |  スリップ許容ポイント
pointPrice | false  |  IDF注文時の指値価格
negatePointPrice | false  |  IDF注文時の逆指値価格
closePointPriceType | false  | 決済時の指値タイプ, [1:指値,2:逆指値]
closeQuantity | false  | 決済数量
closePrice | false  | 決済価格
takeProfitPrice | false | 利益確定価格
stopLossPrice | false | 損切り価格

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | object | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| orderIdStr | string | オーダーID


## 注文キャンセル

```shell
curl -X POST \
    http://api-cloud.huobi.co.jp/cfd/v1/user/order/cancel?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=6hZGIU%2Fy20YfJRa%2Fm6vFzi5V2eLayx0vs4DdkVsIgAI%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A48%3A00 \
    --data {"orderId":"3319395842654209"}
```

> 上記のコマンドは、次のような構造のJSONを返します。

> 成功時のレスポンス

```json
{
  "code": "200",
  "success": true
}
```

> エラー時のレスポンス

```json
{
  "code": "502",
  "message": "parameter error",
  "success": false
}
```

このエンドポイントは注文をキャンセルするAPIです。

### HTTP Request

`POST /v1/user/order/cancel`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
orderId | true  | 注文ID

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| code | string | HTTP STATUS CODE
| message | string | エラーメッセージ
| success | bool | 成功したかどうか 

## 注文一覧


```shell
curl -X GET \
    https://api-cloud.huobi.co.jp/cfd/v1/user/order/list?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=nNk3y1CdapV49vvJBr1RuWDkZtvL1OgsA5SnfI2yvRo%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T13%3A48%3A00 \
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
    "code": 200,
    "data": [
    {
      "accountId": "1234567890",
      "allowSlipPrice": "0.100000000000000000",
      "baseCoin": "btc",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "contractType": 1,
      "detailPositionId": "192631",
      "feeCoin": "jpy",
      "leverage": "0.0000",
      "marginCoin": "jpy",
      "openCloseSide": 2,
      "orderDate": 20200223,
      "orderId": "7822187150704641",
      "orderMarginQuantity": "0.000000000000000000",
      "orderPreFee": "0.000000000000000000",
      "orderPrice": "483126.900000000000000000",
      "orderQuantity": "0.001000000000000000",
      "orderRelationId": "7822187150704641",
      "orderSide": 2,
      "orderStatus": 6,
      "orderTime": 104403,
      "orderTotalAmount": "483.126900000000000000",
      "orderType": 1,
      "pointPriceType": 0,
      "quoteCoin": "jpy",
      "remarkInfo": " ",
      "rowId": "3075",
      "strategyStatus": 1,
      "strikeFee": "0.966253800000000000",
      "strikeMarginQuantity": "0.000000000000000000",
      "strikeQuantity": "0.001000000000000000",
      "tradeType": 1,
      "userId": "12345678"
    },
    {
      "accountId": "1234567890",
      "allowSlipPrice": "0.200000000000000000",
      "baseCoin": "btc",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "contractType": 1,
      "detailPositionId": "0",
      "feeCoin": "jpy",
      "leverage": "3.0000",
      "marginCoin": "jpy",
      "openCloseSide": 1,
      "orderDate": 20200223,
      "orderId": "3318587091320833",
      "orderMarginQuantity": "0.000000000000000000",
      "orderPreFee": "0.000000000000000000",
      "orderPrice": "482162.200000000000000000",
      "orderQuantity": "0.001000000000000000",
      "orderRelationId": "3318587091320833",
      "orderSide": 1,
      "orderStatus": 6,
      "orderTime": 104037,
      "orderTotalAmount": "482.162200000000000000",
      "orderType": 1,
      "pointPriceType": 0,
      "quoteCoin": "jpy",
      "remarkInfo": " ",
      "rowId": "3074",
      "strategyStatus": 1,
      "strikeFee": "0.964324400000000000",
      "strikeMarginQuantity": "160.720733333333333333",
      "strikeQuantity": "0.001000000000000000",
      "tradeType": 1,
      "userId": "12345678"
    }
  ],
  "success": true
}
```

このエンドポイントは注文一覧を返します。

### HTTP Request

`GET /v1/user/order/list`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
orderType | false  | 注文方式, [1:Market,2:IFD,3:OCO,4:IFD-OCO,5:Limit]
contractCode | false  | コンタクトコード, (ex: btcjpy)
orderStatusStr | false  | 注文状態, [1~7]
openCloseSide | false | ポジション方向, [1:open, 2:close]
orderSide | false  | 注文方向, [1:買う,2:売る]
leverage | false  | レバレッジ
tradeType | false  | 取引タイプ, [1:リアルマーケット, 2:シミュレーションマーケット]
queryStartDate | false  | レバレッジ
queryEndDate | false  | レバレッジ
from | false  | レバレッジ
direct | false  | レバレッジ
limit | false  | レバレッジ

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| orderDate | string | 注文日
| orderTime | string | 注文時間
| userId | string | ユーザID
| accountId | string | アカウントID
| orderId | string | オーターID
| orderRelationId | string | 関連オーターID
| detailPositionId | string | ポジションID
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| baseCoin | string | 基礎通貨
| quoteCoin | string | 通貨単位
| marginCoin | string | 保証金通貨
| contractType | string | コンタクトタイプ
| tradeType | string | 取引タイプ
| leverage | string | レバレッジ
| orderType | string | オーダータイプ
| orderSide | string | 注文方向
| openCloseSide | string | ポジション方向
| pointPriceType | string | 指値タイプ, [1:指値,2:逆指値]
| orderPrice | string | 注文価格
| orderQuantity | string | 注文数量
| orderTotalAmount | string | 注文金額
| allowSlipPrice | string | スリップ許容ポイント
| orderStatus | string | 注文状態
| strategyStatus | string | 策略状態
| orderMarginQuantity | string | 保証金数量
| orderPreFee | string | 手数料
| strikeQuantity | string | 成約数量
| strikeFee | string | 成約手数料
| feeCoin | string | 手数料通貨
| remarkInfo | string | 備考

## 注文詳細


```shell
curl -X GET \
    https://api-cloud.huobi.co.jp/v1/user/order/detail?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=Of%2BSECbkg%2BpWO5AJc8NzxXB2jA4lLGEV7tnYMWhxYRs%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T14%3A13%3A38&orderId=3319395842654209
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": {
    "accountId": "1234567890",
    "allowSlipPrice": "0.000000000000000000",
    "baseCoin": "btc",
    "closePointPriceType": 0,
    "closePrice": "0.000000000000000000",
    "closeQuantity": "0.000000000000000000",
    "contractCode": "btcjpy",
    "contractName": "BTC/JPY",
    "contractType": 1,
    "detailPositionId": "0",
    "feeCoin": "jpy",
    "isSlippagePrice": 2,
    "leverage": "3.0000",
    "marginCoin": "jpy",
    "negatePointPrice": "0.000000000000000000",
    "openCloseSide": 1,
    "orderDate": 20200227,
    "orderId": "3319395842654209",
    "orderMarginQuantity": "0.000000000000000000",
    "orderPreFee": "0.000000000000000000",
    "orderPrice": "0.000000000000000000",
    "orderQuantity": "0.100000000000000000",
    "orderRelationId": "3319395842654209",
    "orderSide": 1,
    "orderStatus": 6,
    "orderTime": 214800,
    "orderTotalAmount": "0.000000000000000000",
    "orderType": 1,
    "pointPrice": "0.000000000000000000",
    "pointPriceType": 0,
    "quoteCoin": "jpy",
    "remarkInfo": " ",
    "rowId": "3904",
    "stopLossPrice": "0.000000000000000000",
    "strategyStatus": 1,
    "strikeFee": "19.393220000000000000",
    "strikeMarginQuantity": "32322.033333333333333333",
    "strikeQuantity": "0.100000000000000000",
    "takeProfitPrice": "0.000000000000000000",
    "tradeType": 1,
    "userId": "12345678"
  },
  "success": true
}

```

このエンドポイントは注文の詳細情報を返します。

### HTTP Request

`GET /v1/user/order/detail`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
orderId | true  | 注文ID

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| rawId | string | ID
| orderDate | string | 注文日
| orderTime | string | 注文時間
| userId | string | ユーザID
| accountId | string | アカウントID
| orderId | string | 注文ID
| orderRelationId | string | 関連オーターID
| detailPositionId | string | ポジションID
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| baseCoin | string | 基礎通貨
| quoteCoin | string | 通貨単位
| marginCoin | string | 保証金通貨
| contractType | string | コンタクトタイプ
| tradeType | string | 取引タイプ
| leverage | string | レバレッジ
| orderType | string | オーダータイプ
| orderSide | string | 注文方向
| openCloseSide | string | ポジション方向
| pointPriceType | string | 指値タイプ, [1:指値,2:逆指値]
| orderPrice | string | 注文価格
| orderQuantity | string | 注文数量
| orderTotalAmount | string | 注文金額
| allowSlipPrice | string | スリップ許容ポイント
| orderStatus | string | 注文状態
| strategyStatus | string | 策略状態
| orderMarginQuantity | string | 保証金数量
| orderPreFee | string | 注文凍結金額
| strikeQuantity | string | 成約数量
| strikeMarginQuantity | string | 成約保証金数量
| strikeFee | string | 成約手数料
| feeCoin | string | 手数料通貨
| remarkInfo | string | 備考
| closePointPriceType | string | 決済指値タイプ, [1:指値,2:逆指値]
| closeQuantity | string | 決済数量
| closePrice | string | 決済価格
| pointPrice | string | 指値価格
| negatePointPrice | string | 逆指値価格
| takeProfitPrice | string | 利益確定価格
| stopLossPrice | string | 損切り価格
| isSlippagePrice | string | スリップしたか? [1:yes,2:no]

## 成約履歴


```shell
curl -X GET \
    https://api-cloud.huobi.co.jp/v1/user/order/strikes?AccessKeyId=xxxxxxxxx-xxxxxxxxx-xxxxxxxx-xxxxxxxxxxx&Signature=Of%2BSECbkg%2BpWO5AJc8NzxXB2jA4lLGEV7tnYMWhxYRs%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-02-27T14%3A13%3A38&orderId=3319395842654209
```

> 上記のコマンドは、次のような構造のJSONを返します。

```json
{
  "code": "200",
  "data": [
    {
      "accountId": "1234567890",
      "baseCoin": "btc",
      "closePandl": "0.000000000000000000",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "feeCoin": "jpy",
      "marginCoin": "jpy",
      "matchId": "7822995470024706",
      "openCloseSide": 1,
      "orderId": "3319395842654209",
      "orderSide": 1,
      "orderType": 1,
      "quoteCoin": "jpy",
      "rowId": "377209",
      "strikeDate": 20200227,
      "strikeFee": "19.393220000000000000",
      "strikeId": "5364",
      "strikePrice": "969661.000000000000000000",
      "strikeQuantity": "0.100000000000000000",
      "strikeTime": 214801,
      "userId": "12345678"
    },
    {
      "accountId": "1234567890",
      "baseCoin": "btc",
      "closePandl": "0.000000000000000000",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "feeCoin": "jpy",
      "marginCoin": "jpy",
      "matchId": "7822995463733250",
      "openCloseSide": 1,
      "orderId": "3319395836362753",
      "orderSide": 1,
      "orderType": 1,
      "quoteCoin": "jpy",
      "rowId": "377207",
      "strikeDate": 20200227,
      "strikeFee": "0.193932800000000000",
      "strikeId": "5362",
      "strikePrice": "969664.000000000000000000",
      "strikeQuantity": "0.001000000000000000",
      "strikeTime": 214758,
      "userId": "12345678"
    },
  ],    
  "success": true
}

```

このエンドポイントは成約一覧を返します。

### HTTP Request

`GET /v1/user/order/strikes`

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
contractCode | true  | コンタクトコード
openCloseSide | true  | ポジション方向, [1:open, 2:close]
orderSide | true  | 販売方向, [1:buy, 2:sell]
orderType | true  | 注文タイプ
queryStartDate | true  | 検索開始時間
queryEndDate | true  | 検索終了時間
from | false  | RawIdから
direct | false  | 検索方向, [1:next, 2:prev] 
limit | false  | 件数

### Response Data

| Parameter | Type | Description  
| ------ | ------ | -------  
| success | bool | 成功したかどうか 
| code | string | リクエスト处理结果,  例えば: "ok","error" 
| message | string | エラーメッセージなど
| data   | list | データ 


| Data Field | Type | Description  
| ------ | ------ | -------  
| rawId | string | ID
| strikeDate | string | 成約日
| strikeTime | string | 成約時間
| userId | string | ユーザID
| accountId | string | アカウントID
| strikeId | string | 成約ID
| matchId | string | マーチングID
| orderId | string | 注文ID
| orderType | string | オーダータイプ
| orderSide | string | 注文方向, [1:買う,2:売る]
| openCloseSide | string | ポジション方向, [1:open,2:close]
| opponentUserId | string | 相手ユーザID
| opponentAccountId | string | 相手アカウントID
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| baseCoin | string | 基礎通貨
| quoteCoin | string | 通貨単位
| marginCoin | string | 保証金通貨
| contractType | string | コンタクトタイプ
| strikeQuantity | string | 成約数量
| strikePrice | string | 成約価格
| strikeFee | string | 成約手数料
| feeCoin | string | 手数料通貨
| closePandl | string | 決済損益

# CFD Websocket 


### 接続URL

`wss://api-cloud.huobi.co.jp/cfd/ws`

```shell
wscat --connect wss://api-cloud.huobi.co.jp/cfd/ws
Connected (press CTRL+C to quit)
> 
```


## CFD klineの購読

<aside class="success">署名認証が不要</aside>


> 送るコマンド

```json
{
  "msgType":"quote.kline", 
  "action":"subscribe", 
  "symbols":"btcjpy", 
  "side":"bid", 
  "period":"1"
}
```

> 成功時のレスポンス

```json
{
  "action": "subscribe",
  "code": "200",
  "data": [
    {
      "close": "715990",
      "high": "716300",
      "id": "1585023660",
      "low": "714901",
      "open": "715692"
    }
  ],
  "msgType": "quote.kline",
  "period": "1",
  "sendNum": "-1",
  "seq": "",
  "success": true,
  "ts": "1585023720077"
}
```

> 受信メッセージ

```json
{
  "code": "200",
  "data": [
    {
      "close": "429591.0",
      "high": "429592.0",
      "low": "429198.0",
      "open": "429245.0"
    },
    {
      "close": "430327.0",
      "high": "430511.0",
      "low": "430180.0",
      "open": "430286.0"
    },
    {
      "close": "430730.0",
      "high": "430828.0",
      "low": "430271.0",
      "open": "430328.0"
    },
    {
      "close": "429787.0",
      "high": "429977.0",
      "low": "429487.0",
      "open": "429962.0"
    },
    {
      "close": "429842.0",
      "high": "430179.0",
      "low": "429396.0",
      "open": "429788.0"
    },
  ],
  "success": true
}
```

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
msgType | true | メッセージタイプ, 固定値: quote.kline 
action | true | アクション, 値の範囲: [subscribe, unsubscribe]
symbol | true | 取引ペア,  ex: btcjpy, ethjpy
side   | true | 買い、売り, 値の範囲: [bid, ask]
period | true | 間隔, 値の範囲:  [1、5、15、30、1h，4h，8h，12h，1d，7d，30d]

### Response

| Parameter | Required | Type | Description  
| ------ | ---- | ------ | -------  
| success | true | string | 成功したか? 成功: true, 失敗: false
| code | true | int | HTTP STATUS CODE
| msgType | true | string | メッセージタイプ
| action | true | string | アクション名, 値の範囲: [req, subscribe]
| ts | true | int | タイムスタンプ
| data | true | object | Klineデータ

### 受信データ

| Data Fields | Required | Type | Description  
| ------ | ---- | ------ | -------  
| high | true | string | 最高値
| low | true | string | 最安値
| open | true | string | 始値
| close| true | string | 終値

## 署名認証

<aside class="notice">
<b>プライベートチャンネルの購読について、事前に署名認証が必要になります。</b>
</aside>

### 署名認証コマンド

+ 接続後、authコマンドを送ることによって、プライベートチャンネルの利用が可能になる。
+ 認証方法はRestAPIの認証方法と同じです。

> 署名文字列の例

```json
"GET\napi-cloud.huobi.co.jp\n/ws\nAccessKeyId=xxxx-xxxx-xxxx&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2020-03-23T11%3A07%3A55"
``` 

> 送るコマンド

```json
{
  "msgType":"auth",
  "action":"req",
  "seq": "{任意の識別文字列}",
  "AccessKeyId":"{アクセスキー}",
  "SignatureMethod":"HmacSHA256",
  "SignatureVersion":"2",
  "Timestamp":"{UTCの時間文字列}",
  "Signature":"{取得した署名}"
}
```

> 成功時のレスポンス

```json
{
  "code":"200",
  "msgType":"auth",
  "seq":"",
  "success":true,
  "ts":"1584961676115"
}
```

> 失敗時のレスポンス

```json
{
  "code":"12002",
  "success":false
}
```

Parameter | Required | Description
--------- | ------- | -----------
msgType | true | メッセージタイプ、 固定値(auth)
action | true | アクション、 固定値(req)
seq | false | クライアント識別子、 そのままにレスポンスに含まれる
AccessKeyId | true | Access Public Key
SignatureMethod | true | 暗号化方式、 固定値(HmacSHA256)
SignatureVersion | true | 認証バージョン、 固定値(2)
Timestamp | true | UTCの時間文字列、ex(2020-03-23T11:07:55)
Signature | true | 計算された署名、hmac256(連結文字列, 秘密APIキー)


 エラーコード | 説明 
--------- | ------- 
 12001 | 無効な提出時間または不正なフォーマット 
 12002 | 不正な署名バージョン 
 12003 | 不正な署名方法 
 12004 | API KEYの有効期限が切れました 
 12005 | IPアドレスエラー 
 12006 | 送信時間を空にすることはできません 
 12007 | アクセスキーエラー 
 12008 | 検証に失敗しました 
 12009 | ユーザーの状態が異常です 
 12010 | 秘密鍵署名エラー 
 12011 | 公開鍵エラー 
 12012 | 権限エラー  

### 接続の維持

> 受け取たPINGメッセージ 

```json
{
    "action":"ping",
    "code":"200",
    "data":1585012178967,
    "msgType":"heartbeat",
    "success":true
}
```

> 送信するPONGメッセージ

```json
{
  "action":"pong",
  "code":"200",
  "data":1585012178967,
  "msgType":"heartbeat",
  "success":true
}
```


+ 接続維持する為に、定期的にpongMessageを送る必要があります。
+ サーバー側pingメッセージが受信できたら、pongメッセージを送信する。
+ <b>PONG</b>メッセージを返さないと、自動的に接続が切れます。

## CFD成約データ

<aside class="notice">署名認証が必要</aside>

> 送るコマンド

```json
{
  "msgType":"quote.strike", 
  "action":"subscribe", 
}
```

> 成功時のレスポンス

```json
{
  "action": "subscribe",
  "code": "200",
  "msgType": "user.strike",
  "seq": "12345",
  "success": true,
  "ts": 1585023720076
}
```

> 受信メッセージ

```json
{
  "success": true,
  "msgType": "user.strike",
  "seq": "12345",
  "action": "subscribe",
  "code": 200,
  "ts": 1489474082831,
  "data": {
          "accountId": "1234567890",
          "baseCoin": "btc",
          "closePandl": "0.000000000000000000",
          "contractCode": "btcjpy",
          "contractName": "BTC/JPY",
          "feeCoin": "jpy",
          "marginCoin": "jpy",
          "matchId": "7822995470024706",
          "openCloseSide": 1,
          "orderId": "3319395842654209",
          "orderSide": 1,
          "orderType": 1,
          "quoteCoin": "jpy",
          "rowId": "377209",
          "strikeDate": 20200227,
          "strikeFee": "19.393220000000000000",
          "strikeId": "5364",
          "strikePrice": "969661.000000000000000000",
          "strikeQuantity": "0.100000000000000000",
          "strikeTime": 214801,
          "userId": "12345678"
    }
}
```

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
msgType | true | メッセージタイプ, 固定値: quote.strike 
action | true | アクション, 値の範囲: [subscribe, unsubscribe]
seq | false | 識別番号(任意)

### Response

| Parameter | Required | Type | Description  
| ------ | ---- | ------ | -------  
| success | true | string | 成功したか? 成功: true, 失敗: false
| code | true | int | HTTP STATUS CODE
| msgType | true | string | メッセージタイプ
| action | true | string | アクション名, 値の範囲: [subscribe, unsubscribe]
| ts | true | int | タイムスタンプ
| data | true | object | 成約データ


| Data Field | Type | Description  
| ------ | ------ | -------  
| rawId | string | ID
| strikeDate | string | 成約日
| strikeTime | string | 成約時間
| userId | string | ユーザID
| accountId | string | アカウントID
| strikeId | string | 成約ID
| matchId | string | マーチングID
| orderId | string | 注文ID
| orderType | string | オーダータイプ
| orderSide | string | 注文方向, [1:買う,2:売る]
| openCloseSide | string | ポジション方向, [1:open,2:close]
| opponentUserId | string | 相手ユーザID
| opponentAccountId | string | 相手アカウントID
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| baseCoin | string | 基礎通貨
| quoteCoin | string | 通貨単位
| marginCoin | string | 保証金通貨
| contractType | string | コンタクトタイプ
| strikeQuantity | string | 成約数量
| strikePrice | string | 成約価格
| strikeFee | string | 成約手数料
| feeCoin | string | 手数料通貨
| closePandl | string | 決済損益

## CFD注文データ

<aside class="notice">署名認証が必要</aside>

> 送るコマンド

```json
{
  "msgType":"quote.order", 
  "action":"subscribe", 
}
```

> 成功時のレスポンス

```json
{
  "action": "subscribe",
  "code": "200",
  "msgType": "user.order",
  "seq": "12345",
  "success": true,
  "ts": 1585023720076
}
```

> 受信メッセージ

```json
{
  "success": true,
	"msgType": "user.strike",
	"seq": "12345",
	"action": "subscribe",
  "code": 200,
  "ts": 1489474082831,
  "data": {
        "accountId": "1234567890",
        "allowSlipPrice": "0.100000000000000000",
        "baseCoin": "btc",
        "contractCode": "btcjpy",
        "contractName": "BTC/JPY",
        "contractType": 1,
        "detailPositionId": "192631",
        "feeCoin": "jpy",
        "leverage": "0.0000",
        "marginCoin": "jpy",
        "openCloseSide": 2,
        "orderDate": 20200223,
        "orderId": "7822187150704641",
        "orderMarginQuantity": "0.000000000000000000",
        "orderPreFee": "0.000000000000000000",
        "orderPrice": "483126.900000000000000000",
        "orderQuantity": "0.001000000000000000",
        "orderRelationId": "7822187150704641",
        "orderSide": 2,
        "orderStatus": 6,
        "orderTime": 104403,
        "orderTotalAmount": "483.126900000000000000",
        "orderType": 1,
        "pointPriceType": 0,
        "quoteCoin": "jpy",
        "remarkInfo": " ",
        "rowId": "3075",
        "strategyStatus": 1,
        "strikeFee": "0.966253800000000000",
        "strikeMarginQuantity": "0.000000000000000000",
        "strikeQuantity": "0.001000000000000000",
        "tradeType": 1,
        "userId": "12345678"
  }
}
```

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
msgType | true | メッセージタイプ, 固定値: quote.order 
action | true | アクション, 値の範囲: [subscribe, unsubscribe]
seq | false | 識別番号(任意)

### Response

| Parameter | Required | Type | Description  
| ------ | ---- | ------ | -------  
| success | true | string | 成功したか? 成功: true, 失敗: false
| code | true | int | HTTP STATUS CODE
| msgType | true | string | メッセージタイプ
| action | true | string | アクション名, 値の範囲: [subscribe, unsubscribe]
| ts | true | int | タイムスタンプ
| data | true | object | 注文データ


| Data Field | Type | Description  
| ------ | ------ | -------  
| orderDate | string | 注文日
| orderTime | string | 注文時間
| userId | string | ユーザID
| accountId | string | アカウントID
| orderId | string | オーターID
| orderRelationId | string | 関連オーターID
| detailPositionId | string | ポジションID
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| baseCoin | string | 基礎通貨
| quoteCoin | string | 通貨単位
| marginCoin | string | 保証金通貨
| contractType | string | コンタクトタイプ
| tradeType | string | 取引タイプ
| leverage | string | レバレッジ
| orderType | string | オーダータイプ
| orderSide | string | 注文方向
| openCloseSide | string | ポジション方向
| pointPriceType | string | 指値タイプ, [1:指値,2:逆指値]
| orderPrice | string | 注文価格
| orderQuantity | string | 注文数量
| orderTotalAmount | string | 注文金額
| allowSlipPrice | string | スリップ許容ポイント
| orderStatus | string | 注文状態
| strategyStatus | string | 策略状態
| orderMarginQuantity | string | 保証金数量
| orderPreFee | string | 手数料
| strikeQuantity | string | 成約数量
| strikeFee | string | 成約手数料
| feeCoin | string | 手数料通貨
| remarkInfo | string | 備考


## CFD資産変化

<aside class="notice">署名認証が必要</aside>

> 送るコマンド

```json
{
  "msgType":"quote.assets", 
  "action":"subscribe", 
}
```

> 成功時のレスポンス

```json
{
  "action": "subscribe",
  "code": "200",
  "msgType": "user.assets",
  "success": true,
  "ts": 1585023720076
}
```

> 受信メッセージ

```json
{
  "success": true,
  "msgType": "user.assets",
  "seq": "12345",
  "action": "subscribe",
  "code": 200,
  "ts": 1489474082831,
  "data": {
      "accountEquity": "83930.377060300000000000",
      "accountId": "1234567890",
      "dayProfitAndLoss": "-15388.132215800000000000",
      "floatPandl": "0.000000000000000000",
      "marginAvailableQuantity": "83930.377060300000000000",
      "marginCoin": "jpy",
      "marginDesirableQuantity": "83930.377060300000000000",
      "marginOccupyQuantity": "323.221333333333333333",
      "marketEquity": "0.000000000000000000",
      "monthProfitAndLoss": "-16059.467662300000000000",
      "orderFrozenQuantity": "429.925133733333333332",
      "userId": "12345678",
      "weekProfitAndLoss": "-16059.467662300000000000",
      "yearProfitAndLoss": "-16059.467662300000000000"
    }
}
```

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
msgType | true | メッセージタイプ, 固定値: quote.assets
action | true | アクション, 値の範囲: [subscribe, unsubscribe]

### Response

| Parameter | Required | Type | Description  
| ------ | ---- | ------ | -------  
| success | true | string | 成功したか? 成功: true, 失敗: false
| code | true | int | HTTP STATUS CODE
| msgType | true | string | メッセージタイプ
| action | true | string | アクション名, 値の範囲: [subscribe, unsubscribe]
| ts | true | int | タイムスタンプ
| data | true | object | 資産データ


| Data Field | Type | Description  
| ------ | ------ | -------  
| userId | string | ユーザID
| accountId | string | アカウントID
| marginCoin | string | マージン通貨
| marketEquity | string | 市場評価額 
| marginOccupyQuantity | string | 凍結した保証金
| marginAvailableQuantity | string | 使える保証金
| marginQuantityRetentionRate | string | マージン維持率 
| marginDesirableQuantity | string | 出金できる保証金
| dayProfitAndLoss | string | 日損益
| weekProfitAndLoss | string | 週損益
| monthProfitAndLoss | string | 月損益
| yearProfitAndLoss | string | 年損益
| floatPandl | string | 未実現損益
| accountEquity | string | アカウント資産額
| orderFrozenQuantity | string | 凍結数量

## CFDポジション変化

<aside class="notice">署名認証が必要</aside>

> 送るコマンド

```json
{
  "msgType":"quote.position", 
  "action":"subscribe", 
}
```

> 成功時のレスポンス

```json
{
  "action": "subscribe",
  "code": "200",
  "msgType": "user.position",
  "seq": "12345",
  "success": true,
  "ts": 1585023720076
}
```

> 受信メッセージ

```json
{
  "success": true,
  "msgType": "user.position",
  "seq": "12345",
  "action": "subscribe",
  "code": 200,
  "ts": 1489474082831,
  "data": {
      "accountId": "1234567890",
      "closePandl": "0",
      "contractCode": "btcjpy",
      "contractName": "BTC/JPY",
      "floatPandl": "-1",
      "leverage": "2.000",
      "longShortSide": 1,
      "marginCoin": "jpy",
      "marginOccupyQuantity": "323.221333333333333333",
      "openPrice": "969664",
      "openQuantity": "0.001",
      "orderFrozenQuantity": "0.000",
      "positionFee": "0.000000000000000000",
      "rowId": "222",
      "updateTimes": 198,
      "userId": "12345678"
    }
}
```

### Query Parameters

Parameter | Required | Description
--------- | ------- | -----------
msgType | true | メッセージタイプ, 固定値: quote.position 
action | true | アクション, 値の範囲: [subscribe, unsubscribe]
seq | false | 識別番号(任意)

### Response

| Parameter | Required | Type | Description  
| ------ | ---- | ------ | -------  
| success | true | string | 成功したか? 成功: true, 失敗: false
| code | true | int | HTTP STATUS CODE
| msgType | true | string | メッセージタイプ
| action | true | string | アクション名, 値の範囲: [unsubscribe, subscribe]
| ts | true | int | タイムスタンプ
| data | true | object | ポジションデータ

| Data Field | Type | Description  
| ------ | ------ | -------  
| accountId | string | アカウントID
| closePandl | string | 確定損益
| contractCode | string | コンタクトコード
| contractName | string | コンタクト名前
| floatPandl | string | 未確定損益
| leverage | string | レバレッジ
| longShortSide | string | 売買方向
| marginCoin | string | 基礎通貨
| marginOccupyQuantity | string | 使用中の保証金
| openPrice | string | 新規価格
| openQuantity | string | 新規数量
| orderFrozenQuantity | string | 注文中使う保証金
| positionFee | string | 保有手数料
| rowId | string | id
| updateTimes | int | 更新回数
| userId | string | ユーザID

