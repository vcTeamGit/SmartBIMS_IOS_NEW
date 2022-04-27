//
//  SBFirstMatchingViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 18..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBFirstMatchingViewController.h"
#import "SBUserInfoVO.h"
#import "SBBloodnoInfoVO.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBUtils.h"
#import "SB2ndMatchingFrom1stViewController.h"
#import "SBSideEffectsListViewController.h"

#import "Smart_BIMSAppDelegate.h"

@implementation SBFirstMatchingViewController

@synthesize m_httpRequest;
@synthesize m_SBBloodnoInfoVO;
@synthesize m_SBUserInfoVO;

@synthesize m_scrollView;
@synthesize m_contentsView;

@synthesize m_idNameLabel;
@synthesize m_barcodeUDILabel;

@synthesize m_barcodeBloodNo;
@synthesize m_barcodeABOType;
@synthesize m_barcodeBag;
@synthesize m_barcodeMalaria;
@synthesize m_barcodeBldBagcode;
@synthesize m_barcodeUDI;

@synthesize m_strBarcodeBloodNo;
@synthesize m_strBarcodeABOType;
@synthesize m_strBarcodeBag;
@synthesize m_strBarcodeMalaria;
@synthesize m_strBarcodeBldBagcode;

@synthesize m_strBarcodeUDI;
@synthesize m_strMCode;
@synthesize m_strVCode;
@synthesize m_strLCode;

@synthesize m_BldBagLabel;
@synthesize m_ABOTypeNameLabel;

@synthesize m_BloodCntLabel;

@synthesize m_btnOK;
@synthesize m_btnCancel;
@synthesize m_btnToBloodEndTimeView;
//@synthesize m_btnToSideEffectsView;

@synthesize m_firstDonationImageView;

@synthesize m_target;
@synthesize m_selector;

@synthesize m_activityIndicatorView;

@synthesize m_SB2ndMatchingFrom1stViewController;
//@synthesize m_SBSideEffectsListViewController;


- (void)setUserInfo:(SBUserInfoVO*)userInfo
{
    self.m_SBUserInfoVO = [[SBUserInfoVO alloc] initWithSBUserInfo:userInfo];
}


- (void)setBldBagLabelText
{
    if([m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
        self.m_BldBagLabel.font = [UIFont boldSystemFontOfSize:15];
        self.m_BldBagLabel.text = @"백종류바코드";
    }else{
        self.m_BldBagLabel.font = [UIFont boldSystemFontOfSize:13];
        self.m_BldBagLabel.text = @"채혈장비바코드";
    }
}


- (IBAction)pageReset:(id)sender
{
    if(self.m_strBarcodeBloodNo != nil){
//        self.m_strBarcodeBloodNo = nil;
        [m_strBarcodeBloodNo release];
        
        self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if(self.m_strBarcodeABOType != nil){
        //        self.m_strBarcodeABOType = nil;
        [m_strBarcodeABOType release];
        
        self.m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
    }
    
    if(self.m_strBarcodeBag != nil){
//        self.m_strBarcodeBag = nil;
        [m_strBarcodeBag release];
        
        self.m_strBarcodeBag = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if(self.m_strBarcodeMalaria != nil){
        //        self.m_strBarcodeMalaria = nil;
        [m_strBarcodeMalaria release];
        
        self.m_strBarcodeMalaria = [[NSMutableString alloc] initWithCapacity:6];
    }
    
    if(self.m_strBarcodeBldBagcode != nil){
//        self.m_strBarcodeBldBagcode = nil;
        [m_strBarcodeBldBagcode release];
        
        self.m_strBarcodeBldBagcode = [[NSMutableString alloc] initWithCapacity:7];
    }
    
    if(self.m_strBarcodeUDI != nil){
        [m_strBarcodeUDI release];
        
        self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
    }
    self.m_strMCode = @"";
    self.m_strVCode = @"";
    self.m_strLCode = @"";
    
    self.m_barcodeBloodNo.text = @"";
    self.m_barcodeABOType.text = @"";
    self.m_barcodeBag.text = @"";
    self.m_barcodeMalaria.text = @"";
    self.m_barcodeBldBagcode.text = @"";
    self.m_barcodeUDI.text = @"";
    
    self.m_BloodCntLabel.text = @"";
    
    self.m_ABOTypeNameLabel.text = nil;
    self.m_ABOTypeNameLabel.textColor = [UIColor blackColor];   // UILabel.textColor is non-nil value.
    self.m_ABOTypeNameLabel.backgroundColor = nil;
    
    self.m_barcodeBloodNo.enabled = YES;
    self.m_barcodeABOType.enabled = NO;
    self.m_barcodeBag.enabled = NO;
    self.m_barcodeMalaria.enabled = NO;
    self.m_barcodeBldBagcode.enabled = NO;
    self.m_barcodeUDI.enabled = NO;
    
    self.m_firstDonationImageView.hidden = YES;
//    self.m_btnToSideEffectsView.hidden = YES;
    
    if([self.m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
    [self.m_barcodeBloodNo becomeFirstResponder];
}


- (IBAction)onToBloodEndTimeView:(id)sender
{
    
}


//- (IBAction)onToSideEffectsView:(id)sender
//{
//    if(m_SBSideEffectsListViewController == nil){
//        if(winHeight == kWINDOW_HEIGHT){
//            m_SBSideEffectsListViewController = [[SBSideEffectsListViewController alloc] initWithNibName:@"SBSideEffectsListViewController"
//                                                                                                  bundle:nil];
//        }else{
//            m_SBSideEffectsListViewController = [[SBSideEffectsListViewController alloc] initWithNibName:@"SBSideEffectsListViewController3"
//                                                                                                  bundle:nil];
//        }
//    }
//    
//    [self backgroundTab:nil];
//    
//    [m_SBSideEffectsListViewController setValuesWithBloodNo:self.m_strBarcodeBloodNo];
////    [m_SBSideEffectsListViewController pageReset];
//    [m_SBSideEffectsListViewController setDelegate:self
//                                          selector:@selector(onReFocus)];
//    
//    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
//    m_SBSideEffectsListViewController.view.frame = frame;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    
//    m_SBSideEffectsListViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
//    
//    [self.view addSubview:m_SBSideEffectsListViewController.view];
//    
//    [UIView commitAnimations];
//}


//- (void)onReFocus
//{
//    TRACE(@"onReFocus");
//    
//    TRACE(@"m_barcodeABOType=[%lul]", (unsigned long)[self.m_barcodeABOType.text length]);
//    TRACE(@"m_barcodeBldBagcode=[%lul]", (unsigned long)[self.m_barcodeBldBagcode.text length]);
//    TRACE(@"m_barcodeMalaria=[%lul]", (unsigned long)[self.m_barcodeMalaria.text length]);
//    TRACE(@"m_barcodeBag=[%lul]", (unsigned long)[self.m_barcodeBag.text length]);
//    TRACE(@"m_barcodeBloodNo=[%lul]", (unsigned long)[self.m_barcodeBloodNo.text length]);
//    
//    if([self.m_barcodeBloodNo.text length] == 0) [m_barcodeBloodNo becomeFirstResponder];
//    else if([self.m_barcodeABOType.text length] == 0) [m_barcodeABOType becomeFirstResponder];
//    else if([self.m_barcodeBag.text length] == 0) [m_barcodeBag becomeFirstResponder];
//    else if([self.m_barcodeMalaria.text length] == 0) [m_barcodeMalaria becomeFirstResponder];
//    else if([self.m_barcodeBldBagcode.text length] == 0) [m_barcodeBldBagcode becomeFirstResponder];
//    else return;
//}


- (IBAction)onToHomeView:(id)sender
{
    if(m_target){
        [self backgroundTab:nil];
        [m_target performSelector:m_selector];
    }
}


- (IBAction)onOK:(id)sender
{
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
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) && (m_strBarcodeUDI.length == 0 || [m_strBarcodeUDI isEqualToString:@""])){
        [mstrAlertMsg setString:@"UDI코드를 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) && (m_strBarcodeUDI.length < 34)){
        [mstrAlertMsg setString:@"UDI 코드 길이가 짧습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) &&
        [m_strBarcodeUDI rangeOfString:@"[~!@#$%^&*()_+|<>?:{}]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"특수문자는 허용되지 않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) &&
        [m_strBarcodeUDI rangeOfString:@"[a-z]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"소문자는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) &&
        [m_strBarcodeUDI rangeOfString:@"[\\s]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"띄어쓰기는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) &&
        [m_strBarcodeUDI rangeOfString:@"[ㄱ-ㅎ|ㅏ-ㅣ|가-히]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"한글은 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    // 혈장 부분 로직 추가
    else if (([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES) && (m_strBarcodeUDI.length == 0 || [m_strBarcodeUDI isEqualToString:@""])){
        
        NSString* strTitleMsg = @"혈장 UDI코드가 입력되지 않았습니다. \n 1차 일치검사를 진행하시겠습니까?";
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            actionSheet.tag = kMatchingFirstStepChkUDIActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
            
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[확 인]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            alertView.tag = kMatchingFirstStepChkUDIActionSheetTag;
            [alertView show];
            [alertView release];
        }
        
        [mstrAlertMsg release];
        return;
    }
    
    else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES) && (m_strBarcodeUDI.length < 31) && (m_strBarcodeUDI.length > 1)){
        [mstrAlertMsg setString:@"UDI 코드 길이가 짧습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES) && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[~!@#$%^&*()_+|<>?:{}]" options:NSRegularExpressionSearch].location != NSNotFound )
    {
        [mstrAlertMsg setString:@"특수문자는 허용되지 않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES)  && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[a-z]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"소문자는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES) && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[\\s]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"띄어쓰기는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES) && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[ㄱ-ㅎ|ㅏ-ㅣ|가-히]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"한글은 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else if (([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES ) && (m_strBarcodeUDI.length == 0 || [m_strBarcodeUDI isEqualToString:@""])){
        
        NSString* strTitleMsg = @"혈소판 UDI코드가 입력되지 않았습니다. \n 1차 일치검사를 진행하시겠습니까?";
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            actionSheet.tag = kMatchingFirstStepChkUDIActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
            
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[확 인]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            alertView.tag = kMatchingFirstStepChkUDIActionSheetTag;
            [alertView show];
            [alertView release];
        }
        
        [mstrAlertMsg release];
        return;
    }
    
    else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES) && (m_strBarcodeUDI.length < 31) && (m_strBarcodeUDI.length > 1)){
        [mstrAlertMsg setString:@"UDI 코드 길이가 짧습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES ) && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[~!@#$%^&*()_+|<>?:{}]" options:NSRegularExpressionSearch].location != NSNotFound )
    {
        [mstrAlertMsg setString:@"특수문자는 허용되지 않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES)  && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[a-z]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"소문자는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES) && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[\\s]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"띄어쓰기는 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }else if(([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES) && (m_strBarcodeUDI.length > 1) &&
        [m_strBarcodeUDI rangeOfString:@"[ㄱ-ㅎ|ㅏ-ㅣ|가-히]" options:NSRegularExpressionSearch].location != NSNotFound)
    {
        [mstrAlertMsg setString:@"한글은 허용되지않습니다. 다시 입력하세요."];
        self.m_barcodeUDI.enabled = YES;
        [self.m_barcodeUDI becomeFirstResponder];
    }
    else{
        NSString* strTitleMsg = @"1차 일치검사를 수행하시겠습니까?";
        
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
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[확 인]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            alertView.tag = kMatchingFirstStepConfirmActionSheetTag;
            [alertView show];
            [alertView release];
        }
        
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

- (void)sliceUDI:(NSString*)udi
            code:(NSString*)bldproccode
          length:(NSString*)len {
    
    NSString* strInput = udi;
    
    NSRange rangeMCode = NSMakeRange(6, 4);     // 제조사
    NSRange rangeVCode = NSMakeRange(18, 6);    // 유효기간
    NSRange rangeLCode = NSMakeRange(26, 8);    // 로트번호
    
    self.m_strMCode = [strInput substringWithRange:rangeMCode];
    self.m_strVCode = [strInput substringWithRange:rangeVCode];
    self.m_strLCode = [strInput substringWithRange:rangeLCode];
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
    [self.m_barcodeUDI resignFirstResponder];
    
//    CGPoint point = CGPointMake(0, 0);
//    [m_scrollView setContentOffset:point animated:YES];
}


- (BOOL)barcodeValidation:(id)sender
{
    if([m_strBarcodeBloodNo isEqualToString:m_barcodeBag.text] == YES){
        return NO;
    }else{
        return YES;
    }
}


- (void)setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
    self.m_selector = selector;
}


// 1차 일치검사 완료여부 확인.
- (void)requestIsMatchingFirstStepCompleted:(NSString*)strBloodNo
{
    if(m_isBusy) return;
    else m_isBusy = YES;
    
    TRACE(@"%@", strBloodNo);
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBMatchingCommonDAOTest.jsp";
//    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"matchingFirstStepNew", @"reqId",
//                                strBloodNo, @"bloodno", nil];
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"matchingFirstStepWithSideEffects", @"reqId",
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
    m_isBusy = NO;
//    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    NSString* strKrcBldRecipient = @"";
    NSString* strBeSideEffects = @"";
    NSString* strBldProcCode = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"%@", strData);
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
    strKrcBldRecipient = [dictionary valueForKey:@"krcBldRecipient"];
    strBeSideEffects = [dictionary valueForKey:@"beSideEffects"];
//    strBldProcCode = [dictionary valueForKey:@"bldProcCode"];  // nur_master의 bldproccode 정보를 새로 불러오려 했으나 큰 의미가 없어서 m_SBBloodnoInfoVO 값 그대로 사용
    strBldProcCode = m_SBBloodnoInfoVO.bldproccode;
    
    if([strResult isEqualToString:@"true"] == YES){
        [self.m_barcodeBloodNo resignFirstResponder];
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            NSString* strTitleMsg = @"1차 일치검사가 완료된 혈액입니다.\n메인화면으로 이동합니다.";
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
                                                                message:@"1차 일치검사가 완료된 혈액입니다.\n메인화면으로 이동합니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kIsMatchingFirstStepCompletedActionSheetTag;
            
            [alertView show];
            [alertView release];
        }
        
        return;
    }else{
        TRACE(@"krcbldrecipient=[%@]", strKrcBldRecipient);
        
        // wireline - 2014.06.30: 생애 첫 헌혈자 증진 사업 로직 추가
        if([strKrcBldRecipient isEqualToString:@"Y"] == YES){
            // wireline - 2020. 1.: 사업 종료로 인한 주석처리
            // 내가 정보기획팀 있을 때 제거하는거니깐 혈액정보팀에서 온 문서가 있을거다.
//            self.m_firstDonationImageView.hidden = NO;
//            [SBUtils playAlertSystemSoundWithSoundType:SOUND_FIRST_DONOR];
        }
        
//        if([strBeSideEffects isEqualToString:@"Y"] == YES){
//            self.m_btnToSideEffectsView.hidden = NO;
//            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
//        }
        
//        self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:m_barcodeBloodNo.text];
        NSString* strTempBloodNo = self.m_strBarcodeBloodNo;
        self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:strTempBloodNo];
        self.m_barcodeBloodNo.enabled = NO;
        self.m_barcodeABOType.enabled = YES;
        
        // 2019. 12. 전혈일 경우만 UDI 체크
//        if([strBldProcCode isEqualToString:@"00"] == YES || [strBldProcCode isEqualToString:@"50"] == YES){
//            self.m_barcodeUDI.enabled = YES;
//            self.m_barcodeUDI.backgroundColor = UIColor.whiteColor;
//        }else{
//            self.m_barcodeUDI.enabled = NO;
//            self.m_barcodeUDI.backgroundColor = UIColor.lightGrayColor;
//        }
        
        // 2014.02.21 추가
        self.m_BloodCntLabel.text = m_SBBloodnoInfoVO.bloodcnt;
        
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
    
//    TRACE(@"selectedBldProc3 := [%@], strBagQty := [%@], strBldProcInterface := [%@]", m_SBBloodnoInfoVO.m_selectedBldProc3, strBagQty, strBldProcInterface);
    
    NSString* strBSD = self.m_SBBloodnoInfoVO.isOnBSD == YES? @"Y" : @"N";
    NSString* strIdName = [NSString stringWithString:m_SBUserInfoVO.szBimsName];
    
    if(m_isBusy) return;
    else m_isBusy = YES;
    
//    TRACE(@"bloodno = [%@], bag = [%@]", m_SBBloodnoInfoVO.bloodno, m_strBarcodeBloodNo);
    
//    CGPoint point = CGPointMake(0, 0);
//    [m_scrollView setContentOffset:point animated:YES];
    
//    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBMatchingFirstStepTR.jsp";
//    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:m_SBBloodnoInfoVO.bloodno, @"strBloodNo",
//                                m_SBBloodnoInfoVO.m_selectedBldProc1, @"strBldProcCode",
//                                strBagQty, @"strBagQty",
//                                strBldProcInterface, @"strBldProcInterface",
//                                @"", @"strBandBloodNo",
//                                m_strBarcodeBloodNo, @"strBarcodeBloodNo",
//                                m_strBarcodeABOType, @"strBarcodeABOType",
//                                m_strBarcodeBag, @"strBarcodeBag",
//                                m_strBarcodeMalaria, @"strBarcodeMalaria",
//                                m_strBarcodeBldBagcode, @"strBarcodeBldBagcode",
//                                strBSD, @"strBSD",
//                                strIdName, @"strIdName",
//                                nil];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBMatchingFirstStepWithUdiTR.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:m_SBBloodnoInfoVO.bloodno, @"strBloodNo",
                                m_SBBloodnoInfoVO.m_selectedBldProc1, @"strBldProcCode",
                                strBagQty, @"strBagQty",
                                strBldProcInterface, @"strBldProcInterface",
                                @"", @"strBandBloodNo",
                                m_strBarcodeBloodNo, @"strBarcodeBloodNo",
                                m_strBarcodeABOType, @"strBarcodeABOType",
                                m_strBarcodeBag, @"strBarcodeBag",
                                m_strBarcodeMalaria, @"strBarcodeMalaria",
                                m_strBarcodeBldBagcode, @"strBarcodeBldBagcode",
                                strBSD, @"strBSD",
                                strIdName, @"strIdName",
                                m_strBarcodeUDI, @"strUDICode",
                                m_strMCode, @"strMCode",
                                m_strVCode, @"strVCode",
                                m_strLCode, @"strLCode",
                                nil];
    
//    m_httpRequest = [[HttpRequest alloc] init];
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
    
    m_isBusy = NO;
    
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
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"성공"
//                                                            message:[dictionary valueForKey:@"resultmsg"]
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        [alertView show];
//        [alertView release];
        
//        [self onToHomeView:nil];
        
        // wireline - 2014.01.06: 2차 일치검사로 바로 진입
        if(m_SB2ndMatchingFrom1stViewController == nil){
            if(winHeight == kWINDOW_HEIGHT){
                m_SB2ndMatchingFrom1stViewController = [[SB2ndMatchingFrom1stViewController alloc] initWithNibName:@"SB2ndMatchingFrom1stViewController"
                                                                                                            bundle:nil];
            }else{
                m_SB2ndMatchingFrom1stViewController = [[SB2ndMatchingFrom1stViewController alloc] initWithNibName:@"SB2ndMatchingFrom1stViewController3"
                                                                                                            bundle:nil];
            }
        }
        
        [m_SB2ndMatchingFrom1stViewController setUserInfo:self.m_SBUserInfoVO];
        [m_SB2ndMatchingFrom1stViewController pageReset:nil];
        
        CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
        m_SB2ndMatchingFrom1stViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_SB2ndMatchingFrom1stViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        
        [m_SB2ndMatchingFrom1stViewController setDelegate:self
                                                 selector:@selector(onToHomeViewFromSecondMatchingView)];
        m_SB2ndMatchingFrom1stViewController.m_SBBloodNoInfoVO = self.m_SBBloodnoInfoVO;
        [m_SB2ndMatchingFrom1stViewController setBldBagLabelText];
        
        [self.view addSubview:m_SB2ndMatchingFrom1stViewController.view];
        
        [UIView commitAnimations];
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
//        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
//            NSString* strTitleMsg = [NSString stringWithFormat:@"성공\n%@", [dictionary valueForKey:@"resultmsg"]];
//            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
//                                                                     delegate:self
//                                                            cancelButtonTitle:@"메인화면으로"
//                                                       destructiveButtonTitle:@"2차 일치검사로"
//                                                            otherButtonTitles:nil];
//            
//            actionSheet.tag = kMatchingFirstStepCompleteActionSheetTag;
//            
//            [actionSheet showInView:self.view];
//            [actionSheet release];
//        }else{
//            NSString* strTempMsg = [NSString stringWithFormat:@"%@", [dictionary valueForKey:@"resultmsg"]];
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[성 공]"
//                                                                message:strTempMsg
//                                                               delegate:self
//                                                      cancelButtonTitle:@"메인화면으로"
//                                                      otherButtonTitles:@"2차 일치검사로", nil];
//            
//            alertView.tag = kMatchingFirstStepCompleteActionSheetTag;
//            
//            [alertView show];
//            [alertView release];
//        }

    }else{
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


- (void)onToHomeViewFromSecondMatchingView
{
    if(m_target){
        [self backgroundTab:nil];
        [m_target performSelector:m_selector];
    }
}



#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    TRACE(@"hahaha buttonIndex [%ld]", (long)buttonIndex);
    TRACE(@"hahaha buttonIndex [%@]", alertView.title);
    
    if(alertView.tag == kIsMatchingFirstStepCompletedActionSheetTag){
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
            [self pageReset:nil];
        }
    }else if(alertView.tag == kMatchingFirstStepChkUDIActionSheetTag){
        // UDI 바코드가 없더라도 1차 일치검사를 수행할 것인지 확인하는 ActionSheet
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self requestMatcingFirstStep];
        }else{
            [self pageReset:nil];
        }
    }else if(alertView.tag == kMatchingFirstStepCompleteActionSheetTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO - 2차 일치검사로...
            if(m_SB2ndMatchingFrom1stViewController == nil){
                if(winHeight == kWINDOW_HEIGHT){
                    m_SB2ndMatchingFrom1stViewController = [[SB2ndMatchingFrom1stViewController alloc] initWithNibName:@"SB2ndMatchingFrom1stViewController"
                                                                                                                bundle:nil];
                }else{
                    m_SB2ndMatchingFrom1stViewController = [[SB2ndMatchingFrom1stViewController alloc] initWithNibName:@"SB2ndMatchingFrom1stViewController3"
                                                                                                                bundle:nil];
                }
            }
            
            [m_SB2ndMatchingFrom1stViewController pageReset:nil];
            
            CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
            m_SB2ndMatchingFrom1stViewController.view.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            m_SB2ndMatchingFrom1stViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            
            [m_SB2ndMatchingFrom1stViewController setDelegate:self
                                                     selector:@selector(onToHomeViewFromSecondMatchingView)];
            m_SB2ndMatchingFrom1stViewController.m_SBBloodNoInfoVO = self.m_SBBloodnoInfoVO;
            [m_SB2ndMatchingFrom1stViewController setUserInfo:self.m_SBUserInfoVO];
            [m_SB2ndMatchingFrom1stViewController setBldBagLabelText];
            
            [self.view addSubview:m_SB2ndMatchingFrom1stViewController.view];
            
            [UIView commitAnimations];
        }else{
            [self onToHomeView:nil];
        }
    }
}


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == kIsMatchingFirstStepCompletedActionSheetTag){
        // 1차 일치검사가 완료된 혈액이므로 2차로 진행할 것인지 확인하는 ActionSheet
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            // TO DO... to Matching Second Step.
            [self onToHomeView:nil];
        }else{
//            NSString* strTempBloodNo = self.m_strBarcodeBloodNo;
//            self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:strTempBloodNo];
//            
//            self.m_barcodeBloodNo.enabled = NO;
//            self.m_barcodeBag.enabled = YES;
//            [self.m_barcodeBag becomeFirstResponder];
            [self pageReset:nil];
        }
    }else if(actionSheet.tag == kMatchingFirstStepConfirmActionSheetTag){
        // 1차 일치검사를 수행할 것인지 확인하는 ActionSheet
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self requestMatcingFirstStep];
        }else{
            [self pageReset:nil];
        }
    }else if(actionSheet.tag == kMatchingFirstStepCompleteActionSheetTag){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            // TO DO - 2차 일치검사로...
            if(m_SB2ndMatchingFrom1stViewController == nil){
                if(winHeight == kWINDOW_HEIGHT){
                    m_SB2ndMatchingFrom1stViewController = [[SB2ndMatchingFrom1stViewController alloc] initWithNibName:@"SB2ndMatchingFrom1stViewController"
                                                                                                                bundle:nil];
                }else{
                    m_SB2ndMatchingFrom1stViewController = [[SB2ndMatchingFrom1stViewController alloc] initWithNibName:@"SB2ndMatchingFrom1stViewController3"
                                                                                                                bundle:nil];
                }
            }
            
            [m_SB2ndMatchingFrom1stViewController pageReset:nil];
            
            CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
            m_SB2ndMatchingFrom1stViewController.view.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            m_SB2ndMatchingFrom1stViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            
            [m_SB2ndMatchingFrom1stViewController setDelegate:self
                                                     selector:@selector(onToHomeViewFromSecondMatchingView)];
            m_SB2ndMatchingFrom1stViewController.m_SBBloodNoInfoVO = self.m_SBBloodnoInfoVO;
            [m_SB2ndMatchingFrom1stViewController setUserInfo:self.m_SBUserInfoVO];
            [m_SB2ndMatchingFrom1stViewController setBldBagLabelText];
            
            [self.view addSubview:m_SB2ndMatchingFrom1stViewController.view];
            
            [UIView commitAnimations];
        }else{
            [self onToHomeView:nil];
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
    
    TRACE(@"textFieldShouldReturn:=[%@]\n", strInput);
    
    if(strLength <= 0) return NO;
    
    switch(nTag){
        case kBarcodeBloodNoTextField :
            if(strLength < 12){
                strAlertMsg = @"헌혈자바코드의 길이가 다릅니다.";
                textField.text = @"";
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
                textField.text = @"";
            }else if(strLength == 2){
                
                self.m_ABOTypeNameLabel.text = [SBUtils getABOTypeName:strInput];
                
                if(self.m_ABOTypeNameLabel.text == nil){
                    self.m_strBarcodeABOType = nil;
                    [m_strBarcodeABOType release];
                    
                    self.m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
                    
                    strAlertMsg = @"혈액형코드가 형식에 맞지 않습니다.";
                    textField.text = @"";
                }else if([self.m_SBBloodnoInfoVO.abobarcode isEqualToString:strInput] == NO){
                    self.m_strBarcodeABOType = nil;
                    [m_strBarcodeABOType release];
                    
                    self.m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
                    
                    self.m_ABOTypeNameLabel.text = @"";
                    
                    strAlertMsg = @"입력한 혈액형 정보가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                }else{
                    self.m_barcodeABOType.enabled = NO;
                    self.m_barcodeBag.enabled = YES;
                    
                    [self.m_strBarcodeABOType setString:strInput];
                    self.m_ABOTypeNameLabel.backgroundColor = [SBUtils getABOTypeBgRGBValue:self.m_strBarcodeABOType];
                    self.m_ABOTypeNameLabel.textColor = [SBUtils getABOTypeRGBValue:self.m_strBarcodeABOType];
                    
                    [self.m_barcodeBag becomeFirstResponder];
                }
            }
            break;
        case kBarcodeBagTextField :
            if(strLength < 12){
                strAlertMsg = @"채혈백바코드의 길이가 다릅니다.";
                textField.text = @"";
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
                    
//                    CGPoint point = CGPointMake(0, m_barcodeMalaria.frame.origin.y -20);
//                    [m_scrollView setContentOffset:point animated:YES];
                }
                
//                [self.m_strBarcodeBag setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
//                self.m_barcodeBag.text = [SBUtils formatBloodNo:strInput];
//                self.m_barcodeBag.enabled = NO;
//                self.m_barcodeABOType.enabled = YES;
//                [self.m_barcodeABOType becomeFirstResponder];
            }
            break;
        case kBarcodeMalariaTextField :
            if(strLength != 6){
                strAlertMsg = @"말라리아바코드의 길이가 다릅니다.";
                textField.text = @"";
            }else if(strLength == 6){
                if([self.m_SBBloodnoInfoVO.malbarcode isEqualToString:strInput] == NO){
                    self.m_strBarcodeMalaria = nil;
                    [m_strBarcodeMalaria release];
                    
                    self.m_strBarcodeMalaria = [[NSMutableString alloc] initWithCapacity:6];
                    
                    strAlertMsg = @"입력한 말라리아 정보가 조회한 정보와 다릅니다.";
                    textField.text = @"";
                    
                }else{
                    [self.m_strBarcodeMalaria setString:strInput];
                    self.m_barcodeMalaria.enabled = NO;
                    self.m_barcodeBldBagcode.enabled = YES;
                    [self.m_barcodeBldBagcode becomeFirstResponder];
                    NSLog(@"%@",self.m_SBBloodnoInfoVO.m_barcodeBldBagCode);
                }
            }
            break;
        case kBarcodeBldBagcodeTextField :
            if(strLength < 7){
                if([m_SBBloodnoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                    strAlertMsg = @"백종류바코드의 길이가 다릅니다.";
                }else{
                    strAlertMsg = @"채혈장비바코드의 길이가 다릅니다.";
                }
                textField.text = @"";
            }else if(strLength == 7){
                
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
                
                if([self.m_SBBloodnoInfoVO.m_barcodeBldBagCode isEqualToString:strInput] == NO){
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
                    self.m_barcodeBldBagcode.text = strInput;
                    
                    [self.m_strBarcodeBldBagcode setString:strInput];
//                    [self.m_barcodeBldBagcode resignFirstResponder];
                    self.m_barcodeBldBagcode.enabled = NO;
                    
                    // TO DO... 전혈, 혈장 여부에 따라 분기 필요.
                    if([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES||
                        [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"72"] == YES ||
                        [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"76"] == YES) {
                        // 전혈, 혈장, 혈소판일 경우: UDI바코드 체크
                        self.m_barcodeUDI.enabled = YES;
                        [self.m_barcodeUDI becomeFirstResponder];
                    }else{
                        // 전혈, 혈장이 아닐 경우: UDI바코드 체크 없음
                        [self onOK:nil];
                    }
                }
            }
            break;
        case kBarcodeUDITextField :
            if(strLength <= 0){
                self.m_barcodeUDI.text = strInput;
                [self.m_strBarcodeUDI setString:strInput];
                self.m_barcodeUDI.enabled = YES;
                
                [self onOK:nil];
                
            }else if((strLength > 0 && strLength < 30) || strLength > 40){
                strAlertMsg = @"UDI바코드의 길이가 비정상입니다.";
                textField.text = @"";
                
            }else{
                
                // 21. 04. 자르는 부분 수정 필요
                NSRange rangeMCode = NSMakeRange(6, 4);     // 제조사
                NSRange rangeVCode = NSMakeRange(18, 6);    // 유효기간
                
                self.m_strMCode = [strInput substringWithRange:rangeMCode];
                self.m_strVCode = [strInput substringWithRange:rangeVCode];
                
                if (([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"71"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"75"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"82"] == YES)) {
                    
                    if( [self.m_strMCode isEqualToString:@"6000"] == YES || strLength > 34 )
                    {
                        NSRange rangeLCode = NSMakeRange(26, 10);
                        self.m_strLCode = [strInput substringWithRange:rangeLCode];
                    }
                    else if (strLength > 31)
                    {
                        NSRange rangeLCode = NSMakeRange(26, 6);
                        self.m_strLCode = [strInput substringWithRange:rangeLCode];
                    }
                }
                else if ([m_SBBloodnoInfoVO.bldproccode isEqualToString:@"00"] == YES || [m_SBBloodnoInfoVO.bldproccode isEqualToString:@"50"] == YES) {
                    // 전혈
                    NSRange rangeLCode = NSMakeRange(26, 8);    // 로트번호
                    self.m_strLCode = [strInput substringWithRange:rangeLCode];
                } else {  // 혈소판
                    if( [self.m_strMCode isEqualToString:@"6000"] == YES || strLength > 34 )
                    {
                        NSRange rangeLCode = NSMakeRange(26, 10);
                        self.m_strLCode = [strInput substringWithRange:rangeLCode];
                    } else if( [self.m_strMCode isEqualToString:@"9358"] == YES || strLength > 29 )
                    {
                        NSRange rangeLCode = NSMakeRange(26, 7);
                        self.m_strLCode = [strInput substringWithRange:rangeLCode];
                    }
                    else if (strLength > 34)
                    {
                        NSRange rangeLCode = NSMakeRange(26, 10);
                        self.m_strLCode = [strInput substringWithRange:rangeLCode];
                    }
                }

                TRACE(@"UDI Codes m v l:[%@, %@, %@]", m_strMCode, m_strVCode, m_strLCode);
                
                NSDateFormatter* df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyMMdd"];
                NSDate *targetDate = [df dateFromString:self.m_strVCode];
                
                TRACE(@"혈액백 유효기관 경과여부 = [%ld]", (long)[SBUtils compareDateWithToday:targetDate]);
                
                if([SBUtils compareDateWithToday:targetDate] < 0){
                    strAlertMsg = @"혈액백 유효기간이 경과하였습니다.";
                    textField.text = @"";
                    
                    if(self.m_strBarcodeUDI != nil){
                        [m_strBarcodeUDI release];
                        self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
                    }
                    self.m_strMCode = @"";
                    self.m_strVCode = @"";
                    self.m_strLCode = @"";
                }else{
                    
                    self.m_barcodeUDI.text = strInput;
                    [self.m_strBarcodeUDI setString:strInput];
                    self.m_barcodeUDI.enabled = NO;
                    
                    [self onOK:nil];
                }
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
    self.m_strBarcodeUDI = [[NSMutableString alloc] initWithCapacity:50];
    
    self.m_barcodeBloodNo.enabled = YES;
    self.m_barcodeABOType.enabled = NO;
    self.m_barcodeBag.enabled = NO;
    self.m_barcodeMalaria.enabled = NO;
    self.m_barcodeBldBagcode.enabled = NO;
    self.m_barcodeUDI.enabled = NO;
    
    self.m_ABOTypeNameLabel.text = @"";
    
    self.m_firstDonationImageView.hidden = YES;
//    self.m_btnToSideEffectsView.hidden = YES;
    
    CGSize size;	
	size = self.m_contentsView.frame.size;
	
	TRACE(@"width : %f, height : %f", size.width, size.height); 
	
	self.m_scrollView.contentSize = size;
    
    [self.view addSubview:m_scrollView];
    [m_scrollView addSubview:m_contentsView];
    
    [m_barcodeBloodNo becomeFirstResponder];
    
    self.m_idNameLabel.text = m_SBUserInfoVO.szBimsName;
    TRACE(@"szBimsName: %@", m_SBUserInfoVO.szBimsName);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBBloodnoInfoVO = nil;
    self.m_SBUserInfoVO = nil;
    
    self.m_scrollView = nil;
    self.m_contentsView = nil;
    
    self.m_idNameLabel = nil;
    self.m_barcodeUDILabel = nil;
    
    self.m_barcodeBloodNo = nil;
    self.m_barcodeABOType = nil;
    self.m_barcodeBag = nil;
    self.m_barcodeMalaria = nil;
    self.m_barcodeBldBagcode = nil;
    self.m_barcodeUDI = nil;
    
    self.m_strBarcodeBloodNo = nil;
    self.m_strBarcodeABOType = nil;
    self.m_strBarcodeBag = nil;
    self.m_strBarcodeMalaria = nil;
    self.m_strBarcodeBldBagcode = nil;
    
    self.m_strBarcodeUDI = nil;
    self.m_strMCode = nil;
    self.m_strVCode = nil;
    self.m_strLCode = nil;
    
    self.m_BldBagLabel = nil;
    self.m_ABOTypeNameLabel = nil;
    
    self.m_BloodCntLabel = nil;
    
    self.m_btnOK = nil;
    self.m_btnCancel = nil;
    self.m_btnToBloodEndTimeView = nil;
//    self.m_btnToSideEffectsView = nil;
    
    self.m_firstDonationImageView = nil;
    
    self.m_target = nil;
    
    self.m_activityIndicatorView = nil;
    
    self.m_SB2ndMatchingFrom1stViewController = nil;
//    self.m_SBSideEffectsListViewController = nil;
}


- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBBloodnoInfoVO release];
    [m_SBUserInfoVO release];
    [m_scrollView release];
    [m_contentsView release];
    
    [m_idNameLabel release];
    [m_barcodeUDILabel release];
    
    [m_barcodeBloodNo release];
    [m_barcodeABOType release];
    [m_barcodeBag release];
    [m_barcodeMalaria release];
    [m_barcodeBldBagcode release];
    [m_barcodeUDI release];
    
    [m_strBarcodeBloodNo release];
    [m_strBarcodeABOType release];
    [m_strBarcodeBag release];
    [m_strBarcodeMalaria release];
    [m_strBarcodeBldBagcode release];
    
    [m_strBarcodeUDI release];
    [m_strMCode release];
    [m_strVCode release];
    [m_strLCode release];
    
    [m_BldBagLabel release];
    [m_ABOTypeNameLabel release];
    [m_btnOK release];
    [m_btnCancel release];
    [m_btnToBloodEndTimeView release];
//    [m_btnToSideEffectsView release];
    
    [m_firstDonationImageView release];
    
    [m_target release];
    
    [m_activityIndicatorView release];
    
    [m_SB2ndMatchingFrom1stViewController release];
//    [m_SBSideEffectsListViewController release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
