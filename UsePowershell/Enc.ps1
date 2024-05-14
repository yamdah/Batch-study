# 暗号化(埋め込み)
# $plain = [System.Text.Encoding]::UTF8.GetBytes("target")
# 暗号化(コマンドライン)
  $plain = [System.Txet.Encoding]::UTF8.GetBytes()

# AESオブジェクト 
$AES = [System.Security.Cryptography.Aes]::Create()
$encrypted = $AES.CreateEncryptor().TransformFinalBlock($plain, 0, $plain.Length)

[System.Convert]::ToBase64String($encrypted) > Enc.txt
[System.Convert]::ToBase64String($AES.Key) > Share.key
[System.Convert]::ToBase64String($AES.IV) > Share.iv

# デフォルト確認用
# echo $AES.BlockSize
# echo $AES.Mode
# echo $AES.Key.Length
# echo $AES.IV.Length
