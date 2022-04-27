//
//  SBBloodEndTimeViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 31..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBBloodEndTimeViewController.h"
#import "HttpRequest.h"
#import "SBUserInfoVO.h"
#import "SBUtils.h"
#import "JSON.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBBloodEndTimeViewController

@synthesize m_httpRequest;
@synthesize m_SBUserInfoVO;

@synthesize m_idNameLabel;

@synthesize m_nowTimeLabel;
@synthesize m_barcodeBloodNo;

@synthesize m_strBarcodeBloodNo;
//@synthesize m_strCurrentTime;

@synthesize m_saveBtn;
@synthesize m_cancelBtn;

@synthesize m_timer;
@synthesize m_activityIndicatorView;



- (void)setUserInfo:(SBUserInfoVO*)userInfo
{
    self.m_SBUserInfoVO = [[SBUserInfoVO alloc] initWithSBUserInfo:userInfo];
}


- (IBAction)onToHomeView:(id)sender
{
    [self backgroundTab:nil];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
	self.view.frame = frame;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	
	self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
	
	[UIView commitAnimations];
	
	[NSTimer scheduledTimerWithTimeInterval:0.5
									 target:self
								   selector:@selector(onToHomeViewSelector)
								   userInfo:nil
									repeats:NO];
    
}


- (void) onToHomeViewSelector
{
    [m_timer invalidate];
    [self.view removeFromSuperview];
}


- (IBAction)onBack:(id)sender
{
    [self backgroundTab:nil];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
	self.view.frame = frame;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	
	self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
	
	[UIView commitAnimations];
	
	[NSTimer scheduledTimerWithTimeInterval:0.5
									 target:self
								   selector:@selector(onToHomeViewSelector)
								   userInfo:nil
									repeats:NO];
}


- (IBAction)backgroundTab:(id)sender
{
    [self.m_barcodeBloodNo resignFirstResponder];
}


- (IBAction)onOK:(id)sender
{
    NSString* strAlertMsg = @"";
    
    self.m_strBarcodeBloodNo = m_barcodeBloodNo.text;
    self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:m_strBarcodeBloodNo];

    if(m_strBarcodeBloodNo.length == 0){
        strAlertMsg = @"혈액번호바코드를 입력하세요";
        [m_barcodeBloodNo becomeFirstResponder];
    }else if([m_strBarcodeBloodNo length] < 12){
        strAlertMsg = @"입력된 혈액번호가 정상적이지 않습니다";
        [m_barcodeBloodNo becomeFirstResponder];
    }else{
        
        NSString* strTempBloodNo = [[NSString alloc] initWithString:m_strBarcodeBloodNo];
//        strBloodNo = [strBloodNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* strTemp2BloodNo = [strTempBloodNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSRange range = NSMakeRange(0, 10);
        NSString* strBloodNo = [strTemp2BloodNo substringWithRange:range];
        
        NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBMatchingCommonDAO.jsp";
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"matchingSecondStep", @"reqId",
                                    strBloodNo, @"bloodno", 
                                    nil];
        
        //    m_httpRequest = [[HttpRequest alloc] init];
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveIsMatchingSecondStepCompleted:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
        
        self.m_saveBtn.enabled = NO;
        
        [self.m_activityIndicatorView startAnimating];
        
    }
    
    if(strAlertMsg.length > 0 || ![strAlertMsg isEqualToString:@""]){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
//    [strAlertMsg release];
}


- (IBAction)pageReset:(id)sender
{
    m_idNameLabel.text = m_SBUserInfoVO.szBimsName;
    
    m_strBarcodeBloodNo = @"";
    
    self.m_nowTimeLabel.text = @"";
    self.m_barcodeBloodNo.text = m_strBarcodeBloodNo;
    
    if([self.m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
    self.m_saveBtn.enabled = YES;
    self.m_cancelBtn.enabled = YES;
    
    [m_barcodeBloodNo becomeFirstResponder];
}


- (void)timerStart
{
    // 타이머 설정.
    m_timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(setNowTimeInfo)
                                             userInfo:nil
                                              repeats:YES];
}


- (void)setNowTimeInfo
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"] autorelease]];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString* strNowDate = [dateFormatter stringFromDate:[NSDate date]];
    
    self.m_nowTimeLabel.text = strNowDate;
}


- (void)didReceiveIsMatchingSecondStepCompleted:(id)result
{
    NSString* strData = (NSString*)result;
    NSString* strMatch01TF;
    NSString* strMatch02TF;
    NSString* strBloodEndTime;
    NSString* strIsBSDBag;
    NSString* strAlertMsg;
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData = [%@]", strData);
    //self.m_saveBtn.enabled = YES;
    [self.m_activityIndicatorView stopAnimating];
    
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
    
    strMatch01TF = [dictionary valueForKey:@"match01TF"];
    strMatch02TF = [dictionary valueForKey:@"match02TF"];
    strBloodEndTime = [dictionary valueForKey:@"bloodEndTime"];
    strIsBSDBag = [dictionary valueForKey:@"isBSDBag"]; // Deprecated.
    
    TRACE(@"bloodEndTime = [%@], isBSDBag = [%@]", strBloodEndTime, strIsBSDBag);
    TRACE(@"match01TF=[%@], match02TF=[%@]", strMatch01TF, strMatch02TF);
    
    if([strMatch01TF isEqualToString:@"false"] == YES || [strMatch01TF isEqualToString:@"(null)"] == YES || strMatch01TF == nil){
        [self pageReset:nil];
        
        strAlertMsg = @"1차 일치검사가 완료되지 않은 혈액번호입니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if([strIsBSDBag isEqualToString:@"Y"] == YES && [strMatch02TF isEqualToString:@"false"] == YES){
        NSString* strTitleMsg = @"BSD백을 사용한 혈액번호입니다.\n2차 일치검사를 먼저 진행하세요.\n첫 화면으로 돌아가시겠습니까?";
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            
            actionSheet.tag = kMatchingSecondStepIsBSDBagUseActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kMatchingSecondStepIsBSDBagUseActionSheetTag;
            
            [alertView show];
            [alertView release];
        }
        
        return;
    }
    
    NSString* strTitleMsg = @"채혈종료시간을 저장하시겠습니까?";
    
    // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
    if([[UIDevice currentDevice].systemVersion floatValue] < 7){
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                 delegate:self
                                                        cancelButtonTitle:@"아니오"
                                                   destructiveButtonTitle:@"예"
                                                        otherButtonTitles:nil];
        
        actionSheet.tag = kBloodEndTimeSaveActionSheetTag;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:strTitleMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        alertView.tag = kBloodEndTimeSaveActionSheetTag;
        
        [alertView show];
        [alertView release];
    }
//    [self requestBloodEndTimeSave];
}



- (void)requestBloodEndTimeSave
{
    NSString* strBloodNo = [SBUtils getParameterTypeBloodNo:[NSString stringWithString:m_strBarcodeBloodNo]];
    NSString* strCurrentTime = self.m_nowTimeLabel.text;
    NSString* strIdName = m_SBUserInfoVO.szBimsName;
    
    TRACE(@"strBloodNo = [%@]", strBloodNo);
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBBloodEndTimeTR.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strCurrentTime, @"strCurrentTime", 
                                strBloodNo, @"strBloodNo", 
                                strIdName, @"strIdName",
                                m_SBUserInfoVO.szBimsOrgcode, @"strOrgCode",
                                m_SBUserInfoVO.szBimsCarcode, @"strCarCode",
                                m_SBUserInfoVO.szBimsSitecode, @"strSiteCode",
                                m_SBUserInfoVO.szBimsId, @"strIdNo",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveRequestBloodEndTimeSave:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveRequestBloodEndTimeSave:(id)result
{
    NSString* strData;
    NSString* strResult;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    [self.m_activityIndicatorView stopAnimating];
    self.m_saveBtn.enabled = YES;
    
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
    
    strResult = [dictionary valueForKey:@"resultcode"];
    
    if([strResult isEqualToString:@"1"] == YES){                
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"성공"
                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        [self onToHomeView:nil];
//        [self pageReset:nil];
    }else{
        NSString* strTempMsg = [NSString stringWithFormat:@"오류코드[%@] \n%@", 
                                strResult, [dictionary valueForKey:@"resultmsg"]];
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strTempMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}




#pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if(m_SBUserInfoVO != nil)
//    {
//        if([m_SBUserInfoVO.szBimsId isEqualToString:m_textFieldId.text])
//        {
//            TRACE(@"BIMS id is %@", m_SBUserInfoVO.szBimsId);
//            m_MainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController"
//                                                                        bundle:nil];
//            m_MainViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
//            
//            CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
//            m_MainViewController.view.frame = frame;
//            
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.5];
//            
//            m_MainViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
//            [self.view addSubview:m_MainViewController.view];
//            
//            [UIView commitAnimations];
//        }
//    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kBloodEndTimeSaveActionSheetTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self requestBloodEndTimeSave];
        }else{
            [self pageReset:nil];
            return;
        }
    }else if(alertView.tag == kMatchingSecondStepIsBSDBagUseActionSheetTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self onToHomeView:nil];
        }else{
            [self pageReset:nil];
            return;
        }
    }
}




#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    TRACE(@"actionSheet Delegate!");
    if(actionSheet.tag == kBloodEndTimeSaveActionSheetTag){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self requestBloodEndTimeSave];
        }else{
//            [self onToHomeView:nil];
            [self pageReset:nil];
            return;
        }
    }else if(actionSheet.tag == kMatchingSecondStepIsBSDBagUseActionSheetTag){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self onToHomeView:nil];
        }else{
            [self pageReset:nil];
            return;
        }
    }
}



#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range 
                                                       replacementString:(NSString*)string 
{ 
    NSInteger nTag = textField.tag;
    BOOL bReturn = YES;
    
    NSString* strInput;
    
    strInput = [textField.text stringByReplacingCharactersInRange:range 
                                                       withString:string];
    
    switch(nTag){
        case kBarcodeBloodNoTextField : 
            if(strInput.length > 12){
                bReturn = NO;
            }
            break;
        default:
            bReturn = NO;
            break;
    }
    
    return bReturn;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
//    NSString* strInput = [NSString stringWithString:textField.text];
    NSUInteger strLength = textField.text.length;
    NSString* strAlertMsg = nil;
    
    switch(nTag){
        case kBarcodeBloodNoTextField :
            if(strLength < 12){
                strAlertMsg = @"혈액번호가 정확하지 않습니다.";
                self.m_barcodeBloodNo.text = @"";
            }else if(strLength == 12){
//                [self.m_strBarcodeBloodNo setString:strInput];
//                self.m_strBarcodeBloodNo = strInput;
//                self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:strInput];
                [self.m_barcodeBloodNo resignFirstResponder];
                [self onOK:nil];
            }
            break;
        default:
            return YES;
    }
    
    if(strAlertMsg != nil){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
    return YES;
}





#pragma mark - 
#pragma mark defaults

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
    
    self.m_httpRequest = [[HttpRequest alloc] init];
    
//    self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    
    [self.m_barcodeBloodNo becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBUserInfoVO = nil;
    
    self.m_nowTimeLabel = nil;
    self.m_barcodeBloodNo = nil;
    
    self.m_strBarcodeBloodNo = nil;
    
    self.m_saveBtn = nil;
    self.m_cancelBtn = nil;
    
    self.m_timer = nil;
    self.m_activityIndicatorView = nil;
}

- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBUserInfoVO release];
    
    [m_nowTimeLabel release];
    [m_barcodeBloodNo release];
    
    [m_strBarcodeBloodNo release];
    
    [m_saveBtn release];
    [m_cancelBtn release];
    
    [m_timer release];
    [m_activityIndicatorView release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
