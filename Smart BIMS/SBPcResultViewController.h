//
//  SBPcResultViewController.h
//  SmartBIMS
//
//  Created by  on 12. 3. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBloodNoTextField           1
#define kUsedACTextField            11
#define kCollectionTimeTextField    12
#define kWBProcessedTextField       13
#define kCycleNumTextField          14
#define kPLTVolumeTextField         15
#define kESTYieldTextField          16

@class HttpRequest;
@class SBUserInfoVO;

@interface SBPcResultViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    UIScrollView* m_scrollView;
    UIView* m_contentsView;
    
    UITextField* m_bloodNoTextField;
    
    UILabel* m_nameLabel;
    UILabel* m_interfaceLabel;
    
    UITextField* m_usedACTextField;
    UITextField* m_collectionTimeTextField;
    UITextField* m_WBProcessedTextField;
    UITextField* m_cycleNumTextField;
    UITextField* m_PLTVolumeTextField;
    UITextField* m_ESTYieldTextField;
    
    UIButton* m_searchBtn;
    UIButton* m_cancelBtn;
    UIButton* m_saveBtn;
//    UIButton* m_toSpecViewBtn;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    NSMutableString* m_mStrBloodNo;
    NSMutableArray* m_mBloodInfoArray;
    NSMutableArray* m_mErrArray;
    
    int m_nErrCnt;
    
    UIButton* m_toErrInfoViewBtn;
    
    
    /* 특이사항 뷰 관련 */
    UIView* m_errInfoView;
    
    UIButton* m_showErrInfoViewBtn;
    UIButton* m_hideErrInfoViewBtn;
    
    UISwitch* m_switch01;
    UISwitch* m_switch02;
    UISwitch* m_switch03;
    UISwitch* m_switch04;
    UISwitch* m_switch05;
    UISwitch* m_switch06;
    UISwitch* m_switch07;
    UISwitch* m_switch08;
    UISwitch* m_switch09;
    UISwitch* m_switch10;
    
    CGPoint m_start; // touch start point
    CGPoint m_startAndOriginGab;  // 터치가 시작된 점과 실제 y값의 차이를 저장.
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    // 바코드스캐너의 엔터값 두번 연속 입력 등으로 인해 조회 중 조회를 요청하는 오류 방지용: Y(조회중), N(조회가능)
    BOOL m_isBusy;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) HttpRequest* m_httpRequest;

@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIView* m_contentsView;
@property (nonatomic, retain) IBOutlet UIView* m_errInfoView;

@property (nonatomic, retain) IBOutlet UITextField* m_bloodNoTextField;

@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_interfaceLabel;

@property (nonatomic, retain) IBOutlet UITextField* m_usedACTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_collectionTimeTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_WBProcessedTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_cycleNumTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_PLTVolumeTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_ESTYieldTextField;

@property (nonatomic, retain) IBOutlet UIButton* m_searchBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_cancelBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_saveBtn;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) NSMutableString* m_mStrBloodNo;
@property (nonatomic, retain) NSMutableArray* m_mBloodInfoArray;
@property (nonatomic, retain) NSMutableArray* m_mErrArray;

@property (nonatomic, retain) IBOutlet UIButton* m_toErrInfoViewBtn;


/* 특이사항 뷰 관련 */
@property (nonatomic, retain) IBOutlet UIButton* m_showErrInfoViewBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_hideErrInfoViewBtn;

@property (nonatomic, retain) IBOutlet UISwitch* m_switch01;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch02;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch03;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch04;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch05;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch06;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch07;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch08;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch09;
@property (nonatomic, retain) IBOutlet UISwitch* m_switch10;


- (void)pageReset;
- (IBAction)onToHomeBtnTab:(id)sender;
- (IBAction)backgroundTab:(id)sender;
- (IBAction)onSearch:(id)sender;
- (IBAction)onCancel:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)toErrInfoView:(id)sender;
- (IBAction)toPcResultView:(id)sender;

//- (void)setCustomNumberPadConfig;

@end
