//
//  SBSideEffectsTableViewCell.m
//  SmartBIMS
//
//  Created by wireline_mac2 on 2015. 2. 24..
//
//

#import "SBSideEffectsTableViewCell.h"

@implementation SBSideEffectsTableViewCell

@synthesize m_bloodDate;
@synthesize m_bloodNo;
@synthesize m_bldProcName;
@synthesize m_sideEffectName;
@synthesize m_occurrenceTime;
@synthesize m_symptomDegree;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
