//
//  SBDeviceConfirmViewController.m
//  SmartBIMS
//
//  Created by  on 11. 11. 18..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBDeviceConfirmViewController.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBUtils.h"
#import "SBUserInfoVO.h"

#import "Smart_BIMSAppDelegate.h"

@implementation SBDeviceConfirmViewController

@synthesize m_httpRequest;
@synthesize m_SBUserInfoVO;

@synthesize m_confirmGuideLabel;
@synthesize m_phoneNoTextField;
@synthesize m_confirmNoTextField;
@synthesize m_requestConfirmNoBtn;
@synthesize m_requestConfirmBtn;

@synthesize m_activityIndicatorView;

@synthesize m_target;
@synthesize m_selector;



- (IBAction)onRequestConfirmNo:(id)sender
{
    NSString* strPhoneNo = m_phoneNoTextField.text;
    
    [self backgroundTab:nil];
    
    NSString* url = URL_DEVICE_CONFIRM;
	NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"confirmNoRequest", @"reqId",
                                m_SBUserInfoVO.szBimsId, @"strUserId",
                                m_SBUserInfoVO.szBimsPwd, @"strPassword",
                                strPhoneNo, @"strPhoneNo",
                                nil];
	[m_httpRequest setDelegate:self
					  selector:@selector(didReceiveRequestConfirmNo:)];
	[m_httpRequest requestURL:url
				   bodyObject:bodyObject];
    
    [m_activityIndicatorView startAnimating];
}

- (void)didReceiveRequestConfirmNo:(id)result
{
//    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strResultMsg = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    [m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strResult = [dictionary valueForKey:@"result"];
    strResultMsg = [dictionary valueForKey:@"resultMsg"];
    
    if([strResult isEqualToString:@"1"] == true)
    {
//        Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//        
//        delegate.g_strPhoneNo = 
        m_requestConfirmNoBtn.hidden = YES;
        m_confirmGuideLabel.hidden = NO;
        m_confirmNoTextField.hidden = NO;
        m_requestConfirmBtn.hidden = NO;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.view.frame = CGRectMake(0, -200, viewWidth, viewHeight);
        
        [UIView commitAnimations];
        
        [m_confirmNoTextField becomeFirstResponder];
    }
    else
    {
//        strAlertMsg = @"존재하지 않는 혈액번호입니다.";
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알림]"
                                                            message:strResultMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}


- (IBAction)onRequestConfirm:(id)sender
{
    NSString* strPhoneNo = m_phoneNoTextField.text;
    NSString* strConfirmNo = m_confirmNoTextField.text;
    
    [self backgroundTab:nil];
    
    NSString* url = URL_DEVICE_CONFIRM;
	NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"confirmDevice", @"reqId",
                                m_SBUserInfoVO.szBimsId, @"strUserId",
                                m_SBUserInfoVO.szBimsPwd, @"strPassword",
                                strPhoneNo, @"strPhoneNo",
                                strConfirmNo, @"strConfirmNo",
                                nil];
	[m_httpRequest setDelegate:self
					  selector:@selector(didReceiveRequestConfirm:)];
	[m_httpRequest requestURL:url
				   bodyObject:bodyObject];
    
    [m_activityIndicatorView startAnimating];
}


- (void)didReceiveRequestConfirm:(id)result
{
    //    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strResultMsg = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    [m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strResult = [dictionary valueForKey:@"result"];
    strResultMsg = [dictionary valueForKey:@"resultMsg"];
    
    if([strResult isEqualToString:@"1"] == true)
    {
        Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        delegate.g_strPhoneNo = m_phoneNoTextField.text;
        delegate.g_strConfirmNo = m_confirmNoTextField.text;
        
        TRACE(@"delegate.g_strDeviceToken = [%@]", delegate.g_strDeviceToken);
        
        // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
        NSString* url = URL_DEVICE_CONFIRM;
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"deviceTokenInput", @"reqId",
                                    delegate.g_strPhoneNo, @"strPhoneNo",
                                    delegate.g_strDeviceToken, @"deviceToken",
                                    nil];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveDeviceTokenInputResponse:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
        
        [m_activityIndicatorView startAnimating];
        
//        UIApplication* app = [UIApplication sharedApplication];
////        [[NSNotificationCenter defaultCenter] addObserver:self
////                                                 selector:@selector(applicationWillResignActive:) 
////                                                     name:UIApplicationWillResignActiveNotification
////                                                   object:app];
//
//        
//        int nRemoteNotificationTypes = [app enabledRemoteNotificationTypes];
//        
//        if(nRemoteNotificationTypes == 0){
//            //APNS 에 장치 등록
//            [app registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//            
//            //Badge 개수 설정
//            app.applicationIconBadgeNumber = 0;
//        }else{
//            [app unregisterForRemoteNotifications];
//        }
    }
    else
    {
        //        strAlertMsg = @"존재하지 않는 혈액번호입니다.";
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알림]"
                                                            message:strResultMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}

- (void)didReceiveDeviceTokenInputResponse:(id)result
{
    //    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strResultMsg = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    [m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strResult = [dictionary valueForKey:@"result"];
    strResultMsg = [dictionary valueForKey:@"resultMsg"];
    
    if([strResult isEqualToString:@"1"] == true)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알림]"
                                                            message:@"장비가 정상적으로 등록되었습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        alertView.tag = 1;
        
        [alertView show];
        [alertView release];
    }
    else
    {
        //        strAlertMsg = @"존재하지 않는 혈액번호입니다.";
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알림]"
                                                            message:@"장비등록 중 오류가 발생하였습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = -9;
        
        [alertView show];
        [alertView release];
    }
}



- (void) onCompleteConfrim
{
    [self.view removeFromSuperview];
    [m_target performSelector:m_selector];
}

//- (IBAction)onSelectMgrDate:(id)sender
//{
//    [m_target performSelector:m_selector withObject:self.m_datePicker.date];
//}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}


- (IBAction)backgroundTab:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    self.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    [UIView commitAnimations];
    
    [m_phoneNoTextField resignFirstResponder];
    [m_confirmNoTextField resignFirstResponder];
}


#pragma mark alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        [self onCompleteConfrim];
    }
}



#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    TRACE(@"textFieldDidBeginEditing");
    
    NSInteger nTag = textField.tag;
    
    if(nTag == kPhoneNoTextFieldTag){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.view.frame = CGRectMake(0, -50, viewWidth, viewHeight);
        
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.view.frame = CGRectMake(0, -200, viewWidth, viewHeight);
        
        [UIView commitAnimations];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString*)string 
{ 
    NSInteger nTag = textField.tag;    
    NSString* strInput = @"";
    
    strInput = [textField.text stringByReplacingCharactersInRange:range 
                                                       withString:string];
    
    switch(nTag){
        case kPhoneNoTextFieldTag :
            if(strInput.length > 11){
                return NO;
            }
            break;
        default:
            return YES;
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    NSString* strInput = textField.text;
    NSUInteger strLength = textField.text.length;
//    NSString* strAlertMsg = @"";
//    NSRange range = NSMakeRange(0, 10);
    
    if(strLength == 0){
        return NO;
    }
    
    switch(nTag){
        case kPhoneNoTextFieldTag :
            if(strLength < 11){
                break;
            }else if(strLength == 11){
                
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                
                //numberFormatter를 이용해서 NSNumber로 변환
                NSNumber* candidateNumber = [numberFormatter numberFromString:strInput];
                
                //nil이면 숫자가 아니므로 NO 리턴해서 입력취소
                if(candidateNumber == nil){
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                        message:@"숫자만 입력하세요."
                                                                       delegate:self
                                                              cancelButtonTitle:@"확인"
                                                              otherButtonTitles: nil];
                    
                    [alertView show];
                    [alertView release];
                    
                    return NO;
                }
                
                //원래 문자열과 숫자로 변환한 후의 값이 문자열 비교시 다르면
                //숫자가 아닌 부분이 섞여있다는 의미임
                if([[candidateNumber stringValue] compare:strInput] !=  NSOrderedSame){
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                        message:@"숫자만 입력하세요."
                                                                       delegate:self
                                                              cancelButtonTitle:@"확인"
                                                              otherButtonTitles: nil];
                    
                    [alertView show];
                    [alertView release];
                    
                    return NO;
                }
                
                [self onRequestConfirmNo:nil];
            }
            break;
        case kConfirmNoTextFieldTag :
            if(strLength < 5){
                break;
            }else if(strLength == 5){
                
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                
                //numberFormatter를 이용해서 NSNumber로 변환
                NSNumber* candidateNumber = [numberFormatter numberFromString:strInput];
                
                //nil이면 숫자가 아니므로 NO 리턴해서 입력취소
                if(candidateNumber == nil){
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                        message:@"숫자만 입력하세요."
                                                                       delegate:self
                                                              cancelButtonTitle:@"확인"
                                                              otherButtonTitles: nil];
                    
                    [alertView show];
                    [alertView release];
                    
                    return NO;
                }
                
                //원래 문자열과 숫자로 변환한 후의 값이 문자열 비교시 다르면
                //숫자가 아닌 부분이 섞여있다는 의미임
                if([[candidateNumber stringValue] compare:strInput] !=  NSOrderedSame){
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                        message:@"숫자만 입력하세요."
                                                                       delegate:self
                                                              cancelButtonTitle:@"확인"
                                                              otherButtonTitles: nil];
                    
                    [alertView show];
                    [alertView release];
                    
                    return NO;
                }
                
                [self onRequestConfirm:nil];
            }
            break;
        default:
            return YES;
    }
    
    return YES;
}


#pragma mark -
#pragma Defaults
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
    
    self.m_confirmGuideLabel.hidden = YES;
    self.m_requestConfirmBtn.hidden = YES;
    self.m_requestConfirmNoBtn.hidden = NO;
    self.m_confirmNoTextField.hidden = YES;
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    
//    self.view.frame = CGRectMake(0, -50, viewWidth, viewHeight);
//    
//    [UIView commitAnimations];
    
//    [m_phoneNoTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBUserInfoVO = nil;
    
    self.m_confirmGuideLabel = nil;
    self.m_phoneNoTextField = nil;
    self.m_confirmNoTextField = nil;
    self.m_requestConfirmNoBtn = nil;
    self.m_requestConfirmBtn = nil;
    
    self.m_activityIndicatorView = nil;
    
    self.m_selector = nil;
    self.m_target = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
