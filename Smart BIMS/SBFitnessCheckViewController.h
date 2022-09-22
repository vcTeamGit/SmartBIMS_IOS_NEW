//
//  SBFitnessCheckViewController.h
//  Smart BIMS
//
//  Created by  on 11. 9. 1..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"
#import "SBServerURLContent.h"

#define kJumin1TextFieldTag 1
#define kJumin2TextFieldTag 2

#define kJuminNoCheckError  11

@class HttpRequest;
@class SBUserInfoVO;
@class SBDonorFitnessInfoVO;

@class SBPreUnfitnessDetailViewController;
@class SBSideEffectCheckViewController;
@class SBUnfitnessHistoryViewController;
@class SBSpecialDetailViewController;

@interface SBFitnessCheckViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBUserInfoVO* m_SBUserInfoVO;
    
    SBDonorFitnessInfoVO* m_SBDonorFitnessInfoVO;
    
    SBPreUnfitnessDetailViewController* m_SBPreUnfitnessDetailViewController;
    SBSideEffectCheckViewController* m_SBSideEffectCheckViewController;
    SBSpecialDetailViewController* m_SBSpecialDetailViewController;
    
    SBUnfitnessHistoryViewController* m_SBUnfitnessHistoryViewController;
    
    UITextField* m_jumin1TextField;
    UITextField* m_jumin2TextField;
    
    UILabel* m_nameLabel;
    UILabel* m_ABOTypeLabel;
    UILabel* m_recentBloodDateLabel;
    UILabel* m_recentBldProcNameLabel;
    UILabel* m_ABSLabel;
    
    UILabel* m_SUBLabel;
    UILabel* m_pastOneTotalCntLabel;
    UILabel* m_pastOneWBCntLabel;
    UILabel* m_pastOnePLAPCntLabel;
    UILabel* m_pastOneLrsdpSdpCntLabel;
    
    UILabel* m_pastOnePLTPCntLabel;
    UILabel* m_pastOne2PLTCntLabel;
    UILabel* m_pastOne2RBCCntLabel;
    UILabel* m_pastOneEtcCntLabel;
    UILabel* m_bloodCntLabel;
    
    UILabel* m_pastOneTotalVolumeLabel;
    
    UILabel* m_gbmalResultLabel;
    UILabel* m_invalidTextLabel;
    UILabel* m_statusTextLabel;
    
    UIButton* m_preUnfitnessBtn;
    UIButton* m_adverseBtn;
    UIButton* m_specBtn;
    
    UIButton* m_ddrHisBtn;
    
    UIButton* m_searchBtn;
    UIButton* m_cancelBtn;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    // 부적격사유 조회 확인 뷰
    UIView* m_indivisualInfoConfirmView;
    
    UIButton* m_indivisualInfoLogOkBtn;
    UIButton* m_holdingInfoLogOkBtn;
    
    // 헌혈유보사유 조회 확인 뷰
    UIView* m_holdingInfoAgreeView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    // For Test
//    UILabel* m_testTimeLabel;
//    NSMutableString* m_strDateBefore;
//    NSMutableString* m_strDateAfter;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) SBDonorFitnessInfoVO* m_SBDonorFitnessInfoVO;

@property (nonatomic, retain) SBPreUnfitnessDetailViewController* m_SBPreUnfitnessDetailViewController;
@property (nonatomic, retain) SBSideEffectCheckViewController* m_SBSideEffectCheckViewController;
@property (nonatomic, retain) SBSpecialDetailViewController* m_SBSpecialDetailViewController;
@property (nonatomic, retain) SBUnfitnessHistoryViewController* m_SBUnfitnessHistoryViewController;

@property (nonatomic, retain) IBOutlet UITextField* m_jumin1TextField;
@property (nonatomic, retain) IBOutlet UITextField* m_jumin2TextField;

@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_recentBloodDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_recentBldProcNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ABSLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_SUBLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOneTotalCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOneWBCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOnePLAPCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOneLrsdpSdpCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_pastOnePLTPCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOne2PLTCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOne2RBCCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_pastOneEtcCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_pastOneTotalVolumeLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_gbmalResultLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_invalidTextLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_statusTextLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_preUnfitnessBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_adverseBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_specBtn;

@property (nonatomic, retain) IBOutlet UIButton* m_ddrHisBtn;

@property (nonatomic, retain) IBOutlet UIButton* m_searchBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_cancelBtn;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet UIView* m_indivisualInfoConfirmView;

@property (nonatomic, retain) IBOutlet UIButton* m_indivisualInfoLogOkBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_holdingInfoLogOkBtn;

@property (nonatomic, retain) IBOutlet UIView* m_holdingInfoAgreeView;

// For Test.
//@property (nonatomic, retain) IBOutlet UILabel* m_testTimeLabel;
//@property (nonatomic, assign) NSMutableString* m_strDateBefore;
//@property (nonatomic, assign) NSMutableString* m_strDateAfter;



- (IBAction)pageReset:(id)sender;
- (IBAction)onBack:(id)sender;
- (IBAction)backgroundTab:(id)sender;

- (IBAction)requestDonorFintessInfo;
- (void)didReceiveDonorFitnessInfo:(id)result;

- (void)setPageValues;

- (IBAction)onToPreUnFitnessPages:(id)sender;
- (IBAction)onToSideEffectPages:(id)sender;
- (IBAction)onToSpecPages:(id)sender;

- (IBAction)onIndivisualInfoConfirm:(id)sender;
- (IBAction)onHoldingInfoAgree:(id)sender;

//- (IBAction)onChangedJumin1Value:(id)sender;
//- (IBAction)onChangedJumin2Value:(id)sender;
- (BOOL)checkJuminNo;

//- (void)setCustomNumberPadConfig;

#pragma mark -
#pragma mark For Test
- (IBAction)onToDDRHisRequest:(id)sender;

@end
