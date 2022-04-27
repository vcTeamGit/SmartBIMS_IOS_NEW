//
//  SBSideEffectsTableViewCell.h
//  SmartBIMS
//
//  Created by wireline_mac2 on 2015. 2. 24..
//
//

#import <UIKit/UIKit.h>

@interface SBSideEffectsTableViewCell : UITableViewCell
{
    UILabel* m_bloodDate;
    UILabel* m_bloodNo;
    UILabel* m_bldProcName;
    UILabel* m_sideEffectName;
    UILabel* m_occurrenceTime;
    UILabel* m_symptomDegree;
}

@property (nonatomic, retain) IBOutlet UILabel* m_bloodDate;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodNo;
@property (nonatomic, retain) IBOutlet UILabel* m_bldProcName;
@property (nonatomic, retain) IBOutlet UILabel* m_sideEffectName;
@property (nonatomic, retain) IBOutlet UILabel* m_occurrenceTime;
@property (nonatomic, retain) IBOutlet UILabel* m_symptomDegree;

@end
