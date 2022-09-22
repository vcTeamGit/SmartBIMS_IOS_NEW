//
//  SBMultiSecondMatchingViewController.m
//  SmartBIMS
//
//  Created by  on 12. 4. 18..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "SBMultiSecondMatchingViewController.h"
#import "HttpRequest.h"
#import "SBBloodnoInfoVO.h"
#import "SBUserInfoVO.h"
#import "JSON.h"
#import "SBUtils.h"
#import "SBMultiSecondMatchingViewController.h"

#import "Smart_BIMSAppDelegate.h"



@implementation SBMultiSecondMatchingViewController

@synthesize m_httpRequest;
@synthesize m_SBBloodNoInfoVO;
@synthesize m_SBUserInfoVO;

//@synthesize m_scrollView;
//@synthesize m_contentsView;

@synthesize m_idNameLabel;
@synthesize m_idNameLabel2;

/* firstView */
@synthesize m_bloodNoLabel;
@synthesize m_nameLabel;
@synthesize m_ABOTypeNameLabel;
@synthesize m_malariaLabel;

@synthesize m_BldBagLabel;

@synthesize m_AssetClsNameLabel;

@synthesize m_barcodeBloodNo;
@synthesize m_barcodeABOType;
@synthesize m_barcodeBag;
@synthesize m_barcodeBldBagcode;
@synthesize m_barcodeAssetNo;

@synthesize m_strBarcodeBloodNo;
@synthesize m_strBarcodeABOType;
@synthesize m_strBarcodeBag;
@synthesize m_strBarcodeBldBagcode;
@synthesize m_strBarcodeAssetNo;

@synthesize m_strAssetChkFlag;

@synthesize m_activityIndicatorView;

/* secondView */
@synthesize m_secondView;
@synthesize m_bloodNoLabel2;
@synthesize m_nameLabel2;
@synthesize m_ABOTypeNameLabel2;
@synthesize m_malariaLabel2;

@synthesize m_BldBagLabel2;

@synthesize m_barcodeBloodNoLabel2;
@synthesize m_barcodeABOType2;
@synthesize m_barcodeBag2;
@synthesize m_barcodeBldBagcode2;

//@synthesize m_strBarcodeBloodNo2;
@synthesize m_strBarcodeABOType2;
@synthesize m_strBarcodeBag2;
@synthesize m_strBarcodeBldBagcode2;

@synthesize m_barcodeSample1;
@synthesize m_barcodeSample2;
@synthesize m_barcodeSample3;
@synthesize m_barcodeSample4;
@synthesize m_barcodeSample5;

@synthesize m_strBarcodeSample1;
@synthesize m_strBarcodeSample2;
@synthesize m_strBarcodeSample3;
@synthesize m_strBarcodeSample4;
@synthesize m_strBarcodeSample5;

@synthesize m_activityIndicatorView2;

@synthesize m_bloodNoDuplicationCheckMutableArray;
@synthesize m_bloodNoDuplicationCheckMutableArray2;

@synthesize m_target;
@synthesize m_selector;




#pragma mark -
#pragma mark Methods

- (void)setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
    self.m_selector = selector;
}


- (void)setUserInfo:(SBUserInfoVO*)userInfo
{
    self.m_SBUserInfoVO = [[SBUserInfoVO alloc] initWithSBUserInfo:userInfo];
}


- (void)setBldBagLabelText
{
    if([m_SBBloodNoInfoVO.bloodtype isEqualToString:@"1"] == YES){
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


- (IBAction)onToHomeView:(id)sender;
{
    [self pageReset:nil];
    [self backgroundTab:nil];
    
    if(m_target){
        [m_target performSelector:m_selector];
    }
}


- (IBAction)setPageValues:(NSString*)strBloodNo
{
    self.m_barcodeBloodNo.text = strBloodNo;
    
//    self.m_strBarcodeBloodNo = [NSString stringWithString:m_barcodeBloodNo.text];
    [self.m_strBarcodeBloodNo setString:m_barcodeBloodNo.text];
    self.m_barcodeBloodNo.text = [SBUtils formatBloodNo:m_strBarcodeBloodNo];
    self.m_bloodNoLabel.text = [SBUtils formatBloodNo:m_strBarcodeBloodNo];
    
    [self bloodNoDuplicationCheck:m_strBarcodeBloodNo];
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

- (IBAction)onBack2:(id)sender
{
    static UIViewAnimationTransition orders[4] = {
        UIViewAnimationTransitionCurlDown,
        UIViewAnimationTransitionCurlUp,
        UIViewAnimationTransitionFlipFromLeft,
        UIViewAnimationTransitionFlipFromRight,
    };
    
    [self backgroundTab2:nil];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    m_secondView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:orders[1]
                           forView:self.view
                             cache:YES];
    
    [self.m_secondView removeFromSuperview];
    
    [UIView commitAnimations];

}


- (void) onToHomeViewSelector
{
    [self.view removeFromSuperview];
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
    
//    TRACE(@"m_strBarcodeBloodNo 0009 [%@]'s length is [%d], %d", m_strBarcodeBloodNo, [m_strBarcodeBloodNo length], m_strBarcodeBloodNo.length);
    
    if(m_strBarcodeBloodNo.length == 0 || [m_strBarcodeBloodNo isEqualToString:@""]){
        [mstrAlertMsg setString:@"헌혈자바코드를 입력하세요"];
        [m_barcodeBloodNo becomeFirstResponder];
    }else if(m_strBarcodeABOType.length == 0 || [m_strBarcodeABOType isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액형바코드를 입력하세요"];
        [m_barcodeABOType becomeFirstResponder];
    }else if(m_strBarcodeBag.length == 0 || [m_strBarcodeBag isEqualToString:@""]){
        [mstrAlertMsg setString:@"채혈백바코드를 입력하세요"];
        [m_barcodeBag becomeFirstResponder];
    }else if(m_strBarcodeBldBagcode.length == 0 || [m_strBarcodeBldBagcode isEqualToString:@""]){
        [mstrAlertMsg setString:@"백종류바코드를 입력하세요"];
        [m_barcodeBldBagcode becomeFirstResponder];
    }
    else{
        // P 2차 일치검사 화면으로 전환
        [self pageReset2:nil];
        
        m_bloodNoLabel2.text = m_bloodNoLabel.text;
        m_nameLabel2.text = m_nameLabel.text;
        
        m_malariaLabel2.text = m_SBBloodNoInfoVO.gbmal;
        m_malariaLabel2.textColor = [SBUtils getMalariaStatusColor:m_SBBloodNoInfoVO.gbmal_color];
        
        m_barcodeBloodNoLabel2.text = m_barcodeBloodNo.text;
        
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
    }
    
    if(mstrAlertMsg.length != 0 || ![mstrAlertMsg isEqualToString:@""]){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:mstrAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
    [mstrAlertMsg release];
}


- (IBAction)onOK2:(id)sender
{
    NSMutableString* mstrAlertMsg = [[NSMutableString alloc] initWithCapacity:100];
    
    TRACE(@"m_strBarcodeBloodNo 0009 [%@]'s length is [%lu], %ld", m_strBarcodeBloodNo, (unsigned long)[m_strBarcodeBloodNo length], (unsigned long)m_strBarcodeBloodNo.length);
    
    if(m_strBarcodeBloodNo.length == 0 || [m_strBarcodeBloodNo isEqualToString:@""]){
        [mstrAlertMsg setString:@"헌혈자바코드를 입력하세요"];
        [self onBack2:nil];
        [m_barcodeBloodNo becomeFirstResponder];
    }else if(m_strBarcodeABOType.length == 0 || [m_strBarcodeABOType isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액형바코드를 입력하세요"];
        [self onBack2:nil];
        [m_barcodeABOType becomeFirstResponder];
    }else if(m_strBarcodeBag.length == 0 || [m_strBarcodeBag isEqualToString:@""]){
        [mstrAlertMsg setString:@"채혈백바코드를 입력하세요"];
        [self onBack2:nil];
        [m_barcodeBag becomeFirstResponder];
    }else if(m_strBarcodeBldBagcode.length == 0 || [m_strBarcodeBldBagcode isEqualToString:@""]){
        [mstrAlertMsg setString:@"백종류바코드를 입력하세요"];
        [self onBack2:nil];
        [m_barcodeBldBagcode becomeFirstResponder];
    }
    else if(m_strBarcodeABOType2.length == 0 || [m_strBarcodeABOType2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"혈액형바코드를 입력하세요"];
        [m_barcodeABOType2 becomeFirstResponder];
    }else if(m_strBarcodeBag2.length == 0 || [m_strBarcodeBag2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"채혈백바코드를 입력하세요"];
        [m_barcodeBag2 becomeFirstResponder];
    }else if(m_strBarcodeBldBagcode2.length == 0 || [m_strBarcodeBldBagcode2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"백종류바코드를 입력하세요"];
        [m_barcodeBldBagcode2 becomeFirstResponder];
    }
    else if(m_strBarcodeSample1.length == 0 || [m_strBarcodeSample1 isEqualToString:@""]){
        [mstrAlertMsg setString:@"검체바코드1을 입력하세요"];
        [m_barcodeSample1 becomeFirstResponder];
    }else if(m_strBarcodeSample2.length == 0 || [m_strBarcodeSample2 isEqualToString:@""]){
        [mstrAlertMsg setString:@"검체바코드2를 입력하세요"];
        [m_barcodeSample2 becomeFirstResponder];
    }else if(m_strBarcodeSample3.length == 0 || [m_strBarcodeSample3 isEqualToString:@""]){
        [mstrAlertMsg setString:@"검체바코드3을 입력하세요"];
        [m_barcodeSample3 becomeFirstResponder];
    }else if(m_strBarcodeSample4.length == 0 || [m_strBarcodeSample4 isEqualToString:@""]){
        [mstrAlertMsg setString:@"검체바코드4를 입력하세요"];
        [m_barcodeSample4 becomeFirstResponder];
    }else if(m_strBarcodeSample5.length == 0 || [m_strBarcodeSample5 isEqualToString:@""]){
        [mstrAlertMsg setString:@"검체바코드5를 입력하세요"];
        [m_barcodeSample5 becomeFirstResponder];
    }
    else{
        NSString* strTitleMsg = @"2차 일치검사를 수행하시겠습니까?";
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            
            actionSheet.tag = kMatchingSecondStepConfirmActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kMatchingSecondStepConfirmActionSheetTag;
            
            [alertView show];
            [alertView release];
        }
    }
    
    if(mstrAlertMsg.length != 0 || ![mstrAlertMsg isEqualToString:@""]){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:mstrAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
    [mstrAlertMsg release];
}



- (IBAction)pageReset:(id)sender
{
    m_idNameLabel.text = m_SBUserInfoVO.szBimsName;
    
    m_SBBloodNoInfoVO = nil;
    
    m_bloodNoLabel.text = @"";
    m_nameLabel.text = @"";
    m_ABOTypeNameLabel.text = @"";
    m_malariaLabel.text = @"";
    
    m_barcodeBloodNo.text = @"";
    m_barcodeABOType.text = @"";
    m_barcodeBag.text = @"";
    m_barcodeBldBagcode.text = @"";
    m_barcodeAssetNo.text = @"";
    
    m_AssetClsNameLabel.text = @"";
    
    m_barcodeBloodNo.enabled = YES;
    m_barcodeABOType.enabled = NO;
    m_barcodeBag.enabled = NO;
    m_barcodeBldBagcode.enabled = NO;
    m_barcodeAssetNo.enabled = NO;
    
//    m_barcodeABOType.enabled = YES;
//    m_barcodeBag.enabled = YES;
//    m_barcodeBldBagcode.enabled = YES;
//    m_barcodeAssetNo.enabled = YES;
    
    if(m_strBarcodeBloodNo != nil){
        [m_strBarcodeBloodNo release];
        m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeABOType != nil){
        [m_strBarcodeABOType release];
        m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
    }
    if(m_strBarcodeBag != nil){
        [m_strBarcodeBag release];
        m_strBarcodeBag = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeBldBagcode != nil){
        [m_strBarcodeBldBagcode release];
        m_strBarcodeBldBagcode = [[NSMutableString alloc] initWithCapacity:7];
    }
    if(m_strBarcodeAssetNo != nil){
        [m_strBarcodeAssetNo release];
        m_strBarcodeAssetNo = [[NSMutableString alloc] initWithCapacity:12];
    }
    if(m_strAssetChkFlag != nil){
        [m_strAssetChkFlag release];
        m_strAssetChkFlag = [[NSMutableString alloc] initWithCapacity:1];
    }
    
    if([self.m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
    [m_bloodNoDuplicationCheckMutableArray removeAllObjects];
    
    [m_barcodeBloodNo becomeFirstResponder];
}


- (IBAction)pageReset2:(id)sender
{
    m_idNameLabel2.text = m_SBUserInfoVO.szBimsName;
//    m_SBBloodNoInfoVO = nil;
    
//    m_bloodNoLabel2.text = @"";
//    m_nameLabel2.text = @"";
    m_ABOTypeNameLabel2.text = @"";
//    m_malariaLabel2.text = @"";
    
//    m_barcodeBloodNo.text = @"";
    m_barcodeABOType2.text = @"";
    m_barcodeBag2.text = @"";
    m_barcodeBldBagcode2.text = @"";
    
    m_barcodeSample1.text = @"";
    m_barcodeSample2.text = @"";
    m_barcodeSample3.text = @"";
    m_barcodeSample4.text = @"";
    m_barcodeSample5.text = @"";
    
//    m_barcodeBloodNo.enabled = YES;
    m_barcodeABOType2.enabled = YES;
    m_barcodeBag2.enabled = NO;
    m_barcodeBldBagcode2.enabled = NO;
    
    m_barcodeSample1.enabled = NO;
    m_barcodeSample2.enabled = NO;
    m_barcodeSample3.enabled = NO;
    m_barcodeSample4.enabled = NO;
    m_barcodeSample5.enabled = NO;
    
    if(m_strBarcodeABOType2 != nil){
        [m_strBarcodeABOType2 release];
        m_strBarcodeABOType2 = [[NSMutableString alloc] initWithCapacity:2];
    }
    if(m_strBarcodeBag2 != nil){
        [m_strBarcodeBag2 release];
        m_strBarcodeBag2 = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeBldBagcode2 != nil){
        [m_strBarcodeBldBagcode2 release];
        m_strBarcodeBldBagcode2 = [[NSMutableString alloc] initWithCapacity:7];
    }
    
    if(m_strBarcodeSample1 != nil){
        [m_strBarcodeSample1 release];
        m_strBarcodeSample1 = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeSample2 != nil){
        [m_strBarcodeSample2 release];
        m_strBarcodeSample2 = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeSample3 != nil){
        [m_strBarcodeSample3 release];
        m_strBarcodeSample3 = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeSample4 != nil){
        [m_strBarcodeSample4 release];
        m_strBarcodeSample4 = [[NSMutableString alloc] initWithCapacity:16];
    }
    if(m_strBarcodeSample5 != nil){
        [m_strBarcodeSample5 release];
        m_strBarcodeSample5 = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    if([self.m_activityIndicatorView2 isAnimating]){
        [m_activityIndicatorView2 stopAnimating];
    }
    
    [m_bloodNoDuplicationCheckMutableArray2 removeAllObjects];
    
    [m_barcodeABOType2 becomeFirstResponder];
}



- (IBAction)backgroundTab:(id)sender
{
    [self.m_barcodeBloodNo resignFirstResponder];
    [self.m_barcodeABOType resignFirstResponder];
    [self.m_barcodeBag resignFirstResponder];
    [self.m_barcodeBldBagcode resignFirstResponder];
    [self.m_barcodeAssetNo resignFirstResponder];
    
//    CGPoint point = CGPointMake(0, 0);
//    [m_scrollView setContentOffset:point animated:YES];
}


- (IBAction)backgroundTab2:(id)sender
{
    [self.m_barcodeABOType2 resignFirstResponder];
    [self.m_barcodeBag2 resignFirstResponder];
    [self.m_barcodeBldBagcode2 resignFirstResponder];
    
    [self.m_barcodeSample1 resignFirstResponder];
    [self.m_barcodeSample2 resignFirstResponder];
    [self.m_barcodeSample3 resignFirstResponder];
    [self.m_barcodeSample4 resignFirstResponder];
    [self.m_barcodeSample5 resignFirstResponder];
    
    //    CGPoint point = CGPointMake(0, 0);
    //    [m_scrollView setContentOffset:point animated:YES];
}


- (int)bloodNoDuplicationCheck:(NSString*)bloodNo
{
    NSString* strBloodNo = [[NSString alloc] initWithString:[bloodNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    if([strBloodNo isEqualToString:@""] || strBloodNo.length < 12){
        // 입력값 형식에 맞지 않음.
        return -1;
    }
    
    int nSize = (int)m_bloodNoDuplicationCheckMutableArray.count;
    int i;
    
    for(i = 0; i < nSize; i++){
        if([strBloodNo isEqualToString:[m_bloodNoDuplicationCheckMutableArray objectAtIndex:i]]){
            return -2;
        }
    }
    
    [m_bloodNoDuplicationCheckMutableArray addObject:strBloodNo];
    
    [strBloodNo release];
    
    return 1;
}


- (int)bloodNoDuplicationCheck2:(NSString*)bloodNo
{
    NSString* strBloodNo = [[NSString alloc] initWithString:[bloodNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    if([strBloodNo isEqualToString:@""] || strBloodNo.length < 12){
        // 입력값 형식에 맞지 않음.
        return -1;
    }
    
    // wireline - 2013.06.18: 혈액번호 바코드와 같은 형식인지 체크... 체크비트 중복 체크는 다음 단계에서...
    NSRange range = NSMakeRange(0, 10);
    NSString* strTempBloodNo = [[NSString alloc] initWithString:[m_strBarcodeBloodNo substringWithRange:range]];
    NSString* strTempBloodNo2 = [[NSString alloc] initWithString:[strBloodNo substringWithRange:range]];
    
    if([strTempBloodNo isEqualToString:strTempBloodNo2] == NO){
        // 혈액번호 바코드와 전혀 무관한 값이 입력됨
        return -1;
    }
    //
    
    int nSize = (int)m_bloodNoDuplicationCheckMutableArray.count;
    int i;
    
    for(i = 0; i < nSize; i++){
        if([strBloodNo isEqualToString:[m_bloodNoDuplicationCheckMutableArray objectAtIndex:i]]){
            return -2;
        }
    }
    
    nSize = (int)m_bloodNoDuplicationCheckMutableArray2.count;
    
    for(i = 0; i < nSize; i++){
        if([strBloodNo isEqualToString:[m_bloodNoDuplicationCheckMutableArray2 objectAtIndex:i]]){
            return -2;
        }
    }
    
    [m_bloodNoDuplicationCheckMutableArray2 addObject:strBloodNo];
    
    [strTempBloodNo2 release];
    [strTempBloodNo release];
    [strBloodNo release];
    
    return 1;
}


- (void)requestIsMatchingSecondStepCompleted:(NSString*)bloodNo
{
    NSString* strBloodNo = [[NSString alloc] initWithString:bloodNo];
    strBloodNo = [strBloodNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    strBloodNo = [strBloodNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSRange range = NSMakeRange(0, 10);
    strBloodNo = [strBloodNo substringWithRange:range];
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_CHECK_MATCHING_COMPLETE;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"matchingSecondStep", @"reqId",
                                strBloodNo, @"bloodno", 
                                nil];
    
    //    m_httpRequest = [[HttpRequest alloc] init];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveIsMatchingSecondStepCompleted:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveIsMatchingSecondStepCompleted:(id)result
{
    NSString* strData = (NSString*)result;
    NSString* strMatch01TF;
    NSString* strMatch02TF;
    NSString* strBloodEndTime;
    NSString* strIsBSDBag; // 사용하지 않아도 된다. 현재 사용되는 모든 백은 BSD백이다.
    NSString* strBloodType;
    NSString* strAlertMsg;
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData = [%@]", strData);
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
    strIsBSDBag = [dictionary valueForKey:@"isBSDBag"];
    strBloodType = [dictionary valueForKey:@"bloodType"];
    
    TRACE(@"bloodEndTime = [%@], isBSDBag = [%@]", strBloodEndTime, strIsBSDBag);
    
    if([strMatch01TF isEqualToString:@"true"] == NO){
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
    
    if([strMatch02TF isEqualToString:@"true"] == YES){
        NSString* strTitleMsg = @"2차 일치검사가 이미 완료된 혈액입니다.\n첫 화면으로 돌아가시겠습니까?";
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:strTitleMsg
                                                                     delegate:self
                                                            cancelButtonTitle:@"아니오"
                                                       destructiveButtonTitle:@"예"
                                                            otherButtonTitles:nil];
            
            actionSheet.tag = kMatchingSecondStepAlreadyProcessedActionSheetTag;
            [actionSheet showInView:self.view];
            [actionSheet release];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strTitleMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kMatchingSecondStepAlreadyProcessedActionSheetTag;
            
            [alertView show];
            [alertView release];
        }
        
        return;
    }
    
    if([strIsBSDBag isEqualToString:@"N"] == YES && [strBloodEndTime length] <= 0){
        NSString* strTitleMsg = @"일반백을 사용한 혈액번호입니다.\n채혈종료시간을 먼저 입력하세요.\n첫 화면으로 돌아가시겠습니까?";
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
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
    
    //    TRACE(@"m_barcodeBloodNo.text := [%@]", m_barcodeBloodNo.text);
//    m_strBarcodeBloodNo = [NSString stringWithString:m_barcodeBloodNo.text];
    [m_strBarcodeBloodNo setString:m_barcodeBloodNo.text];
    m_barcodeBloodNo.text = [SBUtils formatBloodNo:m_strBarcodeBloodNo];
    m_bloodNoLabel.text = [SBUtils formatBloodNo:m_strBarcodeBloodNo];
    
    //    TRACE(@"m_strBarcodeBloodNo 0001 [%@]", [NSString stringWithString:m_strBarcodeBloodNo]);
    
    [self requestBloodNoInfo];
}


- (void)requestBloodNoInfo
{
    NSString* strBloodNo = [[NSString alloc] initWithString:m_strBarcodeBloodNo];
    
    [self backgroundTab:nil];
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_INQUIRE_USER_BARCODE;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strBloodNo, @"bloodNoBarcode", nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveBloodNoInfoResponse:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveBloodNoInfoResponse:(id)result
{
    NSString* strData = [[NSString alloc] initWithString:(NSString*)result];
    NSString* strResult = [[NSString alloc] init];
    NSString* strBloodNo = [[NSString alloc] initWithString:m_strBarcodeBloodNo];
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];

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
    
    if([strResult isEqualToString:@"1"] == true)
    {
        if(m_SBBloodNoInfoVO != nil){
            [m_SBBloodNoInfoVO release];
        }
        
        m_SBBloodNoInfoVO = [[SBBloodnoInfoVO alloc] init];
        
        m_SBBloodNoInfoVO.bloodno = [[NSString alloc] initWithString:strBloodNo];
        
        m_SBBloodNoInfoVO.jumin1 = [dictionary valueForKey:@"jumin1"];
        m_SBBloodNoInfoVO.jumin2 = [dictionary valueForKey:@"jumin2"];
        m_SBBloodNoInfoVO.registeryn = [dictionary valueForKey:@"registeryn"];
        m_SBBloodNoInfoVO.marrmstyn = [dictionary valueForKey:@"marrmstyn"];
        m_SBBloodNoInfoVO.name = [dictionary valueForKey:@"name"];
        
        m_SBBloodNoInfoVO.gbmal = [dictionary valueForKey:@"gbmal"];
        m_SBBloodNoInfoVO.gbmal_color = [dictionary valueForKey:@"gbmal_color"];
        m_SBBloodNoInfoVO.sex = [dictionary valueForKey:@"sex"];
        m_SBBloodNoInfoVO.weight = [dictionary valueForKey:@"weight"];
        m_SBBloodNoInfoVO.height = [dictionary valueForKey:@"height"];
        
        m_SBBloodNoInfoVO.bldproccode = [dictionary valueForKey:@"bldproccode"];
        m_SBBloodNoInfoVO.bldprocinterface = [dictionary valueForKey:@"bldprocinterface"];
        m_SBBloodNoInfoVO.bldprocname = [dictionary valueForKey:@"bldprocname"];
        m_SBBloodNoInfoVO.bagqty = [dictionary valueForKey:@"bagqty"];
        m_SBBloodNoInfoVO.bldabocode = [dictionary valueForKey:@"bldabocode"];
        
        m_SBBloodNoInfoVO.aboname = [dictionary valueForKey:@"aboname"];
        m_SBBloodNoInfoVO.sub = [dictionary valueForKey:@"sub"];
        m_SBBloodNoInfoVO.abs = [dictionary valueForKey:@"abs"];
        m_SBBloodNoInfoVO.hct_result = [dictionary valueForKey:@"hct_result"];
        m_SBBloodNoInfoVO.pccnt = [dictionary valueForKey:@"pccnt"];
        
        m_SBBloodNoInfoVO.abobarcode = [dictionary valueForKey:@"abobarcode"];
        m_SBBloodNoInfoVO.malbarcode = [dictionary valueForKey:@"malbarcode"];
        m_SBBloodNoInfoVO.bloodtype = [dictionary valueForKey:@"bloodtype"];  // 4는 다종성분헌혈.
        
        m_SBBloodNoInfoVO.m_selectedBldProc1 = [dictionary valueForKey:@"bldproccode"];
        m_SBBloodNoInfoVO.m_selectedBldProc2 = [dictionary valueForKey:@"bldproccode"];
        m_SBBloodNoInfoVO.m_selectedBldProc3 = [[NSString alloc] initWithFormat:@"%@,%@", 
                                                [dictionary valueForKey:@"bagqty"], 
                                                [dictionary valueForKey:@"bldprocinterface"]];
        m_SBBloodNoInfoVO.m_bagInterface = [SBUtils getBagInterface:m_SBBloodNoInfoVO.m_selectedBldProc3];
        m_SBBloodNoInfoVO.m_barcodeBldBagCode = nil;
        
        
        m_nameLabel.text = m_SBBloodNoInfoVO.name;
        //        m_malariaLabel.text = [SBUtils getMalariaStatusName:m_SBBloodNoInfoVO.gbmal];
        m_malariaLabel.text = m_SBBloodNoInfoVO.gbmal;
        m_malariaLabel.textColor = [SBUtils getMalariaStatusColor:m_SBBloodNoInfoVO.gbmal_color];
        //        m_ABOTypeNameLabel.text = m_SBBloodNoInfoVO.aboname;
        //        m_ABOTypeNameLabel.textColor = [SBUtils getABOTypeRGBValue:m_SBBloodNoInfoVO.bldabocode];
        
        if([m_SBBloodNoInfoVO.bloodtype isEqualToString:@"4"] == NO){
            [self pageReset:nil];
            
            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"입력하신 혈액번호는 다종성분채혈이 아닙니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            [alertView show];
            [alertView release];
            
            return;
        }
        
        if([self.m_bloodNoLabel.text isEqual: @""] || m_SBBloodNoInfoVO == nil){
            [self pageReset:nil];
            
            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"혈액번호를 조회하지 않았습니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            [alertView show];
            [alertView release];
            
        }else{
            // 헌혈지원자접수를 통해 등록되었거나 채혈전 확인사항에서 수정된 [혈액제제코드], [전혈시 백종류코드, 성분헌혈시 장비종류코드]
            // 를 통해 bldbagcode를 가져옴.
            NSString* strTempBldProc1 = m_SBBloodNoInfoVO.m_selectedBldProc1;
            NSString* strTempBldProc2 = m_SBBloodNoInfoVO.m_selectedBldProc2;
            NSString* strTempRealBldProcValue = m_SBBloodNoInfoVO.m_bagInterface;
            
            // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
            NSString* url = URL_GET_BLOOD_PACK_NO;
            NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strTempBldProc1, @"strBldProc1", 
                                        strTempBldProc2, @"strBldProc2", 
                                        strTempRealBldProcValue, @"strBldProc3", 
                                        nil];
            
            [m_httpRequest setDelegate:self
                              selector:@selector(didReceiveCheckBldProcAndBagCodeResponse:)];
            [m_httpRequest requestURL:url
                           bodyObject:bodyObject];
            
            [self.m_activityIndicatorView startAnimating];
        }
    }
}


- (void)didReceiveCheckBldProcAndBagCodeResponse:(id)result
{
    NSString* strAlertMsg;
    NSString* strData;
    NSString* strResult;
    
    [self.m_activityIndicatorView stopAnimating];
    
    strData = [[NSString alloc] initWithString:[(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" 
                                                                                            withString:@""]];
    
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
    
    if([strResult isEqualToString:@"1"] == YES){
        // bldBagCode의 바코드를 얻는다.
        self.m_SBBloodNoInfoVO.m_barcodeBldBagCode = [dictionary valueForKey:@"strBldBagcode"];
        TRACE(@"bldBagCode:[%@]",self.m_SBBloodNoInfoVO.m_barcodeBldBagCode);
        self.m_barcodeBloodNo.enabled = NO;
        self.m_barcodeABOType.enabled = YES;
        [self setBldBagLabelText]; // 라벨에 표기되는 명칭을 바꾼다.  1:백종류바코드, 나머지는 채혈장비바코드.
        [self.m_barcodeABOType becomeFirstResponder];
    }else{
        [self pageReset:nil];
        strAlertMsg = @"헌혈종류가 일치하지 않습니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
    [strData release];
}


- (void)requestMatchingSecondStep
{
    //    NSRange range = NSMakeRange(0, 10);
    //    TRACE(@"requestMatchingSecondStep's m_SBBloodNoInfoVO.bloodno := [%@]", m_SBBloodNoInfoVO.bloodno);
    NSString* strBloodNo = [SBUtils getParameterTypeBloodNo:m_SBBloodNoInfoVO.bloodno];
    NSString* strBarcodeBloodNo = [SBUtils getParameterTypeBloodNo:m_strBarcodeBloodNo];
    NSString* strBarcodeABOType = [m_strBarcodeABOType stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString* strBarcodeBag = [SBUtils getParameterTypeBloodNo:m_strBarcodeBag];
//    NSString* strBarcodeBldProccode = m_strBarcodeBldBagcode;
//    [NSString stringWithFormat:@"%@%@",str1,str2];
    NSString* strBarcodeBldProccode = [NSString stringWithFormat: @"%@%@", m_strBarcodeBldBagcode, m_strBarcodeBldBagcode2];
    NSString* strBarcodeSample1 = [SBUtils getParameterTypeBloodNo:m_strBarcodeSample1];
    NSString* strBarcodeSample2 = [SBUtils getParameterTypeBloodNo:m_strBarcodeSample2];
    NSString* strBarcodeSample3 = [SBUtils getParameterTypeBloodNo:m_strBarcodeSample3];
    NSString* strBarcodeSample4 = [SBUtils getParameterTypeBloodNo:m_strBarcodeSample4];
    NSString* strBarcodeSample5 = [SBUtils getParameterTypeBloodNo:m_strBarcodeSample5];
    
    //    TRACE(@"m_SBUserInfoVO.szBimsOrgcode=[%@], [%@], [%@]", m_SBUserInfoVO.szBimsOrgcode, m_SBUserInfoVO.szBimsCarcode, m_SBUserInfoVO.szBimsSitecode);
    NSString* strOrgCode;
    NSString* strCarCode;
    NSString* strSiteCode;
    NSString* strIdNo;
    NSString* strIdName;
    
    long nAssetNo = [self.m_barcodeAssetNo.text longLongValue];
    NSString* strAssetNo;
    
    TRACE(@"nAssetNo is [%ld]", nAssetNo);

    
//    CGPoint point = CGPointMake(0, 0);
//    [m_scrollView setContentOffset:point animated:YES];
    
    if(m_SBUserInfoVO.szBimsOrgcode == nil || [m_SBUserInfoVO.szBimsOrgcode isEqualToString:@""] 
       || [m_SBUserInfoVO.szBimsOrgcode isEqualToString:@"(null)"]){
        strOrgCode = @"";
    }else{
        strOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
    }
    
    if(m_SBUserInfoVO.szBimsCarcode == nil || [m_SBUserInfoVO.szBimsCarcode isEqualToString:@""] 
       || [m_SBUserInfoVO.szBimsCarcode isEqualToString:@"(null)"]){
        strCarCode = @"";
    }else{
        strCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
    }
    
    if(m_SBUserInfoVO.szBimsSitecode == nil || [m_SBUserInfoVO.szBimsSitecode isEqualToString:@""] 
       || [m_SBUserInfoVO.szBimsSitecode isEqualToString:@"(null)"]){
        strSiteCode = @"";
    }else{
        strSiteCode = [NSString stringWithString:m_SBUserInfoVO.szBimsSitecode];
    }
    
    if(nAssetNo == 0){
        strAssetNo = @"";
        [m_strAssetChkFlag setString: @"3"];
    }else if(nAssetNo != 0 && [m_strAssetChkFlag isEqualToString:@""]){
        strAssetNo = @"";
        [m_strAssetChkFlag setString: @"3"];
    }else{
        strAssetNo = [NSString stringWithFormat:@"%ld", nAssetNo];
    }
    
    strIdNo = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    strIdName = [NSString stringWithString:m_SBUserInfoVO.szBimsName];
    
    TRACE(@"requestMatchingSecondStep's strBloodNo := [%@]", strBloodNo);
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_SECOND_MATCHING_TEST;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strBloodNo, @"strBloodNo", 
                                strBarcodeBloodNo, @"strBarcodeBloodNo",
                                strBarcodeABOType, @"strBarcodeABOType",
                                strBarcodeBag, @"strBarcodeBag",
                                strBarcodeBldProccode, @"strBarcodeBldProccode",
                                strAssetNo, @"strAssetNo",
                                m_strAssetChkFlag, @"strChkFlag",
                                strBarcodeSample1, @"strBarcodeSample1",
                                strBarcodeSample2, @"strBarcodeSample2",
                                strBarcodeSample3, @"strBarcodeSample3",
                                strBarcodeSample4, @"strBarcodeSample4",
                                strBarcodeSample5, @"strBarcodeSample5",
                                strOrgCode, @"strOrgCode",
                                strCarCode, @"strCarCode",
                                strSiteCode, @"strSiteCode",
                                strIdNo, @"strIdNo",
                                strIdName, @"strIdName",
                                nil];
    
    //    m_httpRequest = [[HttpRequest alloc] init];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveRequestMatchingSecondStep:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveRequestMatchingSecondStep:(id)result
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
    
    //    [m_httpRequest release];
}


//- (void)didReceiveAssetNoInfo:(id)result
//{
//    NSString* strAlertMsg;
//    NSString* strData;
//    NSString* strAssetNo;
//    NSString* strOrgCode;
//    NSString* strAssetClsName;
//    NSString* strModel;
//    NSString* strChk;
//    
//    [self.m_activityIndicatorView stopAnimating];
//    
//    strData = [[NSString alloc] initWithString:[(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n"
//                                                                                            withString:@""]];
//    
//    TRACE(@"didReceiveAssetNoInfo strData: %@", strData);
//    
//    // 응답값 확인
//    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:kREQUEST_TIMEOUT_MSG
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        
//        [alertView show];
//        [alertView release];
//        
//        return;
//    }
//    
//    SBJsonParser* jsonParser = [SBJsonParser new];
//    NSDictionary* dictionary = nil;
//    
//    // JSON 문자열을 객체로 변환
//    dictionary = [jsonParser objectWithString:strData];
//    
//    strAssetNo = [dictionary valueForKey:@"assetno"];
//    strOrgCode = [dictionary valueForKey:@"orgcode"];
//    strAssetClsName = [dictionary valueForKey:@"assetclsname"];
//    strModel = [dictionary valueForKey:@"model"];
//    strChk = [dictionary valueForKey:@"chk"];
//    
//    TRACE(@"strChk1:[%@]", strChk);
//    
//    if([strChk isEqualToString:@"T"] == YES){
//        self.m_AssetClsNameLabel.text = strAssetClsName;
//    }else if([strChk isEqualToString:@"1"] == YES){
//        self.m_AssetClsNameLabel.text = @"기관불일치";
//        strAlertMsg = @"기관정보가 일치하지 않습니다.";
//        
//        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
//                                                            message:strAlertMsg
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        [alertView show];
//        [alertView release];
//    }else if([strChk isEqualToString:@"2"] == YES){
//        self.m_AssetClsNameLabel.text = @"확인불가";
//        strAlertMsg = @"존재하지 않는 장비ID 또는 기타사유로 확인이 불가합니다.";
//        
//        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
//                                                            message:strAlertMsg
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        [alertView show];
//        [alertView release];
//    }else if([strChk isEqualToString:@"9"] == YES){
//        self.m_AssetClsNameLabel.text = @"장비상태이상";
//        strAlertMsg = @"장비가 매각처분 또는 폐기(반납)등의 정상적이지 않은 상태입니다.";
//        
//        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
//                                                            message:strAlertMsg
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        [alertView show];
//        [alertView release];
//    }
//    
//    TRACE(@"strChk:[%@]", strChk);
//    
//    [m_strAssetChkFlag setString:[NSString stringWithString:strChk]];
//    
//    m_isBusy = NO;
//    
//    [self onOK:nil];
//    
//    [strData release];
//}


- (void)requestAssetNoCheck:(NSString*)AssetNo
{
    TRACE(@"requestAssetNoCheck start");
    if(m_isBusy) return;
    
    NSString* strOrgCode;
    NSString* strBldProcCode;
    
    long nAssetNo = [AssetNo longLongValue];
    NSString* strAssetNo;
    
    if(nAssetNo == 0){
        strAssetNo = @"";
        [m_strAssetChkFlag setString: @"2"];
    }else{
        strAssetNo = [NSString stringWithFormat:@"%ld", nAssetNo];
    }
    
    TRACE(@"strAssetNo:[%@]", strAssetNo);
    
    if(m_SBUserInfoVO.szBimsOrgcode == nil || [m_SBUserInfoVO.szBimsOrgcode isEqualToString:@""]
       || [m_SBUserInfoVO.szBimsOrgcode isEqualToString:@"(null)"]){
        strOrgCode = @"";
    }else{
        strOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
    }
    
    if(m_SBBloodNoInfoVO.bldproccode == nil || [m_SBBloodNoInfoVO.bldproccode isEqualToString:@""]
       || [m_SBBloodNoInfoVO.bldproccode isEqualToString:@"(null)"]){
        strBldProcCode = @"";
    }else{
        strBldProcCode = [NSString stringWithString:m_SBBloodNoInfoVO.bldproccode];
    }
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_GET_BLD_ASSET_INFO;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strAssetNo, @"strAssetNo",
                                strOrgCode, @"strOrgCode",
                                strBldProcCode, @"strBldProcCode",
                                nil];
    
    //    m_httpRequest = [[HttpRequest alloc] init];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveAssetNoInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    m_isBusy = YES;
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveAssetNoInfo:(id)result
{
    NSString* strAlertMsg;
    NSString* strData;
    NSString* strRetVal;
    
    NSString* strOrgCodeChk;
    NSString* strAssetNo;
    NSString* strOrgCode;
    NSString* strAssetClsName;
    NSString* strModel;
    NSString* strBldChk;
    
    [self.m_activityIndicatorView stopAnimating];
    
    strData = [[NSString alloc] initWithString:[(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n"
                                                                                            withString:@""]];
    
    TRACE(@"didReceiveAssetNoInfo strData: %@", strData);
    
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
    
    strRetVal = [dictionary valueForKey:@"retVal"];
    
    NSArray* arrRetval = [strRetVal componentsSeparatedByString:@"|"];
    
    for(int i = 0; i < [arrRetval count]; i++)
    {
        if(i == 0){
            strOrgCodeChk = [arrRetval objectAtIndex:i];
        }else if(i == 1){
            strAssetNo = [arrRetval objectAtIndex:i];
        }else if(i == 2){
            strOrgCode = [arrRetval objectAtIndex:i];
        }else if(i == 3){
            strAssetClsName = [arrRetval objectAtIndex:i];
        }else if(i == 4){
            strModel = [arrRetval objectAtIndex:i];
        }else if(i == 5){
            strBldChk = [arrRetval objectAtIndex:i];
        }
    }
    
    TRACE(@"strOrgCodeChk:[%@]", strOrgCodeChk);
    TRACE(@"strAssetNo:[%@]", strAssetNo);
    TRACE(@"strOrgCode:[%@]", strOrgCode);
    TRACE(@"strAssetClsName:[%@]", strAssetClsName);
    TRACE(@"strModel:[%@]", strModel);
    TRACE(@"strBldChk:[%@]", strBldChk);
    
    if([strOrgCodeChk isEqualToString:@"T"] == YES){
        if([strBldChk isEqualToString:@"T"] == YES){
            self.m_AssetClsNameLabel.text = strAssetClsName;
        }else{
            self.m_AssetClsNameLabel.text = @"장비불일치";
            strAlertMsg = @"장비의 용도가 적절하지 않습니다.";
            
            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:strAlertMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            [alertView show];
            [alertView release];
        }
    }else if([strOrgCodeChk isEqualToString:@"1"] == YES){
        self.m_AssetClsNameLabel.text = @"기관불일치";
        strAlertMsg = @"기관정보가 일치하지 않습니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }else if([strOrgCodeChk isEqualToString:@"2"] == YES){
        self.m_AssetClsNameLabel.text = @"확인불가";
        strAlertMsg = @"존재하지 않는 장비ID 또는 기타사유로 확인이 불가합니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }else if([strOrgCodeChk isEqualToString:@"9"] == YES){
        self.m_AssetClsNameLabel.text = @"장비상태이상";
        strAlertMsg = @"장비가 매각처분 또는 폐기(반납)등의 정상적이지 않은 상태입니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }else{
        self.m_AssetClsNameLabel.text = @"통신이상";
        strAlertMsg = @"장비의 정보를 불러올 수 없습니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    
    if([strOrgCodeChk isEqualToString:@"T"] == YES && [strBldChk isEqualToString:@"F"] == YES){
        [m_strAssetChkFlag setString:@"4"];
    }else{
        [m_strAssetChkFlag setString:[NSString stringWithString:strOrgCodeChk]];
    }
    
    m_isBusy = NO;
    
    if([m_strAssetChkFlag isEqualToString:@"T"]){
        [self onOK:nil];
    }
    
    [strData release];
}



#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kMatchingSecondStepAlreadyProcessedActionSheetTag){
        // 2차 일치검사가 이미 완료되었으므로 첫 화면으로 돌아갈 것인지 확인.
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self onToHomeView:nil];
        }else{
            [self pageReset:nil];
            
            return;
        }
    }else if(alertView.tag == kMatchingSecondStepConfirmActionSheetTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self requestMatchingSecondStep];
        }else{
            //            [self pageReset2:nil];
            [self onBack2:nil];
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
    }else if(alertView.tag == kMatchingSecondStepEquipIdPassAletViewTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // 장비ID 공란으로 두고 그대로 진행
            m_barcodeSample1.enabled = YES;
            [m_barcodeSample1 becomeFirstResponder];
        }else{
            self.m_barcodeAssetNo.enabled = YES;
            [self.m_barcodeAssetNo becomeFirstResponder];
        }
    }
}


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    TRACE(@"actionSheet Delegate!");
    if(actionSheet.tag == kMatchingSecondStepAlreadyProcessedActionSheetTag){
        // 2차 일치검사가 이미 완료되었으므로 첫 화면으로 돌아갈 것인지 확인.
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self onToHomeView:nil];
        }else{
            //            self.m_barcodeBloodNo.enabled = NO;
            //            self.m_barcodeBag.enabled = YES;
            //            [m_barcodeBag becomeFirstResponder];
            [self pageReset:nil];
            
            return;
        }
    }else if(actionSheet.tag == kMatchingSecondStepConfirmActionSheetTag){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            [self requestMatchingSecondStep];
        }else{
//            [self pageReset2:nil];
            [self onBack2:nil];
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
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    TRACE(@"textFieldShouldClear occured!");
    NSInteger nTag = textField.tag;
    BOOL bReturn = YES;
    
    switch(nTag){
        case kBarcodeAssetNo :
            m_AssetClsNameLabel.text = @"";
            [m_strAssetChkFlag setString:@""];
            break;
        default:
            break;
    }
    
    return bReturn;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString*)string 
{ 
    NSInteger nTag = textField.tag;
    BOOL bReturn = YES;
    
    NSMutableString* mstrInput = [NSMutableString stringWithCapacity:16];
    
    [mstrInput setString:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    
    switch(nTag){
        case kBarcodeBloodNoTextField :
            if(mstrInput.length > 12){
                bReturn = NO;
            }
            break;
        case kBarcodeABOTypeTextField :
            if(mstrInput.length > 2){
                bReturn = NO;
            }
            break;
        case kBarcodeBagTextField :
            if(mstrInput.length > 12){
                bReturn = NO;
            }
            break;
        case kBarcodeBldBagcodeTextField :
            if(mstrInput.length > 7){
                bReturn = NO;
            }else{
                
            }
            break;
//        case kBarcodeAssetNo :
//            if(mstrInput.length > 12){
//                bReturn = NO;
//            }
//            break;
        case kBarcodeAssetNo :
            if([SBUtils isDigit:mstrInput] == NO && mstrInput.length > 0){
                bReturn = NO;
            }else{
                if(mstrInput.length > 10){
                    bReturn = NO;
                }
            }
            
            if(mstrInput.length == 0){
                m_AssetClsNameLabel.text = @"";
                [m_strAssetChkFlag setString:@""];
            }
            break;
        case kBarcodeABOTypeTextField2 :
            if(mstrInput.length > 2){
                bReturn = NO;
            }
            break;
        case kBarcodeBagTextField2 :
            if(mstrInput.length > 12){
                bReturn = NO;
            }
            break;
        case kBarcodeBldBagcodeTextField2 :
            if(mstrInput.length > 7){
                bReturn = NO;
            }else{
                
            }
            break;
        case kBarcodeSample1TextField2 :
            if(mstrInput.length > 12) bReturn = NO;
            break;
        case kBarcodeSample2TextField2 :
            if(mstrInput.length > 12) bReturn = NO;
            break;
        case kBarcodeSample3TextField2 :
            if(mstrInput.length > 12) bReturn = NO;
            break;
        case kBarcodeSample4TextField2 :
            if(mstrInput.length > 12) bReturn = NO;
            break;
        case kBarcodeSample5TextField2 :
            if(mstrInput.length > 12) bReturn = NO;
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
    NSString* strInput = [NSString stringWithString:textField.text];
    NSUInteger strLength = textField.text.length;
    NSString* strAlertMsg = @"";
    
    TRACE(@"textFieldShouldReturn");
    
    if(strLength == 0){
        return NO;
    }
    
    switch(nTag){
        case kBarcodeBloodNoTextField :
            if(strLength < 12){
                strAlertMsg = @"헌혈자바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"헌혈자바코드의 입력 값이 정확하지 않습니다.";
                    textField.text = @"";
                }else if(nRetVal == 1){
                    [self requestIsMatchingSecondStepCompleted:strInput];
                }
            }
            break;
        case kBarcodeABOTypeTextField :
            if(strLength < 2){
                strAlertMsg = @"혈액형바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 2){
                [self.m_strBarcodeABOType setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                
                if([m_strBarcodeABOType isEqualToString:m_SBBloodNoInfoVO.abobarcode] == NO){
                    strAlertMsg = @"혈액형바코드가 혈액정보와 일치하지 않습니다.";
                    [self.m_strBarcodeABOType setString:@""];
                    self.m_barcodeABOType.text = @"";
                    self.m_ABOTypeNameLabel.text = @"";
                    self.m_ABOTypeNameLabel.textColor = [UIColor blackColor];
                    self.m_barcodeBag.enabled = NO;
                }else{
                    m_ABOTypeNameLabel.text = [SBUtils getABOTypeName:m_strBarcodeABOType];
                    m_ABOTypeNameLabel.textColor = [SBUtils getABOTypeRGBValue:m_strBarcodeABOType];
                    self.m_barcodeABOType.enabled = NO;
                    self.m_barcodeBag.enabled = YES;
                    [self.m_barcodeBag becomeFirstResponder];
                    
                    //                    CGPoint point = CGPointMake(0, m_barcodeBldBagcode.frame.origin.y -20);
                    //                    [m_scrollView setContentOffset:point animated:YES];
                }
            }
            break;
        case kBarcodeBagTextField :
            if(strLength < 12){
                strAlertMsg = @"채혈백바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"채혈백바코드의 입력 값이 정확하지 않습니다.";
                    textField.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    [self.m_strBarcodeBag setString:@""];
                    self.m_barcodeBag.text = @"";
                    self.m_barcodeBldBagcode.enabled = NO;
                }else if(nRetVal == 1){
                    [self.m_strBarcodeBag setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                    self.m_barcodeBag.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeBag.enabled = NO;
                    self.m_barcodeBldBagcode.enabled = YES;
                    [self.m_barcodeBldBagcode becomeFirstResponder];
                }
            }
            break;
        case kBarcodeBldBagcodeTextField :
            if(strLength < 7){
                if([m_SBBloodNoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                    strAlertMsg = @"백종류바코드길이가 올바르지 않습니다.";
                }else{
                    strAlertMsg = @"채혈장비바코드길이가 올바르지 않습니다.";
                }
                
                break;
            }else if(strLength == 7){
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
                
                self.m_barcodeBldBagcode.text = strInput;
                
                [self.m_strBarcodeBldBagcode setString:strInput];
                
                NSRange range = NSMakeRange(0, 7);
                NSString* strBldProcBarcode1 = [m_SBBloodNoInfoVO.m_barcodeBldBagCode substringWithRange:range];
                
                if([strBldProcBarcode1 isEqualToString:self.m_strBarcodeBldBagcode] == NO){
                    
                    if([m_SBBloodNoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                        strAlertMsg = @"백종류바코드가 혈액정보와 일치하지 않습니다.";
                    }else{
                        strAlertMsg = @"채혈장비바코드가 혈액정보와 일치하지 않습니다.";
                    }
                    
                    [self.m_strBarcodeBldBagcode setString:@""];
                    self.m_barcodeBldBagcode.text = @"";
//                    self.m_barcodeSample1.enabled = NO;
                    self.m_barcodeAssetNo.enabled = NO;
                }else{
                    self.m_barcodeBldBagcode.enabled = NO;
                    self.m_barcodeAssetNo.enabled = YES;
                    [self.m_barcodeAssetNo becomeFirstResponder];
                }
            }
            break;
//        case kBarcodeAssetNo :
//            if(strLength < 5){
//                strAlertMsg = @"장비ID 길이가 올바르지 않습니다.";
//            }else{
//                TRACE(@"m_barcodeAssetNo:[%@]", self.m_barcodeAssetNo.text);
//                [self requestAssetNoCheck:strInput];
//            }
            break;
        case kBarcodeAssetNo :
            if(strLength == 0){
                strAlertMsg = @"장비ID가 입력되지 않았습니다.\n그대로 진행할까요?";
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                    message:strAlertMsg
                                                                   delegate:self
                                                          cancelButtonTitle:@"아니오"
                                                          otherButtonTitles:@"예", nil];
                
                alertView.tag = kMatchingSecondStepEquipIdPassAletViewTag;
                
                [alertView show];
                [alertView release];
                
                return YES;
            }else if(strLength < 5 || strLength > 10){
                strAlertMsg = @"장비ID 길이가 올바르지 않습니다.";
            }else{
                //                self.m_barcodeAssetNo.text = [strInput substringWithRange:r];
                TRACE(@"m_barcodeAssetNo:[%@]", self.m_barcodeAssetNo.text);
                m_barcodeAssetNo.enabled = NO;
                m_barcodeSample1.enabled = YES;
                [self requestAssetNoCheck:strInput];
            }
            break;
        /* secondView */
        case kBarcodeABOTypeTextField2 :
            if(strLength < 2){
                strAlertMsg = @"혈액형바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 2){
                [self.m_strBarcodeABOType2 setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                
                TRACE(@"strInput = (%@)", strInput);
                
                TRACE(@"m_strBarcodeABOType2 = (%@), abobarcode = (%@)", self.m_strBarcodeABOType2, m_SBBloodNoInfoVO.abobarcode);
                
                if([self.m_strBarcodeABOType2 isEqualToString:m_SBBloodNoInfoVO.abobarcode] == NO){
                    strAlertMsg = @"혈액형바코드가 혈액정보와 일치하지 않습니다.";
                    [self.m_strBarcodeABOType2 setString:@""];
                    self.m_barcodeABOType2.text = @"";
                    self.m_ABOTypeNameLabel2.text = @"";
                    self.m_ABOTypeNameLabel2.textColor = [UIColor blackColor];
                    self.m_barcodeBag2.enabled = NO;
                }else{
                    m_ABOTypeNameLabel2.text = [SBUtils getABOTypeName:m_strBarcodeABOType];
                    m_ABOTypeNameLabel2.textColor = [SBUtils getABOTypeRGBValue:m_strBarcodeABOType];
                    self.m_barcodeABOType2.enabled = NO;
                    self.m_barcodeBag2.enabled = YES;
                    [self.m_barcodeBag2 becomeFirstResponder];
                    
                    //                    CGPoint point = CGPointMake(0, m_barcodeBldBagcode.frame.origin.y -20);
                    //                    [m_scrollView setContentOffset:point animated:YES];
                }
            }
            break;
        case kBarcodeBagTextField2 :
            if(strLength < 12){
                strAlertMsg = @"채혈백바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck2:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"채혈백바코드의 입력 값이 정확하지 않습니다.";
                    textField.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    [self.m_strBarcodeBag2 setString:@""];
                    self.m_barcodeBag2.text = @"";
                    self.m_barcodeBldBagcode2.enabled = NO;
                }else if(nRetVal == 1){
                    [self.m_strBarcodeBag2 setString:[strInput stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                    self.m_barcodeBag2.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeBag2.enabled = NO;
                    self.m_barcodeBldBagcode2.enabled = YES;
                    [self.m_barcodeBldBagcode2 becomeFirstResponder];
                }
            }
            break;
        case kBarcodeBldBagcodeTextField2 :
            if(strLength < 7){
                if([m_SBBloodNoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                    strAlertMsg = @"백종류바코드길이가 올바르지 않습니다.";
                }else{
                    strAlertMsg = @"채혈장비바코드길이가 올바르지 않습니다.";
                }
                
                break;
            }else if(strLength == 7){
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㄴ" withString:@"S"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅇ" withString:@"D"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅆ" withString:@"T"];
                strInput = [strInput stringByReplacingOccurrencesOfString:@"ㅃ" withString:@"Q"];
                
                self.m_barcodeBldBagcode2.text = strInput;
                
                [self.m_strBarcodeBldBagcode2 setString:strInput];
                
                NSRange range = NSMakeRange(7, 7);
                NSString* strBldProcBarcode2 = [m_SBBloodNoInfoVO.m_barcodeBldBagCode substringWithRange:range];
                
                if([strBldProcBarcode2 isEqualToString:self.m_strBarcodeBldBagcode2] == NO){
                    
                    if([m_SBBloodNoInfoVO.bloodtype isEqualToString:@"1"] == YES){
                        strAlertMsg = @"백종류바코드가 혈액정보와 일치하지 않습니다.";
                    }else{
                        strAlertMsg = @"채혈장비바코드가 혈액정보와 일치하지 않습니다.";
                    }
                    
                    [self.m_strBarcodeBldBagcode2 setString:@""];
                    self.m_barcodeBldBagcode2.text = @"";
                    self.m_barcodeSample1.enabled = NO;
                }else{                    
                    self.m_barcodeBldBagcode2.enabled = NO;
                    self.m_barcodeSample1.enabled = YES;
                    [self.m_barcodeSample1 becomeFirstResponder];
                    
                    //                    CGPoint point = CGPointMake(0, m_barcodeSample1.frame.origin.y -20);
                    //                    [m_scrollView setContentOffset:point animated:YES];
                }
            }
            break;
        /* 검체 */
        case kBarcodeSample1TextField2 :
            if(strLength < 12){
                strAlertMsg = @"검체1바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck2:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"검체1바코드의 입력 값이 정확하지 않습니다.";
                    self.m_barcodeSample1.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    self.m_barcodeSample1.text = @"";
                    [self.m_strBarcodeSample1 setString:@""];
                    self.m_barcodeSample2.enabled = NO;
                }else if(nRetVal == 1){
                    [self.m_strBarcodeSample1 setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
                                                                                            withString:@""]];
                    self.m_barcodeSample1.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeSample1.enabled = NO;
                    self.m_barcodeSample2.enabled = YES;
                    [self.m_barcodeSample2 becomeFirstResponder];
                }
            }
            break;
        case kBarcodeSample2TextField2 :
            if(strLength < 12){
                strAlertMsg = @"검체2바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck2:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"검체2바코드의 입력 값이 정확하지 않습니다.";
                    self.m_barcodeSample2.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    self.m_barcodeSample2.text = @"";
                    [self.m_strBarcodeSample2 setString:@""];
                    self.m_barcodeSample3.enabled = NO;
                }else if(nRetVal == 1){
                    [self.m_strBarcodeSample2 setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
                                                                                            withString:@""]];
                    self.m_barcodeSample2.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeSample2.enabled = NO;
                    self.m_barcodeSample3.enabled = YES;
                    [self.m_barcodeSample3 becomeFirstResponder];
                }
            }
            break;
        case kBarcodeSample3TextField2 :
            if(strLength < 12){
                strAlertMsg = @"검체3바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck2:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"검체3바코드의 입력 값이 정확하지 않습니다.";
                    self.m_barcodeSample3.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    self.m_barcodeSample3.text = @"";
                    [self.m_strBarcodeSample3 setString:@""];
                    self.m_barcodeSample4.enabled = NO;
                }else if(nRetVal == 1){
                    [self.m_strBarcodeSample3 setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
                                                                                            withString:@""]];
                    self.m_barcodeSample3.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeSample3.enabled = NO;
                    self.m_barcodeSample4.enabled = YES;
                    [self.m_barcodeSample4 becomeFirstResponder];
                }
            }
            break;
        case kBarcodeSample4TextField2 :
            if(strLength < 12){
                strAlertMsg = @"검체4바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck2:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"검체4바코드의 입력 값이 정확하지 않습니다.";
                    self.m_barcodeSample4.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    self.m_barcodeSample4.text = @"";
                    [self.m_strBarcodeSample4 setString:@""];
                    self.m_barcodeSample5.enabled = NO;
                }else if(nRetVal == 1){
                    [self.m_strBarcodeSample4 setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
                                                                                            withString:@""]];
                    self.m_barcodeSample4.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeSample4.enabled = NO;
                    self.m_barcodeSample5.enabled = YES;
                    [self.m_barcodeSample5 becomeFirstResponder];
                }
            }
            break;
        case kBarcodeSample5TextField2 :
            if(strLength < 12){
                strAlertMsg = @"검체5바코드길이가 올바르지 않습니다.";
                break;
            }else if(strLength == 12){
                int nRetVal = [self bloodNoDuplicationCheck2:strInput];
                
                if(nRetVal == -1){
                    strAlertMsg = @"검체5바코드의 입력 값이 정확하지 않습니다.";
                    self.m_barcodeSample5.text = @"";
                }else if(nRetVal == -2){
                    strAlertMsg = @"이미 입력된 값입니다.";
                    self.m_barcodeSample5.text = @"";
                    [self.m_strBarcodeSample5 setString:@""];
                }else if(nRetVal == 1){
                    [self.m_strBarcodeSample5 setString:[strInput stringByReplacingOccurrencesOfString:@"-" 
                                                                                            withString:@""]];
                    self.m_barcodeSample5.text = [SBUtils formatBloodNo:strInput];
                    self.m_barcodeSample5.enabled = NO;
                    
                    [self.m_barcodeSample5 resignFirstResponder];
                    
                    [self onOK2:nil];
                }
            }
            break;
            
        default:
            return YES;
    }
    
    if(strAlertMsg != nil && [strAlertMsg isEqualToString:@""] == NO){
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
    
    m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeABOType = [[NSMutableString alloc] initWithCapacity:2];
    m_strBarcodeBag = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeBldBagcode = [[NSMutableString alloc] initWithCapacity:7];
    m_strBarcodeAssetNo = [[NSMutableString alloc] initWithCapacity: 12];
    
    m_strAssetChkFlag = [[NSMutableString alloc] initWithCapacity:1];
    
    m_strBarcodeABOType2 = [[NSMutableString alloc] initWithCapacity:2];
    m_strBarcodeBag2 = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeBldBagcode2 = [[NSMutableString alloc] initWithCapacity:7];
    
    m_strBarcodeSample1 = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeSample2 = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeSample3 = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeSample4 = [[NSMutableString alloc] initWithCapacity:16];
    m_strBarcodeSample5 = [[NSMutableString alloc] initWithCapacity:16];
    
//    CGSize size;	
//	size = self.m_contentsView.frame.size;
//	
//	TRACE(@"width : %f, height : %f", size.width, size.height); 
//	
//	self.m_scrollView.contentSize = size;
//    
//    [self.view addSubview:m_scrollView];
//    [m_scrollView addSubview:m_contentsView];
    
    m_bloodNoDuplicationCheckMutableArray = [[NSMutableArray alloc] initWithCapacity:8];
    m_bloodNoDuplicationCheckMutableArray2 = [[NSMutableArray alloc] initWithCapacity:8];
//    TRACE(@"m_bloodNoDuplicationCheckMutableArray's length is %d", m_bloodNoDuplicationCheckMutableArray.count);
    
    m_AssetClsNameLabel.text = @"";
    
    [m_barcodeBloodNo becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBBloodNoInfoVO = nil;
    self.m_SBUserInfoVO = nil;
    
//    self.m_scrollView = nil;
//    self.m_contentsView = nil;
    
    self.m_idNameLabel = nil;
    self.m_idNameLabel2 = nil;
    
    /* firstView */
    self.m_bloodNoLabel = nil;
    self.m_nameLabel = nil;
    self.m_ABOTypeNameLabel = nil;
    self.m_malariaLabel = nil;
    
    self.m_BldBagLabel = nil;
    
    self.m_AssetClsNameLabel = nil;
    
    self.m_barcodeBloodNo = nil;
    self.m_barcodeABOType = nil;
    self.m_barcodeBag = nil;
    self.m_barcodeBldBagcode = nil;
    self.m_barcodeAssetNo = nil;
    
    self.m_strBarcodeBloodNo = nil;
    self.m_strBarcodeABOType = nil;
    self.m_strBarcodeBag = nil;
    self.m_strBarcodeBldBagcode = nil;
    self.m_strBarcodeAssetNo = nil;
    
    self.m_strAssetChkFlag = nil;
    
    self.m_activityIndicatorView = nil;
    
    /* secondView */
    self.m_secondView = nil;
    self.m_bloodNoLabel2 = nil;
    self.m_nameLabel2 = nil;
    self.m_ABOTypeNameLabel2 = nil;
    self.m_malariaLabel2 = nil;
    
    self.m_BldBagLabel2 = nil;
    
    self.m_barcodeBloodNoLabel2 = nil;
    self.m_barcodeABOType2 = nil;
    self.m_barcodeBag2 = nil;
    self.m_barcodeBldBagcode2 = nil;
    
    self.m_strBarcodeABOType2 = nil;
    self.m_strBarcodeBag2 = nil;
    self.m_strBarcodeBldBagcode2 = nil;
    
    self.m_barcodeSample1 = nil;
    self.m_barcodeSample2 = nil;
    self.m_barcodeSample3 = nil;
    self.m_barcodeSample4 = nil;
    self.m_barcodeSample5 = nil;
    
    self.m_strBarcodeSample1 = nil;
    self.m_strBarcodeSample2 = nil;
    self.m_strBarcodeSample3 = nil;
    self.m_strBarcodeSample4 = nil;
    self.m_strBarcodeSample5 = nil;
    
    self.m_activityIndicatorView2 = nil;
    
    self.m_bloodNoDuplicationCheckMutableArray = nil;
}


- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBUserInfoVO release];
    [m_SBBloodNoInfoVO release];
    
//    [m_scrollView release];
//    [m_contentsView release];
    
    [m_idNameLabel release];
    [m_idNameLabel2 release];
    
    [m_bloodNoLabel release];
    [m_nameLabel release];
    [m_ABOTypeNameLabel release];
    [m_malariaLabel release];
    
    [m_BldBagLabel release];
    
    [m_AssetClsNameLabel release];
    
    [m_barcodeBloodNo release];
    [m_barcodeABOType release];
    [m_barcodeBag release];
    [m_barcodeBldBagcode release];
    [m_barcodeAssetNo release];
    
    [m_strBarcodeBloodNo release];
    [m_strBarcodeABOType release];
    [m_strBarcodeBag release];
    [m_strBarcodeBldBagcode release];
    [m_strBarcodeAssetNo release];
    
    [m_strAssetChkFlag release];
    
    [m_activityIndicatorView release];
    
    /* secondView */
    [m_bloodNoLabel2 release];
    [m_nameLabel2 release];
    [m_ABOTypeNameLabel2 release];
    [m_malariaLabel2 release];
    
    [m_BldBagLabel2 release];
    
    [m_barcodeBloodNoLabel2 release];
    [m_barcodeABOType2 release];
    [m_barcodeBag2 release];
    [m_barcodeBldBagcode2 release];
    
    [m_strBarcodeABOType2 release];
    [m_strBarcodeBag2 release];
    [m_strBarcodeBldBagcode2 release];
    
    [m_barcodeSample1 release];
    [m_barcodeSample2 release];
    [m_barcodeSample3 release];
    [m_barcodeSample4 release];
    [m_barcodeSample5 release];
    
    [m_strBarcodeSample1 release];
    [m_strBarcodeSample2 release];
    [m_strBarcodeSample3 release];
    [m_strBarcodeSample4 release];
    [m_strBarcodeSample5 release];
    
    [m_activityIndicatorView2 release];
    
    [m_bloodNoDuplicationCheckMutableArray release];
    [m_bloodNoDuplicationCheckMutableArray2 release];
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
