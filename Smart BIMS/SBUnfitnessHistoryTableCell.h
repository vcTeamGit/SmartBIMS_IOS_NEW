//
//  SBUnfitnessHistoryTableCell.h
//  Smart BIMS
//
//  Created by  on 11. 9. 29..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBUnfitnessHistoryTableCell : UITableViewCell
{
    UILabel* m_dateLabel;
    UILabel* m_descLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* m_dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_descLabel;

@end
