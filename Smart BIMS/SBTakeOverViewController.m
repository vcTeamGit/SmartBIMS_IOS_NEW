//
//  SBTakeOverViewController.m
//  SmartBIMS
//
//  Created by wireline on 2017. 8. 24..
//
//

#import "SBTakeOverViewController.h"

#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

@interface SBTakeOverViewController ()

@end

@implementation SBTakeOverViewController

@synthesize m_SBUserInfoVO;
@synthesize m_activityIndicatorView;
@synthesize m_scrollView;
@synthesize m_contentView;

@synthesize m_spcSampleTextField;
@synthesize m_spcSampleTextField2;
@synthesize m_enrSampleTextField;
@synthesize m_etcSampleTextField;
@synthesize m_hrgSampleTextField;
@synthesize m_hrgSampleTextField2;
@synthesize m_hbvSampleTextField;
@synthesize m_marSampleTextField;

@synthesize m_rhnEmergencySampleTextField;

@synthesize m_icepackTextField;
@synthesize m_coolantTextField;

@synthesize m_target;
@synthesize m_selector;

// page2
@synthesize m_secondView;
@synthesize m_scrollView2;
@synthesize m_contentView2;

@synthesize m_nowTimeLabel2;

@synthesize m_takeSeqLabel2;
@synthesize m_bloodCntLabel2;
//@synthesize m_spcCntLabel2;
@synthesize m_bloodSampleTextField2;
@synthesize m_paperCntLabel2;
@synthesize m_ePaperCntLabel2;
@synthesize m_assignedBloodCntLabel2;
@synthesize m_rhnEmergencyBloodCntLabel2;
@synthesize m_unfitPaperCntTextField2;
@synthesize m_eUnfitPaperCntTextField2;
@synthesize m_mal1Label2;
@synthesize m_mal1Label2_NotWB;
@synthesize m_sumOfMal;
//@synthesize m_mal3Label2;
@synthesize m_bloodBoxCntTextField2;
@synthesize m_activityIndicatorView2;

@synthesize m_mDataArray;

// 수거자 인증
@synthesize m_takerCertView;
@synthesize m_takerUserIdNoTextField;
@synthesize m_takerPasswordTextField;
@synthesize m_takerActivityIndicatorView;
@synthesize m_takerInfoLabel;

@synthesize m_takerIdNoLabel;

@synthesize m_remarksView;
@synthesize m_remarksTextView;
@synthesize m_remarksButton;

@synthesize m_bldPaperCntTextField;
@synthesize m_e_bldPaperCntTextField;
@synthesize m_unfitPaperCntTextField;
@synthesize m_totalbldSampleTextField;
@synthesize m_e_unfitPaperCntTextField;
@synthesize m_bldBoxCntTextField;
@synthesize m_bloodcnt1;

@synthesize numOfRBC320;
@synthesize numOfRBC400;
@synthesize numOFFRBC;
@synthesize numOFAPLT;
@synthesize numOFPLA;
@synthesize numOFPLTAM;
@synthesize numOFPLAM;
@synthesize numOF400D;
@synthesize numOF400Q;

#pragma mark -
#pragma mark Custom methods

- (void) setDelegate:(id)target selector:(SEL)selector
{
    
}

- (IBAction)pageReset:(id)sender
{

    
//    self.m_spcSampleTextField.text = @"";
//    self.m_spcSampleTextField2.text = @"";
//    self.m_enrSampleTextField.text = @"";
//    self.m_etcSampleTextField.text = @"";
//    self.m_hrgSampleTextField.text = @"";
//    self.m_hrgSampleTextField2.text = @"";
//    self.m_hbvSampleTextField.text = @"";
//    self.m_marSampleTextField.text = @"";
//    self.m_rhnEmergencySampleTextField.text = @"";
//    self.m_icepackTextField.text = @"";
//    self.m_coolantTextField.text = @"";
    
 //   [self pageReset2:nil];
    
//    [self scrollContentView:@"DEFAULT"];
//    [self backgroundTab:nil];
}

- (IBAction)pageReset2:(id)sender
{
//    self.m_takeSeqLabel2.text = @"N";
//    self.m_bloodCntLabel2.text = @"";
//    self.m_bloodSampleTextField2.text = @"";
//    self.m_paperCntLabel2.text = @"";
//    self.m_ePaperCntLabel2.text = @"";
//
//    self.m_assignedBloodCntLabel2.text = @"";
//    self.m_rhnEmergencyBloodCntLabel2.text = @"";
//    self.m_unfitPaperCntTextField2.text = @"";
//    self.m_eUnfitPaperCntTextField2.text = @"";
//
//    self.m_mal1Label2.text = @"";
//
//    self.m_bloodBoxCntTextField2.text = @"";
//
//    self.m_takerInfoLabel.text = @"미확인";
//    self.m_takerIdNoLabel.text = @"";
//    self.m_takerUserIdNoTextField.text = @"";
//    self.m_takerPasswordTextField.text = @"";
//
//    self.m_remarksTextView.text = @"";
//    [self.m_remarksButton setTitleColor:UIColor.grayColor forState:normal];
    
    [self scrollContentView2:@"DEFAULT"];
}

- (IBAction)onHomeButtonTab:(id)sender
{
    [self backgroundTab:nil];
    [self backgroundTab2:nil];
    
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
    [self.view removeFromSuperview];
}

- (IBAction)onBack:(id)sender
{
    if(self.m_contentView2.alpha < 1.0){
        CGFloat alpha = 1.0;
        [self.m_contentView2 setAlpha:alpha];
        
        [self.m_takerUserIdNoTextField resignFirstResponder];
        [self.m_takerPasswordTextField resignFirstResponder];
        
        CGRect frame = CGRectMake(8, 51, 304, 172);
        
        self.m_takerCertView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.m_takerCertView.frame = CGRectMake(8, winHeight, 304, 172);
        
        [UIView commitAnimations];
        
        [self.m_remarksTextView resignFirstResponder];
        
        frame = CGRectMake(8, 51, 304, 172);
        
        self.m_remarksView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.m_remarksView.frame = CGRectMake(8, winHeight, 304, 172);
        
        [UIView commitAnimations];
        
//        [NSTimer scheduledTimerWithTimeInterval:0.5
//                                         target:self
//                                       selector:@selector(onBackSelector)
//                                       userInfo:nil
//                                        repeats:NO];
    }else{
        [self.m_bloodBoxCntTextField2 resignFirstResponder];
        [self scrollContentView2:@"DEFAULT"];
        
        CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
        self.m_secondView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.m_secondView.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
        
        [UIView commitAnimations];
    }
}


- (void)onBackSelector
{
    [self.m_bloodBoxCntTextField2 resignFirstResponder];
    [self scrollContentView2:@"DEFAULT"];
    
    
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.m_secondView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.m_secondView.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    
    [UIView commitAnimations];
}


- (IBAction)onHomeButtonTabFromSecondView:(id)sender
{
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(onToHomeViewFromSecondViewSelector)
                                   userInfo:nil
                                    repeats:NO];
}


- (void)onToHomeViewFromSecondViewSelector
{
    self.m_secondView.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    [self.view removeFromSuperview];
}


- (IBAction)backgroundTab:(id)sender
{
    [self.m_spcSampleTextField resignFirstResponder];
    [self.m_spcSampleTextField2 resignFirstResponder];
    [self.m_enrSampleTextField resignFirstResponder];
    [self.m_etcSampleTextField resignFirstResponder];
    [self.m_hrgSampleTextField resignFirstResponder];
    [self.m_hrgSampleTextField2 resignFirstResponder];
    [self.m_hbvSampleTextField resignFirstResponder];
    [self.m_marSampleTextField resignFirstResponder];
    [self.m_rhnEmergencySampleTextField resignFirstResponder];
    [self.m_icepackTextField resignFirstResponder];
    [self.m_coolantTextField resignFirstResponder];
    
    // 추가 사항 resign
    [self.m_totalbldSampleTextField resignFirstResponder];
    [self.m_bldPaperCntTextField resignFirstResponder];
    [self.m_e_bldPaperCntTextField resignFirstResponder];
    [self.m_unfitPaperCntTextField resignFirstResponder];
    [self.m_e_unfitPaperCntTextField resignFirstResponder];
    [self.m_bldBoxCntTextField resignFirstResponder];
    [self scrollContentView:@"DEFAULT"];
}


- (void)scrollContentView:(NSString*)strPosition
{
    CGRect bounds = m_scrollView.bounds;
    
    if([strPosition isEqualToString:@"UP"]){
        bounds.origin.x = 0;
        bounds.origin.y = 226;
    }else{
        bounds.origin.x = 0;
        bounds.origin.y = 0;
    }
    
    [m_scrollView scrollRectToVisible:bounds animated:YES];
}

// 두번째 화면에서 바탕을 클릭했을 시 이벤트
- (IBAction)backgroundTab2:(id)sender
{
    if(self.m_contentView2.alpha < 1.0){
        CGFloat alpha = 1.0;
        [self.m_contentView2 setAlpha:alpha];
        
        TRACE(@"takerCertView origin.y: %f", self.m_takerCertView.frame.origin.y);
        
        if(self.m_takerCertView.frame.origin.y < 60){
            [self.m_takerUserIdNoTextField resignFirstResponder];
            [self.m_takerPasswordTextField resignFirstResponder];
            
            CGRect frame = CGRectMake(8, 51, 304, 172);
            
            self.m_takerCertView.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            self.m_takerCertView.frame = CGRectMake(8, winHeight, 304, 172);
            
            [UIView commitAnimations];
        }
        
        if(self.m_remarksView.frame.origin.y < 60){
            // 특이사항 초기화(데이터는 남겨둡시다)
            TRACE(@"remarksTextView.text.length [%lu]", (unsigned long)m_remarksTextView.text.length);
            if(m_remarksTextView.text.length > 0){
                m_remarksButton.tintColor = UIColor.redColor;
                [self.m_remarksButton setTitleColor:UIColor.redColor forState:normal];  //버튼 라벨 색상 입력
            }else{
                m_remarksButton.tintColor = UIColor.grayColor;
                [self.m_remarksButton setTitleColor:UIColor.grayColor forState:normal];  //버튼 라벨 색상 입력
            }
            
            [self.m_remarksTextView resignFirstResponder];
            
            CGRect frame = CGRectMake(8, 51, 304, 197);
            
            self.m_remarksView.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            self.m_remarksView.frame = CGRectMake(8, winHeight, 304, 197);
            
            [UIView commitAnimations];
        }
    }
    [self.m_bloodSampleTextField2 resignFirstResponder];
    [self.m_bloodBoxCntTextField2 resignFirstResponder];
    [self.m_unfitPaperCntTextField2 resignFirstResponder];
    [self.m_eUnfitPaperCntTextField2 resignFirstResponder];
    
    [self scrollContentView2:@"DEFAULT"];
}

- (void)scrollContentView2:(NSString*)strPosition
{
    CGRect bounds = m_scrollView2.bounds;
    
    if([strPosition isEqualToString:@"UP"]){
        bounds.origin.x = 0;
        bounds.origin.y = 226;
    }else{
        bounds.origin.x = 0;
        bounds.origin.y = 0;
    }
    
    [m_scrollView2 scrollRectToVisible:bounds animated:YES];
}


#pragma mark -
#pragma mark Second View
- (IBAction)showSecondView:(id)selector
{
    NSString* strAlertMsg = @"";
    
//    if([self.m_totalbldSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"헌혈검체수량을 입력하세요.";}
//    else if([self.m_spcSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"특검검체수량을 입력하세요.";
//    }else if([self.m_enrSampleTextField.text isEqualToString:@""]){
//    strAlertMsg = @"등록검체수량을 입력하세요.";
//    }else if([self.m_etcSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"기타검체수량을 입력하세요.";
//    }else if([self.m_hrgSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"안정성의뢰 검체수량을 입력하세요.";
//    }else if([self.m_hbvSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"연구용검체수량을 입력하세요.";
//    }else if([self.m_marSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"조혈모세포기증 검체수량을 입력하세요.";
//    }else if([self.m_icepackTextField.text isEqualToString:@""]){
//        strAlertMsg = @"아이스팩 수량을 입력하세요.";
//    }else if([self.m_coolantTextField.text isEqualToString:@""]){
//        strAlertMsg = @"PCM 냉매제 수량을 입력하세요.";
//    }
//    else if([self.m_spcSampleTextField2.text isEqualToString:@""]){
//         strAlertMsg = @"특검검체 건수를 입력하세요."; }
//    else if([self.m_hrgSampleTextField2.text isEqualToString:@""]){
//         strAlertMsg = @"안전성의뢰 건수를 입력하세요."; }
//    else if([self.m_rhnEmergencySampleTextField.text isEqualToString:@""]){
//         strAlertMsg = @"RH(-) 긴급검체 수량을 입력하세요."; }
//    else if([self.m_bldPaperCntTextField.text isEqualToString:@""]){
//         strAlertMsg = @"헌혈 기록카드 수량을 입력하세요."; }
//    else if([self.m_e_bldPaperCntTextField.text isEqualToString:@""]){
//         strAlertMsg = @"e-헌혈기록카드 수량을 입력하세요."; }
//    else if([self.m_unfitPaperCntTextField.text isEqualToString:@""]){
//         strAlertMsg = @"부적격 기록카드 수량을 입력하세요."; }
//    else if([self.m_e_unfitPaperCntTextField.text isEqualToString:@""]){
//         strAlertMsg = @"e-부적격 기록카드 수량을 입력하세요."; }
//    else if([self.m_bldBoxCntTextField.text isEqualToString:@""]){
//         strAlertMsg = @"혈액박스 수량을 입력하세요."; }
//
    
    
//    if([self.m_totalbldSampleTextField.text isEqualToString:@""]){
//        strAlertMsg = @"헌혈검체수량을 입력하세요.";
//    }else if([self.m_icepackTextField.text isEqualToString:@""]){
//        strAlertMsg = @"아이스팩 수량을 입력하세요.";
//    }else if([self.m_coolantTextField.text isEqualToString:@""]){
//        strAlertMsg = @"PCM 냉매제 수량을 입력하세요.";
//    }else if([self.m_bldBoxCntTextField.text isEqualToString:@""]){
//         strAlertMsg = @"혈액박스 수량을 입력하세요."; }
//
//    if([strAlertMsg isEqualToString:@""] == NO){
//        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"알림"
//                                                            message:strAlertMsg
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//
//        [alertView show];
//        [alertView release];
//
//        return;
//    }
    
    [self.m_spcSampleTextField resignFirstResponder];
    [self.m_spcSampleTextField2 resignFirstResponder];
    [self.m_enrSampleTextField resignFirstResponder];
    [self.m_etcSampleTextField resignFirstResponder];
    [self.m_hrgSampleTextField resignFirstResponder];
    [self.m_hrgSampleTextField2 resignFirstResponder];
    [self.m_hbvSampleTextField resignFirstResponder];
    [self.m_marSampleTextField resignFirstResponder];
    [self.m_rhnEmergencySampleTextField resignFirstResponder];
    [self.m_icepackTextField resignFirstResponder];
    [self.m_coolantTextField resignFirstResponder];
    
    // 추가 사항 resign
    [self.m_totalbldSampleTextField resignFirstResponder];
    [self.m_bldPaperCntTextField resignFirstResponder];
    [self.m_e_bldPaperCntTextField resignFirstResponder];
    [self.m_unfitPaperCntTextField resignFirstResponder];
    [self.m_e_unfitPaperCntTextField resignFirstResponder];
    [self.m_bldBoxCntTextField resignFirstResponder];
    
    //UI update 202007
    self.m_bloodSampleTextField2.text = [self.m_totalbldSampleTextField.text isEqualToString:@""] == YES ? @"0" : self.m_totalbldSampleTextField.text;
    
    //기록카드
    self.m_paperCntLabel2.text = [self.m_bldPaperCntTextField.text isEqualToString:@""] == YES ? @"0" : self.m_bldPaperCntTextField.text;
    self.m_ePaperCntLabel2.text = [self.m_e_bldPaperCntTextField.text isEqualToString:@""] == YES ? @"0" : self.m_e_bldPaperCntTextField.text;
    
    self.m_unfitPaperCntTextField2.text = [self.m_unfitPaperCntTextField.text isEqualToString:@""] == YES ? @"0" : self.m_unfitPaperCntTextField.text;
    self.m_eUnfitPaperCntTextField2.text = [self.m_e_unfitPaperCntTextField.text isEqualToString:@""] == YES ? @"0" : self.m_e_unfitPaperCntTextField.text;
    // 지정헌혈, 긴급
    //self.m_bloodSampleTextField2.text = self.m_totalbldSampleTextField.text;
    //self.m_bloodSampleTextField2.text = self.m_totalbldSampleTextField.text;
    // 혈액박스
    self.m_bloodBoxCntTextField2.text = [self.m_bldBoxCntTextField.text isEqualToString:@""] == YES ? @"0" : self.m_bldBoxCntTextField.text;
    
    // sumOfMal
    self.m_sumOfMal.text = [NSString stringWithFormat:@"%d",[m_mal1Label2.text intValue] + [m_mal1Label2_NotWB.text intValue]];
    
    self.m_takerCertView.frame = CGRectMake(8, winHeight, 304, 172);
    self.m_remarksView.frame = CGRectMake(8, winHeight, 304, 172);
    
    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);

    self.m_secondView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.m_secondView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    [UIView commitAnimations];
}



- (IBAction)onSearch:(id)sender
{
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"takeOverInfoBySeq";
    
    TRACE(@"onSearch Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"009";
        tempCarCode = @"55";
        tempUserId = @"R2019014";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    
    TRACE(@"onSearch tempUserId [%@]", tempUserId);
    //경로 수정
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/Swift_SBTakeOverBloodRegister.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId,   @"reqId",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                tempUserId,  @"userId",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveTakeOverInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveTakeOverInfo:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
    
    self.m_takerInfoLabel.text = @"미확인";
    self.m_takerIdNoLabel.text = @"";
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    [self.m_activityIndicatorView stopAnimating];
    
    // 현재시간 세팅
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"] autorelease]];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString* strNowDate = [dateFormatter stringFromDate:[NSDate date]];
    
    self.m_nowTimeLabel2.text = strNowDate;
    
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
    
    strRowCnt = [dictionary valueForKey:@"bloodcnt"];
    
    int nListCnt = [strRowCnt intValue];
    
    
    if(nListCnt > 0 && [[dictionary valueForKey:@"bloodcnt2"] intValue] > 0){
        self.m_bloodCntLabel2.text = [dictionary valueForKey:@"bloodcnt2"];    //헌혈검체(다종 수)
        self.m_bloodcnt1.text = [dictionary valueForKey:@"bloodcnt"];
        self.m_totalbldSampleTextField.text = [dictionary valueForKey:@"bloodcnt"];
        
        //self.m_bloodSampleTextField2.text = [dictionary valueForKey:@"bloodcnt"];   //헌혈검체
        //self.m_totalbldSampleTextField.text = [dictionary valueForKey:@"bloodcnt"]; //헌혈검체 입력칸
        
        self.m_takeSeqLabel2.text = [dictionary valueForKey:@"nexttakeoverseq"];
        
        self.m_ePaperCntLabel2.text = [dictionary valueForKey:@"isemi"];
        self.m_e_bldPaperCntTextField.text = [dictionary valueForKey:@"isemi"];
        
        self.m_paperCntLabel2.text = [dictionary valueForKey:@"ispaper"];
        self.m_bldPaperCntTextField.text = [dictionary valueForKey:@"ispaper"];
        
        self.m_assignedBloodCntLabel2.text = [dictionary valueForKey:@"isassigned"];
        self.m_rhnEmergencyBloodCntLabel2.text = [dictionary valueForKey:@"rhnemergency"];
        self.m_mal1Label2.text = [dictionary valueForKey:@"gbmal1"];
        self.m_mal1Label2_NotWB.text = [dictionary valueForKey:@"gbmal2"];
        
        self.numOfRBC320.text = [dictionary valueForKey:@"numOf320T"];
        self.numOfRBC400.text = [dictionary valueForKey:@"numOf400T"];
        self.numOFFRBC.text = [dictionary valueForKey:@"numOf320D"];
        
        self.numOFPLA.text = [dictionary valueForKey:@"numOfPLA"];
        self.numOFAPLT.text = [dictionary valueForKey:@"numOfAPLT"];
        self.numOFPLTAM.text = [dictionary valueForKey:@"numOfAPLTM"];
        self.numOFPLAM.text = [dictionary valueForKey:@"numOfPLAM"];
        
        self.numOF400Q.text = [dictionary valueForKey:@"numOf400Q"];
        self.numOF400D.text = [dictionary valueForKey:@"numOf400D"];
        
//        self.m_mal3Label2.text = [dictionary valueForKey:@"gbmal3"];
    }
    else{
        //self.m_bloodCntLabel2.text = [dictionary valueForKey:@"bloodcnt"];
        self.m_takeSeqLabel2.text = [dictionary valueForKey:@"nexttakeoverseq"];
        //self.m_ePaperCntLabel2.text = [dictionary valueForKey:@"isemi"];
        //self.m_paperCntLabel2.text = [dictionary valueForKey:@"ispaper"];
        
        self.m_totalbldSampleTextField.text = @"0";
        self.m_assignedBloodCntLabel2.text = [dictionary valueForKey:@"isassigned"];
        self.m_rhnEmergencyBloodCntLabel2.text = [dictionary valueForKey:@"rhnemergency"];
        self.m_mal1Label2.text = [dictionary valueForKey:@"gbmal1"];
        self.m_mal1Label2_NotWB.text = [dictionary valueForKey:@"gbmal2"];
        
        self.m_assignedBloodCntLabel2.text = @"0";
        self.m_rhnEmergencyBloodCntLabel2.text = @"0";
        self.m_mal1Label2.text = @"0";
        self.m_mal1Label2_NotWB.text = @"0";
        
        self.m_ePaperCntLabel2.text = [dictionary valueForKey:@"isemi"];
        self.m_e_bldPaperCntTextField.text = [dictionary valueForKey:@"isemi"];
        
        self.m_paperCntLabel2.text = [dictionary valueForKey:@"ispaper"];
        self.m_bldPaperCntTextField.text = [dictionary valueForKey:@"ispaper"];
        
        self.numOfRBC320.text = @"0";
        self.numOfRBC400.text = @"0";
        self.numOFFRBC.text = @"0";
        self.numOFPLA.text = @"0";
        self.numOFAPLT.text = @"0";
        self.numOFPLTAM.text = @"0";
        self.numOFPLAM.text = @"0";
        self.numOF400Q.text = @"0";
        self.numOF400D.text = @"0";
        self.m_bloodcnt1.text = @"0";
        self.m_bloodCntLabel2.text = @"0";
        
//        self.m_mal3Label2.text = [dictionary valueForKey:@"gbmal3"];
        
        
        //self.m_bloodCntLabel2.text = @"1"; // 혈액수량
        //self.m_takeSeqLabel2.text = @"2"; // 수거차수
        //self.m_ePaperCntLabel2.text = @"3"; // e-헌혈기록카드
        //self.m_paperCntLabel2.text = @"4"; // 헌혈 기록카드
        
        //self.m_assignedBloodCntLabel2.text = @"5"; // 지정헌혈
        //self.m_rhnEmergencyBloodCntLabel2.text = @"6"; // rh- 긴급
        //self.m_mal1Label2.text = @"7"; // 말라리아 제한

        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"새로운 수거차수로 등록된 혈액번호가 없습니다\n계속 진행하시겠습니까?"
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        alertView.tag = kIsNoBloodNoAtNewTakeOverSeqTag;
        
        [alertView show];
        [alertView release];
        
        return;
    }
}

- (IBAction)onSave:(id)sender
{
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempSiteCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"takeOverInfoSave";
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"005";
        tempCarCode = @"55";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
    }
    
    tempSiteCode = [NSString stringWithString: m_SBUserInfoVO.szBimsSitecode];
    
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    if([m_spcSampleTextField.text isEqualToString:@""])  m_spcSampleTextField.text = @"0";
    if([m_spcSampleTextField2.text isEqualToString:@""]) m_spcSampleTextField2.text = @"0";
    if([m_enrSampleTextField.text isEqualToString:@""])  m_enrSampleTextField.text = @"0";
    if([m_etcSampleTextField.text isEqualToString:@""])  m_etcSampleTextField.text = @"0";
    if([m_hrgSampleTextField.text isEqualToString:@""])  m_hrgSampleTextField.text = @"0";
    if([m_hrgSampleTextField2.text isEqualToString:@""]) m_hrgSampleTextField2.text = @"0";
    if([m_hbvSampleTextField.text isEqualToString:@""])  m_hbvSampleTextField.text = @"0";
    if([m_marSampleTextField.text isEqualToString:@""])  m_marSampleTextField.text = @"0";
        
    if([m_rhnEmergencySampleTextField.text isEqualToString:@""]) m_rhnEmergencySampleTextField.text = @"0";
    if([m_icepackTextField.text isEqualToString:@""])    m_icepackTextField.text = @"0";
    if([m_coolantTextField.text isEqualToString:@""])    m_coolantTextField.text = @"0";
    if([m_takeSeqLabel2.text isEqualToString:@""])       m_takeSeqLabel2.text = @"0";
    if([m_bloodCntLabel2.text isEqualToString:@""])      m_bloodCntLabel2.text = @"0";
    
    if([m_bloodSampleTextField2.text isEqualToString:@""])  m_bloodSampleTextField2.text = @"0";
    if([m_paperCntLabel2.text isEqualToString:@""])         m_paperCntLabel2.text = @"0";
    if([m_ePaperCntLabel2.text isEqualToString:@""])        m_ePaperCntLabel2.text = @"0";
    if([m_assignedBloodCntLabel2.text isEqualToString:@""]) m_assignedBloodCntLabel2.text = @"0";
    if([m_rhnEmergencyBloodCntLabel2.text isEqualToString:@""]) m_rhnEmergencyBloodCntLabel2.text = @"0";
    
    if([m_unfitPaperCntTextField2.text isEqualToString:@""])  m_unfitPaperCntTextField2.text = @"0";
    if([m_eUnfitPaperCntTextField2.text isEqualToString:@""]) m_eUnfitPaperCntTextField2.text = @"0";
    if([m_mal1Label2.text isEqualToString:@""]) m_mal1Label2.text = @"0";
//    if([m_mal3Label2.text isEqualToString:@""]) m_mal3Label2.text = @"0";
    if([m_bloodBoxCntTextField2.text isEqualToString:@""]) m_bloodBoxCntTextField2.text = @"0";
    
    //m_mal1Label2.text = [NSString stringWithFormat:@"%d",[m_mal1Label2.text intValue] + [m_mal1Label2_NotWB.text intValue]];
    //경로수정
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                tempSiteCode, @"sitecode",
                                tempUserId, @"userId",
                                m_spcSampleTextField.text, @"spcSampleCnt",
                                m_spcSampleTextField2.text, @"spcSampleCnt2",
                                m_enrSampleTextField.text, @"enrSampleCnt",
                                m_etcSampleTextField.text, @"etcSampleCnt",
                                m_hrgSampleTextField.text, @"hrgSampleCnt",
                                m_hrgSampleTextField2.text, @"hrgSampleCnt2",
                                m_hbvSampleTextField.text, @"hbvSampleCnt",
                                m_marSampleTextField.text, @"marSampleCnt",
                                
                                m_rhnEmergencySampleTextField.text, @"rhnEmergencySampleCnt",
                                m_icepackTextField.text, @"icepackCnt",
                                m_coolantTextField.text, @"coolantCnt",
                                m_takeSeqLabel2.text, @"takeOverSeq",
                                m_bloodSampleTextField2.text, @"bloodcnt",     // 헌혈검체
                                
                                //m_totalbldSampleTextField.text, @"bloodCnt",
                                
                                m_bloodSampleTextField2.text, @"bloodSampleCnt",
                                m_paperCntLabel2.text, @"paperCnt",
                                m_ePaperCntLabel2.text, @"ePaperCnt",
                                m_assignedBloodCntLabel2.text, @"assignedBloodCnt",
                                m_rhnEmergencyBloodCntLabel2.text, @"rhnEmergencyBloodCnt",
                                
                                m_unfitPaperCntTextField2.text, @"unfitPaperCnt",
                                m_eUnfitPaperCntTextField2.text, @"eUnfitPaperCnt",
                                [NSString stringWithFormat:@"%d",[m_mal1Label2.text intValue] + [m_mal1Label2_NotWB.text intValue]], @"mal1Cnt",
//                                m_mal3Label2.text, @"mal3Cnt",
                                m_bloodBoxCntTextField2.text, @"bloodBoxCnt",
                                
                                m_takerInfoLabel.text, @"takerInfo",
                                m_takerIdNoLabel.text, @"takerIdNo",
                                m_remarksTextView.text, @"remarks",
                                
                                tempUserId, @"userIdNo",
                                nil];

    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveTakeOverInfoSave:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    
    [self.m_activityIndicatorView2 startAnimating];
}

- (IBAction)saveActionValidation:(id)sender
{
//    if([m_bloodCntLabel2.text isEqualToString:@"0"] == NO
//             && [m_bloodSampleTextField2.text isEqualToString:@""]){
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:@"검체수량을 입력하세요."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//
//
//        [alertView show];
//        [alertView release];
//
//        return;
//    }else
        if(([m_icepackTextField.text isEqualToString:@""] && [m_coolantTextField.text isEqualToString:@""])){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"냉매제 수량을 입력하세요."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
        
    }else{
        [self saveActionValidationTaker];
    }
    
//    if([m_takerInfoLabel.text isEqualToString:@""] || [m_takerIdNoLabel.text isEqualToString:@""]){
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:@"수거자정보가 없습니다. 계속 진행하시겠습니까?"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"아니오"
//                                                  otherButtonTitles:@"예", nil];
//
//        alertView.tag = kSaveActionValidationTag;
//
//        [alertView show];
//        [alertView release];
//
//        return;
//    }else if([m_bloodCntLabel2.text isEqualToString:@"0"] == NO
//             && [m_bloodSampleTextField2.text isEqualToString:@""]){
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:@"검체수량을 입력하세요."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//
//
//        [alertView show];
//        [alertView release];
//
//        return;
//    }else if([m_bloodCntLabel2.text isEqualToString:@"0"] == NO
//             && ([m_icepackTextField.text isEqualToString:@""] && [m_coolantTextField.text isEqualToString:@""])){
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:@"냉매제 수량을 입력하세요."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//
//
//        [alertView show];
//        [alertView release];
//
//        return;
//
//    }else{
//        NSString* strTempMsg = [NSString stringWithFormat:@"검체수량[%@], 아이스팩[%@], 냉매제[%@]를 입력하셨습니다. 저장할까요?", self.m_bloodSampleTextField2.text, self.m_icepackTextField.text, self.m_coolantTextField.text];
//
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:strTempMsg
//                                                           delegate:self
//                                                  cancelButtonTitle:@"아니오"
//                                                  otherButtonTitles:@"예", nil];
//
//        alertView.tag = kSaveActionValidationTag;
//
//        [alertView show];
//        [alertView release];
//
//        return;
//
////        [self onSave:nil];
//    }
}


- (void)saveActionValidationTaker
{
    if([m_takerInfoLabel.text isEqualToString:@"미확인"] || [m_takerIdNoLabel.text isEqualToString:@""]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자정보가 없습니다. 계속 진행하시겠습니까?"
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        alertView.tag = kSaveActionValidationTakerTag;
        
        [alertView show];
        [alertView release];
        
        return;
    }else{
        [self saveActionValidationValue];
    }
}

- (IBAction)getTempSaveData:(UIButton *)sender {
    //  NSInteger intValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"chkTakeOverIsSaved"];
        NSString* tempReqId = @"gettemporarydata";
        NSString* tempTakerUserIdNo = m_SBUserInfoVO.szBimsId;
        
        NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodTemporarySave.jsp";
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    tempReqId,         @"reqId",
                                    tempTakerUserIdNo, @"userid",
                                    nil];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(showTempSaveData:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
        
        [self.m_takerActivityIndicatorView startAnimating];
}

- (void)saveActionValidationValue
{
    //NSString* strTempMsg = [NSString stringWithFormat:@"검체수량[%@], 아이스팩[%@], 냉매제[%@]를 입력하셨습니다. 저장할까요?", self.m_bloodSampleTextField2.text, self.m_icepackTextField.text, self.m_coolantTextField.text];

    
//    if(![self.m_bloodSampleTextField2.text isEqualToString:self.m_bloodcnt1.text])
//    {
//        NSString* strTempMsg2 = [NSString stringWithFormat:@"입력하신 헌혈검체수와 조회된 혈액수가 다릅니다. 계속할까요?\n조회된 혈액 수 :[%@]\n입력하신 헌혈검체 수 : [%@]", self.m_bloodcnt1.text, self.m_bloodSampleTextField2.text];
//
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                            message:strTempMsg2
//                                                           delegate:self
//                                                  cancelButtonTitle:@"아니오"
//                                                  otherButtonTitles:@"예", nil];
//        [alertView show];
//        [alertView release];
//    }
    
    NSMutableString* comp1 = [NSMutableString stringWithString:(self.m_bloodcnt1.text)];
    NSString* comp2 = self.m_bloodCntLabel2.text;
    if([comp1 isEqualToString:comp2] == NO)
    {
        [comp1 appendString:@"("];
        [comp1 appendString:comp2];
        [comp1 appendString:@")"];
    }
    
    NSString* strTempMsg2 = [NSString stringWithFormat:@"혈액[%@]\n 헌혈검체[%@]\n 아이스팩[%@]\n PCM냉매제[%@]\n 혈액박스[%@]\n ---------------\n 안전성검사[%@건 %@개]\n 지정헌혈[%@]\n 조혈모세포[%@]\n 특검[%@건 %@개]\n 말라리아[전혈:%@, 혈장%@]\n를 입력하셨습니다. 저장할까요?", comp1, self.m_bloodSampleTextField2.text,  [self.m_icepackTextField.text isEqualToString:@""] == YES ? @"0" : self.m_icepackTextField.text, [self.m_coolantTextField.text isEqualToString:@""] == YES ? @"0" : self.m_coolantTextField.text,  [self.m_bldBoxCntTextField.text isEqualToString:@""] == YES ? @"0" : self.m_bldBoxCntTextField.text,
    
    [self.m_hrgSampleTextField2.text isEqualToString:@""] == YES ? @"0" : self.m_hrgSampleTextField2.text,
    [self.m_hrgSampleTextField.text isEqualToString:@""] == YES ? @"0" : self.m_hrgSampleTextField.text,
                             
    [self.m_assignedBloodCntLabel2.text isEqualToString:@""] == YES ? @"0" : self.m_assignedBloodCntLabel2.text,
                             
    [self.m_marSampleTextField.text isEqualToString:@""] == YES ? @"0" : self.m_marSampleTextField.text,
                             
    [self.m_spcSampleTextField2.text isEqualToString:@""] == YES ? @"0" : self.m_spcSampleTextField2.text,
    [self.m_spcSampleTextField.text isEqualToString:@""] == YES ? @"0" : self.m_spcSampleTextField.text,
                             
    [self.m_mal1Label2.text isEqualToString:@""] == YES ? @"0" : self.m_mal1Label2.text,
    [self.m_mal1Label2_NotWB.text isEqualToString:@""] == YES ? @"0" : self.m_mal1Label2_NotWB.text];
    
    if(![self.m_bloodSampleTextField2.text isEqualToString:self.m_bloodcnt1.text])
    {
        strTempMsg2 = [strTempMsg2 stringByAppendingFormat:@"\n\n 주의\n입력한 헌혈검체수와\n 조회된 혈액수가 다릅니다!\n조회된 혈액 수 : [%@]\n입력하신 헌혈검체 수 : [%@]", self.m_bloodcnt1.text, self.m_bloodSampleTextField2.text];
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                        message:strTempMsg2
                                                       delegate:self
                                              cancelButtonTitle:@"아니오"
                                              otherButtonTitles:@"예", nil];
    
    alertView.tag = kSaveActionValidationValueTag;
    
    [alertView show];
    [alertView release];
    
    return;
}


- (void)didReceiveTakeOverInfoSave:(id)result
{
    NSString* strData;
    NSString* strRetVal;
    NSString* strResultMsg;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"didReceiveTakeOverInfoSave strData := [%@]", strData);
    
    [self.m_activityIndicatorView2 stopAnimating];
    
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
    
    strRetVal = [dictionary valueForKey:@"result"];
    strResultMsg = [dictionary valueForKey:@"resultmsg"];
    
    if([strRetVal isEqualToString:@"Y"]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"혈액인계 정보가 정상적으로 저장되었습니다"
//                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kTakeOverInfoSaveCompletedTag;
        
        [alertView show];
        [alertView release];
        
//        NSString *key = @"chkTakeOverIsSaved";
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }else if([strRetVal isEqualToString:@"N"]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kTakeOverInfoSaveCompletedTag;
        
        [alertView show];
        [alertView release];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"혈액인계 정보 저장중 오류가 발생하였습니다"
//                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kTakeOverInfoSaveFailTag;
        
        [alertView show];
        [alertView release];
    }
}





#pragma mark -
#pragma mark TakerCertiView
- (IBAction)openTakerCertiView:(id)sender
{
    CGRect frame = CGRectMake(8, winHeight, 304, 172);
    
    self.m_takerCertView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.m_takerCertView.frame = CGRectMake(8, 51, 304, 172);
    
    [UIView commitAnimations];
    
    CGFloat alpha = 0.5;
    [self.m_contentView2 setAlpha:alpha];
    
    [self setFocusTakerUserIdNoTextFieldWithTimer];
}

- (void)setFocusTakerUserIdNoTextFieldWithTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(setFocusTakerUserIdNoTextField)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)setFocusTakerUserIdNoTextField
{
    self.m_takerUserIdNoTextField.text = @"";
    self.m_takerPasswordTextField.text = @"";
    
    [self.m_takerUserIdNoTextField becomeFirstResponder];
}

- (IBAction)doDirectTakerCertify:(UIButton *)sender {
    
    self.m_takerInfoLabel.text = m_SBUserInfoVO.szBimsName;
    self.m_takerIdNoLabel.text = m_SBUserInfoVO.szBimsId;
    [self backgroundTab2:nil];
}


- (IBAction)doTakerCertify:(id)sender
{
    // 수거자 인증요청
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"takerCertify";
    
    TRACE(@"doTakerCertify Occurred!");
    
    if(self.m_takerUserIdNoTextField.text.length <= 4){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자 아이디가 부정확합니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if(self.m_takerPasswordTextField.text.length <= 4){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자 비밀번호가 부정확합니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    NSString* tempTakerUserIdNo = [NSString stringWithString:m_takerUserIdNoTextField.text];
    NSString* tempTakerPassword = [NSString stringWithString:m_takerPasswordTextField.text];
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"005";
        tempCarCode = @"55";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
    }
    
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    TRACE(@"doTakerCertify tempTakerUserIdNo [%@]", tempTakerUserIdNo);
    //경로 수정
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                tempUserId, @"userId",
                                tempTakerUserIdNo, @"takerUserIdNo",
                                tempTakerPassword, @"takerPassword",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveDoTakerCertify:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    
    [self.m_takerActivityIndicatorView startAnimating];
}


- (void)didReceiveDoTakerCertify:(id)result
{
    NSString* strData;
    NSString* strResult;
    NSString* strIdName;
    NSString* strResultMsg;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    [self.m_takerActivityIndicatorView stopAnimating];
    
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
    strIdName = [dictionary valueForKey:@"idname"];
    strResultMsg = [dictionary valueForKey:@"resultmsg"];
    
    // 정상인증이 되면 id가 넘어오고 아니면 'N'
    if([strResult isEqualToString:@"N"]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:strResultMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
    }else{
        TRACE(@"idno:%@", [dictionary valueForKey:@"idno"]);
        self.m_takerInfoLabel.text = [dictionary valueForKey:@"idname"];
        self.m_takerIdNoLabel.text = [dictionary valueForKey:@"idno"];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:strResultMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
    }
    
    [self backgroundTab2:nil];
}



#pragma mark -
#pragma mark RemarksView
- (IBAction)openRemarksView:(id)sender
{
    CGRect frame = CGRectMake(8, winHeight, 304, 172);
    
    self.m_remarksView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.m_remarksView.frame = CGRectMake(8, 51, 304, 172);
    
    [UIView commitAnimations];
    
    CGFloat alpha = 0.5;
    [self.m_contentView2 setAlpha:alpha];
    
    [self setFocusRemarksTextViewWithTimer];
}


- (IBAction)closeRemarksView:(id)sender
{
    TRACE(@"remarksTextView.text.length [%lu]", (unsigned long)m_remarksTextView.text.length);
    if(m_remarksTextView.text.length > 0){
        m_remarksButton.tintColor = UIColor.redColor;
        [self.m_remarksButton setTitleColor:UIColor.redColor forState:normal];  //버튼 라벨 색상 입력
    }else{
        m_remarksButton.tintColor = UIColor.grayColor;
        [self.m_remarksButton setTitleColor:UIColor.grayColor forState:normal];  //버튼 라벨 색상 입력
    }
    [self backgroundTab2:nil];
}

- (void)setFocusRemarksTextViewWithTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(setFocusRemarksTextView)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)setFocusRemarksTextView
{
    [self.m_remarksTextView becomeFirstResponder];
}


- (IBAction)clearRemarksTextView:(id)sender
{
    self.m_remarksTextView.text = @"";
}



#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    //    NSString* strInput = textField.text;
    NSUInteger strLength = textField.text.length;
    
    switch(nTag){
        case kTakerUserIdNoTextFieldTag :
            if(strLength < 4){
                m_takerUserIdNoTextField.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"입력하신 수거자아이디가 너무 짧습니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else{
                self.m_takerUserIdNoTextField.text = [textField.text uppercaseString];
                [m_takerPasswordTextField becomeFirstResponder];
            }
            break;
        case kTakerPasswordTextFieldTag :
            if(strLength < 4){
                m_takerPasswordTextField.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"입력하신 비밀번호가 너무 짧습니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else{
                [self doTakerCertify:nil];
            }
            break;
        default:
            return YES;
    }
 
    return YES;
}

// 입력값 체크
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString*)string
{
//    NSInteger nTag = textField.tag;
//    NSString* strInput = @"";
//
//    strInput = [textField.text stringByReplacingCharactersInRange:range
//                                                       withString:string];
    
    if(textField != self.m_takerUserIdNoTextField && textField != self.m_takerPasswordTextField){
        if (textField.text.length < 3 || string.length == 0){
            
            if([textField.text isEqualToString:@"0"] && range.location > 0)
            {
                return NO;
            }
            
            return YES;
        }
        else{
            return NO;
        }
    }
    
    //    TRACE(@"%@'s length is [%d]", strInput, strInput.length);
    
//    switch(nTag){
//        case kBloodNoTextField :
//            if(strInput.length > 12){
//                return NO;
//            }
//            break;
//        case kAssignedBloodNoTextField :
//            if(strInput.length > 12){
//                return NO;
//            }
//            break;
//        case kRhnEmergencyBloodNoTextField :
//            if(strInput.length > 12){
//                return NO;
//            }
//            break;
//        default:
//            return YES;
//    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    TRACE(@"textFieldShouldBeginEditing occurred!");
    
    NSInteger nTag = textField.tag;
    
    switch(nTag){
        case kSpcSampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kSpcSampleTextFieldTag2 :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kEnrSampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kEtcSampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kHrgSampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kHrgSampleTextFieldTag2 :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kHbvSampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kMarSampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
        case kRhnEmergencySampleTextFieldTag :
            [self scrollContentView:@"DEFAULT"];
            break;
            
        case kIcepackTextFieldTag :
            [self scrollContentView:@"UP"];
            break;
        case kCoolantTextFieldTag :
            [self scrollContentView:@"UP"];
            break;
            
        // page2
        case kbloodBoxCntTextFieldTag :
            [self scrollContentView2:@"UP"];
            break;
        case kspcCntTextFieldTag :
            [self scrollContentView2:@"DEFAULT"];
            break;
        default:
            return YES;
    }
    
    return YES;
}


#pragma mark -
#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    TRACE(@"hahaha buttonIndex [%ld]", (long)buttonIndex);
    TRACE(@"hahaha buttonIndex [%@]", alertView.title);
    
    if(alertView.tag == kTakeOverInfoSaveCompletedTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
        }else{
            [self onHomeButtonTabFromSecondView:nil];
        }
    }else if(alertView.tag == kTakeOverInfoSaveFailTag){
        
    }else if(alertView.tag == kSaveActionValidationTakerTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
//            [self onSave:nil];
            [self saveActionValidationValue];
        }else{
            
        }
    }else if(alertView.tag == kSaveActionValidationValueTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
            [self onSave:nil];
        }else{
            
        }
    }else if(alertView.tag == kIsNoBloodNoAtNewTakeOverSeqTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
        }else{
            [self onHomeButtonTab:nil];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_mDataArray = [[NSMutableArray alloc] initWithCapacity:64];
    
    m_httpRequest = [[HttpRequest alloc] init];
    
    CGSize size;
    size.height = self.m_contentView.frame.size.height;
    size.width = self.m_contentView.frame.size.width;
    
    size.height = 726;
    size.width = 320;
    
    TRACE(@"width : %f, height : %f", size.width, size.height);
    
    self.m_scrollView.contentSize = size;
    
    [self.view addSubview:m_scrollView];
    [m_scrollView addSubview:m_contentView];
    
    CGRect bounds = m_scrollView.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    [m_scrollView scrollRectToVisible:bounds animated:YES];
    
    // page2
    [self.view addSubview:m_secondView];
    
    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    self.m_secondView.frame = frame;
    
    self.m_scrollView2.contentSize = size;
    [self.m_secondView addSubview:m_scrollView2];
    [m_scrollView2 addSubview:m_contentView2];
    
    [m_scrollView2 scrollRectToVisible:bounds animated:YES];
    
    // taker View
    [self.view addSubview:m_takerCertView];
    [self.view addSubview:m_remarksView];
    
    CGRect framet = CGRectMake(8, winHeight, 304, 172);
    self.m_takerCertView.frame = framet;
    
    CGRect framer = CGRectMake(8, winHeight, 304, 197);
    self.m_remarksView.frame = framer;
    
    [self.m_remarksButton setTitleColor:UIColor.grayColor forState:normal];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
    [self textAllReset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)OnTempSave:(id)sender {

    NSString* tempReqId = @"savetemporarydata";
    NSString* tempTakerUserIdNo = m_SBUserInfoVO.szBimsId;
    
    NSString* spcSample2     = [NSString stringWithString:m_spcSampleTextField2.text];
    NSString* spcSample1     = [NSString stringWithString:m_spcSampleTextField.text];
    NSString* enrSample      = [NSString stringWithString:m_enrSampleTextField.text];
    
    NSString* etcSample      = [NSString stringWithString:m_etcSampleTextField.text];
    NSString* hrgSample2     = [NSString stringWithString:m_hrgSampleTextField2.text];
    NSString* hrgSample1     = [NSString stringWithString:m_hrgSampleTextField.text];
    NSString* labSample      = [NSString stringWithString:m_hbvSampleTextField.text];
    NSString* hscsSample     = [NSString stringWithString:m_marSampleTextField.text];
    
    NSString* rhSample       = [NSString stringWithString:m_rhnEmergencySampleTextField.text];
    NSString* unfitPaperCnt  = [NSString stringWithString:m_unfitPaperCntTextField.text];
    NSString* eunfitPaperCnt = [NSString stringWithString:m_e_unfitPaperCntTextField.text];
    NSString* icePack        = [NSString stringWithString:m_icepackTextField.text];
    NSString* PCM            = [NSString stringWithString:m_coolantTextField.text];
    
    NSString* bloodBox       = [NSString stringWithString:m_bldBoxCntTextField.text];
    NSString* remarks        = [NSString stringWithString:m_remarksTextView.text];

    //경로 수정
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodTemporarySave.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId,         @"reqId",
                                tempTakerUserIdNo, @"takerUserIdNo",
                                spcSample2,        @"spcSample2",
                                spcSample1,        @"spcSample1",
                                enrSample,         @"enrSample",
                                etcSample,         @"etcSample",
                                hrgSample2,        @"hrgSample2",
                                hrgSample1,        @"hrgSample1",
                                labSample,         @"labSample",
                                hscsSample,        @"hscsSample",
                                rhSample,          @"rhSample",
                                unfitPaperCnt,     @"unfitPaperCnt",
                                eunfitPaperCnt,    @"enunfitPaperCnt",
                                icePack,           @"icePack",
                                PCM,               @"PCM",
                                bloodBox,          @"bloodBox",
                                remarks,        @"remarks",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveTempSave:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_takerActivityIndicatorView startAnimating];

    return;
}

- (void)didReceiveTempSave:(id)result
{
    NSString* strData;
    NSString* strResult;
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    NSLog(@"strData := [%@]", strData);
    
    [self.m_takerActivityIndicatorView stopAnimating];
    
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
    
    if([strResult isEqualToString:@"Y"]){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"정상적으로 입력값들이 저장되었습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
    }else{
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"오류가 발생하여 정상적으로 저장하지 못하였습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}


- (IBAction)btnReset:(id)sender {
    [self textAllReset];
}

-(void) textAllReset {
    [self.m_spcSampleTextField2 setText:@""];
    [self.m_spcSampleTextField setText:@""];

    [self.m_enrSampleTextField setText:@""];
    [self.m_etcSampleTextField setText:@""];

    [self.m_hrgSampleTextField2 setText:@""];
    [self.m_hrgSampleTextField setText:@""];

    [self.m_hbvSampleTextField setText:@""];
    [self.m_marSampleTextField setText:@""];
    [self.m_rhnEmergencySampleTextField setText:@""];

    //[self.m_bldPaperCntTextField setText:@""];
    //[self.m_e_bldPaperCntTextField setText:@""];
    [self.m_unfitPaperCntTextField setText:@""];
    [self.m_e_unfitPaperCntTextField setText:@""];

    [self.m_icepackTextField setText:@""];
    [self.m_coolantTextField setText:@""];

    [self.m_bldBoxCntTextField setText:@""];
    
    self.m_remarksTextView.text = @"특이사항 없음";
    [self.m_remarksButton setTitleColor:UIColor.grayColor forState:normal];
}

- (void)showTempSaveData:(id)result{
    
    NSString* strData;
    
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
    

    if( [[dictionary valueForKey:@"isexist"] isEqualToString:@"y"] == YES ){
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        NSString* showMessage = [NSString stringWithFormat:@"[%@]에\n임시저장된 데이터가 존재합니다.\n불러오겠습니까?", [dictionary valueForKey:@"enterdate"]];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"[알 림]" message:showMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * yesbutton = [UIAlertAction actionWithTitle:@"아니요" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction * nobutton = [UIAlertAction actionWithTitle:@"네" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.m_spcSampleTextField2.text         = [dictionary valueForKey:@"spcsample2"];
            self.m_spcSampleTextField.text          = [dictionary valueForKey:@"spcsample1"];
            self.m_enrSampleTextField.text          = [dictionary valueForKey:@"enrsample"];
            self.m_etcSampleTextField.text          = [dictionary valueForKey:@"etcsample"];
            self.m_hrgSampleTextField2.text         = [dictionary valueForKey:@"hrgsample2"];
            
            self.m_hrgSampleTextField.text          = [dictionary valueForKey:@"hrgsample1"];
            self.m_hbvSampleTextField.text          = [dictionary valueForKey:@"labsample"];
            self.m_marSampleTextField.text          = [dictionary valueForKey:@"hscssample"];
            self.m_rhnEmergencySampleTextField.text = [dictionary valueForKey:@"rhsample"];
            self.m_unfitPaperCntTextField.text      = [dictionary valueForKey:@"unfitPaperCnt"];
            
            self.m_unfitPaperCntTextField.text      = [dictionary valueForKey:@"unfitpapercnt"];
            self.m_e_unfitPaperCntTextField.text    = [dictionary valueForKey:@"eunfitpapercnt"];
            
            self.m_e_unfitPaperCntTextField.text    = [dictionary valueForKey:@"eunfitpapercnt"];
            self.m_icepackTextField.text            = [dictionary valueForKey:@"icepack"];
            self.m_coolantTextField.text            = [dictionary valueForKey:@"pcm"];
            self.m_bldBoxCntTextField.text          = [dictionary valueForKey:@"bloodbox"];
            self.m_remarksTextView.text             = [dictionary valueForKey:@"remarks"];
            
            
            if([[dictionary valueForKey:@"remarks"] isEqualToString:@"특이사항 없음"] == NO)
            {
                m_remarksButton.tintColor = UIColor.redColor;
                [self.m_remarksButton setTitleColor:UIColor.redColor forState:normal];
            }
        }];
        
        [alert addAction:yesbutton];
        [alert addAction:nobutton];
        [self presentViewController:alert animated:NO completion:nil];
    }
    else{
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        
        NSString* showMessage = [NSString stringWithFormat:@"임시저장된 데이터가 존재하지 않습니다"];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:showMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)dealloc {
    [m_spcSampleTextField2 release];
    [m_spcSampleTextField release];
    [m_enrSampleTextField release];
    [m_etcSampleTextField release];
    [m_hrgSampleTextField2 release];
    [m_hrgSampleTextField release];
    [m_hbvSampleTextField release];
    [m_marSampleTextField release];
    [m_rhnEmergencySampleTextField release];
    [m_unfitPaperCntTextField release];
    [m_e_unfitPaperCntTextField release];
    [m_icepackTextField release];
    [m_coolantTextField release];
    [m_bldBoxCntTextField release];
    [m_remarksTextView release];
    [m_mal1Label2_NotWB release];
    [m_mal1Label2 release];
    [m_sumOfMal release];
    [numOF400D release];
    [super dealloc];
}

@end
