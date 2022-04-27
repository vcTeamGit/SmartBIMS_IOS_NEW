//
//  SBBloodGatheringListViewController.h
//  SmartBIMS
//
//  Created by  on 11. 11. 10..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBloodNoTextFieldTag 1

@class HttpRequest;
@class SBUserInfoVO;

@interface SBBloodGatheringListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    UITextField* m_bloodNoTextField;
    UIButton* m_searchBtn;
    UISwitch* m_searchConditionSwitch;
    UILabel* m_searchConditionLabel;
    UISegmentedControl* m_segmentedControl;
    
    UILabel* m_rowCntLabel;
    
    UITableView* m_tableView;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    NSMutableArray* m_mDataArray;
    
    UILabel* m_noDataLabel;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) IBOutlet UITextField* m_bloodNoTextField;
@property (nonatomic, retain) IBOutlet UIButton* m_searchBtn;
@property (nonatomic, retain) IBOutlet UISwitch* m_searchConditionSwitch;
@property (nonatomic, retain) IBOutlet UILabel* m_searchConditionLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_rowCntLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl* m_segmentedControl;

@property (nonatomic, retain) IBOutlet UITableView* m_tableView;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) NSMutableArray* m_mDataArray;

@property (nonatomic, retain) IBOutlet UILabel* m_noDataLabel;

- (IBAction)onToHomeBtnTab:(id)sender;
- (IBAction)onSearch:(id)sender;
- (void)didReceiveBloodGatheringInfo:(id)result;
- (IBAction)backgroundTab:(id)sender;
- (void)pageReset;

- (IBAction)onChangeSearchConditionSwitchValue:(id)sender;

- (IBAction)onListOrderingConditionChange:(id)sender;

@end
