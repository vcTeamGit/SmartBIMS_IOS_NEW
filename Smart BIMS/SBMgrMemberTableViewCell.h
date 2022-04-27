//
//  SBMgrMemberTableViewCell.h
//  SmartBIMS
//
//  Created by  on 11. 11. 7..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBMgrMemberTableViewCell : UITableViewCell
{
    UILabel* m_idNolabel;
    UILabel* m_idNameLabel;
    UILabel* m_gbSessionLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* m_idNoLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_gbSessionLabel;

@end
