//
//  SBTakeOverInfoViewController.h
//  SmartBIMS
//
//  Created by wireline on 2017. 9. 26..
//
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

#define kIsNoTakeOverInfoTag         101

@class HttpRequest;
@class SBUserInfoVO;

@interface SBTakeOverInfoViewController : UIViewController<UIScrollViewDelegate, UIAlertViewDelegate, UIPageViewControllerDelegate>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    UIPageControl* m_pageControl;
    UIScrollView* m_scrollView;
    
    NSMutableArray* m_mPageArray;
    
    NSString* m_strPageCnt;
    
    UILabel* m_totalTakeOverSeqLabel;
    UILabel* m_totalTakeOverBloodCntLabel;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}


@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) IBOutlet UIPageControl* m_pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) NSMutableArray* m_mPageArray;
@property (nonatomic, retain) NSString* m_strPageCnt;

@property (nonatomic, retain) IBOutlet UILabel* m_totalTakeOverSeqLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_totalTakeOverBloodCntLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


- (IBAction)onHomeButtonTab:(id)sender;

//- (void)setValuesWithPageCnt:(NSString*)strCnt jumin1:(NSString*)strJumin1 jumin2:(NSString*)strJumin2;

//- (IBAction)onBack:(id)sender;
- (void)onSearch:(id)sender;
- (IBAction)changePage:(id)sender;
- (void)setPages;

- (IBAction)pageControllerValueChanged:(id)sender;

@end
