//
//  SBFirstMatchingViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 18..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBMultiFirstMatchingViewController.h"
#import "SBUserInfoVO.h"
#import "SBBloodnoInfoVO.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

@implementation SBMultiFirstMatchingViewController

@synthesize m_httpRequest;
@synthesize m_SBBloodnoInfoVO;
@synthesize m_SBUserInfoVO;

//@synthesize m_scrollView;
//@synthesize m_contentsView;
@synthesize m_firstView;
@synthesize m_secondView;

@synthesize m_idNameLabel;
@synthesize m_idNameLabel2;

/* firstView */
@synthesize m_barcodeBloodNo;
@synthesize m_barcodeABOType;
@synthesize m_barcodeBag;
@synthesize m_barcodeMalaria;
@synthesize m_barcodeBldBagcode;
// 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
@synthesize m_barcodeUDI;

@synthesize m_strBarcodeBloodNo;
@synthesize m_strBarcodeABOType;
@synthesize m_strBarcodeBag;
@synthesize m_strBarcodeMalaria;
@synthesize m_strBarcodeBldBagcode;
// 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
@synthesize m_strBarcodeUDI;

@synthesize m_BldBagLabel;
@synthesize m_ABOTypeNameLabel;

@synthesize m_BloodCntLabel;

@synthesize m_btnOK;
@synthesize m_btnCancel;

@synthesize m_firstDonationImageView;

@synthesize m_activityIndicatorView;

/* secondView */
@synthesize m_barcodeBloodNo2;
@synthesize m_barcodeABOType2;
@synthesize m_barcodeBag2;
@synthesize m_barcodeMalaria2;
@synthesize m_barcodeBldBagcode2;

@synthesize m_strBarcodeBloodNo2;
@synthesize m_strBarcodeABOType2;
@synthesize m_strBarcodeBag2;
@synthesize m_strBarcodeMalaria2;
@synthesize m_strBarcodeBldBagcode2;

@synthesize m_BldBagLabel2;
@synthesize m_ABOTypeNameLabel2;

@synthesize m_BloodCntLabel2;

@synthesize m_btnOK2;
@synthesize m_btnCancel2;

@synthesize m_activityIndicatorView2;

/* commons */
@synthesize m_target;
@synthesize m_selector;





- (void)setUserInfo:(SBUserInfoVO*)userInfo
{
    self.m_SBUserInfoVO = [[SBUserInfoVO alloc] initWithSBUserInfo:userInfo];
}


- (void)setBldBagLabelText
{
    if([m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
        self.m_BldBagLabel.font = [UIFont boldSystemFontOfSize:15];
        self.m_BldBagLabel.text = @"백종류바코드";
        
        self.m_BldBagLabel2.font = [UIFont boldSystemFontOfSize:15];
        self.m_BldBagLabel2.text = @"백종류바코드";
    }else{
        self.m_BldBagLabel.font = [UIFont boldSystemFontOfSize:13];
        self.m_BldBagLabel.text = @"채혈장비바코드";
        
        self.m_BldBagLabel2.font = [UIFont boldSystemFontOfSize:13];
        self.m_BldBagLabel2.text = @"채혈장비바코드";
    }
}


- (IBAction)pageReset:(id)sender
{
    m_idNameLabel.text = m_SBUserInfoVO.szBimsName;
    
    if(self.m_strBarcodeBloodNo != nil){
        [m_strBarcodeBloodNo release];
        self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if(self.m_strBarcodeABOType != nil){
        [m_strBarcodeABOType release];
        self.m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
    }
    
    if(self.m_strBarcodeBag != nil){
        [m_strBarcodeBag release];
        self.m_strBarcodeBag = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if(self.m_strBarcodeMalaria != nil){
        [m_strBarcodeMalaria release];
        self.m_strBarcodeMalaria = [[NSMutableString alloc] initWithCapacity:6];
    }
    
    if(self.m_strBarcodeBldBagcode != nil){
        [m_strBarcodeBldBagcode release];
        self.m_strBarcodeBldBagcode = [[NSMutableString alloc] initWithCapacity:7];
    }
    
    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    if(self.m_strBarcodeUDI != nil)
    {
        [m_strBarcodeUDI release];
        
        self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
    }
    self.m_barcodeBloodNo.text = @"";
    self.m_barcodeABOType.text = @"";
    self.m_barcodeBag.text = @"";
    self.m_barcodeMalaria.text = @"";
    self.m_barcodeBldBagcode.text = @"";
    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    self.m_barcodeUDI.text = @"";
    
    self.m_ABOTypeNameLabel.text = nil;
    self.m_ABOTypeNameLabel.textColor = [UIColor blackColor];   // UILabel.textColor is non-nil value.
    self.m_ABOTypeNameLabel.backgroundColor = nil;
    
    self.m_barcodeBloodNo.enabled = YES;
    self.m_barcodeABOType.enabled = NO;
    self.m_barcodeBag.enabled = NO;
    self.m_barcodeMalaria.enabled = NO;
    self.m_barcodeBldBagcode.enabled = NO;
    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    self.m_barcodeUDI.enabled = NO;
    
    self.m_BloodCntLabel.text = @"";
    
    self.m_firstDonationImageView.hidden = YES;
    
    if([self.m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
//    CGRect frame = CGRectMake(0, viewWidth, viewWidth, viewHeight);
//    self.m_secondView.frame = frame;
    
    [self.m_barcodeBloodNo becomeFirstResponder];
}


- (IBAction)pageReset2:(id)sender
{
    m_idNameLabel2.text = m_SBUserInfoVO.szBimsName;
    
    if(self.m_strBarcodeBloodNo2 != nil){
        [m_strBarcodeBloodNo2 release];
        self.m_strBarcodeBloodNo2 = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if(self.m_strBarcodeABOType2 != nil){
        [m_strBarcodeABOType2 release];
        self.m_strBarcodeABOType2 = [[NSMutableString alloc] initWithCapacity:2];
    }
    
    if(self.m_strBarcodeBag2 != nil){
        [m_strBarcodeBag2 release];
        self.m_strBarcodeBag2 = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if(self.m_strBarcodeMalaria2 != nil){
        [m_strBarcodeMalaria2 release];
        self.m_strBarcodeMalaria2 = [[NSMutableString alloc] initWithCapacity:6];
    }
    
    if(self.m_strBarcodeBldBagcode2 != nil){
        [m_strBarcodeBldBagcode2 release];
        self.m_strBarcodeBldBagcode2 = [[NSMutableString alloc] initWithCapacity:7];
    }
    
    self.m_barcodeBloodNo2.text = @"";
    self.m_barcodeABOType2.text = @"";
    self.m_barcodeBag2.text = @"";
    self.m_barcodeMalaria2.text = @"";
    self.m_barcodeBldBagcode2.text = @"";
    
    self.m_ABOTypeNameLabel2.text = nil;
    self.m_ABOTypeNameLabel2.textColor = [UIColor blackColor];   // UILabel.textColor is non-nil value.
    self.m_ABOTypeNameLabel2.backgroundColor = nil;
    
    self.m_barcodeBloodNo2.enabled = YES;
    self.m_barcodeABOType2.enabled = NO;
    self.m_barcodeBag2.enabled = NO;
    self.m_barcodeMalaria2.enabled = NO;
    self.m_barcodeBldBagcode2.enabled = NO;
    
    if([self.m_activityIndicatorView2 isAnimating]){
        [m_activityIndicatorView2 stopAnimating];
    }
    
    [self.m_barcodeBloodNo2 becomeFirstResponder];
}


// 메인화면으로 바로 이동
- (IBAction)onToHomeView:(id)sender
{
    [self backgroundTab:nil];
    
    if(m_target){
        [self backgroundTab:nil];
        [m_target performSelector:m_selector];
    }
}


// 메인화면으로 바로 이동
- (IBAction)onToHomeView2:(id)sender
{
    [self backgroundTab2:nil];
    if(m_target){
        [self backgroundTab:nil];
        [m_target performSelector:m_selector];
    }
}


- (IBAction)onOK:(id)sender
{
    static UIViewAnimationTransition orders[4] = {
        UIViewAnimationTransitionCurlDown,
        UIViewAnimationTransitionCurlUp,
        UIViewAnimationTransitionFlipFromLeft,
        UIViewAnimationTransitionFlipFromRight,
    };
    
    NSMutableString* mstrAlertMsg = [[NSMutableString alloc] initWithCapacity:100];
    
    if(m_strBarcodeBloodNo.length == 0 || [m_strBarcodeBloodNo isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액번호를 입력하세요."];
        self.m_barcodeBloodNo.enabled = YES;
        [self.m_barcodeBloodNo becomeFirstResponder];
    }else if(m_strBarcodeABOType.length == 0 || [m_strBarcodeABOType isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액형바코드를 입력하세요."];
        self.m_barcodeABOType.enabled = YES;
        [self.m_barcodeABOType becomeFirstResponder];
    }else if(m_strBarcodeBag.length == 0 || [m_strBarcodeBag isEqualToString:@""]){
        [mstrAlertMsg setString:@"채혈백바코드를 입력하세요."];
        self.m_barcodeBag.enabled = YES;
        [self.m_barcodeBag becomeFirstResponder];
    }else if(m_strBarcodeMalaria.length == 0 || [m_strBarcodeMalaria isEqualToString:@""]){
        [mstrAlertMsg setString:@"말라리아바코드를 입력하세요."];
        self.m_barcodeMalaria.enabled = YES;
        [self.m_barcodeMalaria becomeFirstResponder];
    }else if(m_strBarcodeBldBagcode.length == 0 || [m_strBarcodeBldBagcode isEqualToString:@""]){
        [mstrAlertMsg setString:@"백종류바코드를 입력하세요."];
        self.m_barcodeBldBagcode.enabled = YES;
        [self.m_barcodeBldBagcode becomeFirstResponder];
    }
    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    else if ([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES && (m_strBarcodeUDI.length == 0 || [m_strBarcodeUDI isEqualToString:@""]))
    {
        NSString* strTitleMsg = @"혈소판혈장 UDI코드가 입력되지 않았습니다.\nUDI 바코드 스캔 없이 진행하시겠습니까?";
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        if([[UIDevice currentDevice].systemVersion floatValue] < 7)
        {
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            actionSheet.tag = kMatchingSecondViewShowUDIActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
            
        }
        else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[확 인]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            alertView.tag = kMatchingSecondViewShowUDIActionSheetTag;
            [alertView show];
            [alertView release];
        }
        
        [mstrAlertMsg release];
        return;
    }
    else if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES && (m_strBarcodeUDI.length < 31) && (m_strBarcodeUDI.length > 1))
    {
        [mstrAlertMsg setString:@"UDI 코드 길이가 짧습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[~!@#$%^&*()_+|<>?:{}]" options:NSRegularExpressionSearch].location != NSNotFound )
    {
        [mstrAlertMsg setString:@"특수문자는 허용되지 않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    
    else if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[a-z]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"소문자는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[\\s]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"띄어쓰기는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[ㄱ-ㅎ|ㅏ-ㅣ|가-히]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"한글은 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else{
        // P 1차 일치검사 화면으로 전환
        [self pageReset2:nil];
        
        CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
        m_secondView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:orders[0]
                               forView:self.view
                                 cache:YES];
        
        [self.view addSubview:m_secondView];
        
        [UIView commitAnimations];
        
        [mstrAlertMsg release];
        
        return;
    }
    
    [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                        message:mstrAlertMsg
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles: nil];
    
    [alertView show];
    [alertView release];
    
    [mstrAlertMsg release];
}


- (IBAction)onOK2:(id)sender
{
    NSMutableString* mstrAlertMsg = [[NSMutableString alloc] initWithCapacity:100];
    
    if(m_strBarcodeBloodNo2.length == 0 || [m_strBarcodeBloodNo2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액번호를 입력하세요."];
        self.m_barcodeBloodNo2.enabled = YES;
        [self.m_barcodeBloodNo2 becomeFirstResponder];
    }else if(m_strBarcodeABOType2.length == 0 || [m_strBarcodeABOType2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액형바코드를 입력하세요."];
        self.m_barcodeABOType2.enabled = YES;
        [self.m_barcodeABOType2 becomeFirstResponder];
    }else if(m_strBarcodeBag2.length == 0 || [m_strBarcodeBag2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"채혈백바코드를 입력하세요."];
        self.m_barcodeBag2.enabled = YES;
        [self.m_barcodeBag2 becomeFirstResponder];
    }else if(m_strBarcodeMalaria2.length == 0 || [m_strBarcodeMalaria2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"말라리아바코드를 입력하세요."];
        self.m_barcodeMalaria2.enabled = YES;
        [self.m_barcodeMalaria2 becomeFirstResponder];
    }else if(m_strBarcodeBldBagcode2.length == 0 || [m_strBarcodeBldBagcode2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"백종류바코드를 입력하세요."];
        self.m_barcodeBldBagcode2.enabled = YES;
        [self.m_barcodeBldBagcode2 becomeFirstResponder];
    }else{
        NSString* strTitleMsg = @"1차 일치검사를 수행하시겠습니까?";
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            actionSheet.tag = kMatchingFirstStepConfirmActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kMatchingFirstStepConfirmActionSheetTag;
            
            [alertView show];
            [alertView release];
        }
        
        return;
    }
    
    [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                        message:mstrAlertMsg
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles: nil];
    
    [alertView show];
    [alertView release];
    
    [mstrAlertMsg release];
}


- (IBAction)onBack:(id)sender
{
    [self backgroundTab:nil];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.view.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    
    //[self.view removeFromSuperview];
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
									 target:self
								   selector:@selector(onBackSelector)
								   userInfo:nil
									repeats:NO];
}

- (IBAction)onBack2:(id)sender
{
    [self backgroundTab2:nil];
    
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
                           forView:self.view
                             cache:YES];

    [m_secondView removeFromSuperview];
    
    [UIView commitAnimations];
}


- (void) onBackSelector
{
    [self.view removeFromSuperview];
}


- (IBAction)backgroundTab:(id)sender
{
    [self.m_barcodeBloodNo resignFirstResponder];
    [self.m_barcodeABOType resignFirstResponder];
    [self.m_barcodeBag resignFirstResponder];
    [self.m_barcodeMalaria resignFirstResponder];
    [self.m_barcodeBldBagcode resignFirstResponder];
    // 2022.05.10 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    [self.m_barcodeUDI resignFirstResponder];
    
//    CGPoint point = CGPointMake(0, 0);
//    [m_scrollView setContentOffset:point animated:YES];
}


- (IBAction)backgroundTab2:(id)sender
{
    [self.m_barcodeBloodNo2 resignFirstResponder];
    [self.m_barcodeABOType2 resignFirstResponder];
    [self.m_barcodeBag2 resignFirstResponder];
    [self.m_barcodeMalaria2 resignFirstResponder];
    [self.m_barcodeBldBagcode2 resignFirstResponder];
}


- (void)setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
    self.m_selector = selector;
}


// 1차 일치검사 완료여부 확인.
- (void)requestIsMatchingFirstStepCompleted:(NSString*)strBloodNo
{
    // 2022.05.16 ADD HMWOO 1차 일치검사 완료 여부 확인 URL을 URL 관리 소스에서 관리하도록 수정
    NSString* url = URL_CHECK_FIRST_MATCHING_COMPLETE;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"matchingFirstStepNew", @"reqId", 
                                strBloodNo, @"bloodno", nil];
    
    //    m_httpRequest = [[HttpRequest alloc] init];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveIsMatchingFirstStepCompleted:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveIsMatchingFirstStepCompleted:(id)result
{
    //    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strKrcBldCnt = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    //    TRACE(@"%@", strData);
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
    
    strResult = [dictionary valueForKey:@"match01TF"];
    strKrcBldCnt = [dictionary valueForKey:@"krcBldCnt"];
    
//    TRACE(@"krcBldCnt = [%@]", strKrcBldCnt);
//    
//    if([strKrcBldCnt isEqualToString:@"2"] == YES){
//        self.m_firstDonationImageView.hidden = NO;
//    }
    
    if([strResult isEqualToString:@"true"] == YES){
        [self.m_barcodeBloodNo resignFirstResponder];
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        NSString* strTitleMsg = @"1차 일치검사가 완료된 혈액입니다.\n메인화면으로 이동합니다.";
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            actionSheet.tag = kIsMatchingFirstStepCompletedActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kIsMatchingFirstStepCompletedActionSheetTag;
            
            [alertView show];
            [alertView release];
        }
    }else{
        TRACE(@"krcBldCnt = [%@]", strKrcBldCnt);
        
        // wireline - 2014.06.30: 생애 첫 헌혈자 증진 사업 로직 추가
        if([strKrcBldCnt isEqualToString:@"2"] == YES){
            // wireline - 2020. 1.: 사업 종료에 따른 주석처리
//            self.m_firstDonationImageView.hidden = NO;
//            [SBUtils playAlertSystemSoundWithSoundType:SOUND_FIRST_DONOR];
        }
        
        //        self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:m_barcodeBloodNo.text];
        NSString* strTempBloodNo = self.m_strBarcodeBloodNo;
        self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:strTempBloodNo];
        self.m_barcodeBloodNo.enabled = NO;
        self.m_barcodeABOType.enabled = YES;
        
        self.m_BloodCntLabel.text = m_SBBloodnoInfoVO.bloodcnt;
        self.m_BloodCntLabel2.text = m_SBBloodnoInfoVO.bloodcnt;
        
        [self.m_barcodeABOType becomeFirstResponder];
    }
}


// 1차 일치검사 실행
- (void)requestMatcingFirstStep
{
    NSRange range = NSMakeRange(0, 1);
    NSString* strBagQty = [m_SBBloodnoInfoVO.m_selectedBldProc3 substringWithRange:range];
    range = NSMakeRange(2, 1);
    NSString* strBldProcInterface = [m_SBBloodnoInfoVO.m_selectedBldProc3 substringWithRange:range];
    NSString* strBarcodeBldBagcode = [NSString stringWithFormat:@"%@%@", self.m_strBarcodeBldBagcode, self.m_strBarcodeBldBagcode2];
    
    NSString* strIdName = [NSString stringWithString:m_SBUserInfoVO.szBimsName];
    
//    CGPoint point = CGPointMake(0, 0);
//    [m_scrollView setContentOffset:point animated:YES];
    // 2022.05.10 MOD HMWOO UDI 포함 일치검사 진행 요청 추가(없을 시 기존대로 진행)
    NSString* url = URL_MULTI_FIRST_MATCHING_TEST;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:m_SBBloodnoInfoVO.bloodno, @"strBloodNo", 
                                m_SBBloodnoInfoVO.m_selectedBldProc1, @"strBldProcCode",
                                strBagQty, @"strBagQty",
                                strBldProcInterface, @"strBldProcInterface",
                                @"", @"strBandBloodNo",
                                m_strBarcodeBloodNo, @"strBarcodeBloodNo",
                                m_strBarcodeBag, @"strBarcodeBag",
                                m_strBarcodeABOType, @"strBarcodeABOType",
                                strBarcodeBldBagcode, @"strBarcodeBldBagcode",
                                m_strBarcodeMalaria, @"strBarcodeMalaria",
                                m_strBarcodeUDI, @"strUDICode",
                                @"Y", @"strBSD",
                                strIdName, @"strIdName",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveRequestMatchingFirstStep:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveRequestMatchingFirstStep:(id)result
{
    //    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"didReceiveRequestMatchingFirstStep strData = [%@]", strData);
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
    
    if([strResult isEqualToString:@"1"] == YES){                
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"성공"
                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        [self onToHomeView:nil];
    }else{
        [self onBack2:nil];
        [self pageReset:nil];
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        NSString* strTempMsg = [NSString stringWithFormat:@"오류코드[%@] \n%@", 
                                strResult, [dictionary valueForKey:@"resultmsg"]];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strTempMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}


- (BOOL)barcodeValidation:(id)sender
{
    if([m_strBarcodeBloodNo isEqualToString:m_barcodeBag.text] == YES){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)barcodeValidation2:(id)sender
{
//    if([m_strBarcodeBloodNo isEqualToString:m_barcodeBloodNo2.text] == YES){
//        return NO;
//    }else if([m_strBarcodeBag isEqualToString:m_barcodeBloodNo2.text] == YES){
//        return NO;
//    }else{
//        return YES;
//    }
    
    return YES;
}

- (BOOL)barcodeValidation3:(id)sender
{
    if([m_strBarcodeBloodNo isEqualToString:m_barcodeBag2.text] == YES){
        return NO;
    }else if([m_strBarcodeBag isEqualToString:m_barcodeBag2.text] == YES){
        return NO;
    }else if([m_strBarcodeBloodNo2 isEqualToString:m_barcodeBag2.text] == YES){
        return NO;
    }else{
        return YES;
    }
}




#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kIsMatchingFirstStepCompletedActionSheetTag){
        // 1차 일치검사가 완료된 혈액이므로 메인화면으로 이동할 것인지 확인 - 첫 번째 백에서만 물어본다.
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO... to Matching Second Step.
            [self onToHomeView:nil];
        }else{
            [self pageReset:nil];
        }
    }else if(alertView.tag == kMatchingFirstStepConfirmActionSheetTag){
        // 1차 일치검사를 수행할 것인지 확인하는 ActionSheet
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self requestMatcingFirstStep];
        }else{
            [self onBack2:nil];
            [self pageReset:nil];
        }
    }
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    else if(alertView.tag == kMatchingSecondViewShowUDIActionSheetTag)
    {
        // UDI 바코드가 없더라도 1차 일치검사를 수행할 것인지 확인하는 ActionSheet
        if(buttonIndex != [alertView cancelButtonIndex])
        {
            [self pageReset2:nil];
            
            CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
            m_secondView.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
                                   forView:self.view
                                     cache:YES];
            
            [self.view addSubview:m_secondView];
            
            [UIView commitAnimations];
        }
        else
        {
            self.m_barcodeUDI.enabled = YES;
            [self.m_barcodeUDI becomeFirstResponder];
        }
    }
}


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == kIsMatchingFirstStepCompletedActionSheetTag){
        // 1차 일치검사가 완료된 혈액이므로 메인화면으로 이동할 것인지 확인 - 첫 번째 백에서만 물어본다.
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            // TO DO... to Matching Second Step.
            [self onToHomeView:nil];
        }else{
            [self pageReset:nil];
        }
    }else if(actionSheet.tag == kMatchingFirstStepConfirmActionSheetTag){
        // 1차 일치검사를 수행할 것인지 확인하는 ActionSheet
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self requestMatcingFirstStep];
        }else{
            [self onBack2:nil];
            [self pageReset:nil];
        }
    }
}



#pragma mark UITextFieldDelegate
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
        case kBarcodeABOTypeTextField :
            if(strInput.length > 2){
                return NO;
            }
            break;
        case kBarcodeBagTextField :
            if(strInput.length > 12){
                return NO;
            }
            break;
        case kBarcodeMalariaTextField :
            if(strInput.length > 6){
                return NO;
            }
            break;
        case kBarcodeBldBagcodeTextField :
            if(strInput.length > 7){
                return NO;
            }else{
                
            }
            break;
        case kBarcodeBloodNoTextField2 :
            if(strInput.length > 12){
                return NO;
            }
            break;
        case kBarcodeABOTypeTextField2 :
            if(strInput.length > 2){
                return NO;
            }
            break;
        case kBarcodeBagTextField2 :
            if(strInput.length > 12){
                return NO;
            }
            break;
        case kBarcodeMalariaTextField2 :
            if(strInput.length > 6){
                return NO;
            }
            break;
        case kBarcodeBldBagcodeTextField2 :
            if(strInput.length > 7){
                return NO;
            }else{
                
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
    NSString* strAlertMsg = @"";
    NSRange range = NSMakeRange(0, 10);
    
    switch(nTag){
        /* firstView */
        case kBarcodeBloodNoTextField :
            if(strLength < 12){
                strAlertMsg = @"헌혈자바코드의 길이가 다릅니다.";
            }else if(strLength == 12){
                
                NSString* strTempBloodNo = [self.m_SBBloodnoInfoVO.bloodno substringWithRange:range];
                NSString* strTempInput = [strInput substringWithRange:range];
                
                if([strTempBloodNo isEqualToString:strTempInput] == YES){
                    [self.m_strBarcodeBloodNo setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
                                                                                            withString:@""]];
                    [self requestIsMatchingFirstStepCompleted:strInput];
                }else{
                    strAlertMsg = @"헌혈자바코드 정보가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                }
            }
            break;
        case kBarcodeABOTypeTextField :
            if(strLength < 2){
                strAlertMsg = @"혈액형바코드의 길이가 다릅니다.";
            }else if(strLength == 2){
                if([self.m_SBBloodnoInfoVO.abobarcode isEqualToString:strInput] == NO){
                    strAlertMsg = @"혈액형코드가 조회한 정보와 맞지 않습니다.";
                    textField.text = @"";
                }else{
                    self.m_ABOTypeNameLabel.text = [SBUtils getABOTypeName:strInput];
                    
                    if(self.m_ABOTypeNameLabel.text == nil){
                        self.m_strBarcodeABOType = nil;
                        [m_strBarcodeABOType release];
                        
                        self.m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
                        
                        strAlertMsg = @"혈액형코드가 형식에 맞지 않습니다.";
                        textField.text = @"";
                    }else{
                        self.m_barcodeABOType.enabled = NO;
                        self.m_barcodeBag.enabled = YES;
                        
                        [self.m_strBarcodeABOType setString:strInput];
                        self.m_ABOTypeNameLabel.backgroundColor = [SBUtils getABOTypeBgRGBValue:self.m_strBarcodeABOType];
                        self.m_ABOTypeNameLabel.textColor = [SBUtils getABOTypeRGBValue:self.m_strBarcodeABOType];
                        
                        [self.m_barcodeBag becomeFirstResponder];
                        
                        //                    CGPoint point = CGPointMake(0, m_barcodeBldBagcode.frame.origin.y -20);
                        //                    [m_scrollView setContentOffset:point animated:YES];
                    }
                }
            }
            break;
        case kBarcodeBagTextField :
            if(strLength < 12){
                strAlertMsg = @"채혈백바코드의 길이가 다릅니다.";
            }else if(strLength == 12){
                if([self barcodeValidation:nil] == NO){                    
                    self.m_strBarcodeBag = nil;
                    [m_strBarcodeBag release];
                    
                    self.m_strBarcodeBag = [[NSMutableString alloc] initWithCapacity:16];
                    
                    strAlertMsg = @"이미 입력된 바코드값입니다.";
                    textField.text = @"";
                }else{
                    [self.m_strBarcodeBag setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                    self.m_barcodeBag.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeBag.enabled = NO;
                    self.m_barcodeMalaria.enabled = YES;
                    [self.m_barcodeMalaria becomeFirstResponder];
                }
            }
            break;
        case kBarcodeMalariaTextField :
            if(strLength < 6){
                strAlertMsg = @"말라리아바코드의 길이가 다릅니다.";
            }else if(strLength == 6){
                if([self.m_SBBloodnoInfoVO.malbarcode isEqualToString:strInput] == NO){
                    self.m_strBarcodeMalaria = nil;
                    [m_strBarcodeMalaria release];
                    
                    self.m_strBarcodeMalaria = [[NSMutableString alloc] initWithCapacity:6];
                    
                    strAlertMsg = @"입력한 말라리아 정보가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                }else{
                    self.m_barcodeMalaria.enabled = NO;
                    self.m_barcodeBldBagcode.enabled = YES;
                    [self.m_strBarcodeMalaria setString:strInput];
                    [self.m_barcodeBldBagcode becomeFirstResponder];
                }
            }
            break;
        case kBarcodeBldBagcodeTextField :
            if(strLength < 7){
                if([self.m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                    strAlertMsg = @"백종류바코드의 길이가 다릅니다.";
                }else{
                    strAlertMsg = @"채혈장비바코드의 길이가 다릅니다.";
                }
            }else if(strLength == 7){
                
                NSRange range = NSMakeRange(0, 7);
                NSString* strTempBldBagCode1 = [[NSString alloc] initWithString:[self.m_SBBloodnoInfoVO.m_barcodeBldBagCode substringWithRange:range]];
                
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅡ" withString:@"M"];
                
                if([strTempBldBagCode1 isEqualToString:strInput] == NO){
                    self.m_strBarcodeBldBagcode = nil;
                    [m_strBarcodeBldBagcode release];
                    
                    self.m_strBarcodeBldBagcode = [[NSMutableString alloc] initWithCapacity:7];
                    
                    if([m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                        strAlertMsg = @"입력한 백종류바코드가 선택된 정보와 다릅니다.";
                    }else{
                        strAlertMsg = @"입력한 채혈장비바코드가 선택된 정보와 다릅니다.";
                    }
                    
                    textField.text = @"";
                }else{
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅡ" withString:@"M"];
                    
                    self.m_barcodeBldBagcode.text = strInput;
                    
                    [self.m_strBarcodeBldBagcode setString:strInput];
                    self.m_barcodeBldBagcode.enabled = NO;
                    [self.m_barcodeBldBagcode resignFirstResponder];
                    
                    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
                    if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES)
                    {
                        self.m_barcodeUDI.enabled = YES;
                        [self.m_barcodeUDI becomeFirstResponder];
                    }
                    else
                    {
                        [self onOK:nil];
                    }
                }
                
                [strTempBldBagCode1 release];
            }
            break;
        // 2022.05.12 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
        case kBarcodeUDITextField :
            if(strLength <= 0)
            {
                self.m_barcodeUDI.text = strInput;
                [self.m_strBarcodeUDI setString:strInput];
                self.m_barcodeUDI.enabled = YES;
                
                [self onOK:nil];
                
            }
            else if((strLength > 0 && strLength < 30) || strLength > 40)
            {
                strAlertMsg = @"UDI바코드의 길이가 비정상입니다.";
                textField.text = @"";
            }
            else
            {
                NSRange rangeMCode = NSMakeRange(6, 4);
                NSRange rangeVCode = NSMakeRange(18, 6);
                
                NSString* MCode = [strInput substringWithRange:rangeMCode];
                NSString* VCode = [strInput substringWithRange:rangeVCode];
                
                NSDateFormatter* df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyMMdd"];
                NSDate *expireDate = [df dateFromString:VCode];
                
                TRACE(@"혈액백 유효기간 경과여부 = [%ld]", (long)[SBUtils compareDateWithToday:expireDate]);
                 
                if([SBUtils compareDateWithToday:expireDate] < 0)
                {
                    strAlertMsg = @"혈액백 유효기간이 경과하였습니다.";
                    textField.text = @"";
                    
                    if(self.m_strBarcodeUDI != nil){
                        [m_strBarcodeUDI release];
                        self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
                    }
                }
                // 2022.05.13 ADD HMWOO 현재 제조사 코드 유효성 검사 대응하지 않음(대응 필요시 활성화 및 checkVenderLOT 메소드 작업)
                /*
                else if([SBUtils checkVenderLOT:MCode])
                {
                    strAlertMsg = @"혈액백 제조사 코드가 유효하지 않습니다.";
                    textField.text = @"";
                    
                    if(self.m_strBarcodeUDI != nil){
                        [m_strBarcodeUDI release];
                        self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
                    }
                }
                */
                else
                {
                    self.m_barcodeUDI.text = strInput;
                    [self.m_strBarcodeUDI setString:strInput];
                    self.m_barcodeUDI.enabled = NO;
                    
                    [self onOK:nil];
                }
            }
            
            break;
        /* secondView */
        case kBarcodeBloodNoTextField2 :
            if(strLength < 12){
                strAlertMsg = @"헌혈자바코드의 길이가 다릅니다.";
            }else if(strLength == 12){
                
//                if([self barcodeValidation2:nil] == NO){
//                    self.m_strBarcodeBloodNo2 = nil;
//                    [m_strBarcodeBloodNo2 release];
//                    
//                    self.m_strBarcodeBloodNo2 = [[NSMutableString alloc] initWithCapacity:16];
//                    
//                    strAlertMsg = @"이미 입력된 바코드값입니다.";
//                    textField.text = @"";
//                }else{
//                    NSString* strTempBloodNo = [self.m_SBBloodnoInfoVO.bloodno substringWithRange:range];
//                    NSString* strTempInput = [strInput substringWithRange:range];
//                    
//                    if([strTempBloodNo isEqualToString:strTempInput] == YES){
//                        [self.m_strBarcodeBloodNo2 setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
//                                                                                                 withString:@""]];
//                        NSString* strTempBloodNo = self.m_strBarcodeBloodNo2;
//                        self.m_barcodeBloodNo2.text = [SBUtils formatBloodNo:strTempBloodNo];
//                        self.m_barcodeBloodNo2.enabled = NO;
//                        self.m_barcodeABOType2.enabled = YES;
//                        [self.m_barcodeABOType2 becomeFirstResponder];
//                    }else{
//                        strAlertMsg = @"헌혈자바코드 정보가 조회한 정보와 다릅니다.";
//                        textField.text = @"";
//                    }
//                }
                
                NSString* strTempBloodNo = [self.m_SBBloodnoInfoVO.bloodno substringWithRange:range];
                NSString* strTempInput = [strInput substringWithRange:range];
                
                if([strTempBloodNo isEqualToString:strTempInput] == YES){
                    [self.m_strBarcodeBloodNo2 setString:[strInput stringByReplacingOccurrencesOfString:@"-"
                                                                                             withString:@""]];
                    NSString* strTempBloodNo = self.m_strBarcodeBloodNo2;
                    self.m_barcodeBloodNo2.text = [SBUtils formatBloodNo:strTempBloodNo];
                    self.m_barcodeBloodNo2.enabled = NO;
                    self.m_barcodeABOType2.enabled = YES;
                    [self.m_barcodeABOType2 becomeFirstResponder];
                }else{
                    strAlertMsg = @"헌혈자바코드 정보가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                }
            }
            break;
        case kBarcodeABOTypeTextField2 :
            if(strLength < 2){
                strAlertMsg = @"혈액형바코드의 길이가 다릅니다.";
            }else if(strLength == 2){
                
                // 입력된 혈액형바코드를 첫 번째백과 비교.
                if([self.m_SBBloodnoInfoVO.abobarcode isEqualToString:strInput] == NO){
                    strAlertMsg = @"혈액형코드가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                }else{
                    // 정상적인 혈액형코드값이 아닌 경우 nil반환
                    self.m_ABOTypeNameLabel2.text = [SBUtils getABOTypeName:strInput];
                    
                    if(self.m_ABOTypeNameLabel2.text == nil){
                        self.m_strBarcodeABOType2 = nil;
                        [m_strBarcodeABOType2 release];
                        
                        self.m_strBarcodeABOType2 = [[NSMutableString alloc] initWithCapacity:2];
                        
                        strAlertMsg = @"혈액형코드가 형식에 맞지 않습니다.";
                        textField.text = @"";
                    }else{
                        self.m_barcodeABOType2.enabled = NO;
                        self.m_barcodeBag2.enabled = YES;
                        
                        [self.m_strBarcodeABOType2 setString:strInput];
                        self.m_ABOTypeNameLabel2.backgroundColor = [SBUtils getABOTypeBgRGBValue:self.m_strBarcodeABOType2];
                        self.m_ABOTypeNameLabel2.textColor = [SBUtils getABOTypeRGBValue:self.m_strBarcodeABOType2];
                        
                        [self.m_barcodeBag2 becomeFirstResponder];
                        
                        //                    CGPoint point = CGPointMake(0, m_barcodeBldBagcode.frame.origin.y -20);
                        //                    [m_scrollView setContentOffset:point animated:YES];
                    }
                }
            }
            break;
        case kBarcodeBagTextField2 :
            if(strLength < 12){
                strAlertMsg = @"채혈백바코드의 길이가 다릅니다.";
            }else if(strLength == 12){
                
                if([self barcodeValidation3:nil] == NO){
                    self.m_strBarcodeBag2 = nil;
                    [m_strBarcodeBag2 release];
                    
                    self.m_strBarcodeBag2 = [[NSMutableString alloc] initWithCapacity:16];
                    
                    strAlertMsg = @"이미 입력된 바코드값입니다.";
                    textField.text = @"";
                }else{
                    NSString* strTempBarcodeBag1 = [SBUtils getParameterTypeBloodNo:self.m_strBarcodeBag];
                    NSString* strTempBarcodeBag2 = [SBUtils getParameterTypeBloodNo:strInput];
                    
                    if([strTempBarcodeBag1 isEqualToString:strTempBarcodeBag2] == YES){
                        [self.m_strBarcodeBag2 setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                        self.m_barcodeBag2.text = [SBUtils formatBloodNo:strInput];
                        self.m_barcodeBag2.enabled = NO;
                        self.m_barcodeMalaria2.enabled = YES;
                        [self.m_barcodeMalaria2 becomeFirstResponder];
                    }else{
                        self.m_strBarcodeBag2 = nil;
                        [m_strBarcodeBag2 release];
                        
                        self.m_strBarcodeBag2 = [[NSMutableString alloc] initWithCapacity:16];
                        
                        strAlertMsg = @"채혈백바코드 정보가 첫 번째 Bag과 다릅니다.";
                        textField.text = @"";
                    }
                }
            }
            break;
        case kBarcodeMalariaTextField2 :
            if(strLength < 6){
                strAlertMsg = @"말라리아바코드의 길이가 다릅니다.";
            }else if(strLength == 6){
                // TO DO...  All input value inserted!
                if([self.m_SBBloodnoInfoVO.malbarcode isEqualToString:strInput] == NO){
                    self.m_strBarcodeMalaria2 = nil;
                    [m_strBarcodeMalaria2 release];
                    
                    self.m_strBarcodeMalaria2 = [[NSMutableString alloc] initWithCapacity:6];
                    
                    strAlertMsg = @"입력한 말라리아 정보가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                }else{
                    [self.m_strBarcodeMalaria2 setString:strInput];
                    self.m_barcodeMalaria2.enabled = NO;
                    self.m_barcodeBldBagcode2.enabled = YES;
                    [self.m_barcodeBldBagcode2 becomeFirstResponder];
//                    [self.m_barcodeMalaria2 resignFirstResponder];
//                    [self.m_strBarcodeMalaria2 setString:strInput];
//                    
//                    [self onOK2:nil];
                }
            }
            break;
        case kBarcodeBldBagcodeTextField2 :
            if(strLength < 7){
                if([self.m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                    strAlertMsg = @"백종류바코드의 길이가 다릅니다.";
                }else{
                    strAlertMsg = @"채혈장비바코드의 길이가 다릅니다.";
                }
            }else if(strLength == 7){
                NSRange range = NSMakeRange(7, 7);
                NSString* strTempBldBagCode2 = [[NSString alloc] initWithString:[self.m_SBBloodnoInfoVO.m_barcodeBldBagCode substringWithRange:range]];
                
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅡ" withString:@"M"];
                
                if([strTempBldBagCode2 isEqualToString:strInput] == NO){
                    self.m_strBarcodeBldBagcode2 = nil;
                    [m_strBarcodeBldBagcode2 release];
                    
                    self.m_strBarcodeBldBagcode2 = [[NSMutableString alloc] initWithCapacity:7];
                    
                    if([m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                        strAlertMsg = @"입력한 백종류바코드가 선택된 정보와 다릅니다.";
                    }else{
                        strAlertMsg = @"입력한 채혈장비바코드가 선택된 정보와 다릅니다.";
                    }
                    
                    textField.text = @"";
                }else{
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
//                    strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅡ" withString:@"M"];
                    
                    self.m_barcodeBldBagcode2.text = strInput;
                    
                    [self.m_strBarcodeBldBagcode2 setString:strInput];
                    self.m_barcodeBldBagcode2.enabled = NO;
                    [self.m_barcodeBldBagcode2 resignFirstResponder];
                    
                    [self onOK2:nil];
                    //                self.m_barcodeMalaria2.enabled = YES;
                    //                [self.m_barcodeMalaria2 becomeFirstResponder];
                }
                
                [strTempBldBagCode2 release];
            }
            break;

        default:
            return YES;
    }
    
    if([strAlertMsg isEqualToString:@""] == NO){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        return NO;
    }else{
        return YES;
    }
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
    
    self.m_httpRequest = [[HttpRequest alloc] init];
    
    self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    self.m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
    self.m_strBarcodeBag = [[NSMutableString alloc] initWithCapacity:16];
    self.m_strBarcodeMalaria = [[NSMutableString alloc] initWithCapacity:6];
    self.m_strBarcodeBldBagcode = [[NSMutableString alloc] initWithCapacity:7];
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
    
    self.m_barcodeBloodNo.enabled = YES;
    self.m_barcodeABOType.enabled = NO;
    self.m_barcodeBag.enabled = NO;
    self.m_barcodeMalaria.enabled = NO;
    self.m_barcodeBldBagcode.enabled = NO;
    
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    self.m_barcodeUDI.enabled = NO;
    
    self.m_ABOTypeNameLabel.text = @"";
    
    self.m_firstDonationImageView.hidden = YES;
    
    
    self.m_strBarcodeBloodNo2 = [[NSMutableString alloc] initWithCapacity:16];
    self.m_strBarcodeABOType2 = [[NSMutableString alloc] initWithCapacity:2];
    self.m_strBarcodeBag2 = [[NSMutableString alloc] initWithCapacity:16];
    self.m_strBarcodeMalaria2 = [[NSMutableString alloc] initWithCapacity:6];
    self.m_strBarcodeBldBagcode2 = [[NSMutableString alloc] initWithCapacity:7];
    
    self.m_barcodeBloodNo2.enabled = YES;
    self.m_barcodeABOType2.enabled = NO;
    self.m_barcodeBag2.enabled = NO;
    self.m_barcodeMalaria2.enabled = NO;
    self.m_barcodeBldBagcode2.enabled = NO;
    
    self.m_ABOTypeNameLabel.text = @"";
    
//    CGSize size;	
//	size = self.m_contentsView.frame.size;
//	
//	TRACE(@"width : %f, height : %f", size.width, size.height); 
//	
//	self.m_scrollView.contentSize = size;
//    
//    [self.view addSubview:m_scrollView];
//    [m_scrollView addSubview:m_contentsView];
    
    [m_barcodeBloodNo becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBBloodnoInfoVO = nil;
    self.m_SBUserInfoVO = nil;
    
//    self.m_scrollView = nil;
//    self.m_contentsView = nil;
    self.m_firstView = nil;
    self.m_secondView = nil;
    
    self.m_idNameLabel = nil;
    self.m_idNameLabel2 = nil;
    
    /* firstView */
    self.m_barcodeBloodNo = nil;
    self.m_barcodeABOType = nil;
    self.m_barcodeBag = nil;
    self.m_barcodeMalaria = nil;
    self.m_barcodeBldBagcode = nil;
    
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    self.m_barcodeUDI = nil;
    
    self.m_strBarcodeBloodNo = nil;
    self.m_strBarcodeABOType = nil;
    self.m_strBarcodeBag = nil;
    self.m_strBarcodeMalaria = nil;
    self.m_strBarcodeBldBagcode = nil;
    
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    self.m_strBarcodeUDI = nil;
    
    self.m_BldBagLabel = nil;
    self.m_ABOTypeNameLabel = nil;
    
    self.m_BloodCntLabel = nil;
    
    self.m_btnOK = nil;
    self.m_btnCancel = nil;
    
    self.m_firstDonationImageView = nil;
    self.m_activityIndicatorView = nil;
    
    /* secondView */
    self.m_barcodeBloodNo2 = nil;
    self.m_barcodeABOType2 = nil;
    self.m_barcodeBag2 = nil;
    self.m_barcodeMalaria2 = nil;
    self.m_barcodeBldBagcode2 = nil;
    
    self.m_strBarcodeBloodNo2 = nil;
    self.m_strBarcodeABOType2 = nil;
    self.m_strBarcodeBag2 = nil;
    self.m_strBarcodeMalaria2 = nil;
    self.m_strBarcodeBldBagcode2 = nil;
    
    self.m_BldBagLabel2 = nil;
    self.m_ABOTypeNameLabel2 = nil;
    
    self.m_BloodCntLabel2 = nil;
    
    self.m_btnOK2 = nil;
    self.m_btnCancel2 = nil;
    self.m_activityIndicatorView2 = nil;
    
    /* commons */
    self.m_target = nil;
}


- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBBloodnoInfoVO release];
    [m_SBUserInfoVO release];
//    [m_scrollView release];
//    [m_contentsView release];
    [m_firstView release];
    [m_secondView release];
    
    [m_idNameLabel release];
    [m_idNameLabel2 release];
    
    /* firstView */
    [m_barcodeBloodNo release];
    [m_barcodeABOType release];
    [m_barcodeBag release];
    [m_barcodeMalaria release];
    [m_barcodeBldBagcode release];
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    [m_barcodeUDI release];
    
    [m_strBarcodeBloodNo release];
    [m_strBarcodeABOType release];
    [m_strBarcodeBag release];
    [m_strBarcodeMalaria release];
    [m_strBarcodeBldBagcode release];
    // 2022.05.11 ADD HMWOO 혈소판혈장성분 채혈 시 UDI 바코드 일치 검사를 위한 UDI 바코드 내역 추가
    [m_strBarcodeUDI release];
    
    [m_BldBagLabel release];
    [m_ABOTypeNameLabel release];
    [m_btnOK release];
    [m_btnCancel release];
    [m_activityIndicatorView release];
    
    [m_firstDonationImageView release];
    
    [m_BloodCntLabel release];
    
    /* secondView */
    [m_barcodeBloodNo2 release];
    [m_barcodeABOType2 release];
    [m_barcodeBag2 release];
    [m_barcodeMalaria2 release];
    [m_barcodeBldBagcode2 release];
    
    [m_strBarcodeBloodNo2 release];
    [m_strBarcodeABOType2 release];
    [m_strBarcodeBag2 release];
    [m_strBarcodeMalaria2 release];
    [m_strBarcodeBldBagcode2 release];
    
    [m_BldBagLabel2 release];
    [m_ABOTypeNameLabel2 release];
    [m_btnOK2 release];
    [m_btnCancel2 release];
    [m_activityIndicatorView2 release];
    
    [m_BloodCntLabel2 release];
    
    /* commons */
    [m_target release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
