//
//  SBTakeOverViewController.h
//  SmartBIMS
//
//  Created by wireline on 2017. 8. 24..
//
//

#import <UIKit/UIKit.h>

#define kSpcSampleTextFieldTag          1
#define kEtcSampleTextFieldTag          2
#define kHrgSampleTextFieldTag          3
#define kHbvSampleTextFieldTag          4
#define kMarSampleTextFieldTag          5

#define kRhnEmergencySampleTextFieldTag  6

#define kSpcSampleTextFieldTag2         7
#define kHrgSampleTextFieldTag2         8
#define kEnrSampleTextFieldTag          9

#define kIcepackTextFieldTag            11
#define kCoolantTextFieldTag            12

#define kbloodBoxCntTextFieldTag        21
#define kspcCntTextFieldTag             22

#define kTakerUserIdNoTextFieldTag      31
#define kTakerPasswordTextFieldTag      32

#define kTakeOverInfoSaveCompletedTag       101
#define kTakeOverInfoSaveFailTag            102
#define kIsNoBloodNoAtNewTakeOverSeqTag     104
#define kSaveActionValidationTag            105
#define kSaveActionValidationTakerTag       106
#define kSaveActionValidationValueTag       107

@class HttpRequest;
@class SBUserInfoVO;

@interface SBTakeOverViewController : UIViewController<UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    UIScrollView* m_scrollView;
    UIView* m_contentView;
    
    UITextField* m_spcSampleTextField;
    UITextField* m_spcSampleTextField2;
    UITextField* m_enrSampleTextField;
    UITextField* m_etcSampleTextField;
    UITextField* m_hrgSampleTextField;
    UITextField* m_hrgSampleTextField2;
    UITextField* m_hbvSampleTextField;
    UITextField* m_marSampleTextField;
    
    UITextField* m_rhnEmergencySampleTextField;
    
    UITextField* m_icepackTextField;
    UITextField* m_coolantTextField;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
    SEL m_selector;
    
    // page2
    UIView* m_secondView;
    UIScrollView* m_scrollView2;
    UIView* m_contentView2;
    
    UILabel* m_nowTimeLabel2;
    
    UILabel* m_takeSeqLabel2;  // 수거차수
    UILabel* m_bloodCntLabel2;
//    UILabel* m_spcCntLabel2;
    UILabel* m_bloodSampleTextField2;
    UILabel* m_paperCntLabel2;
    UILabel* m_ePaperCntLabel2;
    UILabel* m_assignedBloodCntLabel2;
    UILabel* m_rhnEmergencyBloodCntLabel2;
    UILabel* m_unfitPaperCntTextField2;
    UILabel* m_eUnfitPaperCntTextField2;
    UILabel* m_mal1Label2;  // 말라리아 고위험 - 0:정상, 1:제한, 2:고위험, 3:가능
    UILabel* m_mal1Label2_NotWB;
    UILabel* m_sumOfMal;
//    UILabel* m_mal3Label2;  // 말라리아 가능
    UILabel* m_bloodBoxCntTextField2;
    UILabel* m_bloodcnt1;
    
    UIActivityIndicatorView* m_activityIndicatorView2;
    
    // For Test...
    NSMutableArray* m_mDataArray;
    
    // 수거자 인증
    UIView* m_takerCertView;
    UITextField* m_takerUserIdNoTextField;
    UITextField* m_takerPasswordTextField;
    UIActivityIndicatorView* m_takerActivityIndicatorView;
    UILabel* m_takerInfoLabel;
    UILabel* m_takerIdNoLabel;
    
    // 특이사항 입력
    UIView* m_remarksView;
    UITextView* m_remarksTextView;
    UIButton* m_remarksButton;
    UIButton* getTempSaveData;
    
    // 추가사항 입력
    UITextField* m_totalbldSampleTextField;
    UITextField* m_bldPaperCntTextField;
    UITextField* m_e_bldPaperCntTextField;
    UITextField* m_unfitPaperCntTextField;
    UITextField* m_e_unfitPaperCntTextField;
    UITextField* m_bldBoxCntTextField;
    
    //신규 표시 6개 라벨
    UITextView* numOfRBC320;
    UITextView* numOfRBC400;
    UITextView* numOFFRBC;
    UITextView* numOFPLA;
    UITextView* numOFAPLT;
    UITextView* numOFPLTAM;
    UITextView* numOFPLAM;
    
    UITextView* numOF400D;
    UITextView* numOF400Q;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;
@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIView* m_contentView;

@property (nonatomic, retain) IBOutlet UITextField* m_spcSampleTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_spcSampleTextField2;
@property (nonatomic, retain) IBOutlet UITextField* m_enrSampleTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_etcSampleTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_hrgSampleTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_hrgSampleTextField2;
@property (nonatomic, retain) IBOutlet UITextField* m_hbvSampleTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_marSampleTextField;

@property (nonatomic, retain) IBOutlet UITextField* m_rhnEmergencySampleTextField;

@property (nonatomic, retain) IBOutlet UITextField* m_icepackTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_coolantTextField;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

// page2
@property (nonatomic, retain) IBOutlet UIView* m_secondView;
@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView2;
@property (nonatomic, retain) IBOutlet UIView* m_contentView2;

@property (nonatomic, retain) IBOutlet UILabel* m_nowTimeLabel2;

@property (nonatomic, retain) IBOutlet UILabel* m_takeSeqLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodCntLabel2;
//@property (nonatomic, retain) IBOutlet UILabel* m_spcCntLabel2;

@property (nonatomic, retain) IBOutlet UILabel* m_paperCntLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_ePaperCntLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_assignedBloodCntLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_rhnEmergencyBloodCntLabel2;

@property (nonatomic, retain) IBOutlet UILabel* m_mal1Label2;
@property (retain, nonatomic) IBOutlet UILabel *m_mal1Label2_NotWB;
@property (retain, nonatomic) IBOutlet UILabel *m_sumOfMal;

//@property (nonatomic, retain) IBOutlet UILabel* m_mal3Label2;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView2;



// Label 수정
@property (nonatomic, retain) IBOutlet UILabel* m_bloodSampleTextField2;
@property (nonatomic, retain) IBOutlet UILabel* m_unfitPaperCntTextField2;
@property (nonatomic, retain) IBOutlet UILabel* m_eUnfitPaperCntTextField2;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodBoxCntTextField2;
// m_bloodSampleTextField2      혈액검체
// m_unfitPaperCntTextField2    부적격 헌혈 기록카드
// m_eUnfitPaperCntTextField2   e-부적격 헌혈 기록카드
// m_bloodBoxCntTextField2.     혈액박스 수량

@property (nonatomic, retain) NSMutableArray* m_mDataArray;

// 수거자 인증
@property (nonatomic, retain) IBOutlet UIView* m_takerCertView;
@property (nonatomic, retain) IBOutlet UITextField* m_takerUserIdNoTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_takerPasswordTextField;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_takerActivityIndicatorView;
@property (nonatomic, retain) IBOutlet UILabel* m_takerInfoLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_takerIdNoLabel;

// 특이사항
@property (nonatomic, retain) IBOutlet UIView* m_remarksView;
@property (nonatomic, retain) IBOutlet UITextView* m_remarksTextView;
@property (nonatomic, retain) IBOutlet UIButton* m_remarksButton;
// 추가사항 2020 07
@property (retain, nonatomic) IBOutlet UITextField *m_totalbldSampleTextField;
@property (retain, nonatomic) IBOutlet UITextField *m_bldPaperCntTextField;
@property (retain, nonatomic) IBOutlet UITextField *m_e_bldPaperCntTextField;
@property (retain, nonatomic) IBOutlet UITextField *m_unfitPaperCntTextField;
@property (retain, nonatomic) IBOutlet UITextField *m_e_unfitPaperCntTextField;
@property (retain, nonatomic) IBOutlet UITextField *m_bldBoxCntTextField;

@property (nonatomic, retain) IBOutlet UILabel* m_bloodcnt1;


// 신규 표시 6개 라벨
@property (retain, nonatomic) IBOutlet UITextView *numOfRBC320;
@property (retain, nonatomic) IBOutlet UITextView *numOfRBC400;
@property (retain, nonatomic) IBOutlet UITextView *numOFFRBC;
@property (retain, nonatomic) IBOutlet UITextView *numOFPLA;
@property (retain, nonatomic) IBOutlet UITextView *numOFAPLT;
@property (retain, nonatomic) IBOutlet UITextView *numOFPLTAM;
@property (retain, nonatomic) IBOutlet UITextView *numOFPLAM;
@property (retain, nonatomic) IBOutlet UITextView *numOF400D;
@property (retain, nonatomic) IBOutlet UITextView *numOF400Q;


- (void) setDelegate:(id)target selector:(SEL)selector;

- (IBAction)pageReset:(id)sender;
- (IBAction)pageReset2:(id)sender;

- (IBAction)onHomeButtonTab:(id)sender;
- (IBAction)backgroundTab:(id)sender;
- (IBAction)onBack:(id)sender;

- (IBAction)backgroundTab2:(id)sender;

- (IBAction)openTakerCertiView:(id)sender;
- (IBAction)doTakerCertify:(id)sender;

- (IBAction)openRemarksView:(id)sender;
- (IBAction)closeRemarksView:(id)sender;
- (IBAction)clearRemarksTextView:(id)sender;

- (IBAction)onHomeButtonTabFromSecondView:(id)sender;
- (IBAction)OnTempSave:(id)sender;
- (IBAction)onSearch:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)saveActionValidation:(id)sender;
- (IBAction)getTempSaveData:(UIButton *)sender;

- (void)saveActionValidationTaker;
- (void)saveActionValidationValue;
- (void)textAllReset;
- (void)didReceiveTempSave:(id)result;
- (void)showTempSaveData:(id)result;

@end
