# Docker+Squid
Dockerで稼働するSquidです。  
Squidの設定はすべてデフォルトのままにしています。  

## バージョン情報（2021/09/25時点）
### Squid
```
# /sbin/squid -v
Squid Cache: Version 3.5.20
～～省略～～
```
### CentOS
```
# cat /etc/redhat-release
CentOS Linux release 7.9.2009 (Core)
```

## 動作確認方法（curl）
コンテナにログイン後、curlを使って動作確認できます。
```
# curl https://www.google.com --proxy localhost:3128
～～省略～～
```
接続先のHTMLが返ってくれば動作確認OKです。

## 動作確認方法（ブラウザ）
ローカルPCのブラウザから動作確認する場合は、ブラウザのプロキシ設定でlocalhost:3128を設定すると動作します。

## ログ確認
前述のcurlやブラウザからアクセスした際のログが出力されます。
```
# tail /var/log/squid/access.log
～～省略～～
```