//
//  SBLoginMgrListViewCell.h
//  SmartBIMS
//
//  Created by  on 12. 1. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBLoginMgrListViewCell : UITableViewCell
{
    UILabel* m_carNameTitleLabel;
//    UILabel* m_carCodeLabel;
    UILabel* m_carNameLabel;
    UILabel* m_siteCodeLabel;
    UILabel* m_siteNameLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* m_carNameTitleLabel;
//@property (nonatomic, retain) IBOutlet UILabel* m_carCodeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_carNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_siteCodeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_siteNameLabel;

@end


