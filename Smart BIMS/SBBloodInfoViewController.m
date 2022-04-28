//
//  SBBloodInfoViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 17..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBBloodInfoViewController.h"

#import "HttpRequest.h"
#import "JSON.h"
#import "SBBloodnoInfoVO.h"
#import "SBUserInfoVO.h"
#import "SBUtils.h"
#import "SBBldProcPickerViewController.h"
#import "SBFirstMatchingViewController.h"
#import "SBMultiBloodInfoViewController.h"
#import "SBSideEffectsListViewController.h"

#import "Smart_BIMSAppDelegate.h"



@implementation SBBloodInfoViewController

@synthesize m_httpRequest;
@synthesize m_SBBloodnoInfoVO;
@synthesize m_SBUserInfoVO;

@synthesize m_titleLabel;
@synthesize m_idNameLabel;

@synthesize m_bloodnoBarcodeTextField;
@synthesize m_strBarcodeBloodNo;

@synthesize m_juminLabel;
@synthesize m_nameLabel;
// 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
@synthesize m_bloodCntLabel;

@synthesize m_registerImageView;
@synthesize m_marrmstImageView;

@synthesize m_heightLabel;
@synthesize m_weightLabel;

@synthesize m_bldprocNames;

@synthesize m_aboNameLabel;
@synthesize m_absLabel;
@synthesize m_subLabel;
@synthesize m_gbMal;

@synthesize m_hematoLabel;
@synthesize m_plateletLabel;

@synthesize m_searchButton;
@synthesize m_toFirstMatchingViewButton;
@synthesize m_cancelButton;
@synthesize m_btnToSideEffectsView;

@synthesize m_toMultiMatchingViewButton;

@synthesize m_activityIndicatorView;

@synthesize m_bldProcPickerViewController;
@synthesize m_firstMatchingViewController;
@synthesize m_multiBloodInfoViewController;
@synthesize m_SBSideEffectsListViewController;

@synthesize m_bPickerViewMode;

@synthesize m_target;
@synthesize m_selector;

//@synthesize m_strSubViewId;




- (void)pageReset:(id)sender
{
    self.m_titleLabel.text = @"채혈전확인사항";
//    NSString* strIdName = [NSString stringWithString:m_SBUserInfoVO.szBimsName];
    self.m_idNameLabel.text = m_SBUserInfoVO.szBimsName;
    self.m_bloodnoBarcodeTextField.text = @"";
    
    if(self.m_strBarcodeBloodNo != nil){
        [m_strBarcodeBloodNo release];
        
        m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    }
    
    self.m_juminLabel.text = @"";
    self.m_nameLabel.text = @"";
    // 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
    self.m_bloodCntLabel.text = @"";
    
    self.m_registerImageView.hidden = YES;
    self.m_marrmstImageView.hidden = YES;
    self.m_gbMal.hidden = YES;
    
    self.m_heightLabel.text = @"";
    self.m_weightLabel.text = @"";
    //    [self.m_bsdSwitch setOn:YES animated:YES];
    
    //    m_bsdStatusLabel.text = @"BSD";
    
    self.m_bldprocNames.text = @"";
    
    self.m_aboNameLabel.text = @"";
    self.m_aboNameLabel.textColor = [UIColor blackColor];
    self.m_absLabel.text = @"";
    self.m_subLabel.text = @"";
    self.m_hematoLabel.text = @"";
    self.m_plateletLabel.text = @"";
    self.m_SBBloodnoInfoVO = nil;
    
//    self.m_strSubViewId = @"";
    
    self.m_bPickerViewMode = NO;
    self.m_toFirstMatchingViewButton.hidden = YES;
    
    self.m_searchButton.hidden = NO;
    self.m_cancelButton.hidden = YES;
    
    self.m_toMultiMatchingViewButton.hidden = YES;
    
    if([self.m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
    [self.m_bloodnoBarcodeTextField becomeFirstResponder];
}


- (IBAction)onSelectBloodnoInfo:(id)sender
{
    if(m_searchButton.hidden == YES){
        return;
    }
    
    if(m_isBusy) return;
    else m_isBusy = YES;
    
    if(m_bloodnoBarcodeTextField.text.length < 12){
        self.m_strBarcodeBloodNo = nil;
        [m_strBarcodeBloodNo release];
        self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
        
        m_bloodnoBarcodeTextField.text = @"";
        
        m_isBusy = NO;
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                            message:@"혈액번호 형식이 틀립니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    [m_strBarcodeBloodNo setString:m_bloodnoBarcodeTextField.text];
//    [m_strBarcodeBloodNo setString:[SBUtils getParameterTypeBloodNo:m_bloodnoBarcodeTextField.text]];
//    [m_strBarcodeBloodNo setString:[NSString stringWithFormat:@"%@%@", m_strBarcodeBloodNo, @"01"]];
    m_bloodnoBarcodeTextField.text = [SBUtils formatBloodNo:[NSString stringWithString:m_strBarcodeBloodNo]];
    NSString* strBloodno = [NSString stringWithString:m_strBarcodeBloodNo];
    
    [self backgroundTab:nil];
    
//    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBMatchingBloodInfoWithSideEffectsInfoDAO.jsp";
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBMatchingBloodInfoDAO.jsp";

    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strBloodno, @"bloodNoBarcode", nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveBloodInfoResponse:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveBloodInfoResponse:(id)result
{
    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    
    m_isBusy = NO;
    
    TRACE(@"didReceiveBloodInfoResponse=[%@]", strData);
    
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
    
    if([strResult isEqualToString:@"1"] == true) // == 수정
    {
        [self stopActivityIndicatorView];
        
        if(m_SBBloodnoInfoVO != nil)
        {
            m_SBBloodnoInfoVO = nil;
            [m_SBBloodnoInfoVO release];
        }
        
        m_SBBloodnoInfoVO = [[SBBloodnoInfoVO alloc] init];
        
        m_SBBloodnoInfoVO.bloodno = [NSString stringWithString:m_strBarcodeBloodNo];
        
        m_SBBloodnoInfoVO.jumin1 = [dictionary valueForKey:@"jumin1"];
        m_SBBloodnoInfoVO.jumin2 = [dictionary valueForKey:@"jumin2"];
        m_SBBloodnoInfoVO.registeryn = [dictionary valueForKey:@"registeryn"];
        m_SBBloodnoInfoVO.marrmstyn = [dictionary valueForKey:@"marrmstyn"];
        m_SBBloodnoInfoVO.name = [dictionary valueForKey:@"name"];
        
        // 2014.02.21 추가
        m_SBBloodnoInfoVO.bloodcnt = [dictionary valueForKey:@"bloodcnt"];
        // 2015.04.06 추가
        m_SBBloodnoInfoVO.sideeffectsyn = [dictionary valueForKey:@"sideeffectsyn"];
        
        m_SBBloodnoInfoVO.gbmal = [dictionary valueForKey:@"gbmal"];
        m_SBBloodnoInfoVO.gbmal_color = [dictionary valueForKey:@"gbmal_color"];
        m_SBBloodnoInfoVO.sex = [dictionary valueForKey:@"sex"];
        m_SBBloodnoInfoVO.weight = [dictionary valueForKey:@"weight"];
        m_SBBloodnoInfoVO.height = [dictionary valueForKey:@"height"];
        
        m_SBBloodnoInfoVO.bldproccode = [dictionary valueForKey:@"bldproccode"];
        m_SBBloodnoInfoVO.bldprocinterface = [dictionary valueForKey:@"bldprocinterface"];
        m_SBBloodnoInfoVO.bldprocname = [dictionary valueForKey:@"bldprocname"];
        m_SBBloodnoInfoVO.bagqty = [dictionary valueForKey:@"bagqty"];
        m_SBBloodnoInfoVO.bldabocode = [dictionary valueForKey:@"bldabocode"];
        
        m_SBBloodnoInfoVO.aboname = [dictionary valueForKey:@"aboname"];
        m_SBBloodnoInfoVO.sub = [dictionary valueForKey:@"sub"];
        m_SBBloodnoInfoVO.abs = [dictionary valueForKey:@"abs"];
        m_SBBloodnoInfoVO.hct_result = [dictionary valueForKey:@"hct_result"];
        m_SBBloodnoInfoVO.pccnt = [dictionary valueForKey:@"pccnt"];
        
        m_SBBloodnoInfoVO.abobarcode = [dictionary valueForKey:@"abobarcode"];
        m_SBBloodnoInfoVO.malbarcode = [dictionary valueForKey:@"malbarcode"];
        m_SBBloodnoInfoVO.bloodtype = [dictionary valueForKey:@"bloodtype"];  // 4는 다종성분헌혈.
        
        m_SBBloodnoInfoVO.isOnBSD = YES; //m_bsdSwitch.on;
        
        if ([[dictionary valueForKey:@"gbmal"] isEqualToString:@"0"]) {
            m_gbMal.hidden = true;
        } else {
            m_gbMal.hidden = false;
        }
        
        
        // wireline - 2015.02.25: 헌혈관련증상 버튼 생성
        if([m_SBBloodnoInfoVO.sideeffectsyn isEqualToString:@"Y"] == YES){
            self.m_btnToSideEffectsView.hidden = NO;
            [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:@"헌혈관련증상내역이 존재합니다.\n확인하시겠습니까?"
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            
            alertView.tag = kIsSideEffectsInfoActionSheetTag;
            
            [alertView show];
            [alertView release];
        }else{
            self.m_btnToSideEffectsView.hidden = YES;
        }
        
        m_SBBloodnoInfoVO.m_selectedBldProc1 = [dictionary valueForKey:@"bldproccode"];
        m_SBBloodnoInfoVO.m_selectedBldProc2 = [dictionary valueForKey:@"bldproccode"];
        m_SBBloodnoInfoVO.m_selectedBldProc3 = [[NSString alloc] initWithFormat:@"%@,%@", 
                                                [dictionary valueForKey:@"bagqty"], 
                                                [dictionary valueForKey:@"bldprocinterface"]];
        m_SBBloodnoInfoVO.m_bagInterface = [SBUtils getBagInterface:m_SBBloodnoInfoVO.m_selectedBldProc3];
        m_SBBloodnoInfoVO.m_barcodeBldBagCode = @"";
        
        self.m_juminLabel.text = [NSString stringWithFormat:@"%@-%@", m_SBBloodnoInfoVO.jumin1, m_SBBloodnoInfoVO.jumin2];
        self.m_nameLabel.text = m_SBBloodnoInfoVO.name;
        // 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
        self.m_bloodCntLabel.text = [NSString stringWithFormat:@"%@회", m_SBBloodnoInfoVO.bloodcnt];
        
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
        self.m_aboNameLabel.textColor = [SBUtils getABOTypeRGBValue:[dictionary valueForKey:@"abobarcode"]];
        self.m_absLabel.text = m_SBBloodnoInfoVO.abs;
        self.m_subLabel.text = m_SBBloodnoInfoVO.sub;
        self.m_hematoLabel.text = m_SBBloodnoInfoVO.hct_result;
        self.m_plateletLabel.text = m_SBBloodnoInfoVO.pccnt;
        
        [self.m_bldProcPickerViewController setBldProcArrays:m_SBBloodnoInfoVO.bldproccode];
        
//        [self.m_bldProcPickerViewController reloadBldProcNameComponents];
        [self.m_bldProcPickerViewController reloadBldProcNameComponentsByBldProccode:m_SBBloodnoInfoVO.bldproccode];
        
        self.m_bldprocNames.text = [[NSString alloc] initWithFormat:@"%@  %@  %@", 
                                    [m_bldProcPickerViewController getBldProc1TitleNameByValue:m_SBBloodnoInfoVO.m_selectedBldProc1],
                                    [m_bldProcPickerViewController getBldProc2TitleNameByValue:m_SBBloodnoInfoVO.m_selectedBldProc2],
                                    [m_bldProcPickerViewController getBldProc3TitleNameByValue:m_SBBloodnoInfoVO.m_selectedBldProc3]];
        
        self.m_SBBloodnoInfoVO.bldprocNames = self.m_bldprocNames.text;
        
//        self.m_toFirstMatchingViewButton.hidden = NO;
        self.m_searchButton.hidden = YES;
        self.m_cancelButton.hidden = NO;
        
        // 다종성분일 경우 분기가 시작되는 지점.
        if([m_SBBloodnoInfoVO.bloodtype isEqualToString:@"4"] == YES){
            self.m_titleLabel.text = @"채혈전확인사항 PLT";
            self.m_toMultiMatchingViewButton.hidden = NO;
        }else{
            self.m_toFirstMatchingViewButton.hidden = NO;
        }
    }
    else
    {
        [self stopActivityIndicatorView];
        strAlertMsg = @"존재하지 않는 혈액번호입니다.";
        
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"조회결과"
                                                            message:strAlertMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        [self pageReset:nil];
    }
}


// 헌혈관련증상내역 조회 화면
- (IBAction)onToSideEffectsView:(id)sender
{
    if(m_SBSideEffectsListViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBSideEffectsListViewController = [[SBSideEffectsListViewController alloc] initWithNibName:@"SBSideEffectsListViewController"
                                                                                                  bundle:nil];
        }else{
            m_SBSideEffectsListViewController = [[SBSideEffectsListViewController alloc] initWithNibName:@"SBSideEffectsListViewController3"
                                                                                                  bundle:nil];
        }
    }
    
    [self backgroundTab:nil];
    
    [m_SBSideEffectsListViewController setValuesWithBloodNo:self.m_strBarcodeBloodNo];
    //    [m_SBSideEffectsListViewController pageReset];
    [m_SBSideEffectsListViewController setDelegate:self
                                          selector:nil];
    
    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    m_SBSideEffectsListViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBSideEffectsListViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    [self.view addSubview:m_SBSideEffectsListViewController.view];
    
    [UIView commitAnimations];
}



/* 다종성분인 경우 */
- (IBAction)onToMultiMatchingView:(id)sender
{
    if([self.m_bloodnoBarcodeTextField.text isEqualToString:@""] || m_SBBloodnoInfoVO == nil){
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
        NSString* strTempBldProc1 = m_SBBloodnoInfoVO.m_selectedBldProc1;
        NSString* strTempBldProc2 = m_SBBloodnoInfoVO.m_selectedBldProc2;
        NSString* strTempRealBldProcValue = m_SBBloodnoInfoVO.m_bagInterface;
        
        if(m_isBusy) return;
        else m_isBusy = YES;
        
        NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBCheckBldProcAndBagCode.jsp";
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strTempBldProc1, @"strBldProc1", 
                                    strTempBldProc2, @"strBldProc2", strTempRealBldProcValue, @"strBldProc3", nil];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveCheckBldProcAndBagCodeResponseToGoMultiMatchingView:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
        
        [self.m_activityIndicatorView startAnimating];
        
    }
}


/* 
 * bldproccode와 bag_interface를 매개로 bldbagcode(barcode)값을 수신한다.
 */
- (void)didReceiveCheckBldProcAndBagCodeResponseToGoMultiMatchingView:(id)result
{
    static UIViewAnimationTransition orders[4] = {
        UIViewAnimationTransitionCurlDown,
        UIViewAnimationTransitionCurlUp,
        UIViewAnimationTransitionFlipFromLeft,
        UIViewAnimationTransitionFlipFromRight,
    };
    
    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    
    m_isBusy = NO;
    
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
    
    if([strResult isEqualToString:@"1"] == YES){ // == 변경
        // bldBagCode의 바코드를 얻는다.
        self.m_SBBloodnoInfoVO.m_barcodeBldBagCode = [dictionary valueForKey:@"strBldBagcode"];
        self.m_SBBloodnoInfoVO.isOnBSD = YES;//m_bsdSwitch.on;
        
        TRACE(@"%@", self.m_SBBloodnoInfoVO.m_barcodeBldBagCode);
        
        if(m_multiBloodInfoViewController == nil){
            if(winHeight == kWINDOW_HEIGHT){
                m_multiBloodInfoViewController = [[SBMultiBloodInfoViewController alloc] initWithNibName:@"SBMultiBloodInfoViewController"
                                                                                                  bundle:nil];
            }else{
                m_multiBloodInfoViewController = [[SBMultiBloodInfoViewController alloc] initWithNibName:@"SBMultiBloodInfoViewController3"
                                                                                            bundle:nil];
            }
        }
        
        m_multiBloodInfoViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        
        [m_multiBloodInfoViewController setDelegate:self 
                                           selector:@selector(onToHomeViewFromSubView)];
        m_multiBloodInfoViewController.m_SBBloodnoInfoVO = self.m_SBBloodnoInfoVO;
        m_multiBloodInfoViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
        
        [m_multiBloodInfoViewController pageReset:nil];
        [m_multiBloodInfoViewController setPageValues];
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:orders[0]
                               forView:self.view
                                 cache:YES];
        
        [self.view addSubview:m_multiBloodInfoViewController.view];
        
        [UIView commitAnimations];
        
    }else{
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
    
}


- (void)stopActivityIndicatorView
{
    [self.m_activityIndicatorView stopAnimating];
}


/* 채혈전 확인사항 확인 후 1차 일치검사화면으로 이동하기 전 Server와의 통신.
 * 
 */
- (IBAction)onToFirstMatchingView:(id)sender
{
    if([self.m_bloodnoBarcodeTextField.text isEqualToString:@""] || m_SBBloodnoInfoVO == nil){
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
        NSString* strTempBldProc1 = m_SBBloodnoInfoVO.m_selectedBldProc1;
        NSString* strTempBldProc2 = m_SBBloodnoInfoVO.m_selectedBldProc2;
        NSString* strTempRealBldProcValue = m_SBBloodnoInfoVO.m_bagInterface;
        
        if(m_isBusy) return;
        else m_isBusy = YES;
        
        NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBCheckBldProcAndBagCode.jsp";
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:strTempBldProc1, @"strBldProc1", 
                                    strTempBldProc2, @"strBldProc2", strTempRealBldProcValue, @"strBldProc3", nil];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveCheckBldProcAndBagCodeResponse:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
        
        [self.m_activityIndicatorView startAnimating];

    }
}


/* 
 * bldproccode와 bag_interface를 매개로 bldbagcode(barcode)값을 수신한다.
 */
- (void)didReceiveCheckBldProcAndBagCodeResponse:(id)result
{
    NSString* strAlertMsg = @"";
    NSString* strData = (NSString*)result;
    NSString* strResult = @"";
    
    m_isBusy = NO;
    
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
    
    if([strResult isEqualToString:@"1"] == YES){ //----- ==
        // bldBagCode의 바코드를 얻는다.
        self.m_SBBloodnoInfoVO.m_barcodeBldBagCode = [dictionary valueForKey:@"strBldBagcode"];
        self.m_SBBloodnoInfoVO.isOnBSD = YES;//m_bsdSwitch.on;
        
        // TO DO - 1차 일치검사로...
        if(m_firstMatchingViewController == nil){
            if(winHeight == kWINDOW_HEIGHT){
                m_firstMatchingViewController = [[SBFirstMatchingViewController alloc] initWithNibName:@"SBFirstMatchingViewController"
                                                                                                bundle:nil];
            }else{
                m_firstMatchingViewController = [[SBFirstMatchingViewController alloc]
                    initWithNibName:@"SBFirstMatchingViewController3"
                
                                                                                                bundle:nil];
            }
        }
        
        [m_firstMatchingViewController pageReset:nil];
        
        [m_firstMatchingViewController setUserInfo:self.m_SBUserInfoVO];
        
        CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
        m_firstMatchingViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_firstMatchingViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        
        [m_firstMatchingViewController setDelegate:self 
                                          selector:@selector(onToHomeViewFromSubView)];
        m_firstMatchingViewController.m_SBBloodnoInfoVO = self.m_SBBloodnoInfoVO;
        [m_firstMatchingViewController setBldBagLabelText];
        
        [self.view addSubview:m_firstMatchingViewController.view];
        
        [UIView commitAnimations];

    }else{
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

}


- (void)setBldProcNamesAndValues:(id)obj
{
    NSMutableDictionary* dictionary = (NSMutableDictionary*)obj;
    
    NSString* strBldProcNames = [[NSString alloc] initWithFormat:@"%@  %@  %@", [dictionary valueForKey:@"bldprocname1"],[dictionary valueForKey:@"bldprocname2"], [dictionary valueForKey:@"bldprocname3"]];
    
    m_SBBloodnoInfoVO.m_selectedBldProc1 = [dictionary valueForKey:@"bldproccode1"];
    m_SBBloodnoInfoVO.m_selectedBldProc2 = [dictionary valueForKey:@"bldproccode2"];
    m_SBBloodnoInfoVO.m_selectedBldProc3 = [dictionary valueForKey:@"bldproccode3"];
    
    m_SBBloodnoInfoVO.m_bagInterface = [SBUtils getBagInterface:[dictionary valueForKey:@"bldproccode3"]];
    
    m_bldprocNames.text = strBldProcNames;
    m_SBBloodnoInfoVO.bldprocNames = strBldProcNames;
    
    CGRect frame = CGRectMake(0, winHeight-272, viewWidth, 272);
    m_bldProcPickerViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_bldProcPickerViewController.view.frame = CGRectMake(0, winHeight, viewWidth, 272);
    
    [UIView commitAnimations];
    
    m_bPickerViewMode = NO;
}


///////////////////////


- (IBAction)onHomeButtonTab:(id)sender
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
//    [self.m_bldProcPickerViewController.view removeFromSuperview];
    [m_target performSelector:m_selector withObject:nil];
	[self.view removeFromSuperview];
}


- (void)onToHomeViewFromSubView
{
    [m_bloodnoBarcodeTextField resignFirstResponder];
    
//    self.m_strSubViewId = [NSString stringWithString:strViewId];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
	self.view.frame = frame;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	
	self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
	
	[UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(onToHomeViewFromSubViewSelector)
                                   userInfo:nil
                                    repeats:NO];
}


- (void)onToHomeViewFromSubViewSelector
{
//    if([m_strSubViewId isEqualToString:@"FirstMatchingView"]){
//        [self.m_firstMatchingViewController.view removeFromSuperview];
//    }else if([m_strSubViewId isEqualToString:@"MultiBloodNoInfoView"]){
//        [self.m_multiBloodInfoViewController.view removeFromSuperview];
//    }else if([m_strSubViewId isEqualToString:@"MultiFirstMatchingView1"]){
//        for(UIView* subview in [self.view subviews]){
//            [subview removeFromSuperview];
//        }
//    }
    
    for(UIView* subview in [self.view subviews]){
        [subview removeFromSuperview];
    }
    
    [m_target performSelector:m_selector withObject:nil];
    [self.view removeFromSuperview];
}


- (void)backgroundTab:(id)sender
{
    [self.m_bloodnoBarcodeTextField resignFirstResponder];
    
    if(m_bPickerViewMode){
        CGRect frame = CGRectMake(0, winHeight-272, viewWidth, 272);
        m_bldProcPickerViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_bldProcPickerViewController.view.frame = CGRectMake(0, winHeight, viewWidth, 272);
        
        [UIView commitAnimations];
        
        m_bPickerViewMode = NO;
    }
    
//    [self.m_bloodnoBarcodeTextField becomeFirstResponder];
}


- (IBAction)onPickerViewMode:(id)sender
{
    TRACE(@"onPickerViewMode");
    if(m_bPickerViewMode){
        TRACE(@"true!");
    }else{
        TRACE(@"false");
    }
    
    if(m_SBBloodnoInfoVO == nil){
        TRACE(@"m_SBBloodnoInfoVO is nil!");
    }else{
        TRACE(@"m_SBBloodnoInfoVO is not nil");
    }
    
    if(m_SBBloodnoInfoVO != nil && !m_bPickerViewMode){
        TRACE(@"picker Up!");
        CGRect frame = CGRectMake(0, winHeight, viewWidth, 272);
        m_bldProcPickerViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_bldProcPickerViewController.view.frame = CGRectMake(0, winHeight-272, viewWidth, 272);
        
        [UIView commitAnimations];
        
        m_bPickerViewMode = YES;
    }
}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}




#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    TRACE(@"hahaha buttonIndex [%ld]", (long)buttonIndex);
    TRACE(@"hahaha buttonIndex [%@]", alertView.title);
    
    if(alertView.tag == kIsSideEffectsInfoActionSheetTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO... to Matching Second Step.
            [self onToSideEffectsView:nil];
        }else{
            
        }
    }
}



#pragma mark - 
#pragma mark UIText/Users/wireline/works/Smart BIMS/Smart BIMS/SBBloodInfoViewController.hFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
//    NSString* strInput = textField.text;
    NSUInteger strLength = textField.text.length;
    NSString* strAlertMsg = @"혈액번호 형식이 틀립니다.";
    
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
//                [m_strBarcodeBloodNo setString:m_bloodnoBarcodeTextField.text];
//                m_bloodnoBarcodeTextField.text = [SBUtils formatBloodNo:
//                                                  [NSString stringWithString:m_strBarcodeBloodNo]];
                [m_bloodnoBarcodeTextField resignFirstResponder];
                [self onSelectBloodnoInfo:nil];
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
    
//    TRACE(@"%@'s length is [%d]", strInput, strInput.length);
    
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


//- (IBAction)bsdValueChanged:(id)sender
//{
//    if(m_bsdSwitch.on == YES){
//        self.m_bsdStatusLabel.text = @"BSD";
//    }else{
//        self.m_bsdStatusLabel.text = @"일반백";
//    }
//}


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
    
    m_bPickerViewMode = NO;
    m_SBBloodnoInfoVO = nil;
    
    m_toFirstMatchingViewButton.hidden = YES;
    m_toMultiMatchingViewButton.hidden = YES;
    m_btnToSideEffectsView.hidden = YES;
    m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
    
    // m_pickerView
    if(m_bldProcPickerViewController == nil){
        m_bldProcPickerViewController = [[SBBldProcPickerViewController alloc] initWithNibName:@"SBBldProcPickerViewController" 
                                                                                        bundle:nil];
    }
    CGRect bldProcPickerViewFrame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_bldProcPickerViewController.view.frame = bldProcPickerViewFrame;
    [self.view addSubview:m_bldProcPickerViewController.view];
    
    [m_bldProcPickerViewController setDelegate:self selector:@selector(setBldProcNamesAndValues:)];
    
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
    
    self.m_titleLabel = nil;
    self.m_idNameLabel = nil;
    
    self.m_bloodnoBarcodeTextField = nil;
    self.m_strBarcodeBloodNo = nil;
    
    self.m_juminLabel = nil;
    self.m_nameLabel = nil;
    // 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
    self.m_bloodCntLabel = nil;
    
    self.m_registerImageView = nil;
    self.m_marrmstImageView = nil;
    
    self.m_heightLabel = nil;
    self.m_weightLabel = nil;
//    self.m_bsdSwitch = nil;
//    
//    self.m_bsdStatusLabel = nil;
    
    self.m_bldprocNames = nil;
    
    self.m_aboNameLabel = nil;
    self.m_absLabel = nil;
    self.m_subLabel = nil;
    
    self.m_hematoLabel = nil;
    self.m_plateletLabel = nil;
    
    self.m_searchButton = nil;
    self.m_toFirstMatchingViewButton = nil;
    self.m_cancelButton = nil;
    self.m_toMultiMatchingViewButton = nil;
    self.m_btnToSideEffectsView = nil;
    
    self.m_activityIndicatorView = nil;
    
//    self.m_strSubViewId = nil;
    
//    self.m_bldProcPickerViewController = nil;
//    self.m_firstMatchingViewController = nil;
    TRACE(@"SBBloodinfoViewController viewDidUnload Occurred");

}


- (void)viewDidDisappear:(BOOL)animated
{
    TRACE(@"SBBloodInfoViewController viewDidDisappear occurred");
}


- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBBloodnoInfoVO release];
    [m_SBUserInfoVO release];
    
    [m_titleLabel release];
    [m_idNameLabel release];

    [m_bloodnoBarcodeTextField release];
    [m_strBarcodeBloodNo release];
    
    [m_juminLabel release];
    [m_nameLabel release];
    // 2022.04.28 ADD HMWOO 헌혈자 헌혈 횟수 추가
    [m_bloodCntLabel release];
    
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
    
    [m_searchButton release];
    [m_toFirstMatchingViewButton release];
    [m_cancelButton release];
    [m_toMultiMatchingViewButton release];
    [m_btnToSideEffectsView release];
    
    [m_activityIndicatorView release];
    
    [m_bldProcPickerViewController release];
    [m_firstMatchingViewController release];
    
    TRACE(@"SBBloodInfoViewController dealloc occurred");
    
//    [m_strSubViewId release];
    
    [m_gbMal release];
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
