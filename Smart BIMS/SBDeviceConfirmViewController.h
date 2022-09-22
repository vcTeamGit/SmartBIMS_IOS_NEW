//
//  SBDeviceConfirmViewController.h
//  SmartBIMS
//
//  Created by  on 11. 11. 18..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

#define kPhoneNoTextFieldTag    1
#define kConfirmNoTextFieldTag  2

@class HttpRequest;
@class SBUserInfoVO;

@interface SBDeviceConfirmViewController : UIViewController <UITextFieldDelegate>
{
    HttpRequest* m_httpRequest;
    SBUserInfoVO* m_SBUserInfoVO;
    
    UILabel* m_confirmGuideLabel;
    
    UITextField* m_phoneNoTextField;
    UITextField* m_confirmNoTextField;
    
    UIButton* m_requestConfirmNoBtn;
    UIButton* m_requestConfirmBtn;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    id m_target;
	SEL m_selector;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UILabel* m_confirmGuideLabel;
@property (nonatomic, retain) IBOutlet UITextField* m_phoneNoTextField;
@property (nonatomic, retain) IBOutlet UITextField* m_confirmNoTextField;
@property (nonatomic, retain) IBOutlet UIButton* m_requestConfirmNoBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_requestConfirmBtn;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (IBAction)onRequestConfirmNo:(id)sender;
- (IBAction)onRequestConfirm:(id)sender;

- (void) setDelegate:(id)target selector:(SEL)selector;
- (void) onCompleteConfrim;

- (IBAction)backgroundTab:(id)sender;

@end
