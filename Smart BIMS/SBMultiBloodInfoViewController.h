//
//  SBMultiBloodInfoViewController.h
//  SmartBIMS
//
//  Created by  on 12. 4. 10..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kBarcodeBloodNoTextField 1


@class HttpRequest;
@class SBBloodnoInfoVO;
@class SBUserInfoVO;
// 2022.09.23 ADD HMWOO 헌혈관련증상 조회 추가
@class SBSideEffectsListViewController;
@class SBMultiFirstMatchingViewController;


@interface SBMultiBloodInfoViewController : UIViewController <UITextFieldDelegate>
{
    HttpRequest* m_httpRequest;
    SBBloodnoInfoVO* m_SBBloodnoInfoVO;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UILabel* m_idNameLabel;  // 사용자 이름
    
    NSMutableString* m_strBarcodeBloodNo;   // 혈액번호 포멧이 아닌 채로 저장
    
    UITextField* m_bloodnoBarcodeTextField;  // 헌혈자바코드
    UILabel* m_juminLabel;
    UILabel* m_nameLabel;
    
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

    // 2022.09.23 ADD HMWOO 헌혈관련증상버튼 추가
    UIButton* m_btnToSideEffectsView;
    UIButton* m_cancelButton;
    UIButton* m_toFirstMatchingViewButton;
    
    SBMultiFirstMatchingViewController* m_multiFirstMatchingViewController; 
    
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

@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;

@property (nonatomic, retain) IBOutlet UITextField* m_bloodnoBarcodeTextField;
@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;

@property (nonatomic, retain) IBOutlet UILabel* m_juminLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_nameLabel;

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

@property (nonatomic, retain) IBOutlet UIButton* m_btnToSideEffectsView;
@property (nonatomic, retain) IBOutlet UIButton* m_cancelButton;
@property (nonatomic, retain) IBOutlet UIButton* m_toFirstMatchingViewButton;

// 2022.09.23 ADD HMWOO 헌혈관련증상 조회 추가
@property (nonatomic, retain) IBOutlet SBSideEffectsListViewController* m_SBSideEffectsListViewController;
@property (nonatomic, retain) IBOutlet SBMultiFirstMatchingViewController* m_multiFirstMatchingViewController;

/* commons */
@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;



- (IBAction)pageReset:(id)sender;
- (void)setPageValues;
- (IBAction)backgroundTab:(id)sender;
- (IBAction)onBack:(id)sender; // BACK button tab event
//- (void)onBackSelector;  // BACK button tab selector

- (void)onToHomeViewFromMultiFirstMatchingViewController;
//- (void)onToHomeViewFromMultiFirstMatchingViewControllerSelector;

- (IBAction)onToFirstMatchingView:(id)sender;  // 다종성분 1차 일치검사로 이동
// 2022.09.23 ADD HMWOO 헌혈관련증상 조회 추가
- (IBAction)onToSideEffectsView:(id)sender;
// 
- (void)chkBarcodeBloodNo;  // 다종성분의 두 혈액번호 비교

- (void)setDelegate:(id)target selector:(SEL)selector;


@end
