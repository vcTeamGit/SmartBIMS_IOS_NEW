//
//  SBBloodEndTimeViewController.h
//  Smart BIMS
//
//  Created by  on 11. 8. 31..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

#define kBarcodeBloodNoTextField        1

#define kBloodEndTimeSaveActionSheetTag                   101
#define kMatchingSecondStepIsBSDBagUseActionSheetTag      103

@class HttpRequest;
@class SBUserInfoVO;

@interface SBBloodEndTimeViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    HttpRequest* m_httpRequest;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UILabel* m_idNameLabel;
    
    UILabel* m_nowTimeLabel;
    UITextField* m_barcodeBloodNo;
    
//    NSMutableString* m_strBarcodeBloodNo;
//    NSMutableString* m_strCurrentTime;
    NSString* m_strBarcodeBloodNo;
    
    UIButton* m_saveBtn;
    UIButton* m_cancelBtn;
    
    NSTimer* m_timer;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UILabel* m_idNameLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_nowTimeLabel;
@property (nonatomic, retain) IBOutlet UITextField* m_barcodeBloodNo;

//@property (nonatomic, retain) NSMutableString* m_strBarcodeBloodNo;
@property (nonatomic, retain) NSString* m_strBarcodeBloodNo;

@property (nonatomic, retain) IBOutlet UIButton* m_saveBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_cancelBtn;

@property (nonatomic, retain) NSTimer* m_timer;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;


- (void)setUserInfo:(SBUserInfoVO*)userInfo;

- (IBAction)backgroundTab:(id)sender;

- (void)timerStart;

- (IBAction)onToHomeView:(id)sender;
- (IBAction)onBack:(id)sender;

- (IBAction)onOK:(id)sender;
- (IBAction)pageReset:(id)sender;

- (void)requestBloodEndTimeSave;
- (void)didReceiveRequestBloodEndTimeSave:(id)result;


@end
