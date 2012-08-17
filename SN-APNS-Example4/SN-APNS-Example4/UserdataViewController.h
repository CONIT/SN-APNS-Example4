//
//  UserdataViewController.h
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserdataViewController : UIViewController

@property (nonatomic, strong) NSString *userdata_;
@property (nonatomic, strong) IBOutlet UITextView *txtUserdata_;
@property (nonatomic, strong) IBOutlet UIButton *btnClose_;

@end
