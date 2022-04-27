//
//  SBLoginMgrListViewCell.m
//  SmartBIMS
//
//  Created by  on 12. 1. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "SBLoginMgrListViewCell.h"

@implementation SBLoginMgrListViewCell

@synthesize m_carNameTitleLabel;
//@synthesize m_carCodeLabel;
@synthesize m_carNameLabel;
@synthesize m_siteCodeLabel;
@synthesize m_siteNameLabel;


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
    [m_carNameTitleLabel release];
//    [m_carCodeLabel release];
    [m_carNameLabel release];
    [m_siteCodeLabel release];
    [m_siteNameLabel release];
    
    [super dealloc];
}

@end
