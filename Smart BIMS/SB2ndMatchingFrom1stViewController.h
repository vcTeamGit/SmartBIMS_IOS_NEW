//
//  SB2ndMatchingFrom1stViewController.h
//  SmartBIMS
//
//  Created by Jennis on 13. 9. 26..
//
//

#import <UIKit/UIKit.h>

#define k2BarcodeBloodNoTextField    21
#define k2BarcodeABOTypeTextField    22
#define k2BarcodeBagTextField        23
#define k2BarcodeBldBagcodeTextField 24
#define k2BarcodeAssetNo             25

#define k2BarcodeSample1TextField    211
#define k2BarcodeSample2TextField    212
#define k2BarcodeSample3TextField    213
#define k2BarcodeSample4TextField    214
#define k2BarcodeSample5TextField    215

#define k2MatchingSecondStepAlreadyProcessedActionSheetTag 2101
#define k2MatchingSecondStepConfirmActionSheetTag          2102
#define k2MatchingSecondStepIsBSDBagUseActionSheetTag      2103
#define k2MatchingSecondStepEquipIdPassAletViewTag          2104      // iOS7부터는 ActionSheet 대신 AlertView를 쓰기로 했음. 신규 tag는 AlertView로...


@class HttpRequest;
@class SBBloodnoInfoVO;
@class SBUserInfoVO;
@class SBMultiSecondMatchingViewController;

@interface SB2ndMatchingFrom1stViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBBloodnoInfoVO* m_SBBloodNoInfoVO;
    SBUserInfoVO* m_SBUserInfoVO;
    
    SBMultiSecondMatchingViewController* m_SBMultiSecondMatchingViewController;
    
    UIScrollView* m_scrollView;
    UIView* m_contentsView;
    
    UILabel* m_idNameLabel;  // 사용자 이름
    
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
    
    UITextField* m_barcodeSample1;
    UITextField* m_barcodeSample2;
    UITextField* m_barcodeSample3;
    UITextField* m_barcodeSample4;
    UITextField* m_barcodeSample5;
    
    NSMutableString* m_strBarcodeBloodNo;
    NSMutableString* m_strBarcodeABOType;
    NSMutableString* m_strBarcodeBag;
    NSMutableString* m_strBarcodeBldBagcode;
    NSMutableString* m_strBarcodeAssetNo;
    
    NSMutableString* m_strAssetChkFlag;
    
    NSMutableString* m_strBarcodeSample1;
    NSMutableString* m_strBarcodeSample2;
    NSMutableString* m_strBarcodeSample3;
    NSMutableString* m_strBarcodeSample4;
    NSMutableString* m_strBarcodeSample5;
    
    //    NSString* m_strBarcodeBloodNo;
    //    NSString* m_strBarcodeBag;
    //    NSString* m_strBarcodeABOType;
    //    NSString* m_strBarcodeBldBagcode;
    //
    //    NSString* m_strBarcodeSample1;
    //    NSString* m_strBarcodeSample2;
    //    NSString* m_strBarcodeSample3;
    //    NSString* m_strBarcodeSample4;
    //    NSString* m_strBarcodeSample5;
    
    NSMutableArray* m_bloodNoDuplicationCheckMutableArray;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
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

@property (nonatomic, retain) SBMultiSecondMatchingViewController* m_SBMultiSecondMatchingViewController;

@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIView* m_contentsView;

@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_bloodNoLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ABOTypeNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_malariaLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_BldBagLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_AssetClsNameLabel;

@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBloodNo;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeABOType;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBag;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBldBagcode;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeAssetNo;

@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample1;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample2;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample3;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample4;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeSample5;

@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;
@property (nonatomic, retain) NSMutableString* m_strBarcodeABOType;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBag;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBldBagcode;
@property (nonatomic, retain) NSMutableString* m_strBarcodeAssetNo;

@property (nonatomic, retain) NSMutableString* m_strAssetChkFlag;

@property (nonatomic, retain) NSMutableString* m_strBarcodeSample1;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample2;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample3;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample4;
@property (nonatomic, retain) NSMutableString* m_strBarcodeSample5;

@property (nonatomic, retain) NSMutableArray* m_bloodNoDuplicationCheckMutableArray;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


- (void)setUserInfo:(SBUserInfoVO*)userInfo;
- (void)setBldBagLabelText;

- (IBAction)onToHomeView:(id)sender;
//- (IBAction)onBack:(id)sender;
- (IBAction)onOK:(id)sender;
- (IBAction)pageReset:(id)sender;
- (IBAction)onToBloodEndTimeView:(id)sender;

- (IBAction)backgroundTab:(id)sender;

- (int)bloodNoDuplicationCheck:(NSString*)bloodNo;

- (void)setDelegate:(id)target selector:(SEL)selector;

// 2차 일치검사 완료여부 확인.
- (void)requestIsMatchingSecondStepCompleted:(NSString*)strBloodNo;
- (void)didReceiveIsMatchingSecondStepCompleted:(id)result;

- (void)requestBloodNoInfo;
- (void)didReceiveBloodNoInfoResponse:(id)result;

- (void)requestMatchingSecondStep;
- (void)didReceiveRequestMatchingSecondStep:(id)result;

// 채혈장비 확인
- (void)requestAssetNoCheck:(NSString*)strAssetNo;
- (void)didReceiveAssetNoInfo:(id)result;

/* commons */
//- (void)onToHomeViewFromSubView;  // subView들로부터의 메인뷰 이동요청을 처리.

@end
