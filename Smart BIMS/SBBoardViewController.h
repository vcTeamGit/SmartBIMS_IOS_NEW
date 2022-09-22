//
//  SBBoardViewController.h
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 11..
//
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

@class HttpRequest;
@class SBUserInfoVO;
@class SBBoardTableViewCell;
@class SBBoardContentViewController;

@interface SBBoardViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    NSMutableArray* m_mDataArray;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    UITableView* m_tableView;
    
    UISwitch* m_switch;
    UILabel* m_switchStatusLabel;
    
    SBBoardContentViewController* m_boardContentViewController;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) NSMutableArray* m_mDataArray;
@property (nonatomic, retain) IBOutlet UITableView* m_tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet UISwitch* m_switch;
@property (nonatomic, retain) IBOutlet UILabel* m_switchStatusLabel;

@property (nonatomic, retain) SBBoardContentViewController* m_boardContentViewController;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (void) setDelegate:(id)target selector:(SEL)selector;

- (IBAction)onSearch:(id)sender;
- (IBAction)onSearchBoardList:(id)sender;
- (IBAction)onSearchBoardContentList:(id)sender;
//- (void)didReceiveBoardInfo:(id)result;
- (IBAction)onSwitchStatusChange:(id)sender;

- (IBAction)onToHomeBtnTab:(id)sender;
- (IBAction)backgroundTab:(id)sender;

@end
