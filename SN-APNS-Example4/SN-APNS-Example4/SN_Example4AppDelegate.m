//
//  SN_Example4AppDelegate.m
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 CONIT CO.,LTD. All rights reserved.
//

#import "SN_Example4AppDelegate.h"

#import "MessageHistoryViewController.h"
#import "UserdataViewController.h"


@implementation SN_Example4AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

// midのアクセサを自動生成します。
@synthesize mid = _mid;
// midのアクセサを自動生成します。
@synthesize udt = _udt;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.mid = nil;
    self.udt = nil;
    /*
     リモート通知にをタップしてアプリが起動された場合に、launchOptionsにメッセージの情報が含まれます
     */
    if (launchOptions) {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            // リモート通知からの起動なので、mid,user_dataを取得します
            self.mid = [userInfo objectForKey:@"mid"];
            self.udt = [userInfo objectForKey:@"udt"];
        }
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 通常の起動処理
    [self.window makeKeyAndVisible];

    return YES;
}

/*
 No.9
 アプリ起動中に、リモート通知を受けた場合に呼び出されます。
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // midを取得します。
    self.mid = nil;
    self.udt = nil;
    if (userInfo) {
        self.mid = [userInfo objectForKey:@"mid"];
        self.udt = [userInfo objectForKey:@"udt"];
        
        // midをsamuraiサーバに送信するため、Appleサーバに端末のdevicetoken取得依頼を掛けます。
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     バッジを初期化します。
     ※このサンプルアプリでは起動時（バックグラウンド含む）にバッジを初期化します。
     */
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    /*
     Appleサーバに端末のdevicetoken取得依頼を掛けます
     （成功失敗は非同期でdidRegisterForRemoteNotificationsWithDeviceToken,
     didFailToRegisterForRemoteNotificationsWithErrorがコールされます）
     */
    NSLog(@"デバイストークン取得依頼");  
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    NSLog(@"画面起動");
    self.viewController = [[MessageHistoryViewController alloc] initWithNibName:@"MessageHistoryViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    if( self.udt != nil ){
        if( [self.udt hasPrefix:@"http"] ){
            // Safariを起動して指定されたURLを開く
            NSURL *url = [NSURL URLWithString:self.udt];
            [[UIApplication sharedApplication] openURL:url];
        }
        else{
            NSLog(@"user_dataで指定された画面を開く");
            // user_dataで指定された画面などを開く
            UserdataViewController* userView = [[UserdataViewController alloc] initWithNibName:@"UserdataViewController" bundle:nil];
            userView.userdata_ = self.udt;
            [self.viewController presentModalViewController:userView animated:YES];
        }
    }

    self.mid = nil;
    self.udt = nil;

}


#pragma mark == push result==
/*
 push通知のappleサーバ登録が成功した場合に呼び出されます。
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /*
     Appleサーバからdevicetokenの取得に成功した場合は、
     SamuraiNotificationサーバにdevicetokenを送信します。
     
     補足：devicetokenとは、iOSプッシュ通知の仕組みにおいて、プッシュ通知の宛先となる識別子です
     */
    
    NSLog(@"Appleサーバに登録成功しました。devicetoken=[%@]",[deviceToken description]);    
    //devicetoken送信処理
    [self sendAPNsToken:deviceToken];
}

/*
 push通知のappleサーバ登録が失敗した場合に呼び出されます。
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Appleサーバに登録失敗しました。理由[%@]",[error localizedDescription]);
}

#pragma mark == register token (samurai notification server) ==
- (void) sendAPNsToken:(NSData*)devicetoken
{
    /*
     取得したdevicetokenをsamurai notification serverに送信します。
     （成功失敗は非同期でconnectionDidFinishLoading,didFailWithErrorが呼び出されます）
     */
    NSLog(@"SamuraiNotificationサーバにdevicetokenを送信します");
    
    NSString *deviceTokenString = [[devicetoken description] 
                                   stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTokenString = [deviceTokenString 
                         stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceTokenString = [deviceTokenString 
                         stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // タグ登録のサンプル用
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    // アクセストークン、デバイストークン、言語を送信
    NSMutableString *body = [NSMutableString stringWithFormat:@"token=%@&device_token=%@&lang=%@&tags=%@", 
                             SN_ACCESS_TOKEN,
                             deviceTokenString,
                             currentLanguage,
                             currentLanguage];

    if (!self.mid) {
        // メッセージ受信後であれば、メッセージIDも送信
        body = [NSString stringWithFormat:@"%@&mid=%@", body, [self.mid integerValue]];
    }
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", 
                                       SN_SERVER_URL, SN_DEVICE_REGIST_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /*
     samurai notification serverに送信成功しました。
     */
    
    NSLog(@"SamuraiNotificationサーバに送信成功しました");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    /*
     samurai notification serverに送信失敗しました。
     */
    
    NSLog(@"SamuraiNotificationサーバに送信失敗しました。理由[%@]",[error localizedDescription]);
}

@end
