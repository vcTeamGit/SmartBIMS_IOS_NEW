//
//  SBPcResultViewController.m
//  SmartBIMS
//
//  Created by  on 12. 3. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "SBPcResultViewController.h"
#import "HttpRequest.h"
#import "SBUserInfoVO.h"
#import "SBUtils.h"
#import "JSON.h"

#import "Smart_BIMSAppDelegate.h"

//#define ERR_INFO_VIEW_CLOSED_HEAD_Y 410
#define ERR_INFO_VIEW_CLOSED_HEAD_Y 506
#define ERR_INFO_VIEW_HEIGHT        524


@interface SBPcResultViewController ()

@end

@implementation SBPcResultViewController

@synthesize m_SBUserInfoVO;
@synthesize m_httpRequest;

@synthesize m_scrollView;
@synthesize m_contentsView;
@synthesize m_errInfoView;

@synthesize m_bloodNoTextField;

@synthesize m_nameLabel;
@synthesize m_interfaceLabel;

@synthesize m_usedACTextField;
@synthesize m_collectionTimeTextField;
@synthesize m_WBProcessedTextField;
@synthesize m_cycleNumTextField;
@synthesize m_PLTVolumeTextField;
@synthesize m_ESTYieldTextField;

@synthesize m_searchBtn;
@synthesize m_cancelBtn;
@synthesize m_saveBtn;

@synthesize m_activityIndicatorView;

@synthesize m_mStrBloodNo;
@synthesize m_mBloodInfoArray;
@synthesize m_mErrArray;

@synthesize m_toErrInfoViewBtn;

/* 특이사항 뷰 관련 */
@synthesize m_showErrInfoViewBtn;
@synthesize m_hideErrInfoViewBtn;

@synthesize m_switch01;
@synthesize m_switch02;
@synthesize m_switch03;
@synthesize m_switch04;
@synthesize m_switch05;
@synthesize m_switch06;
@synthesize m_switch07;
@synthesize m_switch08;
@synthesize m_switch09;
@synthesize m_switch10;



- (void)pageReset
{
    self.m_bloodNoTextField.text = @"";
    
    self.m_nameLabel.text = @"";
    self.m_interfaceLabel.text = @"";
    
    self.m_usedACTextField.text = @"";
    self.m_collectionTimeTextField.text = @"";
    self.m_WBProcessedTextField.text = @"";
    self.m_cycleNumTextField.text = @"";
    self.m_PLTVolumeTextField.text = @"";
    self.m_ESTYieldTextField.text = @"";
    
    self.m_searchBtn.enabled = YES;
    self.m_cancelBtn.enabled = YES;
    self.m_cancelBtn.hidden = YES;
    self.m_searchBtn.hidden = NO;
    self.m_saveBtn.hidden = YES;
    
    self.m_cycleNumTextField.userInteractionEnabled = true;
    self.m_cycleNumTextField.backgroundColor = UIColor.whiteColor;
    
    if(self.m_mStrBloodNo != nil){
        self.m_mStrBloodNo = nil;
        [m_mStrBloodNo release];
        self.m_mStrBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    [self.m_mBloodInfoArray removeAllObjects];
    [self.m_mErrArray removeAllObjects];
    
    if([m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
//    CGRect frame = CGRectMake(0, winHeight, 320, ERR_INFO_VIEW_HEIGHT);
//    m_errInfoView.frame = frame;
    
    CGRect frame = CGRectMake(10, ERR_INFO_VIEW_CLOSED_HEAD_Y, 300, ERR_INFO_VIEW_HEIGHT);
    m_errInfoView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    m_errInfoView.frame = CGRectMake(10, winHeight, 300, ERR_INFO_VIEW_HEIGHT);
    
    [UIView commitAnimations];
    
    m_showErrInfoViewBtn.hidden = NO;
    m_hideErrInfoViewBtn.hidden = YES;
    
    [m_switch01 setOn:NO];
    [m_switch02 setOn:NO];
    [m_switch03 setOn:NO];
    [m_switch04 setOn:NO];
    [m_switch05 setOn:NO];
    [m_switch06 setOn:NO];
    [m_switch07 setOn:NO];
    [m_switch08 setOn:NO];
    [m_switch09 setOn:NO];
    [m_switch10 setOn:NO];
    
    m_nErrCnt = 0;
    
    [m_toErrInfoViewBtn setTitleColor:[UIColor colorWithRed:0.13 green:0.26 blue:0.39 alpha:1.0] forState:UIControlStateNormal];
    m_toErrInfoViewBtn.hidden = YES;
    
    self.m_usedACTextField.enabled = NO;
    self.m_collectionTimeTextField.enabled = NO;
    self.m_WBProcessedTextField.enabled = NO;
    self.m_cycleNumTextField.enabled = NO;
    self.m_PLTVolumeTextField.enabled = NO;
    self.m_ESTYieldTextField.enabled = NO;
    
    [self.m_bloodNoTextField becomeFirstResponder];
}

//- (void)setCustomNumberPadConfig
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self 
//                                             selector:@selector(keyboardWillShow:) 
//                                                 name:UIKeyboardDidShowNotification 
//                                               object:nil];
//}
//
//- (void)keyboardWillShow:(NSNotification *)note {  
////    TRACE(@"keyboardWillShow");
//    // create custom button
//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    doneButton.frame = CGRectMake(0, 163, 106, 53);
//    doneButton.frame = CGRectMake(0, 163, 105, 54);
//    doneButton.adjustsImageWhenHighlighted = NO;
//    doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:22];  
//    
//    //set the label text of the button when its not pushed   
//    [doneButton setTitle:@"확 인" forState:UIControlStateNormal];
//    [doneButton setBackgroundImage:[UIImage imageNamed:@"buttonUp.png"] forState:UIControlStateNormal];
//    [doneButton setBackgroundImage:[UIImage imageNamed:@"buttonDown.png"] forState:UIControlStateHighlighted];
////    [doneButton setImage:[UIImage imageNamed:@"0.png"] forState:UIControlStateNormal];
////    [doneButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    // locate keyboard view
//    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
////    UIView* tempWindow = self.view;
//    UIView* keyboard;
//    for(int i=0; i<[tempWindow.subviews count]; i++) {
//        keyboard = [tempWindow.subviews objectAtIndex:i];
////        TRACE(@"keyboard := [%@]", [keyboard description]);
//        // keyboard view found; add the custom button to it
//        if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES){
//            [keyboard addSubview:doneButton];
//        }
//    }
//}

- (void)doneButton:(id)sender
{
//    TRACE(@"doneButton := [%@]", [sender description]);
    
    if([m_bloodNoTextField isFirstResponder] == YES){
        if(m_bloodNoTextField.text.length < 12){
            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                message:@"혈액번호 형식이 틀립니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            [alertView show];
            [alertView release];

        }else{
            [self onSearch:nil];
        }
    }else if([m_usedACTextField isFirstResponder] == YES){
        [m_collectionTimeTextField becomeFirstResponder];
    }else if([m_collectionTimeTextField isFirstResponder]){
        [m_WBProcessedTextField becomeFirstResponder];
    }else if([m_WBProcessedTextField isFirstResponder]){
        [m_cycleNumTextField becomeFirstResponder];
    }else if([m_cycleNumTextField isFirstResponder]){
        [m_PLTVolumeTextField becomeFirstResponder];
    }else if([m_PLTVolumeTextField isFirstResponder]){
        [m_ESTYieldTextField becomeFirstResponder];
    }else if([m_ESTYieldTextField isFirstResponder]){
        [m_ESTYieldTextField resignFirstResponder];
        CGPoint point = CGPointMake(0, 0);
        [m_scrollView setContentOffset:point animated:YES];
        [self onSave:nil];
    }
}

- (IBAction)onToHomeBtnTab:(id)sender
{
    [self backgroundTab:nil];
    
    CGRect frame = CGRectMake(0, 0, 320, viewHeight);
	self.view.frame = frame;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	
	self.view.frame = CGRectMake(0, winHeight, 320, viewHeight);
	
	[UIView commitAnimations];
	[NSTimer scheduledTimerWithTimeInterval:0.5
									 target:self
								   selector:@selector(onToHomeViewSelector)
								   userInfo:nil
									repeats:NO];
}

- (void) onToHomeViewSelector
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[self.view removeFromSuperview];
}

- (IBAction)backgroundTab:(id)sender
{
    [m_bloodNoTextField resignFirstResponder];
    [m_usedACTextField resignFirstResponder];
    [m_collectionTimeTextField resignFirstResponder];
    [m_WBProcessedTextField resignFirstResponder];
    [m_cycleNumTextField resignFirstResponder];
    [m_PLTVolumeTextField resignFirstResponder];
    [m_ESTYieldTextField resignFirstResponder];
    
    CGPoint point = CGPointMake(0, 0);
    [m_scrollView setContentOffset:point animated:YES];
    
//    m_cancelBtn.hidden = YES;
//    m_searchBtn.hidden = NO;
    
//    [m_bloodNoTextField becomeFirstResponder];
}


- (IBAction)onSearch:(id)sender
{
    TRACE(@"SBPcResultViewController onSearch Occurred");
    if(m_searchBtn.hidden == YES){
        return;
    }
    
    if(m_isBusy) return;
    else m_isBusy = YES;
    
    self.m_mStrBloodNo = nil;
    [m_mStrBloodNo release];
    self.m_mStrBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    
    if(m_bloodNoTextField.text.length < 12){
//        self.m_mStrBloodNo = nil;
//        [m_mStrBloodNo release];
//        self.m_mStrBloodNo = [[NSMutableString alloc] initWithCapacity:16];
        
        m_bloodNoTextField.text = @"";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                            message:@"혈액번호 형식이 틀립니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        m_isBusy = NO;
        
        return;
    }
    
    [m_mStrBloodNo setString:self.m_bloodNoTextField.text];
    m_bloodNoTextField.text = [SBUtils formatBloodNo:[NSString stringWithString:m_mStrBloodNo]];
    
    [self backgroundTab:nil];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBPcResultBloodInfoDAO.jsp";
    
    TRACE(@"1111");
    
#ifdef WIRELINE_AUTO_LOGIN_MODE
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"003", @"strOrgCode", 
                                @"51200645", @"strSiteCode",
                                @"031207610201", @"strBloodNo",
                                nil];
#else
    NSString* strBloodno = [NSString stringWithString:m_mStrBloodNo];
    NSString* strOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
    NSString* strSiteCode = [NSString stringWithString:m_SBUserInfoVO.szBimsSitecode];
    
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strOrgCode, @"strOrgCode", 
                                strSiteCode, @"strSiteCode",
                                strBloodno, @"strBloodNo",
                                nil];
#endif
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveBloodInfoResponse:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveBloodInfoResponse:(id)result
{
//    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strInfoCnt = @"";
//    NSString* strInfoResult = @"";
    NSString* strErrCnt = @"";
//    NSString* strErrResult = @"";
    NSString* strResultMsg = @"";
    
    m_isBusy = NO;
    
    [self.m_activityIndicatorView stopAnimating];
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
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
    
    strResult = [dictionary valueForKey:@"resultCode"];
    strResultMsg = [dictionary valueForKey:@"resultMsg"];
    
    strInfoCnt = [dictionary valueForKey:@"infoCnt"];
    strErrCnt = [dictionary valueForKey:@"errCnt"];
    
    int nInfoCnt = [strInfoCnt intValue];
    int nErrCnt = [strErrCnt intValue];
    
    if(nInfoCnt > 0){
        m_mBloodInfoArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"infoResult"]];
        [self setPageValues];
    }else{
        [m_mBloodInfoArray removeAllObjects];
        [self pageReset];
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:@"조회결과가 없습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if(nErrCnt > 0){
        m_mErrArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"errResult"]];
        [self setErrValues];
    }else{
        [m_mErrArray removeAllObjects];
    }
    
    if(m_nErrCnt > 0){
//        m_toErrInfoViewBtn.titleLabel.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        [m_toErrInfoViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
//        m_toErrInfoViewBtn.titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        [m_toErrInfoViewBtn setTitleColor:[UIColor colorWithRed:0.13 green:0.26 blue:0.39 alpha:1.0] forState:UIControlStateNormal];
    }
    
    CGRect frame = CGRectMake(10, winHeight, 300, ERR_INFO_VIEW_HEIGHT);
    m_errInfoView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    m_errInfoView.frame = CGRectMake(10, ERR_INFO_VIEW_CLOSED_HEAD_Y, 300, ERR_INFO_VIEW_HEIGHT);
    
    [UIView commitAnimations];
    
    self.m_usedACTextField.enabled = YES;
    self.m_collectionTimeTextField.enabled = YES;
    self.m_WBProcessedTextField.enabled = YES;
    self.m_cycleNumTextField.enabled = YES;
    self.m_PLTVolumeTextField.enabled = YES;
    self.m_ESTYieldTextField.enabled = YES;
    
    self.m_searchBtn.hidden = YES;
    self.m_cancelBtn.hidden = NO;
    self.m_saveBtn.hidden = NO;
    self.m_toErrInfoViewBtn.hidden = NO;
}


- (void)setPageValues
{
    self.m_nameLabel.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"name"];
    self.m_interfaceLabel.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"bldprocinterface_name"];
    
    self.m_usedACTextField.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"used_ac"];
    self.m_collectionTimeTextField.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"collection_time"];
    self.m_WBProcessedTextField.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"wb_processed"];
    self.m_cycleNumTextField.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"cycle_num"];
    self.m_PLTVolumeTextField.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"plt_vol"];
    self.m_ESTYieldTextField.text = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"est_yield"];
    
    NSString* chkCycle = [[m_mBloodInfoArray objectAtIndex:0] objectForKey:@"bldprocinterface_name"];
    if([chkCycle isEqualToString:@"Trima"] || [chkCycle isEqualToString:@"Amicus"]){
        self.m_cycleNumTextField.text = @"";
        //self.m_cycleNumTextField.userInteractionEnabled = false;
        self.m_cycleNumTextField.backgroundColor = UIColor.grayColor;
    }
    else{
        self.m_cycleNumTextField.backgroundColor = UIColor.whiteColor;
    }
}

- (void)setErrValues
{
    if([[[m_mErrArray objectAtIndex:0] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch01 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch01 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:1] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch02 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch02 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:2] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch03 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch03 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:3] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch04 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch04 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:4] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch05 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch05 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:5] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch06 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch06 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:6] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch07 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch07 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:7] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch08 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch08 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:8] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch09 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch09 setOn:NO];
    }
    
    if([[[m_mErrArray objectAtIndex:9] objectForKey:@"check_yn"] isEqualToString:@"Y"]){
        [self.m_switch10 setOn:YES];
        m_nErrCnt++;
    }else{
        [self.m_switch10 setOn:NO];
    }
}




- (IBAction)onCancel:(id)sender
{
    [self pageReset];
}



- (IBAction)onSave:(id)sender
{
    NSString* strErrCodes = @"";
    
    if(m_isBusy) return;
    else m_isBusy = YES;
    
    if(m_mStrBloodNo.length < 12){
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[오류]"
                                                            message:@"먼저 혈액번호를 조회하세요."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if([m_switch01 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"01,"];
    if([m_switch02 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"02,"];
    if([m_switch03 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"03,"];
    if([m_switch04 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"04,"];
    if([m_switch05 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"05,"];
    if([m_switch06 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"06,"];
    if([m_switch07 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"07,"];
    if([m_switch08 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"08,"];
    if([m_switch09 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"09,"];
    if([m_switch10 isOn]) strErrCodes = [strErrCodes stringByAppendingString:@"10,"];
    
    TRACE(@"strErrCodes := [%@]", strErrCodes);
    
    [self backgroundTab:nil];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBPcResultSaveTR.jsp";

#ifdef WIRELINE_AUTO_LOGIN_MODE
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"003", @"strOrgCode", 
                                @"51200645", @"strSiteCode",
                                @"031207610201", @"strBloodNo",
                                self.m_usedACTextField.text, @"strUsedAC",
                                self.m_collectionTimeTextField.text, @"strCollectionTime",
                                self.m_WBProcessedTextField.text, @"strProcVol",
                                self.m_cycleNumTextField.text, @"strCycleNum",
                                self.m_PLTVolumeTextField.text, @"strPLTVol",
                                self.m_ESTYieldTextField.text, @"strESTYield",
                                strErrCodes, @"strErrCodes",
                                m_SBUserInfoVO.szBimsName, @"strIdName",
                                nil];
#else
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                m_SBUserInfoVO.szBimsOrgcode, @"strOrgCode", 
                                m_SBUserInfoVO.szBimsSitecode, @"strSiteCode",
                                m_mStrBloodNo, @"strBloodNo",
                                self.m_usedACTextField.text, @"strUsedAC",
                                self.m_collectionTimeTextField.text, @"strCollectionTime",
                                self.m_WBProcessedTextField.text, @"strProcVol",
                                self.m_cycleNumTextField.text, @"strCycleNum",
                                self.m_PLTVolumeTextField.text, @"strPLTVol",
                                self.m_ESTYieldTextField.text, @"strESTYield",
                                strErrCodes, @"strErrCodes",
                                m_SBUserInfoVO.szBimsName, @"strIdName",
                                nil];
#endif
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveSaveTRResponse:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    m_searchBtn.enabled = NO;
    m_cancelBtn.enabled = NO;
    m_saveBtn.enabled = NO;
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveSaveTRResponse:(id)result
{
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strResultMsg = @"";
    
    m_isBusy = NO;
    
    [self.m_activityIndicatorView stopAnimating];
    
    m_saveBtn.enabled = YES;
    [self pageReset];
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
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
    strResultMsg = [dictionary valueForKey:@"resultmsg"];
    
    if([strResult isEqualToString:@"1"] == YES){
//        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"저장완료"
                                                            message:@"정상적으로 처리되었습니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }else{
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strResultMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}



- (IBAction)toErrInfoView:(id)sender
{
    [self backgroundTab:nil];
    
    m_showErrInfoViewBtn.hidden = YES;
    m_hideErrInfoViewBtn.hidden = NO;
    
//    CGRect frame = CGRectMake(10, ERR_INFO_VIEW_CLOSED_HEAD_Y, 300, ERR_INFO_VIEW_HEIGHT);
    CGRect frameOrigin = m_errInfoView.frame;
    CGRect frame = CGRectMake(10, frameOrigin.origin.y, 300, ERR_INFO_VIEW_HEIGHT);
    m_errInfoView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_errInfoView.frame = CGRectMake(10, 54, 300, ERR_INFO_VIEW_HEIGHT);
    
    [UIView commitAnimations];
}

- (IBAction)toPcResultView:(id)sender
{
    m_showErrInfoViewBtn.hidden = NO;
    m_hideErrInfoViewBtn.hidden = YES;
    
//    CGRect frame = CGRectMake(10, 54, 300, ERR_INFO_VIEW_HEIGHT);
    CGRect frameOrigin = m_errInfoView.frame;
    CGRect frame = CGRectMake(10, frameOrigin.origin.y, 300, ERR_INFO_VIEW_HEIGHT);
    m_errInfoView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_errInfoView.frame = CGRectMake(10, ERR_INFO_VIEW_CLOSED_HEAD_Y, 300, ERR_INFO_VIEW_HEIGHT);
    
    [UIView commitAnimations];
}


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //    TRACE(@"actionSheet Delegate!");
    //    if(actionSheet.tag == kBloodEndTimeSaveActionSheetTag){
    //        if(buttonIndex != [actionSheet cancelButtonIndex]){
    //            [self requestBloodEndTimeSave];
    //        }else{
    //            [self onToHomeView:nil];
    //            return;
    //        }
    //    }
}



#pragma mark touchEvent
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"%@", @"Began");
	
	TRACE(@"multi : %lu", (unsigned long)[touches count]);
	
	UITouch* touch = [touches anyObject];
	
	CGPoint point = [touch locationInView:self.view];
    
    if(point.y < 54){
        return;
    }
    
    CGRect frame = m_errInfoView.frame;
    
	m_start = point;
    m_startAndOriginGab = CGPointMake(0, frame.origin.y - m_start.y);
//	TRACE(@"%@", touch.view);
    TRACE(@"touch y = %f", m_start.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if(point.y < 54){
        return;
    }
    
    CGRect frame = m_errInfoView.frame;
    
    TRACE(@"m_start.y := %f ", m_start.y);
    TRACE(@"frame.origin.y := %f ", frame.origin.y);
    
    if(m_showErrInfoViewBtn.isHidden == NO){
        if((m_start.y + m_startAndOriginGab.y - frame.origin.y) > 30){
            TRACE(@"1111");
            [self toErrInfoView:nil];
        }else{
            TRACE(@"2222");
            [self toPcResultView:nil];
        }
    }else{
        if((m_start.y + m_startAndOriginGab.y - frame.origin.y) < -30){
            TRACE(@"3333");
            [self toPcResultView:nil];
        }else{
            TRACE(@"4444");
            [self toErrInfoView:nil];
        }
    }

//	if(CGRectContainsPoint(m_errInfoView.frame, m_start)){
//		UITouch* touch = [touches anyObject];
//		CGPoint point = [touch locationInView:self.view];
//        
//        CGRect frame = m_errInfoView.frame;
//        
//        TRACE(@"m_start.y := %f ", m_start.y);
//        TRACE(@"frame.origin.y := %f ", frame.origin.y);
//        
//        if(m_showErrInfoViewBtn.isHidden == NO){
//            if((m_start.y - frame.origin.y) > 20){
//                TRACE(@"1111");
//                [self toErrInfoView:nil];
//            }else{
//                TRACE(@"2222");
//                [self toPcResultView:nil];
//            }
//        }else{
//            if((m_start.y - frame.origin.y) < -20){
//                TRACE(@"3333");
//                [self toPcResultView:nil];
//            }else{
//                TRACE(@"4444");
//                [self toErrInfoView:nil];
//            }
//        }
//        
////        m_start.y = 0;
//        
////        if(point.y < 380 && m_showErrInfoViewBtn.isHidden == NO){
////            [self toErrInfoView:nil];
////        }else if(point.y < 380 && m_showErrInfoViewBtn.isHidden == YES){
////            [self toPcResultView:nil];
////        }else if(point.y > 74 && m_showErrInfoViewBtn.isHidden == YES){
////            [self toPcResultView:nil];
////        }else if(point.y > 74 && m_showErrInfoViewBtn.isHidden == NO){
////            [self toErrInfoView:nil];
////        }
//        
//        
////        if(m_start.y > point.y && point.y < 380){
////            [self toErrInfoView:nil];
////        }else if(m_start.y < point.y && point.y > 74){
////            [self toPcResultView:nil];
////        }else{
////            m_start.y = frame.origin.y;
////            m_errInfoView.frame = frame;
////        }
//		
////		CGRect frame = m_errInfoView.frame;
//		
////		frame.origin.x = frame.origin.x + (point.x - m_start.x);
////		frame.origin.y = frame.origin.y + (point.y - m_start.y);
////		
////		m_errInfoView.frame = frame;
//	}
	
	TRACE(@"%@", @"Ended");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CGRect frame = m_errInfoView.frame;
    
    if((point.y + m_startAndOriginGab.y) > ERR_INFO_VIEW_CLOSED_HEAD_Y 
       || (point.y + m_startAndOriginGab.y) < 54 || m_start.y == 0){
        return;
    }
    
    if(frame.origin.y > ERR_INFO_VIEW_CLOSED_HEAD_Y){
        frame.origin.y = ERR_INFO_VIEW_CLOSED_HEAD_Y;
        m_errInfoView.frame = frame;
        return;
    }
    
    if(frame.origin.y < 54){
        frame.origin.y = 54.0f;
        m_errInfoView.frame = frame;
        return;
    }
    
    frame.origin.y = point.y + m_startAndOriginGab.y;
    m_errInfoView.frame = frame;
    
    
    
//    m_start.y = frame.origin.y;
//    m_errInfoView.frame = frame;
    
//    m_start.x = frame.origin.x;
//    m_start.y = frame.origin.y;
    
//    if(m_start.y > point.y && point.y < 380){
//        [self toErrInfoView:nil];
//    }else if(m_start.y < point.y && point.y > 74){
//        [self toPcResultView:nil];
//    }else{
//        m_start.y = frame.origin.y;
//        m_errInfoView.frame = frame;
//    }
    
//    TRACE(@"touch y = %f", point.y);
//    
//    CGRect frame = m_errInfoView.frame;
//    
//    frame.origin.x = frame.origin.x + (point.x - m_start.x);
//    frame.origin.y = frame.origin.y + (point.y - m_start.y);
//   
//    m_start.x = frame.origin.x;
//    m_start.y = frame.origin.y;
//    
//    m_errInfoView.frame = frame;
//    
//	TRACE(@"%@", @"Moved");
}




#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    
    switch(nTag){
        case kBloodNoTextField :{
            CGPoint point = CGPointMake(0, 0);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        case kUsedACTextField :{
            CGPoint point = CGPointMake(0, m_usedACTextField.frame.origin.y -30);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        case kCollectionTimeTextField :{
            CGPoint point = CGPointMake(0, m_usedACTextField.frame.origin.y -30);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        case kWBProcessedTextField :{
            CGPoint point = CGPointMake(0, m_usedACTextField.frame.origin.y -30);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        case kCycleNumTextField :{
            CGPoint point = CGPointMake(0, m_usedACTextField.frame.origin.y -30);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        case kPLTVolumeTextField :{
            CGPoint point = CGPointMake(0, m_usedACTextField.frame.origin.y -30);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        case kESTYieldTextField :{
            CGPoint point = CGPointMake(0, m_usedACTextField.frame.origin.y -30);
            [m_scrollView setContentOffset:point animated:YES];
            break;
        }
        default:
            return NO;
            break;
    }

    
    TRACE(@"hahaha");
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString*)string 
{ 
    NSString* strCandidate;
    NSInteger nTag = textField.tag;
    
    strCandidate = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    TRACE(@"strCandidate := [%@]", strCandidate);
    
    switch(nTag){
        case kBloodNoTextField :
//            if(textField.text.length > 6){
//                return NO;
//            }else if(textField.text.length == 6){
//                [m_jumin2TextField becomeFirstResponder];
//                return YES;
//            }else{
//                if(strCandidate.length == 6){
//                    textField.text = strCandidate;
//                    [m_jumin2TextField becomeFirstResponder];
//                    return NO;
//                }
//            }
//            break;
//        case kJumin2TextFieldTag :
//            if(textField.text.length > 7){
//                return NO;
//            }else if(textField.text.length == 7){
//                return YES;
//            }
            if(strCandidate.length > 12){
                return NO;
            }
            break;
        case kUsedACTextField :
            if(strCandidate.length > 3){
                return NO;
            }
            break;
        case kCollectionTimeTextField :
            if(strCandidate.length > 3){
                return NO;
            }
            break;
        case kWBProcessedTextField :
            if(strCandidate.length > 4){
                return NO;
            }
            break;
        case kCycleNumTextField :
            if(strCandidate.length > 1){
                return NO;
            }
            break;
        case kPLTVolumeTextField :
            if(strCandidate.length > 3){
                return NO;
            }
            break;
        case kESTYieldTextField :
            if(strCandidate.length > 4){
                return NO;
            }
            break;
        default:
            return NO;
            break;
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    NSUInteger strLength = textField.text.length;
    
//#define kUsedACTextField            11
//#define kCollectionTimeTextField    12
//#define kWBProcessedTextField       13
//#define kCycleNumTextField          14
//#define kPLTVolumeTextField         15
//#define kESTYieldTextField          16
    
    if(strLength == 0) return NO;
    
    switch(nTag){
        case kBloodNoTextField :
            if(strLength < 12){
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"혈액번호 형식이 틀립니다."
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
            }else if(strLength == 12){
                [self onSearch:nil];
            }
            break;
        default:
            return YES;
    }
    
    //    if(strAlertMsg != nil){
    //        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
    //                                                            message:strAlertMsg
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"확인"
    //                                                  otherButtonTitles: nil];
    //        
    //        [alertView show];
    //        [alertView release];
    //    }
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
    
    m_mStrBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    m_mBloodInfoArray = [[NSMutableArray alloc] initWithCapacity:1];
    m_mErrArray = [[NSMutableArray alloc] initWithCapacity:16];
    
    m_nErrCnt = 0;
    
    CGSize size;	
	size = self.m_contentsView.frame.size;
	
	TRACE(@"width : %f, height : %f", size.width, size.height); 
	
	self.m_scrollView.contentSize = size;
    
    [self.view addSubview:m_scrollView];
    [m_scrollView addSubview:m_contentsView];
    
    [self.view addSubview:m_errInfoView];
    m_errInfoView.frame = CGRectMake(0, winHeight, 320, ERR_INFO_VIEW_HEIGHT);
    
    self.m_searchBtn.enabled = YES;
    self.m_cancelBtn.enabled = YES;
    self.m_cancelBtn.hidden = YES;
    self.m_searchBtn.hidden = NO;
    self.m_saveBtn.hidden = YES;
    self.m_toErrInfoViewBtn.hidden = YES;
    
    [m_bloodNoTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.m_SBUserInfoVO = nil;
    self.m_httpRequest = nil;
    
    self.m_scrollView = nil;
    self.m_contentsView = nil;
    self.m_errInfoView = nil;
    
    self.m_bloodNoTextField = nil;
    
    self.m_nameLabel = nil;
    self.m_interfaceLabel = nil;
    
    self.m_usedACTextField = nil;
    self.m_collectionTimeTextField = nil;
    self.m_WBProcessedTextField = nil;
    self.m_cycleNumTextField = nil;
    self.m_PLTVolumeTextField = nil;
    self.m_ESTYieldTextField = nil;
    
    self.m_searchBtn = nil;
    self.m_cancelBtn = nil;
    self.m_saveBtn = nil;
    
    self.m_activityIndicatorView = nil;
    
    self.m_mStrBloodNo = nil;
    self.m_mBloodInfoArray = nil;
    self.m_mErrArray = nil;
    
    self.m_toErrInfoViewBtn = nil;
    
    self.m_showErrInfoViewBtn = nil;
    self.m_hideErrInfoViewBtn = nil;
    
    self.m_switch01 = nil;
    self.m_switch02 = nil;
    self.m_switch03 = nil;
    self.m_switch04 = nil;
    self.m_switch05 = nil;
    self.m_switch06 = nil;
    self.m_switch07 = nil;
    self.m_switch08 = nil;
    self.m_switch09 = nil;
    self.m_switch10 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
