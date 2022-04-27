//
//  SBMultiBloodInfoViewController.m
//  SmartBIMS
//
//  Created by  on 12. 4. 10..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "SBMultiBloodInfoViewController.h"

#import "HttpRequest.h"
#import "JSON.h"
#import "SBBloodnoInfoVO.h"
#import "SBUserInfoVO.h"
#import "SBUtils.h"
#import "SBBldProcPickerViewController.h"
#import "SBMultiFirstMatchingViewController.h"

#import "Smart_BIMSAppDelegate.h"



@implementation SBMultiBloodInfoViewController

@synthesize m_httpRequest;
@synthesize m_SBBloodnoInfoVO;
@synthesize m_SBUserInfoVO;

@synthesize m_idNameLabel;

@synthesize m_bloodnoBarcodeTextField;
@synthesize m_strBarcodeBloodNo;

@synthesize m_juminLabel;
@synthesize m_nameLabel;

@synthesize m_registerImageView;
@synthesize m_marrmstImageView;

@synthesize m_heightLabel;
@synthesize m_weightLabel;

@synthesize m_bldprocNames;

@synthesize m_aboNameLabel;
@synthesize m_absLabel;
@synthesize m_subLabel;

@synthesize m_hematoLabel;
@synthesize m_plateletLabel;

@synthesize m_cancelButton;
@synthesize m_toFirstMatchingViewButton;
@synthesize m_multiFirstMatchingViewController;

/* commons */
@synthesize m_target;
@synthesize m_selector;




- (void)setPageValues
{
    self.m_juminLabel.text = [NSString stringWithFormat:@"%@-%@", m_SBBloodnoInfoVO.jumin1, m_SBBloodnoInfoVO.jumin2];
    self.m_nameLabel.text = m_SBBloodnoInfoVO.name;
    
    if([m_SBBloodnoInfoVO.registeryn isEqualToString:@"Y"]){
        self.m_registerImageView.hidden = NO;
    }else{
        self.m_registerImageView.hidden = YES;
    }
    
    if([m_SBBloodnoInfoVO.marrmstyn isEqualToString:@"Y"]){
        self.m_marrmstImageView.hidden = NO;
    }else{
        self.m_marrmstImageView.hidden = YES;
    }
    
    self.m_heightLabel.text = m_SBBloodnoInfoVO.height;
    self.m_weightLabel.text = m_SBBloodnoInfoVO.weight;
    
    self.m_aboNameLabel.text = m_SBBloodnoInfoVO.aboname;
    self.m_aboNameLabel.textColor = [SBUtils getABOTypeRGBValue:m_SBBloodnoInfoVO.abobarcode];
    self.m_absLabel.text = m_SBBloodnoInfoVO.abs;
    self.m_subLabel.text = m_SBBloodnoInfoVO.sub;
    self.m_hematoLabel.text = m_SBBloodnoInfoVO.hct_result;
    self.m_plateletLabel.text = m_SBBloodnoInfoVO.pccnt;
    
    self.m_bldprocNames.text = m_SBBloodnoInfoVO.bldprocNames;
    
//    self.m_toFirstMatchingViewButton.hidden = NO;
}


- (void)pageReset:(id)sender
{
    m_idNameLabel.text = m_SBUserInfoVO.szBimsName;
    
    self.m_bloodnoBarcodeTextField.text = @"";
    
    m_cancelButton.hidden = YES;
    m_toFirstMatchingViewButton.hidden = YES;
    
    if(m_strBarcodeBloodNo != nil){
        [m_strBarcodeBloodNo release];
        m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    [self.m_bloodnoBarcodeTextField becomeFirstResponder];
}



/*
 * 첫번째 성분에서 헌혈종류를 체크하였으므로 혈액번호가 같다면 따로 체크할 필요가 없다.
 * 바로 1차 일치검사로 이동
 */
- (IBAction)onToFirstMatchingView:(id)sender
{
    m_cancelButton.hidden = NO;
    
    // TO DO - 1차 일치검사로...
    if(m_multiFirstMatchingViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_multiFirstMatchingViewController = [[SBMultiFirstMatchingViewController alloc] initWithNibName:@"SBMultiFirstMatchingViewController"
                                                                                                      bundle:nil];
        }else{
            m_multiFirstMatchingViewController = [[SBMultiFirstMatchingViewController alloc] initWithNibName:@"SBMultiFirstMatchingViewController3"
                                                                                                      bundle:nil];
        }
    }
    
    [m_multiFirstMatchingViewController setUserInfo:self.m_SBUserInfoVO];
    [m_multiFirstMatchingViewController pageReset:nil];
    
    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    m_multiFirstMatchingViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_multiFirstMatchingViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    [m_multiFirstMatchingViewController setDelegate:self 
                                           selector:@selector(onToHomeViewFromMultiFirstMatchingViewController)];
    m_multiFirstMatchingViewController.m_SBBloodnoInfoVO = self.m_SBBloodnoInfoVO;
    [m_multiFirstMatchingViewController setBldBagLabelText];
    
    [self.view addSubview:m_multiFirstMatchingViewController.view];
    
    [UIView commitAnimations];
}



// 다종성분의 두 혈액번호바코드 비교
- (void)chkBarcodeBloodNo
{
    NSString* strAlertMsg = @"";
    NSString* strBloodNo1 = [SBUtils getParameterTypeBloodNo:m_SBBloodnoInfoVO.bloodno];
    NSString* strBloodNo2 = [SBUtils getParameterTypeBloodNo:m_strBarcodeBloodNo];
    
    if([strBloodNo1 isEqualToString:strBloodNo2] == NO){
        strAlertMsg = @"첫번째 성분과 다른 혈액번호가 입력되었습니다.";
    }else{
        m_toFirstMatchingViewButton.hidden = NO;
        [self onToFirstMatchingView:nil];
    }
    
//    if([m_SBBloodnoInfoVO.bloodno isEqualToString:m_strBarcodeBloodNo] == YES){
//        strAlertMsg = @"첫번째 바코드와 같은 바코드가 입력되었습니다.";
//    }else if([strBloodNo1 isEqualToString:strBloodNo2] == NO){
//        strAlertMsg = @"첫번째 성분과 다른 혈액번호가 입력되었습니다.";
//    }else{
//        m_toFirstMatchingViewButton.hidden = NO;
//        [self onToFirstMatchingView:nil];
//    }
    
    if([strAlertMsg isEqualToString:@""] == NO){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        [self pageReset:nil];
        return;
    }
}


///////////////////////

// 메인뷰로 이동
- (IBAction)onToHomeView:(id)sender
{
    [self backgroundTab:nil];
    
    if(m_target){
        [self backgroundTab:nil];
        [m_target performSelector:m_selector];
    }
}

// 이전 뷰로 이동
- (IBAction)onBack:(id)sender
{
//    [self backgroundTab:nil];
//    
//    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
//	self.view.frame = frame;
//	
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.5];
//	
//	self.view.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
//	
//	[UIView commitAnimations];
//	[NSTimer scheduledTimerWithTimeInterval:0.5
//									 target:self
//								   selector:@selector(onBackSelector)
//								   userInfo:nil
//									repeats:NO];
    [self backgroundTab:nil];
    
    static UIViewAnimationTransition orders[4] = {
        UIViewAnimationTransitionCurlDown,
        UIViewAnimationTransitionCurlUp,
        UIViewAnimationTransitionFlipFromLeft,
        UIViewAnimationTransitionFlipFromRight,
    };
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:orders[1]
                           forView:self.view.superview
                             cache:YES];
    
    [self.view removeFromSuperview];
    
    [UIView commitAnimations];
}


//- (void)onBackSelector
//{
//    //    [self.m_bldProcPickerViewController.view removeFromSuperview];
//	[self.view removeFromSuperview];
//}


- (void)onToHomeViewFromMultiFirstMatchingViewController
{
    [m_bloodnoBarcodeTextField resignFirstResponder];
    
    [self onToHomeView:nil];    
//    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
//	self.view.frame = frame;
//	
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.5];
//	
//	self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
//	
//	[UIView commitAnimations];
//    
//    [NSTimer scheduledTimerWithTimeInterval:0.5
//									 target:self
//								   selector:@selector(onToHomeViewFromMultiFirstMatchingViewControllerSelector)
//								   userInfo:nil
//									repeats:NO];
}


//- (void)onToHomeViewFromMultiFirstMatchingViewControllerSelector
//{
//    [self.m_multiFirstMatchingViewController.view removeFromSuperview];
//    [self.view removeFromSuperview];
//}


- (void)backgroundTab:(id)sender
{
    [self.m_bloodnoBarcodeTextField resignFirstResponder];
}


- (void)setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
    self.m_selector = selector;
}



// For Test...
- (IBAction)onOK:(id)sender
{
    [m_strBarcodeBloodNo setString:m_bloodnoBarcodeTextField.text];
    m_bloodnoBarcodeTextField.text = [SBUtils formatBloodNo:[NSString stringWithString:m_strBarcodeBloodNo]];
    [self chkBarcodeBloodNo];
}



#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    //    NSString* strInput = textField.text;
    NSUInteger strLength = textField.text.length;
    NSString* strAlertMsg = @"혈액번호 형식이 틀립니다.";
    
    if(m_cancelButton.isHidden == NO){
        return NO;
    }
    
    switch(nTag){
        case kBarcodeBloodNoTextField :
            if(strLength < 12){
                self.m_strBarcodeBloodNo = nil;
                [m_strBarcodeBloodNo release];
                self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
                
                m_bloodnoBarcodeTextField.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:strAlertMsg
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else if(strLength == 12){
                [m_strBarcodeBloodNo setString:m_bloodnoBarcodeTextField.text];
                m_bloodnoBarcodeTextField.text = [SBUtils formatBloodNo:[NSString stringWithString:m_strBarcodeBloodNo]];
                [self chkBarcodeBloodNo];
//                [m_bloodnoBarcodeTextField resignFirstResponder];
            }
            break;
        default:
            return YES;
    }
    
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString*)string 
{ 
    NSInteger nTag = textField.tag;
    NSString* strInput = @"";
    
    strInput = [textField.text stringByReplacingCharactersInRange:range 
                                                       withString:string];
    
    switch(nTag){
        case kBarcodeBloodNoTextField :
            if(strInput.length > 12){
                return NO;
            }
            break;
        default:
            return YES;
    }
    
    return YES;
}




#pragma mark -
#pragma mark Defaults

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
    
    m_SBBloodnoInfoVO = nil;
    
    m_cancelButton.hidden = YES;
    m_toFirstMatchingViewButton.hidden = YES;
    m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    
    [m_bloodnoBarcodeTextField becomeFirstResponder];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBBloodnoInfoVO = nil;
    self.m_SBUserInfoVO = nil;
    
    self.m_idNameLabel = nil;
    
    self.m_bloodnoBarcodeTextField = nil;
    self.m_strBarcodeBloodNo = nil;
    
    self.m_juminLabel = nil;
    self.m_nameLabel = nil;
    
    self.m_registerImageView = nil;
    self.m_marrmstImageView = nil;
    
    self.m_heightLabel = nil;
    self.m_weightLabel = nil;
    
    self.m_bldprocNames = nil;
    
    self.m_aboNameLabel = nil;
    self.m_absLabel = nil;
    self.m_subLabel = nil;
    
    self.m_hematoLabel = nil;
    self.m_plateletLabel = nil;
    
    self.m_cancelButton = nil;
    self.m_toFirstMatchingViewButton = nil;
    
    /* commons */
    self.m_target = nil;
}


- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBBloodnoInfoVO release];
    [m_SBUserInfoVO release];
    
    [m_idNameLabel release];
    
    [m_bloodnoBarcodeTextField release];
    [m_strBarcodeBloodNo release];
    
    [m_juminLabel release];
    [m_nameLabel release];
    
    [m_registerImageView release];
    [m_marrmstImageView release];
    
    [m_heightLabel release];
    [m_weightLabel release];
    
    [m_bldprocNames release];
    
    [m_aboNameLabel release];
    [m_absLabel release];
    [m_subLabel release];
    
    [m_hematoLabel release];
    [m_plateletLabel release];
    
    [m_cancelButton release];
    [m_toFirstMatchingViewButton release];

    [m_multiFirstMatchingViewController release];
    
    [m_target release];
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
