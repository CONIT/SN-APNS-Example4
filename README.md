# SN-APNS-Example4

SamuraiNotification
*プッシュメッセージの履歴取得＆表示サンプルコード*

メッセージ履歴取得APIは過去に送信したメッセージを一覧形式で取得できるものです。
<http://developer.conit.jp/samurai_notification/api/history.html>

このAPIを通して取得したメッセージの一覧を、アプリ内のお知らせページで利用するなど考えられます。
メッセージのオプション領域に任意の情報を埋め込むことで、アプリ側で設定された情報を元に開く画面を変えるといった実装も可能となります。

このサンプルでは、以下のアクションをおこなった際に、オプションに指定されている情報によって、ブラウザを開いたり、別の画面を表示します。
* 通知センターに表示されたメッセージをタップ
* 履歴取得APIで取得した一覧でメッセージをタップ

# サンプルの使い方

1. Samurai Smartphont Servicesの管理画面から新しくアプリを追加し、Samurai Notificationを有効にします。
<http://developer.conit.jp/console_manual/regi_sn.html>

2. iOS Dev Centerでアプリを追加し、Push用の証明書を発行します。
<http://developer.conit.jp/samurai_notification/usage/apns.html#apns-title>

3. Samurai Smartphont Servicesの管理画面で、アプリの「アクセス情報」メニューを参照しながら、サンプルソースのDefine.hを修正。

12行目の「SN_SERVER_URL」に、発行されたサーバーホスト名を入力。
`#define SN_SERVER_URL @"https://アプリに割り当てられたAPIサーバのホスト名/v2/ios/devices/"`

15行目の「SN_ACCESS_TOKEN」に、sandbox環境用のアクセストークンを入力。
`#define SN_ACCESS_TOKEN @"<SANDBOX環境token>"`

17行目の「SN_ACCESS_TOKEN」に、live環境用のアクセストークンを入力。
`#define SN_ACCESS_TOKEN @"<LIVE環境token>"`

4. アプリを実行
アプリが起動するとAPNS用のデバイストークンがAppleから取得され、サーバに送信されます。

5. Samurai Smartphont Servicesの管理画面からメッセージを送信します。
<http://developer.conit.jp/console_manual/regi_sn.html#message4ios>

以上でサンプルソースを使った、メッセージの送信と、メッセージ履歴の表示が出来ます。



# 株式会社コニット
<http://www.conit.co.jp/>

# Samurai Smartphont Services
<http://www.conit.jp/>

# Blog
<http://www.conit.co.jp/conitlabs/?p=1666>

# Facebook
<https://www.facebook.com/conit.fan>

# Twitter
<https://twitter.com/#!/conit>

