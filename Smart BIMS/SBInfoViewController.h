//
//  SBInfoViewController.h
//  SmartBIMS
//
//  Created by  on 11. 11. 7..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HttpRequest;
@class SBUserInfoVO;

@class SBNoticeBodyViewController;

@interface SBInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    HttpRequest* m_httpRequest;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UITableView* m_tableView;
    
    NSMutableArray* m_mDataArray;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    SBNoticeBodyViewController* m_SBNoticeBodyViewController;
    
    // button for only admin
    UIButton* m_createNoticeBtn;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) IBOutlet UITableView* m_tableView;

@property (nonatomic, retain) NSMutableArray* m_mDataArray;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet SBNoticeBodyViewController* m_SBNoticeBodyViewController;

@property (nonatomic, retain) IBOutlet UIButton* m_createNoticeBtn;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (void) setDelegate:(id)target selector:(SEL)selector;

- (IBAction)onToHomeBtnTab:(id)sender;

- (void)pageReset;
- (IBAction)onSearch:(id)sender;

@end
