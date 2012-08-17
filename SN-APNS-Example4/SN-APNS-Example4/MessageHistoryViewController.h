//
//  MessageHistoryViewController.h
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageHistoryViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tblMessageView;
@property (strong, nonatomic) NSArray *messageArr;

@end
