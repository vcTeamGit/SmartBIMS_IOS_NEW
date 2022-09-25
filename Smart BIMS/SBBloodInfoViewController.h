//
//  SBBloodInfoViewController.h
//  Smart BIMS
//
//  Created by  on 11. 8. 17..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

#define kBldprocPickerComponentNumber 3

#define kBarcodeBloodNoTextField 1

#define kIsSideEffectsInfoActionSheetTag 101


@class HttpRequest;
@class SBBloodnoInfoVO;
@class SBUserInfoVO;
@class SBBldProcPickerViewController;
@class SBFirstMatchingViewController;
@class SBMultiBloodInfoViewController;
@class SBSideEffectsListViewController;


@interface SBBloodInfoViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBBloodnoInfoVO* m_SBBloodnoInfoVO;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UILabel* m_titleLabel;
    UILabel* m_idNameLabel;
    
    UITextField* m_bloodnoBarcodeTextField;  // 헌혈자바코드
    NSMutableString* m_strBarcodeBloodNo;
    UILabel* m_juminLabel;
    UILabel* m_nameLabel;
    // 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
    UILabel* m_bloodCntLabel;
    
    UIImageView* m_registerImageView;
    UIImageView* m_marrmstImageView;
    // 2022.09.22 ADD HMWOO 지정헌혈 여부 확인 뷰 추가
    UIImageView* m_assignImageView;
    
    UILabel* m_heightLabel;
    UILabel* m_weightLabel;
    
    UILabel* m_bldprocNames;
    
    UILabel* m_aboNameLabel;
    UILabel* m_absLabel;
    UILabel* m_subLabel;
    
    UILabel* m_hematoLabel;
    UILabel* m_plateletLabel;
    
    UIButton* m_searchButton;
    UIButton* m_toFirstMatchingViewButton;
    UIButton* m_cancelButton;
    UIButton* m_btnToSideEffectsView;
    
    
    UIButton* m_toMultiMatchingViewButton;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    SBBldProcPickerViewController* m_bldProcPickerViewController;
    SBFirstMatchingViewController* m_firstMatchingViewController;
    SBMultiBloodInfoViewController* m_multiBloodInfoViewController;
    
    BOOL m_bPickerViewMode;
    
//    NSString* m_strSubViewId;  // selector를 호출하는 subView의 ID
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    // 바코드스캐너의 엔터값 두번 연속 입력 등으로 인해 조회 중 조회를 요청하는 오류 방지용: Y(조회중), N(조회가능)
    BOOL m_isBusy;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBBloodnoInfoVO* m_SBBloodnoInfoVO;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UILabel* m_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;

@property (nonatomic, retain) IBOutlet UITextField* m_bloodnoBarcodeTextField;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;

@property (nonatomic, retain) IBOutlet UILabel* m_juminLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel;
// 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
@property (nonatomic, retain) IBOutlet UILabel* m_bloodCntLabel;

@property (nonatomic, retain) IBOutlet UIImageView* m_registerImageView;
@property (nonatomic, retain) IBOutlet UIImageView* m_marrmstImageView;
// 2022.09.22 ADD HMWOO 지정헌혈 여부 확인 뷰 추가
@property (nonatomic, retain) IBOutlet UIImageView* m_assignImageView;

@property (nonatomic, retain) IBOutlet UILabel* m_heightLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_weightLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_bldprocNames;

@property (nonatomic, retain) IBOutlet UILabel* m_aboNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_absLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_subLabel;



@property (nonatomic, retain) IBOutlet UILabel* m_hematoLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_plateletLabel;
@property (retain, nonatomic) IBOutlet UILabel *m_gbMal;

@property (nonatomic, retain) IBOutlet UIButton* m_searchButton;
@property (nonatomic, retain) IBOutlet UIButton* m_toFirstMatchingViewButton;
@property (nonatomic, retain) IBOutlet UIButton* m_cancelButton;
@property (nonatomic, retain) IBOutlet UIButton* m_btnToSideEffectsView;

@property (nonatomic, retain) IBOutlet UIButton* m_toMultiMatchingViewButton;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet SBBldProcPickerViewController* m_bldProcPickerViewController;
@property (nonatomic, retain) IBOutlet SBFirstMatchingViewController* m_firstMatchingViewController;
@property (nonatomic, retain) IBOutlet SBMultiBloodInfoViewController* m_multiBloodInfoViewController;
@property (nonatomic, retain) IBOutlet SBSideEffectsListViewController* m_SBSideEffectsListViewController;

@property (nonatomic, assign) BOOL m_bPickerViewMode;

//@property (nonatomic, retain) NSString* m_strSubViewId;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (void) setDelegate:(id)target selector:(SEL)selector;


- (IBAction)pageReset:(id)sender;

- (IBAction)onSelectBloodnoInfo:(id)sender;
- (IBAction)onHomeButtonTab:(id)sender;
//- (void)onToHomeViewFromFirstMatchingViewController;
- (IBAction)backgroundTab:(id)sender;
- (void)onToHomeViewSelector;
- (void)onToHomeViewFromSubView;  // subView들로부터의 메인뷰 이동요청을 처리.

- (IBAction)onToFirstMatchingView:(id)sender;
- (IBAction)onToMultiMatchingView:(id)sender;
- (IBAction)onToSideEffectsView:(id)sender;

- (void)didReceiveBloodInfoResponse:(id)result; // 혈액번호정보를 불러온다.
//- (NSString*)getBagInterface:(NSString*)value; // DB에 저장하는 실제 bag_interface 값을 얻는다.

- (void)stopActivityIndicatorView;

- (void)setBldProcNamesAndValues:(id)obj;

- (IBAction)onPickerViewMode:(id)sender;

- (void)didReceiveCheckBldProcAndBagCodeResponse:(id)result;

//- (IBAction)bsdValueChanged:(id)sender; // fired when BSD switch value changed.


@end
