//
//  SBTakeOverActionTableViewCell.h
//  SmartBIMS
//
//  Created by wireline on 2017. 8. 17..
//
//

#import <UIKit/UIKit.h>

@interface SBTakeOverActionTableViewCell : UITableViewCell
{
    UILabel* m_bloodNo;
    UIButton* m_savedFlagBtn;
    UILabel* m_bldProcNameShLabel;
    UILabel* m_assignmentBloodLabel;
    UILabel* m_rhnEmergencyBloodLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* m_bloodNo;
@property (nonatomic, retain) IBOutlet UIButton* m_savedFlagBtn;
@property (nonatomic, retain) IBOutlet UILabel* m_bldProcNameShLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_assignmentBloodLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_rhnEmergencyBloodLabel;

@end
