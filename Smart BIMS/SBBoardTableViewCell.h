//
//  SBBoardTableViewCell.h
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 11..
//
//

#import <UIKit/UIKit.h>

@interface SBBoardTableViewCell : UITableViewCell
{
    UILabel* m_enterDateLabel;
    UILabel* m_enterTimeLabel;
    UILabel* m_boardTitleLabel;
    UILabel* m_startDateLabel;
    UILabel* m_endDateLabel;
    UILabel* m_enterNameLabel;
    
    NSString* m_seqno;
    
    NSString* m_indexId;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) IBOutlet UILabel* m_enterDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_enterTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_boardTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_startDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_endDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_enterNameLabel;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

@property (nonatomic, retain) NSString* m_seqno;

@property (nonatomic, retain) NSString* m_indexId;

- (IBAction)onToBoardContentView:(id)sender;
- (void) setDelegate:(id)target selector:(SEL)selector;

@end
