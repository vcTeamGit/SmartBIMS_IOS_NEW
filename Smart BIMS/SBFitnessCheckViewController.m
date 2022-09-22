//
//  SBFitnessCheckViewController.m
//  Smart BIMS
//
//  Created by  on 11. 9. 1..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBFitnessCheckViewController.h"
#import "HttpRequest.h"
#import "SBUserInfoVO.h"
#import "SBDonorFitnessInfoVO.h"
#import "SBPreUnfitnessDetailViewController.h"
#import "SBSideEffectCheckViewController.h"
#import "SBSpecialDetailViewController.h"
#import "SBUnfitnessHistoryViewController.h"

#import "SBUtils.h"
#import "JSON.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBFitnessCheckViewController

@synthesize m_httpRequest;
@synthesize m_SBUserInfoVO;
@synthesize m_SBDonorFitnessInfoVO;

@synthesize m_SBPreUnfitnessDetailViewController;
@synthesize m_SBSideEffectCheckViewController;
@synthesize m_SBSpecialDetailViewController;
@synthesize m_SBUnfitnessHistoryViewController;

@synthesize m_jumin1TextField;
@synthesize m_jumin2TextField;

@synthesize m_nameLabel;
@synthesize m_ABOTypeLabel;
@synthesize m_recentBloodDateLabel;
@synthesize m_recentBldProcNameLabel;
@synthesize m_ABSLabel;

@synthesize m_SUBLabel;
@synthesize m_pastOneTotalCntLabel;
@synthesize m_pastOneWBCntLabel;
@synthesize m_pastOnePLAPCntLabel;
@synthesize m_pastOneLrsdpSdpCntLabel;

@synthesize m_pastOnePLTPCntLabel;
@synthesize m_pastOne2PLTCntLabel;
@synthesize m_pastOne2RBCCntLabel;
@synthesize m_pastOneEtcCntLabel;
@synthesize m_bloodCntLabel;

@synthesize m_pastOneTotalVolumeLabel;

@synthesize m_gbmalResultLabel;
@synthesize m_invalidTextLabel;
@synthesize m_statusTextLabel;

@synthesize m_preUnfitnessBtn;
@synthesize m_adverseBtn;
@synthesize m_specBtn;

@synthesize m_ddrHisBtn;

@synthesize m_searchBtn;
@synthesize m_cancelBtn;

@synthesize m_activityIndicatorView;

@synthesize m_indivisualInfoConfirmView;

@synthesize m_indivisualInfoLogOkBtn;
@synthesize m_holdingInfoLogOkBtn;

@synthesize m_holdingInfoAgreeView;

// For Test
//@synthesize m_testTimeLabel;
//@synthesize m_strDateBefore;
//@synthesize m_strDateAfter;





- (IBAction)pageReset:(id)sender
{
    m_SBDonorFitnessInfoVO = nil;
    
//    [m_SBPreUnfitnessDetailViewController release];
    
    m_jumin1TextField.text = @"";
    m_jumin2TextField.text = @"";
    
    m_nameLabel.text = @"";
    m_ABOTypeLabel.text = @"";
    m_ABOTypeLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    m_recentBloodDateLabel.text = @"";
    m_recentBldProcNameLabel.text = @"";
    m_ABSLabel.text = @"";
    
    m_SUBLabel.text = @"";
    m_pastOneTotalCntLabel.text = @"";
    m_pastOneWBCntLabel.text = @"";
    m_pastOnePLAPCntLabel.text = @"";
    m_pastOneLrsdpSdpCntLabel.text = @"";

    m_pastOnePLTPCntLabel.text = @"";
    m_pastOne2PLTCntLabel.text = @"";
    m_pastOne2RBCCntLabel.text = @"";
    m_pastOneEtcCntLabel.text = @"";
    m_bloodCntLabel.text = @"";
    
    m_pastOneTotalVolumeLabel.text = @"";
    m_pastOneTotalVolumeLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    m_gbmalResultLabel.text = @"";
    m_invalidTextLabel.text = @"";
    m_statusTextLabel.text = @"";
    
    // For Test
//    m_testTimeLabel.text = @"";
    
    m_searchBtn.hidden = NO;
    m_cancelBtn.hidden = YES;
    
    m_specBtn.hidden = YES;
    m_preUnfitnessBtn.hidden = YES;
    m_ddrHisBtn.hidden = YES;
    m_adverseBtn.hidden = YES;
    
    // 개인정보조회 확인 뷰.
    CGRect frame = CGRectMake(10, winHeight, 301, viewHeight-40);
    m_indivisualInfoConfirmView.frame = frame;
    
    CGRect frameHoldingInfoView = CGRectMake(10, winHeight, 301, viewHeight-40);
    m_holdingInfoAgreeView.frame = frameHoldingInfoView;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    
//    m_indivisualInfoConfirmView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
////    [self.view addSubview:m_SBSpecialDetailViewController.view];
//    
//    [UIView commitAnimations];
    
    if([m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
    [m_jumin1TextField becomeFirstResponder];
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

- (void) onToHomeViewSelector
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[self.view removeFromSuperview];
}


- (IBAction)backgroundTab:(id)sender
{
    [self.m_jumin1TextField resignFirstResponder];
    [self.m_jumin2TextField resignFirstResponder];
}


- (IBAction)onToPreUnFitnessPages:(id)sender
{
//    static UIViewAnimationTransition orders[4] = {
//		UIViewAnimationTransitionCurlDown,
//		UIViewAnimationTransitionCurlUp,
//		UIViewAnimationTransitionFlipFromLeft,
//		UIViewAnimationTransitionFlipFromRight,
//	};
    
    m_SBPreUnfitnessDetailViewController = [[SBPreUnfitnessDetailViewController alloc] init];
//    
//    [container setValuesWithPageCnt:m_SBDonorFitnessInfoVO.strUnfitnessValue
//                             jumin1:m_jumin1TextField.text
//                             jumin2:m_jumin2TextField.text];
    [m_SBPreUnfitnessDetailViewController setValuesWithPageCnt:m_SBDonorFitnessInfoVO.strUnfitnessValue
                                                        jumin1:m_jumin1TextField.text
                                                        jumin2:m_jumin2TextField.text];
	
//	[UIView beginAnimations:nil context:nil];
//	
//	[UIView setAnimationDuration:1.0];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    
//	[UIView setAnimationTransition:orders[0]
//						   forView:self.view
//							 cache:YES];
//    
//    m_SBPreUnfitnessDetailViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
//    [self.view addSubview:m_SBPreUnfitnessDetailViewController.view];
//	
//	[UIView commitAnimations];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBPreUnfitnessDetailViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBPreUnfitnessDetailViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBPreUnfitnessDetailViewController.view];
    
    [UIView commitAnimations];
}


- (IBAction)onToSideEffectPages:(id)sender
{
//    if(m_SBSideEffectCheckViewController != nil){
//        [m_SBSideEffectCheckViewController release];
//        m_SBSideEffectCheckViewController = nil;
//    }
    m_SBSideEffectCheckViewController = [[SBSideEffectCheckViewController alloc] init];

    [m_SBSideEffectCheckViewController setValuesWithPageCnt:m_SBDonorFitnessInfoVO.strErrValue
                                                     jumin1:m_jumin1TextField.text
                                                     jumin2:m_jumin2TextField.text];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBSideEffectCheckViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBSideEffectCheckViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBSideEffectCheckViewController.view];
    
    [UIView commitAnimations];
}


- (IBAction)onToSpecPages:(id)sender
{
    //    if(m_SBSideEffectCheckViewController != nil){
    //        [m_SBSideEffectCheckViewController release];
    //        m_SBSideEffectCheckViewController = nil;
    //    }
    m_SBSpecialDetailViewController = [[SBSpecialDetailViewController alloc] init];
    
//    [m_SBSpecialPageViewController setValuesWith
    
    [m_SBSpecialDetailViewController setValuesWithPageCnt:m_SBDonorFitnessInfoVO.strSpecValue
                                                   jumin1:m_jumin1TextField.text
                                                   jumin2:m_jumin2TextField.text];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBSpecialDetailViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBSpecialDetailViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBSpecialDetailViewController.view];
    
    [UIView commitAnimations];
}


- (IBAction)onIndivisualInfoConfirm:(id)sender
{
    NSString* strJumin1 = m_jumin1TextField.text;
    NSString* strJumin2 = m_jumin2TextField.text;
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_SEARCH_SPECIAL_LOG;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"indivisualInfo", @"strPart",
                                strJumin1, @"strJumin1", 
                                strJumin2, @"strJumin2",
                                m_SBUserInfoVO.szBimsOrgcode, @"strOrgCode",
                                m_SBUserInfoVO.szBimsSitecode, @"strSiteCode",
                                m_SBUserInfoVO.szBimsId, @"strIdNo",
                                m_SBUserInfoVO.szBimsName, @"strIdName",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveIndivisualInfoConfirm:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveIndivisualInfoConfirm:(id)result
{
    NSString* strData;
    NSString* strResult;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
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
    
    strResult = [dictionary valueForKey:@"resultcode"];
    int nResultCode = [strResult intValue];
    
    TRACE(@"strResult = [%d]", nResultCode);
    
    if(nResultCode > 0){
        CGRect frame = CGRectMake(10, 48, 301, viewHeight-40);
        m_indivisualInfoConfirmView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_indivisualInfoConfirmView.frame = CGRectMake(10, winHeight, 301, viewHeight-40);
        
        [UIView commitAnimations];
    }
}



- (IBAction)onHoldingInfoAgree:(id)sender
{
    NSString* strJumin1 = m_jumin1TextField.text;
    NSString* strJumin2 = m_jumin2TextField.text;
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_SEARCH_SPECIAL_LOG;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"holdingInfo", @"strPart",
                                strJumin1, @"strJumin1", 
                                strJumin2, @"strJumin2",
                                m_SBUserInfoVO.szBimsOrgcode, @"strOrgCode",
                                m_SBUserInfoVO.szBimsSitecode, @"strSiteCode",
//                                m_SBUserInfoVO.szBimsCarcode, @"strCarCode",
                                m_SBUserInfoVO.szBimsId, @"strIdNo",
                                m_SBUserInfoVO.szBimsName, @"strIdName",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveHoldingInfoAgree:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveHoldingInfoAgree:(id)result
{
    NSString* strData;
    NSString* strResult;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
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
    
    strResult = [dictionary valueForKey:@"resultcode"];
    int nResultCode = [strResult intValue];
    
    TRACE(@"strResult = [%d]", nResultCode);
    
    if(nResultCode > 1){
        CGRect frame = CGRectMake(10, 48, 301, viewHeight-40);
        m_holdingInfoAgreeView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_holdingInfoAgreeView.frame = CGRectMake(10, winHeight, 301, viewHeight-40);
        
        [UIView commitAnimations];
    }
}





- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)msg
{
    [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles: nil];
    
    [alertView show];
    [alertView release];
}


- (void)requestDonorFintessInfo
{
    if(m_searchBtn.hidden == YES){
        return;
    }
    
    NSString* strJumin1 = m_jumin1TextField.text;
    NSString* strJumin2 = m_jumin2TextField.text;
    
    if(strJumin1 == nil || [strJumin1 length] != 6){
        [self showAlertViewWithTitle:@"오류" message:@"주민번호1의 형식을 확인하세요."];
        return;
    }
    
    if(strJumin2 == nil || [strJumin2 length] != 7){
        [self showAlertViewWithTitle:@"오류" message:@"주민번호2의 형식을 확인하세요."];
        return;
    }
    
    if([self checkJuminNo] == NO){
        return;
    }
    
    
    // For Time Test.
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"] autorelease]];
//    [dateFormatter setDateFormat:@"HHmmss"];
//    [m_strDateBefore setString:[dateFormatter stringFromDate:[NSDate date]]];
    // For Time Test End.
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_CHECK_SPECIAL;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strJumin1, @"strJumin1", 
                                strJumin2, @"strJumin2",
                                m_SBUserInfoVO.szBimsOrgcode, @"strOrgcode",
                                m_SBUserInfoVO.szBimsSitecode, @"strSitecode",
                                m_SBUserInfoVO.szBimsId, @"strId",
                                m_SBUserInfoVO.szBimsName, @"strName",
                                nil];

    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveDonorFitnessInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveDonorFitnessInfo:(id)result
{
    NSString* strData;
    NSString* strResult;
    NSString* strViewLogHis;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
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
    
    strResult = [dictionary valueForKey:@"result"];
    strViewLogHis = [dictionary valueForKey:@"viewLogHis"];
    
    TRACE(@"viewLogHis = [%@]", strViewLogHis);
    
    // For Time Test
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"] autorelease]];
//    [dateFormatter setDateFormat:@"HHmmss"];
//    [m_strDateAfter setString:[dateFormatter stringFromDate:[NSDate date]]];
//
//    NSDate *date1 = [dateFormatter dateFromString:[NSString stringWithString: m_strDateBefore]];
//    NSDate *date2 = [dateFormatter dateFromString:[NSString stringWithString: m_strDateAfter]];
//    
//    NSTimeInterval diff = [date2 timeIntervalSinceDate:date1]; // diff = 3600.0
//    m_testTimeLabel.text = [NSString stringWithFormat:@"%.0f", diff];
    
    // For Time Test End..
    
    if(strResult.length > 0){                
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"성공"
//                                                            message:[dictionary valueForKey:@"result"]
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        [alertView show];
//        [alertView release];
        
        TRACE(@"strResult = [%@]", strResult);
        
        if(self.m_SBDonorFitnessInfoVO != nil){
            self.m_SBDonorFitnessInfoVO = nil;
            [m_SBDonorFitnessInfoVO release];
        }
        
        self.m_SBDonorFitnessInfoVO = [[SBDonorFitnessInfoVO alloc] init];
        
        NSArray* arrRetval = [strResult componentsSeparatedByString:@"|"];
        
//        for(NSString* val in arrRetval)
        for(int i = 0; i < [arrRetval count]; i++)
        {
//            NSArray *lineElements = [line componentsSeparatedByString:@"\t"];
            // do something with lineElements
//            TRACE(@"arrRetVal[%d]'s value is [%@]", i, [arrRetval objectAtIndex:i]);
            
            if(i == 0){
                m_SBDonorFitnessInfoVO.strName = [arrRetval objectAtIndex:i];
            }else if(i == 1){
                m_SBDonorFitnessInfoVO.strABOCode = [arrRetval objectAtIndex:i];
            }else if(i == 2){
                m_SBDonorFitnessInfoVO.strSUB = [arrRetval objectAtIndex:i];
            }else if(i == 3){
                m_SBDonorFitnessInfoVO.strABS = [arrRetval objectAtIndex:i];
            }else if(i == 4){
                m_SBDonorFitnessInfoVO.strRecentBloodDate = [arrRetval objectAtIndex:i];
            }else if(i == 5){
                m_SBDonorFitnessInfoVO.strRecentBldProcName = [arrRetval objectAtIndex:i];
            }else if(i == 6){
                m_SBDonorFitnessInfoVO.strPastOneTotalCnt = [arrRetval objectAtIndex:i];
            }else if(i == 7){
                m_SBDonorFitnessInfoVO.strPastOneWBCnt = [arrRetval objectAtIndex:i];
            }else if(i == 8){
                m_SBDonorFitnessInfoVO.strPastOnePlapCnt = [arrRetval objectAtIndex:i];
            }else if(i == 9){
                m_SBDonorFitnessInfoVO.strPastOneLrsdpSdpCnt = [arrRetval objectAtIndex:i];
            }else if(i == 10){
                m_SBDonorFitnessInfoVO.strPastOnePltpCnt = [arrRetval objectAtIndex:i];
            }else if(i == 11){
                m_SBDonorFitnessInfoVO.strPastOne2PltCnt = [arrRetval objectAtIndex:i];
            }else if(i == 12){
                m_SBDonorFitnessInfoVO.strPastOne2RbcCnt = [arrRetval objectAtIndex:i];
            }else if(i == 13){
                m_SBDonorFitnessInfoVO.strPastOneEtcCnt = [arrRetval objectAtIndex:i];
            }else if(i == 14){
                m_SBDonorFitnessInfoVO.strBloodCnt = [arrRetval objectAtIndex:i];
            }else if(i == 15){
                m_SBDonorFitnessInfoVO.strGbMalResult = [arrRetval objectAtIndex:i];
            }else if(i == 16){
                m_SBDonorFitnessInfoVO.strRegister = [arrRetval objectAtIndex:i];
            }else if(i == 17){
                m_SBDonorFitnessInfoVO.strInvalidText = [arrRetval objectAtIndex:i];
                TRACE(@"Invalid Text =[%@]", m_SBDonorFitnessInfoVO.strInvalidText);
            }else if(i == 18){
                m_SBDonorFitnessInfoVO.strPreviousCheckLog = [arrRetval objectAtIndex:i];
            }else if(i == 19){
                m_SBDonorFitnessInfoVO.strUnfitnessValue = [arrRetval objectAtIndex:i];
            }else if(i == 20){
                m_SBDonorFitnessInfoVO.strErrValue = [arrRetval objectAtIndex:i];
            }else if(i == 21){
                m_SBDonorFitnessInfoVO.strSpecValue = [arrRetval objectAtIndex:i];
            }else if(i == 22){
                m_SBDonorFitnessInfoVO.strStatusValue = [arrRetval objectAtIndex:i];
            }else if(i == 23){
                // 9:외부배제(외부사유), 8:헌혈유보사유군, 4:영구배제, 3:일시보류, 2:제한헌혈, 1: 헌혈정보없음, 0: 정상
                m_SBDonorFitnessInfoVO.strFitnessResult = [arrRetval objectAtIndex:i];
            }
            
            if([m_SBDonorFitnessInfoVO.strFitnessResult isEqualToString:@"8"] == true){
                CGRect frame = CGRectMake(10, winHeight, 301, viewHeight-40);
                m_holdingInfoAgreeView.frame = frame;
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                
                m_holdingInfoAgreeView.frame = CGRectMake(10, 48, 301, viewHeight-40);
                
                [UIView commitAnimations];
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_IS_HOLDING];
            }
            // 헌혈정보없음 또는 정상이 아닌 경우. 개인정보조회 확인 뷰가 생성됨.
            else if([m_SBDonorFitnessInfoVO.strFitnessResult intValue] > 1){
                CGRect frame = CGRectMake(10, winHeight, 301, viewHeight-40);
                m_indivisualInfoConfirmView.frame = frame;
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                
                m_indivisualInfoConfirmView.frame = CGRectMake(10, 48, 301, viewHeight-40);
                //    [self.view addSubview:m_SBSpecialDetailViewController.view];
                
                [UIView commitAnimations];
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_IS_INDIVISUAL];
            }
        }
        
        if([m_SBDonorFitnessInfoVO.strPreviousCheckLog length] > 0){
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"조회정보가 있습니다"
                                                                message:m_SBDonorFitnessInfoVO.strPreviousCheckLog
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            [alertView show];
            [alertView release];
            
            //[SBUtils vibrate];
            [SBUtils playAlertSystemSoundWithSoundType:SOUND_IS_RECORDED];
        }
        
        [self setPageValues];
        
    }else{
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:@"조회결과가 없습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
    [self backgroundTab:nil];
}


- (void)setPageValues
{
    m_nameLabel.text = m_SBDonorFitnessInfoVO.strName;
    m_ABOTypeLabel.text = [SBUtils getABOTypeName:m_SBDonorFitnessInfoVO.strABOCode];
    m_ABOTypeLabel.textColor = [SBUtils getABOTypeRGBValue:m_SBDonorFitnessInfoVO.strABOCode];
//    m_ABOTypeLabel.backgroundColor = [SBUtils getABOTypeBgRGBValue:m_SBDonorFitnessInfoVO.strABOCode];
    m_recentBloodDateLabel.text = m_SBDonorFitnessInfoVO.strRecentBloodDate;
    m_recentBldProcNameLabel.text = m_SBDonorFitnessInfoVO.strRecentBldProcName;
    m_ABSLabel.text = m_SBDonorFitnessInfoVO.strABS;
    
    m_SUBLabel.text = m_SBDonorFitnessInfoVO.strSUB;
    m_pastOneTotalCntLabel.text = m_SBDonorFitnessInfoVO.strPastOneTotalCnt;
    m_pastOneWBCntLabel.text = m_SBDonorFitnessInfoVO.strPastOneWBCnt;
    m_pastOnePLAPCntLabel.text = m_SBDonorFitnessInfoVO.strPastOnePlapCnt;
    m_pastOneLrsdpSdpCntLabel.text = m_SBDonorFitnessInfoVO.strPastOneLrsdpSdpCnt;
    
    m_pastOnePLTPCntLabel.text = m_SBDonorFitnessInfoVO.strPastOnePltpCnt;
    m_pastOne2PLTCntLabel.text = m_SBDonorFitnessInfoVO.strPastOne2PltCnt;
    m_pastOne2RBCCntLabel.text = m_SBDonorFitnessInfoVO.strPastOne2RbcCnt;
    m_pastOneEtcCntLabel.text = m_SBDonorFitnessInfoVO.strPastOneEtcCnt;
    
    // 연간채혈량 출력
    int nPastOneTotalVolume = 0;
    nPastOneTotalVolume += [m_SBDonorFitnessInfoVO.strPastOneWBCnt intValue] * 430;
    nPastOneTotalVolume += [m_SBDonorFitnessInfoVO.strPastOnePlapCnt intValue] * 45;
    nPastOneTotalVolume += [m_SBDonorFitnessInfoVO.strPastOneLrsdpSdpCnt intValue] * 90;
    nPastOneTotalVolume += [m_SBDonorFitnessInfoVO.strPastOnePltpCnt intValue] * 90;
    nPastOneTotalVolume += [m_SBDonorFitnessInfoVO.strPastOne2PltCnt intValue] * 0;
    nPastOneTotalVolume += [m_SBDonorFitnessInfoVO.strPastOne2RbcCnt intValue] * 0;
    
    if(nPastOneTotalVolume > 2160){
        m_pastOneTotalVolumeLabel.textColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }else{
        m_pastOneTotalVolumeLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    }
    
    m_pastOneTotalVolumeLabel.text = [NSString stringWithFormat:@"(연간채혈량: %dmL)", nPastOneTotalVolume];
    
    m_bloodCntLabel.text = m_SBDonorFitnessInfoVO.strBloodCnt;
    
    m_gbmalResultLabel.text = m_SBDonorFitnessInfoVO.strGbMalResult;
//    m_invalidTextLabel.text = m_SBDonorFitnessInfoVO.strInvalidText;
//    m_statusTextLabel.text = m_SBDonorFitnessInfoVO.strStatusValue;
    
    if([m_SBDonorFitnessInfoVO.strInvalidText length] > 9){
        NSRange rangeInvalid = NSMakeRange(9, [m_SBDonorFitnessInfoVO.strInvalidText length] - 9);
        m_invalidTextLabel.text = [m_SBDonorFitnessInfoVO.strInvalidText substringWithRange:rangeInvalid];
    }
    
    if([m_SBDonorFitnessInfoVO.strStatusValue length] > 10){
        NSRange rangeStatus = NSMakeRange(10, [m_SBDonorFitnessInfoVO.strStatusValue length] - 10);
        m_statusTextLabel.text = [m_SBDonorFitnessInfoVO.strStatusValue substringWithRange:rangeStatus];
    }
    
    // wireline - 2013.06.13: 제한헌혈자 정보가 들어오면 [HIS]버튼 띄우던 버그를 수정
    if([m_SBDonorFitnessInfoVO.strInvalidText rangeOfString:@"#"].location == NSNotFound && [m_SBDonorFitnessInfoVO.strInvalidText rangeOfString:@"!"].location == NSNotFound){
        m_ddrHisBtn.hidden = YES;
    }else{
        m_ddrHisBtn.hidden = NO;
    }
    
//    if([m_SBDonorFitnessInfoVO.strInvalidText length] > 0){
//        m_ddrHisBtn.hidden = NO;
//    }else{
//        m_ddrHisBtn.hidden = YES;
//    }
    
    if([m_SBDonorFitnessInfoVO.strUnfitnessValue integerValue] > 0){
        m_preUnfitnessBtn.hidden = NO;
    }else{
        m_preUnfitnessBtn.hidden = YES;
    }
    
    if([m_SBDonorFitnessInfoVO.strErrValue integerValue] > 0){
        m_adverseBtn.hidden = NO;
    }else{
        m_adverseBtn.hidden = YES;
    }
    
    if([m_SBDonorFitnessInfoVO.strSpecValue integerValue] > 0){
        m_specBtn.hidden = NO;
    }else{
        m_specBtn.hidden = YES;
    }
    
    m_searchBtn.hidden = YES;
    m_cancelBtn.hidden = NO;

}


// 주민번호 체크 로직
- (BOOL)checkJuminNo
{
    NSString* strJumin1 = self.m_jumin1TextField.text;
    NSString* strJumin2 = self.m_jumin2TextField.text;
    
    // 자리수 체크
    NSString* strJumin = [NSString stringWithFormat:@"%@%@", strJumin1, strJumin2];
    
    if([strJumin length] < 13){
        TRACE(@"주민번호 자리수가 틀립니다");
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"주민번호 자리수가 틀립니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];

        return NO;
    }
    
    
    // 주민번호 첫자리 날짜형식 체크
    TRACE(@"%@", [strJumin substringWithRange:NSMakeRange(2, 2)]);
    
    if([[strJumin substringWithRange:NSMakeRange(2, 2)] intValue] > 12 || [[strJumin substringWithRange:NSMakeRange(2, 2)] intValue] == 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"주민번호 첫자리의 날짜형식이 틀립니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return NO;
    }
    
    TRACE(@"%@", [strJumin substringWithRange:NSMakeRange(4, 2)]);
    
    if([[strJumin substringWithRange:NSMakeRange(4, 2)] intValue] > 31 || [[strJumin substringWithRange:NSMakeRange(4, 2)] intValue] == 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"주민번호 첫자리의 날짜형식이 틀립니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return NO;
    }
    
    // 주민번호 체크비트를 이용한 체크
    NSArray *arrayLogic = [NSArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"2",@"3",@"4",@"5",nil];
    int allSumSsn2 = 0;
    for(int i=0 ; i< [arrayLogic count]; i++){
        allSumSsn2 += [[strJumin substringWithRange:NSMakeRange(i, 1)] intValue] * [[arrayLogic objectAtIndex:i] intValue];
    }
    
    int nanum = (11-(allSumSsn2 % 11) ) % 10;
    
    if (nanum == [[strJumin substringWithRange:NSMakeRange(12, 1)] intValue]){
        TRACE(@"맞는 주민번호 !");
        return YES;
    }else{
        TRACE(@"틀린 주민번호 !");
        
        NSString* strTitleMsg = @"주민번호 형식이 옳지 않습니다.\n계속 진행하시겠습니까?";
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            actionSheet.tag = kJuminNoCheckError;
            [actionSheet showInView:self.view];
            [actionSheet release];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kJuminNoCheckError;
            
            [alertView show];
            [alertView release];
        }
        
        return NO;
    }
}



#pragma mark - 
#pragma mark Soft Keyboard OK button show
//- (void)setCustomNumberPadConfig
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//}
//
//
//- (void)keyboardWillShow:(NSNotification *)note {
//    //    TRACE(@"keyboardWillShow");
//    // create custom button
//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    doneButton.frame = CGRectMake(0, 163, 106, 53);
//    doneButton.frame = CGRectMake(0, 163, 105, 54);
//    doneButton.adjustsImageWhenHighlighted = NO;
//    doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:22];
//    
//    //set the label text of the button when its not pushed
//    [doneButton setTitle:@"확 인" forState:UIControlStateNormal];
//    [doneButton setBackgroundImage:[UIImage imageNamed:@"buttonUp.png"] forState:UIControlStateNormal];
//    [doneButton setBackgroundImage:[UIImage imageNamed:@"buttonDown.png"] forState:UIControlStateHighlighted];
//    //    [doneButton setImage:[UIImage imageNamed:@"0.png"] forState:UIControlStateNormal];
//    //    [doneButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    // locate keyboard view
//    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
//    //    UIView* tempWindow = self.view;
//    UIView* keyboard;
//    for(int i=0; i<[tempWindow.subviews count]; i++) {
//        keyboard = [tempWindow.subviews objectAtIndex:i];
//        //        TRACE(@"keyboard := [%@]", [keyboard description]);
//        // keyboard view found; add the custom button to it
//        if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES){
//            [keyboard addSubview:doneButton];
//        }
//    }
//}

- (void)doneButton:(id)sender
{
    // wireline - 2013.05.31: 주민번호 체크로직 추가
    if([self checkJuminNo] == YES){
        [self requestDonorFintessInfo];
    }
    //    TRACE(@"doneButton := [%@]", [sender description]);
    
//    if([m_bloodNoTextField isFirstResponder] == YES){
//        if(m_bloodNoTextField.text.length < 12){
//            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
//            
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
//                                                                message:@"혈액번호 형식이 틀립니다."
//                                                               delegate:self
//                                                      cancelButtonTitle:@"확인"
//                                                      otherButtonTitles: nil];
//            
//            [alertView show];
//            [alertView release];
//            
//        }else{
//            [self onSearch:nil];
//        }
//    }else if([m_usedACTextField isFirstResponder] == YES){
//        [m_collectionTimeTextField becomeFirstResponder];
//    }else if([m_collectionTimeTextField isFirstResponder]){
//        [m_WBProcessedTextField becomeFirstResponder];
//    }else if([m_WBProcessedTextField isFirstResponder]){
//        [m_cycleNumTextField becomeFirstResponder];
//    }else if([m_cycleNumTextField isFirstResponder]){
//        [m_PLTVolumeTextField becomeFirstResponder];
//    }else if([m_PLTVolumeTextField isFirstResponder]){
//        [m_ESTYieldTextField becomeFirstResponder];
//    }else if([m_ESTYieldTextField isFirstResponder]){
//        [m_ESTYieldTextField resignFirstResponder];
//        CGPoint point = CGPointMake(0, 0);
//        [m_scrollView setContentOffset:point animated:YES];
//        [self onSave:nil];
//    }
}


#pragma mark -
#pragma mark For Test Section
- (IBAction)onToDDRHisRequest:(id)sender
{
    if(m_httpRequest == nil){
        m_httpRequest = [[HttpRequest alloc] init];
    }
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_SPECIAL_DETAIL;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"bissDDRHis", @"reqId", 
                                m_jumin1TextField.text, @"strJumin1",
                                m_jumin2TextField.text, @"strJumin2",
                                m_SBUserInfoVO.szBimsId, @"strWriteUserId",
                                nil];
    
    //    m_httpRequest = [[HttpRequest alloc] init];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveDDRHisInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [m_activityIndicatorView startAnimating];
}


- (void)didReceiveDDRHisInfo:(id)result
{
//    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    
    [self.m_activityIndicatorView stopAnimating];
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
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

    NSArray* arrVO = [strResult componentsSeparatedByString:@"|"];
    NSMutableArray* m_mTempArray = [[[NSMutableArray alloc] initWithCapacity:[arrVO count]] autorelease];
    NSMutableArray* m_mTempArray2 = [[[NSMutableArray alloc] initWithCapacity:[arrVO count]] autorelease];
    
    for(int i = 0; i < [arrVO count]; i++){
        if(i >=3){
            if(i%2 == 1) [m_mTempArray addObject:[arrVO objectAtIndex:i]];
            if(i%2 == 0) [m_mTempArray2 addObject:[arrVO objectAtIndex:i]];
        }
    }
    
    m_SBUnfitnessHistoryViewController.m_mDateArray = m_mTempArray;
    m_SBUnfitnessHistoryViewController.m_mDescArray = m_mTempArray2;
    [m_SBUnfitnessHistoryViewController.m_tableView reloadData];
    
    
    
    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    m_SBUnfitnessHistoryViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBUnfitnessHistoryViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    [self.view addSubview:m_SBUnfitnessHistoryViewController.view];
    
    [UIView commitAnimations];
//    [self.view addSubview:m_SBUnfitnessHistoryViewController.view];
}


//- (IBAction)onChangedJumin1Value:(id)sender
//{
//    UITextField* tempTextField = (UITextField*)sender;
//    
//    TRACE(@"onChangedJumin1Value");
//    
//    if([tempTextField.text length] == 6){
//        [m_jumin2TextField becomeFirstResponder];
//    }
//}
//
//
//- (IBAction)onChangedJumin2Value:(id)sender
//{
//    
//}



#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kJuminNoCheckError){
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self requestDonorFintessInfo];
        }else{
            [self pageReset:nil];
        }
    }
}


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == kJuminNoCheckError){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self requestDonorFintessInfo];
        }else{
            [self pageReset:nil];
        }
    }
}



#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString*)string 
{ 
    NSString* strCandidate;
    NSInteger nTag = textField.tag;
    
    strCandidate = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    TRACE(@"strCandidate := [%@]", strCandidate);
    
    switch(nTag){
        case kJumin1TextFieldTag :
            if(textField.text.length > 6){
                return NO;
            }else if(textField.text.length == 6){
                [m_jumin2TextField becomeFirstResponder];
                return YES;
            }else{
                if(strCandidate.length == 6){
                    textField.text = strCandidate;
                    [m_jumin2TextField becomeFirstResponder];
                    return NO;
                }
            }
            break;
        case kJumin2TextFieldTag :
            if(textField.text.length > 7){
                return NO;
            }else if(textField.text.length == 7){
                return YES;
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
    
    switch(nTag){
        case kJumin1TextFieldTag :
            if(strLength < 6){
                // 
            }else if(strLength == 6){
                [m_jumin2TextField becomeFirstResponder];
            }
            break;
        case kJumin2TextFieldTag :
            if(strLength < 7){
                
            }else if(strLength == 7){
                // wireline - 2013.05.31: 주민번호 체크로직 추가
                if([self checkJuminNo] == YES){
                    [self requestDonorFintessInfo];
                }
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





#pragma mark - Defaults

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
    
    // For Test
//    m_jumin1TextField.text = @"770303";
//    m_jumin2TextField.text = @"1357326";
//    m_strDateBefore = [[NSMutableString alloc] initWithCapacity:16];
//    m_strDateAfter = [[NSMutableString alloc] initWithCapacity:16];
    // For Test End...
    
    if(winHeight == kWINDOW_HEIGHT){
        m_SBPreUnfitnessDetailViewController = [[SBPreUnfitnessDetailViewController alloc] initWithNibName:@"SBPreUnfitnessDetailViewController"
                                                                                                    bundle:nil];
        
        m_SBUnfitnessHistoryViewController = [[SBUnfitnessHistoryViewController alloc] initWithNibName:@"SBUnfitnessHistoryViewController"
                                                                                                bundle:nil];
        
        m_SBSpecialDetailViewController = [[SBSpecialDetailViewController alloc] initWithNibName:@"SBSpecialDetailViewController" bundle:nil];
    }else{
        m_SBPreUnfitnessDetailViewController = [[SBPreUnfitnessDetailViewController alloc] initWithNibName:@"SBPreUnfitnessDetailViewController3"
                                                                                                    bundle:nil];
        
        m_SBUnfitnessHistoryViewController = [[SBUnfitnessHistoryViewController alloc] initWithNibName:@"SBUnfitnessHistoryViewController3"
                                                                                                bundle:nil];
        
        m_SBSpecialDetailViewController = [[SBSpecialDetailViewController alloc] initWithNibName:@"SBSpecialDetailViewController3" bundle:nil];
    }
    
    CGRect frame = CGRectMake(10, winHeight, 301, viewHeight-40);
    m_indivisualInfoConfirmView.frame = frame;
    
    m_holdingInfoAgreeView.frame = frame;
    
    [m_jumin1TextField becomeFirstResponder];
    
//    m_jumin1TextField.text = @"730410";
//    m_jumin2TextField.text = @"2156419";
//    m_jumin1TextField.text = @"910126";
//    m_jumin2TextField.text = @"2205211";
//    m_jumin1TextField.text = @"820419";
//    m_jumin2TextField.text = @"1647910";
//    
//    [self requestDonorFintessInfo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBUserInfoVO = nil;
    self.m_SBDonorFitnessInfoVO = nil;
    
    self.m_SBPreUnfitnessDetailViewController = nil;
    self.m_SBUnfitnessHistoryViewController = nil;
    self.m_SBSpecialDetailViewController = nil;
    
    self.m_jumin1TextField = nil;
    self.m_jumin2TextField = nil;
    
    self.m_nameLabel = nil;
    self.m_ABOTypeLabel = nil;
    self.m_recentBloodDateLabel = nil;
    self.m_recentBldProcNameLabel = nil;
    self.m_ABSLabel = nil;
    
    self.m_SUBLabel = nil;
    self.m_pastOneTotalCntLabel = nil;
    self.m_pastOneWBCntLabel = nil;
    self.m_pastOnePLAPCntLabel = nil;
    self.m_pastOneLrsdpSdpCntLabel = nil;
    
    self.m_pastOnePLAPCntLabel = nil;
    self.m_pastOne2PLTCntLabel = nil;
    self.m_pastOne2RBCCntLabel = nil;
    self.m_pastOneEtcCntLabel = nil;
    self.m_bloodCntLabel = nil;
    
    self.m_gbmalResultLabel = nil;
    self.m_invalidTextLabel = nil;
    self.m_statusTextLabel = nil;
    
    self.m_preUnfitnessBtn = nil;
    self.m_adverseBtn = nil;
    self.m_specBtn = nil;
    
    self.m_ddrHisBtn = nil;
    
    self.m_searchBtn = nil;
    self.m_cancelBtn = nil;
    
    self.m_activityIndicatorView = nil;
    
    self.m_indivisualInfoConfirmView = nil;
    
    self.m_indivisualInfoLogOkBtn = nil;
    self.m_holdingInfoLogOkBtn = nil;
    
    self.m_holdingInfoAgreeView = nil;
    
    // For Test
//    self.m_testTimeLabel = nil;
}


- (void)dealloc{
    
    [m_httpRequest release];
    
    [m_SBUserInfoVO release];
    [m_SBDonorFitnessInfoVO release];
    
    [m_SBPreUnfitnessDetailViewController release];
    [m_SBUnfitnessHistoryViewController release];
    [m_SBSpecialDetailViewController release];
    [m_jumin1TextField release];
    [m_jumin2TextField release];
    
    [m_nameLabel release];
    [m_ABOTypeLabel release];
    [m_recentBloodDateLabel release];
    [m_recentBldProcNameLabel release];
    [m_ABSLabel release];
    
    [m_SUBLabel release];
    [m_pastOneTotalCntLabel release];
    [m_pastOneWBCntLabel release];
    [m_pastOnePLAPCntLabel release];
    [m_pastOneLrsdpSdpCntLabel release];
    
    [m_pastOnePLAPCntLabel release];
    [m_pastOne2PLTCntLabel release];
    [m_pastOne2RBCCntLabel release];
    [m_pastOneEtcCntLabel release];
    [m_bloodCntLabel release];
    
    [m_gbmalResultLabel release];
    [m_invalidTextLabel release];
    [m_statusTextLabel release];
    
    [m_preUnfitnessBtn release];
    [m_adverseBtn release];
    [m_specBtn release];
    
    [m_ddrHisBtn release];
    
    [m_searchBtn release];
    [m_cancelBtn release];
    
    [m_activityIndicatorView release];
    
    [m_indivisualInfoConfirmView release];
    
    [m_indivisualInfoLogOkBtn release];
    [m_holdingInfoLogOkBtn release];
    
    [m_holdingInfoAgreeView release];
    
    // For Test
//    [m_testTimeLabel release];
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
