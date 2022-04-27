//
//  SBTakeOverActionTableViewCell.m
//  SmartBIMS
//
//  Created by wireline on 2017. 8. 17..
//
//

#import "SBTakeOverActionTableViewCell.h"

@implementation SBTakeOverActionTableViewCell

@synthesize m_bloodNo;
@synthesize m_savedFlagBtn;
@synthesize m_bldProcNameShLabel;
@synthesize m_assignmentBloodLabel;
@synthesize m_rhnEmergencyBloodLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
