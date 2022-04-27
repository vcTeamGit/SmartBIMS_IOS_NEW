//
//  SBBloodGatheringTableViewCell.m
//  SmartBIMS
//
//  Created by  on 11. 11. 10..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBBloodGatheringTableViewCell.h"

@implementation SBBloodGatheringTableViewCell

@synthesize m_rowNumLabel;
@synthesize m_carNameLabel;
@synthesize m_bloodNoLabel;

@synthesize m_firstMatchingImage;
@synthesize m_secondMatchingImage;
@synthesize m_bloodEndTimeImage;

@synthesize m_equipmentImage;
@synthesize m_equipmentImageNo;

@synthesize m_firstMatchingBtnNO;
@synthesize m_secondMatchingBtnNO;
@synthesize m_bloodEndTimeBtnNO;

@synthesize m_bloodEndTimeLabel;
@synthesize m_equipmentLabel;

@synthesize m_strBarcodeBloodNo;

@synthesize m_beforeTakeOver, m_afterTakeOver;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.m_strBarcodeBloodNo = nil;
        [m_strBarcodeBloodNo release];
        self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onFirstMatchingTab:(id)sender
{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                        message:@"1차 일치검사 미완료"
//                                                       delegate:self
//                                              cancelButtonTitle:@"확인"
//                                              otherButtonTitles: nil];
//    
//    
//    [alertView show];
//    [alertView release];
    
    return;
}

- (IBAction)onSecondMatchingTab:(id)sender
{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                        message:@"2차 일치검사 미완료"
//                                                       delegate:self
//                                              cancelButtonTitle:@"확인"
//                                              otherButtonTitles: nil];
//    
//    
//    [alertView show];
//    [alertView release];
    
    return;
}

- (IBAction)onBloodEndTimeTab:(id)sender
{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                        message:self.m_strBarcodeBloodNo
//                                                       delegate:self
//                                              cancelButtonTitle:@"확인"
//                                              otherButtonTitles: nil];
//    
//    
//    [alertView show];
//    [alertView release];
    
    return;
}

- (void)dealloc
{
    [m_rowNumLabel release];
    [m_carNameLabel release];
    [m_bloodNoLabel release];
    
    [m_firstMatchingImage release];
    [m_secondMatchingImage release];
    [m_bloodEndTimeImage release];
    [m_equipmentImage release];
    [m_equipmentImageNo release];
    
    [m_bloodEndTimeLabel release];
    [m_equipmentLabel release];
    
    [m_beforeTakeOver release];
    [m_afterTakeOver release];
    
    [super dealloc];
}

@end
