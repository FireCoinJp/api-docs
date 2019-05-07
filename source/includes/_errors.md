# エラーコード

## マーケット関連API

| エラーコード |  説明 |
|-----|-----|
| bad-request | リクエストエラー |
| invalid-parameter | パラメーターエラー |
| invalid-command | 命令エラー|

<aside class="success">
code の具体的な詳細については `err-msg`にて対応しているもの参照ください.
</aside>

## 取引関連API

| エラーコード  |  説明 |
|-----|-----|
| base-symbol-error |  トレードペアが存在していない |
| base-currency-error |  銘柄が存在していない |
| base-date-error | 日時フォマットのエラー |
| account-transfer-balance-insufficient-error | 残高不足により凍結できません |
| bad-argument | パラメーターの期限切れ |
| api-signature-not-valid | API署名エラー |
| gateway-internal-error | システムビジー，少し時間をあけて再度お試しください|
| security-require-assets-password|資金パスワードの入力が必要|
| audit-failed | 注文失敗|
| ad-ethereum-address | 有効なETHのアドレスを入力してください|
| order-accountbalance-error | アカウント残高不足|
| order-limitorder-price-error |指値の注文価格が制限を超えている |
| order-limitorder-amount-error |指値の注文量が制限を超えている |
| order-orderprice-precision-error |注文価格が制限精度を超えている |
| order-orderamount-precision-error |注文量が制限精度を超えている|
| order-marketorder-amount-error |注文量が制限を超えている|
| order-queryorder-invalid |この注文を見つけることができない |
| order-orderstate-error |注文ステータスエラー|
| order-datelimit-error |照会時間制限を超えた|
| order-update-error |注文の更新失敗|
