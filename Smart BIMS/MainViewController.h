//
//  MainViewController.h
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLogoutActionSheetTag   -9999

@class HttpRequest;
@class SBUserInfoVO;
//@class SBMatching1ViewController;
@class SBBloodInfoViewController;
@class SBSecondMatchingViewController;
@class SBBloodEndTimeViewController;
@class SBFitnessCheckViewController;
@class SBMgrInfoViewController;
@class SBInfoViewController;
@class SBBloodGatheringListViewController;
@class SBPcResultViewController;
@class SBBoardViewController;
@class SBEtcSrchStaViewController;
@class SBTakeOverActionViewController;  // 인계혈액등록
@class SBTakeOverViewController; // 혈액인계
@class SBTakeOverInfoViewController;  // 혈액인계정보조회
@class SBPairingBarcodeViewController;  // 패어링용 바코드 화면

// For module Test
@class PictureLibViewController;

@interface MainViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
{
    SBUserInfoVO* m_SBUserInfoVO;
    
    HttpRequest* m_httpRequest;
    
    UILabel* m_orgNameLabel;
    UILabel* m_userNameLabel;
    UILabel* m_siteNameLabel;
    
    /* 제제 유효기간 라벨 */
    UILabel* m_validTermWBLabel;
    UILabel* m_validTermPLTLabel;
    UILabel* m_validTermPLLabel;
    
    UILabel* m_boardLabel;
    
    UIButton* m_donorManageButton;
    UIButton* m_matching1Button;
    UIButton* m_matching2Button;
    UIButton* m_endtimeButton;
    UIButton* m_bldprocButton;
    
    UIButton* m_infoButton;
    UIButton* m_newInfoButton;
    UILabel* m_newInfoLabel;
    UIButton* btnOrgTalk;
    
    // 간호팀 공지사항 확인 안 한 갯수
    UILabel* m_newBoardListLabel;
    
//    SBMatching1ViewController* m_SBMatching1ViewController;
    SBBloodInfoViewController* m_SBBloodInfoViewController;
    SBSecondMatchingViewController* m_SBSecondMatchingViewController;
    SBBloodEndTimeViewController* m_SBBloodEndTimeViewController;
    
    SBFitnessCheckViewController* m_SBFitnessCheckViewController;
    SBMgrInfoViewController* m_SBMgrInfoViewController;
    SBInfoViewController* m_SBInfoViewController;
    SBBloodGatheringListViewController* m_SBBloodGatheringListViewController;
    
    SBPcResultViewController* m_SBPcResultViewController;
    SBBoardViewController* m_SBBoardViewController;
    SBEtcSrchStaViewController* m_SBEtcSrchStaViewController;
    
    SBTakeOverActionViewController* m_SBTakeOverActionViewController;
    SBTakeOverViewController* m_SBTakeOverViewController;
    SBTakeOverInfoViewController* m_SBTakeOverInfoViewController;
    
    id m_target;
	SEL m_selector;
    
    UIScrollView* m_scrollView;
    UIView* m_btnContainerView;
    UIPageControl* m_pageControl;
    
    // For Module Test 
    UIButton* m_testButton;
    // Pairing Barcode View
    UIButton* m_barcodeButton;
    
    PictureLibViewController* m_pictureLibViewController;
    SBPairingBarcodeViewController* m_SBPairingBarcodeViewController;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    BOOL isTimerON;
    
    // 신규 공지글 표시용
    NSTimer* m_timer;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) HttpRequest* m_httpRequest;

@property (nonatomic, retain) IBOutlet UILabel* m_orgNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_siteNameLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_validTermWBLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_validTermPLTLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_validTermPLLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_boardLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_donorManageButton;
@property (nonatomic, retain) IBOutlet UIButton* m_matching1Button;
@property (nonatomic, retain) IBOutlet UIButton* m_matching2Button;
@property (nonatomic, retain) IBOutlet UIButton* m_endtimeButton;
@property (nonatomic, retain) IBOutlet UIButton* m_bldprocButton;

@property (nonatomic, retain) IBOutlet UIButton* m_infoButton;
@property (nonatomic, retain) IBOutlet UIButton* m_newInfoButton;
@property (nonatomic, retain) IBOutlet UILabel* m_newInfoLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_newBoardListLabel;

//@property (nonatomic, retain) IBOutlet SBMatching1ViewController* m_SBMatching1ViewController;
@property (nonatomic, retain) IBOutlet SBBloodInfoViewController* m_SBBloodInfoViewController;
@property (nonatomic, retain) IBOutlet SBSecondMatchingViewController* m_SBSecondMatchingViewController;
@property (nonatomic, retain) IBOutlet SBBloodEndTimeViewController* m_SBBloodEndTimeViewController;

@property (nonatomic, retain) IBOutlet SBFitnessCheckViewController* m_SBFitnessCheckViewController;
@property (nonatomic, retain) IBOutlet SBMgrInfoViewController* m_SBMgrInfoViewController;
@property (nonatomic, retain) IBOutlet SBInfoViewController* m_SBInfoViewController;
@property (nonatomic, retain) IBOutlet SBBloodGatheringListViewController* m_SBBloodGatheringListViewController;

@property (nonatomic, retain) IBOutlet SBPcResultViewController* m_SBPcResultViewController;
@property (nonatomic, retain) IBOutlet SBBoardViewController* m_SBBoardViewController;
@property (nonatomic, retain) IBOutlet SBEtcSrchStaViewController* m_SBEtcSrchStaViewController;

@property (nonatomic, retain) IBOutlet SBTakeOverActionViewController* m_SBTakeOverActionViewController;
@property (nonatomic, retain) IBOutlet SBTakeOverViewController* m_SBTakeOverViewController;
@property (nonatomic, retain) IBOutlet SBTakeOverInfoViewController* m_SBTakeOverInfoViewController;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIView* m_btnContainerView;
@property (nonatomic, retain) IBOutlet UIPageControl* m_pageControl;

@property (strong) IBOutlet UIButton* m_testButton;
@property (strong) IBOutlet PictureLibViewController* m_pictureLibViewController;

@property (nonatomic, retain) IBOutlet UIButton* m_pairingBarcodeButton;
@property (nonatomic, retain) IBOutlet SBPairingBarcodeViewController* m_SBPariingBarcodeViewController;

@property (nonatomic, retain) NSTimer* m_timer;


- (IBAction)goFitnessCheckView:(id)sender;

- (IBAction)goMatching1View:(id)sender;
- (IBAction)goMatching2View:(id)sender;
- (IBAction)goEndtimeView:(id)sender;

- (IBAction)goMgrInfoView:(id)sender;
- (IBAction)goNotificationView:(id)sender;
- (IBAction)goInfoView:(id)sender;

- (IBAction)goPcResultView:(id)sender;

- (IBAction)goBoardView:(id)sender;
- (IBAction)goEtcSrchStaView:(id)sender;
- (IBAction)goTakeOverActionView:(id)sender;
- (IBAction)goTakeOverView:(id)sender;
- (IBAction)goTakeOverInfoView:(id)sender;

- (IBAction)logout:(id)sender;

- (IBAction)pageControllerValueChanged:(id)sender;

- (void) setDelegate:(id)target selector:(SEL)selector;

- (IBAction)showOrgTalk:(id)sender;

// For module Test
- (IBAction)goPictureLibView:(id)sender;
- (IBAction)goPairingBarcodeView:(id)sender;
// New Infomation Button Handling
- (void)getNewNoticeInfo;
- (void)showNewInfoButton:(BOOL)showCondition;
- (void)getBoardListCnt;
@property (retain, nonatomic) IBOutlet UIButton *btnOrgTalk;



@end
