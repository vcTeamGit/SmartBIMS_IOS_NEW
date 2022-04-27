//
//  SBMgrInfoViewController.h
//  SmartBIMS
//
//  Created by  on 11. 10. 25..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HttpRequest;
@class SBUserInfoVO;

@class SBMgrDatePickerViewController;

@interface SBMgrInfoViewController : UIViewController <UIScrollViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UILabel* m_strMgrDateLabel;
    UIView* m_noDataLabel; // 조회결과가 없음을 나타낸다.
    
    UIButton* m_datePickerShowBtn;
    UIButton* m_beforeSchedulePageBtn;
    UIButton* m_nextSchedulePageBtn;
    
    NSMutableArray* m_mPageArray;
    int nDetailPageCnt;
    
    UIScrollView* m_scrollView;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    SBMgrDatePickerViewController* m_SBMgrDatePickerViewController;
    NSDate* m_selectedDate;
    
    BOOL m_bPickerViewMode;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UILabel* m_strMgrDateLabel;
@property (nonatomic, retain) IBOutlet UIView* m_noDataLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_datePickerShowBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_beforeSchedulePageBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_nextSchedulePageBtn;

@property (nonatomic, retain) NSMutableArray* m_mPageArray;
@property (nonatomic, assign) int m_nDetailPageCnt;

@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet SBMgrDatePickerViewController* m_SBMgrDatePickerViewController;
@property (nonatomic, retain) NSDate* m_selectedDate;

@property (nonatomic, assign) BOOL m_bPickerViewMode;


- (void)pageReset:(id)sender;
- (IBAction)backgroundTab:(id)sender;
- (IBAction)onHomeButtonTab:(id)sender;

- (IBAction)toBeforeSchedulePage:(id)sender;
- (IBAction)toNextSchedulePage:(id)sender;

- (void)requestMgrInfo;

- (void)setMgrDateValue:(id)date;

- (IBAction)toTomorrowSchedule:(id)sender;
- (IBAction)toYesterdaySchedule:(id)sender;


@end
