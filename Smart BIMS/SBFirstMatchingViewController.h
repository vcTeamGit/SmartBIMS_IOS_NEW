//
//  SBFirstMatchingViewController.h
//  Smart BIMS
//
//  Created by  on 11. 8. 18..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

/*
 * 1차 일치검사
 */

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

#define kBarcodeBloodNoTextField    1
#define kBarcodeABOTypeTextField    2
#define kBarcodeBagTextField        3
#define kBarcodeMalariaTextField    4
#define kBarcodeBldBagcodeTextField 5
#define kBarcodeUDITextField        6

#define kIsMatchingFirstStepCompletedActionSheetTag     101
#define kMatchingFirstStepConfirmActionSheetTag         102
#define kMatchingFirstStepCompleteActionSheetTag        103

#define kMatchingFirstStepChkUDIActionSheetTag          104



@class HttpRequest;
@class SBBloodnoInfoVO;
@class SBUserInfoVO;
@class SB2ndMatchingFrom1stViewController;
//@class SBSideEffectsListViewController;


@interface SBFirstMatchingViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBBloodnoInfoVO* m_SBBloodnoInfoVO;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UIScrollView* m_scrollView;
    UIView* m_contentsView;
    
    UILabel* m_idNameLabel;
    UILabel* m_barcodeUDILabel;  // 전혈일경우만 UDI바코드를 체크하며, 전혈이 아닐 경우는 UDI타이틀 비활성화
    
    UITextField* m_barcodeBloodNo;
    UITextField* m_barcodeABOType;
    UITextField* m_barcodeBag;
    UITextField* m_barcodeMalaria;
    UITextField* m_barcodeBldBagcode;
    UITextField* m_barcodeUDI;
    
    NSMutableString* m_strBarcodeBloodNo;
    NSMutableString* m_strBarcodeABOType;
    NSMutableString* m_strBarcodeBag;
    NSMutableString* m_strBarcodeMalaria;
    NSMutableString* m_strBarcodeBldBagcode;
    
    NSMutableString* m_strBarcodeUDI;
    NSString* m_strMCode;
    NSString* m_strVCode;
    NSString* m_strLCode;
    
    UILabel* m_BldBagLabel;
    UILabel* m_ABOTypeNameLabel;
    
    UILabel* m_BloodCntLabel;
    
    UIButton* m_btnOK;
    UIButton* m_btnCancel;
    UIButton* m_btnToBloodEndTimeView;
//    UIButton* m_btnToSideEffectsView;
    
    UIImageView* m_firstDonationImageView;
    
    id m_target;
	SEL m_selector;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    // 바코드스캐너의 엔터값 두번 연속 입력 등으로 인해 조회 중 조회를 요청하는 오류 방지용: Y(조회중), N(조회가능)
    BOOL m_isBusy;
    
    SB2ndMatchingFrom1stViewController* m_SB2ndMatchingFrom1stViewController;
//    SBSideEffectsListViewController* m_SBSideEffectsListViewController;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBBloodnoInfoVO* m_SBBloodnoInfoVO;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIView* m_contentsView;

@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_barcodeUDILabel;

@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBloodNo;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeABOType;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBag;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeMalaria;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBldBagcode;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeUDI;

@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;
@property (nonatomic, retain) NSMutableString* m_strBarcodeABOType;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBag;
@property (nonatomic, retain) NSMutableString* m_strBarcodeMalaria;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBldBagcode;

@property (nonatomic, retain) NSMutableString* m_strBarcodeUDI;
@property (nonatomic, retain) NSString* m_strMCode;
@property (nonatomic, retain) NSString* m_strVCode;
@property (nonatomic, retain) NSString* m_strLCode;

@property (nonatomic, retain) IBOutlet UILabel* m_BldBagLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeNameLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_BloodCntLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_btnOK;
@property (nonatomic, retain) IBOutlet UIButton* m_btnCancel;
@property (nonatomic, retain) IBOutlet UIButton* m_btnToBloodEndTimeView;
//@property (nonatomic, retain) IBOutlet UIButton* m_btnToSideEffectsView;

@property (nonatomic, retain) IBOutlet UIImageView* m_firstDonationImageView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet SB2ndMatchingFrom1stViewController* m_SB2ndMatchingFrom1stViewController;
//@property (nonatomic, retain) IBOutlet SBSideEffectsListViewController* m_SBSideEffectsListViewController;


- (void)setUserInfo:(SBUserInfoVO*)userInfo;
- (void)setBldBagLabelText;

- (IBAction)pageReset:(id)sender;
- (IBAction)onToBloodEndTimeView:(id)sender;
- (IBAction)onToHomeView:(id)sender;
- (IBAction)onOK:(id)sender;
- (IBAction)onBack:(id)sender;
//- (IBAction)onToSideEffectsView:(id)sender;

//- (NSString*)getABOTypeName:(NSString*)ABOTypeCode;
//- (UIColor*)getABOTypeRGBValue:(NSString*)ABOTypeCode;
//- (UIColor*)getABOTypeBgRGBValue:(NSString*)ABOTypeCode;

- (IBAction)backgroundTab:(id)sender;

- (BOOL)barcodeValidation:(id)sender;

- (void)setDelegate:(id)target selector:(SEL)selector;

// 1차 일치검사 완료여부 확인.
- (void)requestIsMatchingFirstStepCompleted:(NSString*)strBloodNo;
- (void)didReceiveIsMatchingFirstStepCompleted:(id)result;
- (void)sliceUDI:(NSString*)udi code:(NSString*)bldproccode length:(NSString*)len;
// 1차 일치검사 실행.
- (void)requestMatcingFirstStep;
- (void)didReceiveRequestMatchingFirstStep:(id)result;
// 2차 일치검사 화면에서 홈화면으로가는 셀렉터
- (void)onToHomeViewFromSecondMatchingView;
// 헌혈관련증상자 화면에서 복귀 시 포커스 확인
//- (void)onReFocus;


@end
