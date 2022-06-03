//
//  SBMultiFirstMatchingViewController.h
//  SmartBIMS
//
//  Created by  on 12. 4. 13..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

/*
 * 1차 일치검사
 */

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"
#import "SBUtils.h"

#define kBarcodeBloodNoTextField    1
#define kBarcodeABOTypeTextField    2
#define kBarcodeBagTextField        3
#define kBarcodeMalariaTextField    4
#define kBarcodeBldBagcodeTextField 5
#define kBarcodeUDITextField        6

#define kBarcodeBloodNoTextField2    11
#define kBarcodeABOTypeTextField2    12
#define kBarcodeBagTextField2        13
#define kBarcodeMalariaTextField2    14
#define kBarcodeBldBagcodeTextField2 15

#define kIsMatchingFirstStepCompletedActionSheetTag     101
#define kMatchingFirstStepConfirmActionSheetTag         102

// 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
#define kMatchingSecondViewShowUDIActionSheetTag        103

@class HttpRequest;
@class SBBloodnoInfoVO;
@class SBUserInfoVO;


@interface SBMultiFirstMatchingViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBBloodnoInfoVO* m_SBBloodnoInfoVO;
    SBUserInfoVO* m_SBUserInfoVO;
    
//    UIScrollView* m_scrollView;
//    UIView* m_contentsView;
    UIView* m_firstView;
    UIView* m_secondView;
    
    UILabel* m_idNameLabel;  // 사용자 이름
    UILabel* m_idNameLabel2;  // 사용자 이름2
    
    /* firstView components */
    UITextField* m_barcodeBloodNo;
    UITextField* m_barcodeABOType;
    UITextField* m_barcodeBag;
    UITextField* m_barcodeMalaria;
    UITextField* m_barcodeBldBagcode;
    
    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    UITextField* m_barcodeUDI;
    
    NSMutableString* m_strBarcodeBloodNo;
    NSMutableString* m_strBarcodeABOType;
    NSMutableString* m_strBarcodeBag;
    NSMutableString* m_strBarcodeMalaria;
    NSMutableString* m_strBarcodeBldBagcode;

    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    NSMutableString* m_strBarcodeUDI;
    
    UILabel* m_BldBagLabel;
    UILabel* m_ABOTypeNameLabel;
    
    // 2022.06.03 HMWOO DEL 1차 일치검사 시 헌혈횟수 제거 요청 대응
    // UILabel* m_BloodCntLabel;
    
    UIButton* m_btnOK;
    UIButton* m_btnCancel;
    
    UIImageView* m_firstDonationImageView;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    /* secondView components */
    UITextField* m_barcodeBloodNo2;
    UITextField* m_barcodeABOType2;
    UITextField* m_barcodeBag2;
    UITextField* m_barcodeMalaria2;
    UITextField* m_barcodeBldBagcode2;
    
    NSMutableString* m_strBarcodeBloodNo2;
    NSMutableString* m_strBarcodeABOType2;
    NSMutableString* m_strBarcodeBag2;
    NSMutableString* m_strBarcodeMalaria2;
    NSMutableString* m_strBarcodeBldBagcode2;
    
    UILabel* m_BldBagLabel2;
    UILabel* m_ABOTypeNameLabel2;
    
    // 2022.06.03 HMWOO DEL 1차 일치검사 시 헌혈횟수 제거 요청 대응
    // UILabel* m_BloodCntLabel2;
    
    UIActivityIndicatorView* m_activityIndicatorView2;
    
    /* commons */
    id m_target;
	SEL m_selector;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBBloodnoInfoVO* m_SBBloodnoInfoVO;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

//@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
//@property (nonatomic, retain) IBOutlet UIView* m_contentsView;
@property (nonatomic, retain) IBOutlet UIView* m_firstView;
@property (nonatomic, retain) IBOutlet UIView* m_secondView;

@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel2;

/* firstView */
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBloodNo;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeABOType;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBag;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeMalaria;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBldBagcode;

// 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
@property (nonatomic, retain) NSMutableString* m_strBarcodeUDI;

// 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeUDI;

@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;
@property (nonatomic, retain) NSMutableString* m_strBarcodeABOType;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBag;
@property (nonatomic, retain) NSMutableString* m_strBarcodeMalaria;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBldBagcode;

@property (nonatomic, retain) IBOutlet UILabel* m_BldBagLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeNameLabel;

// 2022.06.03 HMWOO DEL 1차 일치검사 시 헌혈횟수 제거 요청 대응
// @property (nonatomic, retain) IBOutlet UILabel* m_BloodCntLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_btnOK;
@property (nonatomic, retain) IBOutlet UIButton* m_btnCancel;

@property (nonatomic, retain) IBOutlet UIImageView* m_firstDonationImageView;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

/* secondView */
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBloodNo2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeABOType2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBag2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeMalaria2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBldBagcode2;

@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeABOType2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBag2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeMalaria2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBldBagcode2;

@property (nonatomic, retain) IBOutlet UILabel* m_BldBagLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeNameLabel2;

// 2022.06.03 HMWOO DEL 1차 일치검사 시 헌혈횟수 제거 요청 대응
// @property (nonatomic, retain) IBOutlet UILabel* m_BloodCntLabel2;

@property (nonatomic, retain) IBOutlet UIButton* m_btnOK2;
@property (nonatomic, retain) IBOutlet UIButton* m_btnCancel2;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView2;

/* commons */
@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


- (void)setUserInfo:(SBUserInfoVO*)userInfo;
- (void)setBldBagLabelText;

- (IBAction)pageReset:(id)sender;
- (IBAction)onToHomeView:(id)sender;
- (IBAction)onOK:(id)sender;
- (IBAction)onBack:(id)sender;
- (IBAction)backgroundTab:(id)sender;

- (BOOL)barcodeValidation:(id)sender;

- (void)setDelegate:(id)target selector:(SEL)selector;

// 1차 일치검사 완료여부 확인.
- (void)requestIsMatchingFirstStepCompleted:(NSString*)strBloodNo;
- (void)didReceiveIsMatchingFirstStepCompleted:(id)result;
// 1차 일치검사 실행.
- (void)requestMatcingFirstStep;
- (void)didReceiveRequestMatchingFirstStep:(id)result;


/* secondView */
- (IBAction)pageReset2:(id)sender;
- (IBAction)onToHomeView2:(id)sender;
- (IBAction)onOK2:(id)sender;
- (IBAction)onBack2:(id)sender;
- (IBAction)backgroundTab2:(id)sender;

- (BOOL)barcodeValidation2:(id)sender;
- (BOOL)barcodeValidation3:(id)sender;


@end
