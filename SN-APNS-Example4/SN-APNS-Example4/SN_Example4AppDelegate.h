//
//  SN_Example4AppDelegate.h
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SN_Example4AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;

// midのpropertyを宣言します。
@property (strong, nonatomic) NSNumber *mid;
// user_dataのpropertyを宣言します。
@property (strong, nonatomic) NSString *udt;

@end
