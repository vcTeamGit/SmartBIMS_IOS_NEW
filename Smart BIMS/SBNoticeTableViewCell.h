//
//  SBNoticeTableViewCell.h
//  SmartBIMS
//
//  Created by  on 11. 11. 17..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBNoticeTableViewCell : UITableViewCell
{
    UILabel* m_orgNameLabel;
    UILabel* m_idNameLabel;
    UILabel* m_dateLabel;
    UILabel* m_titleLabel;
    UILabel* m_newInfoLabel;
    
    NSString* m_strSeq;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) IBOutlet UILabel* m_orgNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_newInfoLabel;

@property (nonatomic, retain) NSString* m_strSeq;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (IBAction)onSelected:(id)sender;
- (void) setDelegate:(id)target selector:(SEL)selector;

@end
