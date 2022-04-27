//
//  SBTakeOverActionViewController.h
//  SmartBIMS
//
//  Created by wireline on 2017. 8. 17..
//
//

#import <UIKit/UIKit.h>

#define kBloodNoTextField               1
#define kAssignedBloodNoTextField       2
#define kRhnEmergencyBloodNoTextField   3
#define kBldProcBarCodeTextField        4

#define kDeleteBloodNoTag               11
#define kDeleteSavedBloodNoTag          12

#define kIsDuplicatedBloodNoTag         101
#define kWrongBloodNoInsertedTag        201
#define kWrongAssingedBloodNoInsertTag  202
#define kWrongRhnEmergencyBloodNoTag    203

#define kBloodInfoSaveSuccessTag        301
#define kBloodInfoSaveFailTag           302

#define kDeleteSavedBloodNoSuccessTag   311
#define kDeleteSavedBloodNoFailTag      312

@class HttpRequest;
@class SBUserInfoVO;
@class SBTakeOverActionTableViewCell;

@interface SBTakeOverActionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    NSMutableArray* m_mDataArray;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    UILabel* m_pageTitleLabel;  // 화면 상단 화면 제목
    
//    UISwitch* m_assignmentBloodSwitch;
//    UISwitch* m_rhnEmergencyBloodSwitch;
    
    UITableView* m_tableView;
    
    UITextField* m_bloodNoTextField;
    UITextField* m_assignedBloodNoTextField;
    UITextField* m_rhnEmergencyBloodNoTextField;
    
    UILabel* m_bldProcNameShLabel;
    UILabel* m_bldProcCodeLabel;
    UITextField* m_bldProcBarCodeTextField;
    
    UILabel* m_takeOverSeqLabel;
    UILabel* m_takeOverBloodCntLabel;
    
    UILabel* m_assignedBloodNoLabel;
    UILabel* m_bloodNoToLeftLabel;
    UILabel* m_bloodNoToRightLabel;
    UILabel* m_rhnEmergencyBloodNoLabel;
    UILabel* m_chkmal;
    UIButton* m_toLeftBtn;
    UIButton* m_toRightBtn;
    
    UIScrollView* m_scrollView;
    UIView* m_containerView;
    
    UITextView *numOfRBC;
    UITextView *numOfRBC400;
    UITextView *numOfFRBC;
    UITextView *numOfPLA;
    UITextView *numOfPLAM;
    UITextView *numOfAPLT;
    UITextView *numOfAPLTM;
    UITextView *numOfWB;
    
    UITextView *m_numOfBlood;
    UITextView *m_numOfBloodBag;

//    SBBoardContentViewController* m_boardContentViewController;
    NSString *m_deleteBloodNo;
    NSString *m_deleteBloodProcode;
    int m_deleteRow;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
    SEL m_selector;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) NSMutableArray* m_mDataArray;
@property (nonatomic, retain) IBOutlet UITableView* m_tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet UILabel* m_pageTitleLabel;

//@property (nonatomic, retain) IBOutlet UISwitch* m_assignmentBloodSwitch;
//@property (nonatomic, retain) IBOutlet UISwitch* m_rhnEmergencyBloodSwitch;

@property (nonatomic, retain) IBOutlet UITextField* m_bloodNoTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_assignedBloodNoTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_rhnEmergencyBloodNoTextField;

@property (nonatomic, retain) IBOutlet UILabel* m_bldProcNameShLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bldProcCodeLabel; //실제로 코드도 가져와 저장
@property (nonatomic, retain) IBOutlet UITextField* m_bldProcBarCodeTextField;
@property (retain, nonatomic) IBOutlet UILabel *m_chkmal;

@property (nonatomic, retain) IBOutlet UILabel* m_takeOverSeqLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_takeOverBloodCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_assignedBloodNoLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodNoToLeftLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodNoToRightLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_rhnEmergencyBloodNoLabel;
@property (nonatomic, retain) IBOutlet UIButton* m_toLeftBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_toRightBtn;

@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) IBOutlet UIView* m_containerView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


//신규 제제 개수 표시 라벨 추가

- (void) setDelegate:(id)target selector:(SEL)selector;
@property (retain, nonatomic) IBOutlet UITextView *numOfRBC;
@property (retain, nonatomic) IBOutlet UITextView *numOfRBC400;
@property (retain, nonatomic) IBOutlet UITextView *numOfFRBC;
@property (retain, nonatomic) IBOutlet UITextView *numOfPLA;
@property (retain, nonatomic) IBOutlet UITextView *numOfPLAM;
@property (retain, nonatomic) IBOutlet UITextView *numOfAPLT;
@property (retain, nonatomic) IBOutlet UITextView *numOfAPLTM;
@property (retain, nonatomic) IBOutlet UITextView *numOfWB;

@property (retain, nonatomic) IBOutlet UITextView *m_numOfBlood;
@property (retain, nonatomic) IBOutlet UITextView *m_numOfBloodBag;

- (IBAction)pageReset:(id)sender;

- (IBAction)onHomeButtonTab:(id)sender;
- (IBAction)backgroundTab:(id)sender;
- (IBAction)getTakeOverBloodInfoWithSeq:(id)sender;
- (void)didReceiveTakeOverBloodInfoWithSeq:(id)result;

- (IBAction)onScrollMoveLeftBtn:(id)sender;
- (IBAction)onScrollMoveRightBtn:(id)sender;

- (IBAction)onSave:(id)sender;

@end
