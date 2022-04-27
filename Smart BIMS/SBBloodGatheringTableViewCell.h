//
//  SBBloodGatheringTableViewCell.h
//  SmartBIMS
//
//  Created by  on 11. 11. 10..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBBloodGatheringTableViewCell : UITableViewCell
{
    UILabel* m_rowNumLabel;
    UILabel* m_carNameLabel;
    UILabel* m_bloodNoLabel;
    
    UIImageView* m_firstMatchingImage;
    UIImageView* m_secondMatchingImage;
    UIImageView* m_bloodEndTimeImage;
    
    UIImageView* m_equipmentImage;
    UIImageView* m_equipmentImageNo;
   
    UIImageView* m_beforeTakeOver;
    UIImageView* m_afterTakeOver;
    
    UIButton* m_firstMatchingBtnNO;
    UIButton* m_secondMatchingBtnNO;
    UIButton* m_bloodEndTimeBtnNO;
    
    UILabel* m_bloodEndTimeLabel;
    UILabel* m_equipmentLabel;
    
    NSMutableString* m_strBarcodeBloodNo;
}

@property (nonatomic, retain) IBOutlet UILabel* m_rowNumLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_carNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodNoLabel;

@property (nonatomic, retain) IBOutlet UIImageView* m_firstMatchingImage;
@property (nonatomic, retain) IBOutlet UIImageView* m_secondMatchingImage;
@property (nonatomic, retain) IBOutlet UIImageView* m_bloodEndTimeImage;

@property (nonatomic, retain) IBOutlet UIImageView* m_equipmentImage;
@property (nonatomic, retain) IBOutlet UIImageView* m_equipmentImageNo;
@property (nonatomic, retain) IBOutlet UILabel* m_equipmentLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_firstMatchingBtnNO;
@property (nonatomic, retain) IBOutlet UIButton* m_secondMatchingBtnNO;
@property (nonatomic, retain) IBOutlet UIButton* m_bloodEndTimeBtnNO;

@property (nonatomic, retain) IBOutlet UILabel* m_bloodEndTimeLabel;

@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;

@property (retain, nonatomic) IBOutlet UIImageView *m_beforeTakeOver;
@property (retain, nonatomic) IBOutlet UIImageView *m_afterTakeOver;


- (IBAction)onFirstMatchingTab:(id)sender;
- (IBAction)onSecondMatchingTab:(id)sender;
- (IBAction)onBloodEndTimeTab:(id)sender;

@end
