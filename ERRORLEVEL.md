# ERRORLEVELについて

## 学習環境
* Windows

<br>

## ERRORLEVELとは
「ERRORLEVEL」とは、Windowsバッチファイルにおいて自動的に設定される環境変数のひとつ。<br>
「0」を正常終了とし、それ以外には異常終了の原因に対応した値が割り振られている。
exitコマンドの後ろに設定されており、exit /b [数字・変数]を入れると、カッコ内の数字がエラーレベルになる。

【参考】システム エラー コード (0 から 499)<br>
<https://learn.microsoft.com/ja-jp/windows/win32/debug/system-error-codes--0-499->

<br>

## 基本的なリターン値 

| リターン値 |  内容  |
| :----: | :---- |
|  0  |  コマンドの正常終了  |
|  1  |  関数が正しくない  |
|  2  |  指定されたファイルが見つからない  |
|  3  |  指定したパスが見つからない  |
|  9009  |  コマンドが操作可能なものとして認識されていない  |
