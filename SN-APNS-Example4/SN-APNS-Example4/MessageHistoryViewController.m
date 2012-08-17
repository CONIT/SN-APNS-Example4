//
//  MessageHistoryViewController.m
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#import "MessageHistoryViewController.h"
#import "MessageHistoryCell.h"
#import "UserdataViewController.h"


@implementation MessageHistoryViewController

@synthesize tblMessageView = _tblMessageView;
@synthesize messageArr = _messageArr;

- (void)showMessageHistory{
    
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    // タグを利用したメッセージの絞り込みサンプル
    NSString *params = [NSString stringWithFormat:@"?token=%@&tags=%@", 
                             SN_ACCESS_TOKEN,
                             currentLanguage];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", 
                                       SN_SERVER_URL, SN_MESSAGE_HISTORY_URL, params]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:@"GET"];

    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&response
                                                       error:&error];
    
    // エラー
    if (!result || error) {
        NSLog(@"request error: %@", error.description);
        return;
    }
    
    if( response.statusCode == 200 ){
        NSLog(@"%@",  [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]);
        
        NSDictionary* json = [NSJSONSerialization 
                              JSONObjectWithData:result
                              options:NSJSONReadingAllowFragments 
                              error:&error];
        
        self.messageArr = [[NSArray alloc] initWithArray: (NSArray*)[json objectForKey:@"messages"]];
    }
    
    [self.tblMessageView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.messageArr = [NSArray array];

    NSLog(@"画面表示");  
    [self performSelectorInBackground:@selector(showMessageHistory) withObject:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messageArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageHistoryCell";
    MessageHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil ){
        UIViewController* controller;
        controller = [[UIViewController alloc] initWithNibName:@"MessageHistoryCell" bundle:nil];
        cell = (MessageHistoryCell*)controller.view;
    }

    NSDictionary* msgData = [self.messageArr objectAtIndex:[indexPath row]];
    [cell.alertLbl setText:[msgData objectForKey:@"alert"]];
    NSString* udt = [msgData objectForKey:@"udt"];
    if( udt != nil && ![udt isEqual:[NSNull null]] && ![udt isEqual:@""]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* msgData = [self.messageArr objectAtIndex:[indexPath row]];
    NSString* udt = [msgData objectForKey:@"udt"];
    if( udt != nil && ![udt isEqual:[NSNull null]] ){
        if( [udt hasPrefix:@"http"] ){
            NSLog(@"URLを開きます[%@]", udt);
            // Safariを起動して指定されたURLを開く
            NSURL *url = [NSURL URLWithString:udt];
            [[UIApplication sharedApplication] openURL:url];
        }
        else{
            // do something
            // user_dataで指定された画面などを開く
            UserdataViewController* userView = [[UserdataViewController alloc] initWithNibName:@"UserdataViewController" bundle:nil];
            userView.userdata_ =  udt;
            [self presentModalViewController:userView animated:YES];
        }

    }
}

@end
