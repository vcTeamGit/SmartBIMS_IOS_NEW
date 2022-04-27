//
//  SBUnfitnessHistoryTableCell.m
//  Smart BIMS
//
//  Created by  on 11. 9. 29..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBUnfitnessHistoryTableCell.h"

@implementation SBUnfitnessHistoryTableCell

@synthesize m_dateLabel;
@synthesize m_descLabel;

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
    [m_dateLabel release];
    [m_descLabel release];
    
    [super dealloc];
}

@end
