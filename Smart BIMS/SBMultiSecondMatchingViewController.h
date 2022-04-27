//
//  SBMultiSecondMatchingViewController.h
//  SmartBIMS
//
//  Created by  on 12. 4. 18..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBarcodeBloodNoTextField        1
#define kBarcodeABOTypeTextField        2
#define kBarcodeBagTextField            3
#define kBarcodeBldBagcodeTextField     4
#define kBarcodeAssetNo                 5

#define kBarcodeABOTypeTextField2       12
#define kBarcodeBagTextField2           13
#define kBarcodeBldBagcodeTextField2    14

#define kBarcodeSample1TextField2        51
#define kBarcodeSample2TextField2        52
#define kBarcodeSample3TextField2        53
#define kBarcodeSample4TextField2        54
#define kBarcodeSample5TextField2        55

#define kMatchingSecondStepAlreadyProcessedActionSheetTag 101
#define kMatchingSecondStepConfirmActionSheetTag          102
#define kMatchingSecondStepIsBSDBagUseActionSheetTag      103
#define kMatchingSecondStepEquipIdPassAletViewTag         104


@class HttpRequest;
@class SBBloodnoInfoVO;
@class SBUserInfoVO;


@interface SBMultiSecondMatchingViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBBloodnoInfoVO* m_SBBloodNoInfoVO;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UILabel* m_idNameLabel;  // 사용자 이름
    UILabel* m_idNameLabel2;  // 사용자 이름
    
    /* firstView */
    UILabel* m_bloodNoLabel;
    UILabel* m_nameLabel;
    UILabel* m_ABOTypeNameLabel;
    UILabel* m_malariaLabel;
    
    UILabel* m_BldBagLabel;
    
    UILabel* m_AssetClsNameLabel;
    
    UITextField* m_barcodeBloodNo;
    UITextField* m_barcodeABOType;
    UITextField* m_barcodeBag;
    UITextField* m_barcodeBldBagcode;
    UITextField* m_barcodeAssetNo;
    
    NSMutableString* m_strBarcodeBloodNo;
    NSMutableString* m_strBarcodeABOType;
    NSMutableString* m_strBarcodeBag;
    NSMutableString* m_strBarcodeBldBagcode;
    NSMutableString* m_strBarcodeAssetNo;
    
    NSMutableString* m_strAssetChkFlag;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    /* secondView */
    UIView* m_secondView;
    
    UILabel* m_bloodNoLabel2;
    UILabel* m_ABOTypeNameLabel2;
    UILabel* m_nameLabel2;
    UILabel* m_malariaLabel2;
    
    UILabel* m_BldBagLabel2;
    
    UILabel* m_barcodeBloodNoLabel2;
    UITextField* m_barcodeABOType2;
    UITextField* m_barcodeBag2;
    UITextField* m_barcodeBldBagcode2;
    
//    NSMutableString* m_strBarcodeBloodNo2;
    NSMutableString* m_strBarcodeABOType2;
    NSMutableString* m_strBarcodeBag2;
    NSMutableString* m_strBarcodeBldBagcode2;
    
    UITextField* m_barcodeSample1;
    UITextField* m_barcodeSample2;
    UITextField* m_barcodeSample3;
    UITextField* m_barcodeSample4;
    UITextField* m_barcodeSample5;
    
    NSMutableString* m_strBarcodeSample1;
    NSMutableString* m_strBarcodeSample2;
    NSMutableString* m_strBarcodeSample3;
    NSMutableString* m_strBarcodeSample4;
    NSMutableString* m_strBarcodeSample5;
    
    UIActivityIndicatorView* m_activityIndicatorView2;
    
    NSMutableArray* m_bloodNoDuplicationCheckMutableArray;
    NSMutableArray* m_bloodNoDuplicationCheckMutableArray2;
    
    id m_target;
	SEL m_selector;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    // 바코드스캐너의 엔터값 두번 연속 입력 등으로 인해 조회 중 조회를 요청하는 오류 방지용: Y(조회중), N(조회가능)
    BOOL m_isBusy;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBBloodnoInfoVO* m_SBBloodNoInfoVO;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel2;

/* firstView */
@property (nonatomic, retain) IBOutlet UILabel* m_bloodNoLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_malariaLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_BldBagLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_AssetClsNameLabel;

@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBloodNo;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeABOType;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBag;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBldBagcode;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeAssetNo;

@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;
@property (nonatomic, retain) NSMutableString* m_strBarcodeABOType;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBag;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBldBagcode;
@property (nonatomic, retain) NSMutableString* m_strBarcodeAssetNo;

@property (nonatomic, retain) NSMutableString* m_strAssetChkFlag;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

/* secondView */
@property (nonatomic, retain) IBOutlet UIView* m_secondView;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodNoLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeNameLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_malariaLabel2;

@property (nonatomic, retain) IBOutlet UILabel* m_BldBagLabel2;

@property (nonatomic, retain) IBOutlet UILabel* m_barcodeBloodNoLabel2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeABOType2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBag2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBldBagcode2;

//@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeABOType2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBag2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBldBagcode2;

@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample1;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample3;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample4;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample5;

@property (nonatomic, retain) NSMutableString* m_strBarcodeSample1;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample3;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample4;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample5;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView2;

@property (nonatomic, retain) NSMutableArray* m_bloodNoDuplicationCheckMutableArray;
@property (nonatomic, retain) NSMutableArray* m_bloodNoDuplicationCheckMutableArray2;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


/* firstView */
- (IBAction)setPageValues:(NSString*)strBloodNo;
- (IBAction)onBack:(id)sender;
- (IBAction)onOK:(id)sender;
- (IBAction)pageReset:(id)sender;

- (IBAction)backgroundTab:(id)sender;
- (int)bloodNoDuplicationCheck:(NSString*)bloodNo;

/* secondView */
- (IBAction)onBack2:(id)sender;
- (IBAction)onOK2:(id)sender;
- (IBAction)pageReset2:(id)sender;

- (IBAction)backgroundTab2:(id)sender;
- (int)bloodNoDuplicationCheck2:(NSString*)bloodNo;

/* commons */
- (void)setUserInfo:(SBUserInfoVO*)userInfo;
- (void)setBldBagLabelText;

- (IBAction)onToHomeView:(id)sender;

// 2차 일치검사 완료여부 확인.
- (void)requestIsMatchingSecondStepCompleted:(NSString*)strBloodNo;
- (void)didReceiveIsMatchingSecondStepCompleted:(id)result;

- (void)requestBloodNoInfo;
- (void)didReceiveBloodNoInfoResponse:(id)result;

- (void)requestMatchingSecondStep;
- (void)didReceiveRequestMatchingSecondStep:(id)result;

- (void)setDelegate:(id)target selector:(SEL)selector;

// 채혈장비 확인
- (void)requestAssetNoCheck:(NSString*)strAssetNo;
- (void)didReceiveAssetNoInfo:(id)result;

@end
