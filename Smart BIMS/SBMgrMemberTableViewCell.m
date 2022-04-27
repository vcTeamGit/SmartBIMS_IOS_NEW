//
//  SBMgrMemberTableViewCell.m
//  SmartBIMS
//
//  Created by  on 11. 11. 7..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBMgrMemberTableViewCell.h"

@implementation SBMgrMemberTableViewCell

@synthesize m_idNoLabel;
@synthesize m_idNameLabel;
@synthesize m_gbSessionLabel;

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
    [m_idNoLabel release];
    [m_idNameLabel release];
    [m_gbSessionLabel release];
    
    [super dealloc];
}

@end
