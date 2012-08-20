//
//  Define.h
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#ifndef SN_APNS_Example4_Define_h
#define SN_APNS_Example4_Define_h

// SN_SERVER_URLとSN_ACCESS_TOKENは、SamuraiNotification登録後に発行されますので適宜書き換えてください
#define SN_SERVER_URL @"https://アプリに割り当てられたAPIサーバのホスト名/v2/ios/devices/"
#define SN_DEVICE_REGIST_URL @"devices/"
#define SN_MESSAGE_HISTORY_URL @"messages/"

#ifdef DEBUG
#define SN_ACCESS_TOKEN @"<SANDBOX環境token>"
#else
#define SN_ACCESS_TOKEN @"<LIVE環境token>"
#endif

#endif
