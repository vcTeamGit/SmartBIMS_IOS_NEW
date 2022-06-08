//
//  SBLoginViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBLoginViewController.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBUserInfoVO.h"
#import "MainViewController.h"
#import "SBDeviceConfirmViewController.h"
#import "SBLoginMgrListViewController.h"

#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

@implementation SBLoginViewController

@synthesize m_textFieldId;
@synthesize m_textFieldPassword;
@synthesize m_loginButton;
@synthesize m_activityIndicatorView;
@synthesize m_httpRequest;
@synthesize m_SBUserInfoVO;
@synthesize m_MainViewController;

@synthesize m_SBDeviceConfirmViewController;
@synthesize m_SBLoginMgrListViewController;

@synthesize m_strVersion;

//@synthesize m_dictionary;


- (IBAction)loginButtonPressed:(id)sender
{
    NSString* strId = m_textFieldId.text;
    NSString* strPassword = m_textFieldPassword.text;
    
    // 2022.06.08 ADD HMWOO 테스트 대응 바코드 생성 URL 실행
    #if TARGET==DEV
        if([m_textFieldId.text isEqualToString:@"Z999999Z"])
        {
            NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@", @"http://", BLOOD_SERVER, SERVER_TARGET, @"/SBCreateTestBarCode.jsp"]];
            [[UIApplication sharedApplication] openURL:url];
        }
    #endif
    
    if(strId == nil || [strId isEqualToString:@""]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"아이디를 입력하세요"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = 0;
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if(strPassword == nil || [strPassword isEqualToString:@""]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"비밀번호를 입력하세요"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = 0;
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    [self backgroundTab:nil];
    
    NSString* url = URL_IDPW_LOGIN;
    
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                strId, @"strUserId",
                                strPassword, @"strPassword",
                                nil];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveResponse:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];

    [m_activityIndicatorView startAnimating];
}



- (void) didReceiveResponse:(id)result
{
    NSString* strRetVal = @"";
//    NSString* strAlertMsg = @"";
    NSString* string = (NSString*)result;
    
    // For test
    TRACE(@"#####[%@]", string);
    
    string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    [self stopActivityIndicatorView];
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:string error:nil];
    
    // 결과 출력
//    NSString* key;
//    for (key in dictionary) {
////        NSLog(@"Key: %@, Value: %@", key, [dictionary valueForKey:key]);
//    }
    
    strRetVal = [dictionary valueForKey:@"result"];
    
    // json parsing section end.
    
    if([strRetVal isEqualToString: @"1"]){
        
        NSString* strVersion = (NSString*)[dictionary valueForKey:@"version"];
        NSString* tempVersion = [NSString stringWithFormat:@"%@", kProgramVersionInfo];
        NSString* strDeptCode = (NSString*)[dictionary valueForKey:@"bims_deptcode"];
        
        // 버전체크.
        if([strVersion isEqualToString:tempVersion] == NO){
            
            NSString* strMsg = [NSString stringWithFormat:@"Smart BIMS가 버전 [%@]로 업데이트되었습니다.\n현재 사용 중이신 버전은 [%@]입니다.\nMDM 계정(아이디)를 확인하신 후 혈액전산팀(02-3705-8449)로 업그레이드를 요청하세요.", strVersion, tempVersion];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
//            alertView.tag = 1;
            
            [alertView show];
            [alertView release];
            
            return;
        }
        
        // 운영편성정보가 2곳 이상인지 확인.
        int nMgrCnt = [(NSString*)[dictionary valueForKey:@"nMgrCnt"] intValue];
        NSString* strMgrData = (NSString*)[dictionary valueForKey:@"strMgrData"];
        
        if([strDeptCode isEqualToString:@"250"] == NO && [strDeptCode isEqualToString:@"251"] == NO && [strDeptCode isEqualToString:@"252"] == NO && [strDeptCode isEqualToString:@"210"] == NO && [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"R2011202"] == NO && [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2019038"] == NO && [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"R2011202"] == NO && [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"R2020045"] == NO &&
           [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2022059"] == NO &&
           [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2022001"] == NO)
        {
            NSString* strMsg = [NSString stringWithFormat:@"SmartBIMS는 간호팀 또는 의무관리실(편성된) 직원이 이용 가능합니다."];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            //            alertView.tag = 1;
            
            [alertView show];
            [alertView release];
            
            return;
        }

        if(nMgrCnt > 1)
        {
            m_SBUserInfoVO.szBimsId = (NSString*)[dictionary valueForKey:@"bims_id"];
            m_SBUserInfoVO.szBimsName = (NSString*)[dictionary valueForKey:@"bims_name"];
            m_SBUserInfoVO.szBimsPwd = (NSString*)[dictionary valueForKey:@"bims_pwd"];
            m_SBUserInfoVO.szBimsPgLimt = (NSString*)[dictionary valueForKey:@"bims_pglimit"];
            m_SBUserInfoVO.szBimsOrgcode = (NSString*)[dictionary valueForKey:@"bims_orgcode"];
            m_SBUserInfoVO.szBimsOrgname = (NSString*)[dictionary valueForKey:@"bims_orgname"];
            m_SBUserInfoVO.szBimsDeptcode = (NSString*)[dictionary valueForKey:@"bims_deptcode"];
            m_SBUserInfoVO.szBimsDeptname = (NSString*)[dictionary valueForKey:@"bims_deptname"];
            // 장소코드와 차량코드는 편성계정을 선택한 후에 담는다.
            m_SBUserInfoVO.szBimsDeptorders = (NSString*)[dictionary valueForKey:@"bims_deptorders"];
            
            NSArray* tempMgrDataArray = [strMgrData componentsSeparatedByString:@"|"];
            
//            TRACE(@"nMgrCnt := [%@]", (NSString*)[m_dictionary valueForKey:@"nMgrCnt"]);
//            TRACE(@"strMgrData := [%@]", (NSString*)[m_dictionary valueForKey:@"strMgrData"]);
            
            if(m_SBLoginMgrListViewController != nil){
                m_SBLoginMgrListViewController = nil;
            }
            
            if(winHeight == kWINDOW_HEIGHT){
                m_SBLoginMgrListViewController = [[SBLoginMgrListViewController alloc] initWithNibName:@"SBLoginMgrListViewController"
                                                                                                bundle:nil];
            }else{
                m_SBLoginMgrListViewController = [[SBLoginMgrListViewController alloc] initWithNibName:@"SBLoginMgrListViewController3"
                                                                                                bundle:nil];
            }
            
            m_SBLoginMgrListViewController.m_array = tempMgrDataArray;
            [m_SBLoginMgrListViewController setDelegate:self selector:@selector(didSelectMgrSiteCode:)];
            
            CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
            m_SBLoginMgrListViewController.view.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            m_SBLoginMgrListViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:m_SBLoginMgrListViewController.view];
            
            [UIView commitAnimations];
            
//            [tempMgrDataArray release];
        }
        else if(nMgrCnt == 0)
        {
//            2013.05.23 교육을 위해 운영반편성표 체크 조건을 잠시 풀어둠. - 다시 막았어~~~ 시범실시 기간이 지났거든~~~
            if([(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"R2011202"] == YES || [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2018133"] == YES || [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"R2011202"] == YES ||
                [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2019038"] == YES ||
               [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2022001"] == YES ||
               [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"R2020045"] == YES ||
               [(NSString*)[dictionary valueForKey:@"bims_id"] isEqualToString:@"Z2022059"] == YES
               ){
                
                m_SBUserInfoVO.szBimsId = (NSString*)[dictionary valueForKey:@"bims_id"];
                m_SBUserInfoVO.szBimsName = (NSString*)[dictionary valueForKey:@"bims_name"];
                m_SBUserInfoVO.szBimsPwd = (NSString*)[dictionary valueForKey:@"bims_pwd"];
                m_SBUserInfoVO.szBimsPgLimt = (NSString*)[dictionary valueForKey:@"bims_pglimit"];
                m_SBUserInfoVO.szBimsOrgcode = (NSString*)[dictionary valueForKey:@"bims_orgcode"];
                m_SBUserInfoVO.szBimsOrgname = (NSString*)[dictionary valueForKey:@"bims_orgname"];
                m_SBUserInfoVO.szBimsDeptcode = (NSString*)[dictionary valueForKey:@"bims_deptcode"];
                m_SBUserInfoVO.szBimsDeptname = (NSString*)[dictionary valueForKey:@"bims_deptname"];
                m_SBUserInfoVO.szBimsSitecode = (NSString*)[dictionary valueForKey:@"bims_sitecode"];
                m_SBUserInfoVO.szBimsSitename = (NSString*)[dictionary valueForKey:@"bims_sitename"];
                m_SBUserInfoVO.szBimsCarcode = (NSString*)[dictionary valueForKey:@"bims_carcode"];
                m_SBUserInfoVO.szBimsCarname = (NSString*)[dictionary valueForKey:@"bims_carname"];
                m_SBUserInfoVO.szBimsDeptorders = (NSString*)[dictionary valueForKey:@"bims_deptorders"];
                
                if([m_SBUserInfoVO.szBimsId isEqualToString:m_textFieldId.text])
                {
                    [self goMainView];     
                }
            }else{
                NSString* strMsg = [NSString stringWithFormat:@"금일 운영반편성표에 편성정보가 없습니다."];
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                    message:strMsg
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                //            alertView.tag = 1;
                
                [alertView show];
                [alertView release];
                
                return;
            }
        }
        else
        {
            m_SBUserInfoVO.szBimsId = (NSString*)[dictionary valueForKey:@"bims_id"];
            m_SBUserInfoVO.szBimsName = (NSString*)[dictionary valueForKey:@"bims_name"];
            m_SBUserInfoVO.szBimsPwd = (NSString*)[dictionary valueForKey:@"bims_pwd"];
            m_SBUserInfoVO.szBimsPgLimt = (NSString*)[dictionary valueForKey:@"bims_pglimit"];
            m_SBUserInfoVO.szBimsOrgcode = (NSString*)[dictionary valueForKey:@"bims_orgcode"];
            m_SBUserInfoVO.szBimsOrgname = (NSString*)[dictionary valueForKey:@"bims_orgname"];
            m_SBUserInfoVO.szBimsDeptcode = (NSString*)[dictionary valueForKey:@"bims_deptcode"];
            m_SBUserInfoVO.szBimsDeptname = (NSString*)[dictionary valueForKey:@"bims_deptname"];
            m_SBUserInfoVO.szBimsSitecode = (NSString*)[dictionary valueForKey:@"bims_sitecode"];
            m_SBUserInfoVO.szBimsSitename = (NSString*)[dictionary valueForKey:@"bims_sitename"];
            m_SBUserInfoVO.szBimsCarcode = (NSString*)[dictionary valueForKey:@"bims_carcode"];
            m_SBUserInfoVO.szBimsCarname = (NSString*)[dictionary valueForKey:@"bims_carname"];
            m_SBUserInfoVO.szBimsDeptorders = (NSString*)[dictionary valueForKey:@"bims_deptorders"];
            
            if([m_SBUserInfoVO.szBimsId isEqualToString:m_textFieldId.text])
            {
                [self goMainView];
            }

        }
    }else{
        if([string isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
            TRACE(@"#####[%@]", kREQUEST_TIMEOUT_MSG);
            
            NSString* strMsg = [NSString stringWithFormat:@"%@\n%@", @"로그인 실패", kREQUEST_TIMEOUT_MSG];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            alertView.tag = -9;
            
            [alertView show];
            [alertView release];
        }else{
            NSString* strMsg = [NSString stringWithFormat:@"%@\n%@", @"로그인 실패", @"아이디와 비밀번호를 확인하세요"];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            alertView.tag = -9;
            
            [alertView show];
            [alertView release];
        }
    }
}


- (void) goMainView
{
    if(m_SBDeviceConfirmViewController != nil){
        [m_SBDeviceConfirmViewController removeFromParentViewController];
    }
    
    if(winHeight == kWINDOW_HEIGHT){
        m_MainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController"
                                                                    bundle:nil];
    }else{
        m_MainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController3"
                                                                    bundle:nil];
    }
    
    m_MainViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    [m_MainViewController setDelegate:self selector:@selector(pageReset)];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_MainViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_MainViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_MainViewController.view];
    
    [UIView commitAnimations];
    
    [SBUtils playAlertSystemSoundWithSoundType:SOUND_APPEARED];
}


- (void)didSelectMgrSiteCode:(id)obj
{
    if(obj == nil){
        CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
        m_SBLoginMgrListViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_SBLoginMgrListViewController.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
        
        [UIView commitAnimations];
        
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(didNotSelectMgrSiteCodeCB)
                                       userInfo:nil
                                        repeats:NO];
    }else{
        NSString* strMgrDetailData = (NSString*)obj;
        NSArray* tempMgrDetailDataArray = [strMgrDetailData componentsSeparatedByString:@":"];
        
        if([tempMgrDetailDataArray count] > 0){
            m_SBUserInfoVO.szBimsSitecode = [tempMgrDetailDataArray objectAtIndex:0];
            m_SBUserInfoVO.szBimsSitename = [tempMgrDetailDataArray objectAtIndex:1];
            m_SBUserInfoVO.szBimsCarcode = [tempMgrDetailDataArray objectAtIndex:2];
            m_SBUserInfoVO.szBimsCarname = [tempMgrDetailDataArray objectAtIndex:3];
            
            CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
            m_SBLoginMgrListViewController.view.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            m_SBLoginMgrListViewController.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
            
            [UIView commitAnimations];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(didSelectMgrSiteCodeCB)
                                           userInfo:nil
                                            repeats:NO];
        }else{
            return;
        }
    }
}


- (void)didSelectMgrSiteCodeCB
{
    [m_SBLoginMgrListViewController.view removeFromSuperview];
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:m_textFieldId.text])
    {
        [self goMainView];
    }
}


- (void)didNotSelectMgrSiteCodeCB
{
    [m_SBLoginMgrListViewController.view removeFromSuperview];
    [self pageReset];
}


- (void) stopActivityIndicatorView
{
    [self.m_activityIndicatorView stopAnimating];
}


- (void)backgroundTab:(id)sender
{    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    
//    if([[UIDevice currentDevice].systemVersion floatValue] < 7){
//        self.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
//    }else{
//        self.view.frame = CGRectMake(0, 20, viewWidth, viewHeight);
//    }
//    
//    [UIView commitAnimations];
    
    [m_textFieldId resignFirstResponder];
    [m_textFieldPassword resignFirstResponder];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        
        // 2022.05.04 ADD HMWOO 죽은 소스로 확인됨 더이상 사용되지 않고 해당 was 서버 내 아래와 같은 페이지도 존재하지 않음
        NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/pages/appstore/SBIndex.jsp";
        NSString* command = [[NSString stringWithString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:command]];

    }
}

- (void) pageReset
{
    m_textFieldId.text = @"";
    m_textFieldPassword.text = @"";
    
    [m_textFieldId becomeFirstResponder];
}



#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string 
{ 
    NSInteger nTag = textField.tag;
    NSString* strInput = @"";
    
    strInput = [textField.text stringByReplacingCharactersInRange:range 
                                                       withString:string];
    
    switch(nTag){
        case kIdTextFieldTagIndex :
            if(strInput.length > 10){
                return NO;
            }else{
                self.m_textFieldId.text = [textField.text uppercaseString];
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
//    NSString* strInput = textField.text;
    NSUInteger strLength = textField.text.length;
    NSString* strAlertMsg = @"";
    
    switch(nTag){
        case kIdTextFieldTagIndex :
            if(strLength <= 0){
                strAlertMsg = @"아이디를 입력하세요.";
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:strAlertMsg
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else{
                self.m_textFieldId.text = [textField.text uppercaseString];
                
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:0.5];
//                
//                self.view.frame = CGRectMake(0, -50, viewWidth, viewHeight);
//                
//                [UIView commitAnimations];
                
                [self.m_textFieldPassword becomeFirstResponder];
            }
            break;
        case kPwTextFieldTagIndex :
            if(strLength <= 0){
                strAlertMsg = @"패스워드를 입력하세요.";
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:strAlertMsg
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else{
                [self loginButtonPressed:nil];
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
    
    // 2022.06.07 ADD HMWOO 테스트 대응 아이디 비밀번호
    #if TARGET==DEV
        self.m_textFieldId.text = @"Z9999999";
        self.m_textFieldPassword.text = @"P@ssw0rd!";
    #endif
    
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
    m_SBUserInfoVO = [[SBUserInfoVO alloc] init];
    
    [self.m_textFieldPassword setSecureTextEntry:YES];
    
    [self.m_textFieldId becomeFirstResponder];
    
#ifdef WIRELINE_AUTO_LOGIN_MODE // 자동로그인
    //self.m_textFieldId.text = @"R2020045";
    //self.m_textFieldPassword.text = @"nk413#910";
    [self loginButtonPressed:nil];
#endif
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.m_textFieldId = nil;
    self.m_textFieldPassword = nil;
    self.m_loginButton = nil;
    self.m_activityIndicatorView = nil;
    self.m_httpRequest = nil;
    
    self.m_SBUserInfoVO = nil;
//    self.m_MainViewController = nil;
}

- (void)dealloc
{
    [m_httpRequest release];
    
    [m_textFieldId release];
    [m_textFieldPassword release];
    [m_loginButton release];
    [m_activityIndicatorView release];
    
    [m_SBUserInfoVO release];
    [m_MainViewController release];
    [m_SBDeviceConfirmViewController release];
    [m_SBLoginMgrListViewController release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
