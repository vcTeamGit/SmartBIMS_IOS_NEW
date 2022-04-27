//
//  SBNoticeTableViewCell.m
//  SmartBIMS
//
//  Created by  on 11. 11. 17..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBNoticeTableViewCell.h"

@implementation SBNoticeTableViewCell

@synthesize m_orgNameLabel;
@synthesize m_idNameLabel;
@synthesize m_dateLabel;
@synthesize m_titleLabel;
@synthesize m_newInfoLabel;

@synthesize m_strSeq;
@synthesize m_target;
@synthesize m_selector;


- (IBAction)onSelected:(id)sender
{
    [m_target performSelector:m_selector withObject:m_strSeq];
}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [m_orgNameLabel release];
    [m_idNameLabel release];
    [m_dateLabel release];
    [m_titleLabel release];
    [m_newInfoLabel release];
    
    [m_strSeq release];
    
    [m_target release];
    
    [super dealloc];
}

@end
