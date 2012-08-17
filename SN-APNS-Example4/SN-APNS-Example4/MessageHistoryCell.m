//
//  MessageHistoryCell.m
//  SN-APNS-Example4
//
//  Copyright (c) 2012年 Conit. All rights reserved.
//

#import "MessageHistoryCell.h"

@implementation MessageHistoryCell

@synthesize alertLbl = _alertLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
