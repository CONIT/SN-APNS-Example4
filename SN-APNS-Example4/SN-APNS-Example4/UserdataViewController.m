//
//  UserdataViewController.m
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#import "UserdataViewController.h"

@interface UserdataViewController ()

@end

@implementation UserdataViewController

@synthesize userdata_ = userdata;
@synthesize txtUserdata_ = txtUserdata;
@synthesize btnClose_ = btnClose;

- (IBAction)tapCloseBtn:(UIButton *)aBtn
{
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.txtUserdata_.text = self.userdata_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
