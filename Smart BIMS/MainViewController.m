//
//  MainViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
// 2022.05.19 ADD HMWOO 수거자 등록 대응 VO 파일 추가
#import "SBTakeOverInfoVO.h"
#import "SBUserInfoVO.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBBloodInfoViewController.h"
#import "SBSecondMatchingViewController.h"
#import "SBBloodEndTimeViewController.h"
#import "SBFitnessCheckViewController.h"
#import "SBMgrInfoViewController.h"
#import "SBInfoViewController.h"
#import "SBBloodGatheringListViewController.h"
#import "SBPcResultViewController.h"
#import "SBBoardViewController.h"
#import "SBEtcSrchStaViewController.h"

#import "SBTakeOverActionViewController.h"  // 인계혈액등록
#import "SBTakeOverViewController.h"  // 혈액인계
#import "SBTakeOverInfoViewController.h"  // 혈액인계정보조회

#import "PictureLibViewController.h"
#import "SBPairingBarcodeViewController.h"

#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"
#import "SmartBIMS-Swift.h"

@implementation MainViewController

@synthesize m_SBUserInfoVO;
@synthesize m_httpRequest;

// 2022.05.24 ADD HMWOO 수거자 등록 다이얼 로그 추가
@synthesize layout_dialog_back;
@synthesize dialog_reg_collector;
@synthesize btn_takeover_seq;
@synthesize sp_takeover_seq;
@synthesize et_collector_id;
@synthesize et_collector_pw;
@synthesize takeOverInfoMap;

@synthesize m_orgNameLabel;
@synthesize m_userNameLabel;
@synthesize m_siteNameLabel;

@synthesize m_validTermWBLabel;
@synthesize m_validTermPLTLabel;
@synthesize m_validTermPLLabel;

@synthesize m_boardLabel;


@synthesize m_donorManageButton;
@synthesize m_matching1Button;
@synthesize m_matching2Button;
@synthesize m_endtimeButton;
@synthesize m_bldprocButton;
@synthesize m_infoButton;
@synthesize m_newInfoButton;
@synthesize m_newInfoLabel;

@synthesize m_newBoardListLabel;

//@synthesize m_SBMatching1ViewController;
@synthesize m_SBBloodInfoViewController;
@synthesize m_SBSecondMatchingViewController;
@synthesize m_SBBloodEndTimeViewController;

@synthesize m_SBFitnessCheckViewController;
@synthesize m_SBMgrInfoViewController;
@synthesize m_SBInfoViewController;
@synthesize m_SBBloodGatheringListViewController;
@synthesize m_SBPcResultViewController;

@synthesize m_SBBoardViewController;
@synthesize m_SBEtcSrchStaViewController;

@synthesize m_SBTakeOverActionViewController;
@synthesize m_SBTakeOverViewController;
@synthesize m_SBTakeOverInfoViewController;

@synthesize m_target;
@synthesize m_selector;

@synthesize m_scrollView;
@synthesize m_btnContainerView;
@synthesize m_pageControl;

// For Module Test
@synthesize m_testButton;
@synthesize m_pairingBarcodeButton;
@synthesize m_pictureLibViewController;

@synthesize m_timer;
@synthesize btnOrgTalk;

- (IBAction)logout:(id)sender
{    
    // iOS7부터는 actionSheet를 쓰지 않는다. statusBar와 함께 쓰면 화면이 잘리더라구...
    if([[UIDevice currentDevice].systemVersion floatValue] < 7){
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"로그아웃하시겠습니까?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"아니오"
                                                   destructiveButtonTitle:@"예"
                                                        otherButtonTitles:nil];
        
        actionSheet.tag = kLogoutActionSheetTag;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"로그아웃하시겠습니까?"
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        alertView.tag = kLogoutActionSheetTag;
        
        [alertView show];
        [alertView release];
    }
}

- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}

- (void)logoutAction
{
//    [m_target performSelector:m_selector withObject:dictionary];
    [m_target performSelector:m_selector];
    [self.view removeFromSuperview];
}


- (IBAction)goFitnessCheckView:(id)sender
{
    if(m_SBFitnessCheckViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBFitnessCheckViewController = [[SBFitnessCheckViewController alloc] initWithNibName:@"SBFitnessCheckViewController"
                                                                                            bundle:nil];
        }else{
            m_SBFitnessCheckViewController = [[SBFitnessCheckViewController alloc] initWithNibName:@"SBFitnessCheckViewController3"
                                                                                            bundle:nil];
        }
    }
    
    m_SBFitnessCheckViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
//    [m_SBFitnessCheckViewController setCustomNumberPadConfig];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBFitnessCheckViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBFitnessCheckViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBFitnessCheckViewController.view];
    
    [m_SBFitnessCheckViewController pageReset:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goMatching1View:(id)sender
{
    if(m_SBBloodInfoViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBBloodInfoViewController = [[SBBloodInfoViewController alloc] initWithNibName:@"SBBloodInfoViewController"
                                                                                      bundle:nil];
        }else{
            m_SBBloodInfoViewController = [[SBBloodInfoViewController alloc] initWithNibName:@"SBBloodInfoViewController3"
                                                                                      bundle:nil];
        }
    }else{
        [m_SBBloodInfoViewController release];
        m_SBBloodInfoViewController = nil;
        
        if(winHeight == kWINDOW_HEIGHT){
            m_SBBloodInfoViewController = [[SBBloodInfoViewController alloc] initWithNibName:@"SBBloodInfoViewController"
                                                                                      bundle:nil];
        }else{
            m_SBBloodInfoViewController = [[SBBloodInfoViewController alloc] initWithNibName:@"SBBloodInfoViewController3"
                                                                                      bundle:nil];
        }
    }
    
    [m_SBBloodInfoViewController setDelegate:self selector:@selector(getBoardListCnt)];
    
    m_SBBloodInfoViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBBloodInfoViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBBloodInfoViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBBloodInfoViewController.view];
    
    [m_SBBloodInfoViewController pageReset:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goMatching2View:(id)sender
{
    if(m_SBSecondMatchingViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBSecondMatchingViewController = [[SBSecondMatchingViewController alloc] initWithNibName:@"SBSecondMatchingViewController"
                                                                                                bundle:nil];
        }else{
            m_SBSecondMatchingViewController = [[SBSecondMatchingViewController alloc] initWithNibName:@"SBSecondMatchingViewController3"
                                                                                                bundle:nil];
        }
    }else{
        [m_SBSecondMatchingViewController release];
        m_SBSecondMatchingViewController = nil;
        
        if(winHeight == kWINDOW_HEIGHT){
            m_SBSecondMatchingViewController = [[SBSecondMatchingViewController alloc] initWithNibName:@"SBSecondMatchingViewController"
                                                                                                bundle:nil];
        }else{
            m_SBSecondMatchingViewController = [[SBSecondMatchingViewController alloc] initWithNibName:@"SBSecondMatchingViewController3"
                                                                                                bundle:nil];
        }
    }
    
    [m_SBSecondMatchingViewController setUserInfo:self.m_SBUserInfoVO];
    //[m_SBSecondMatchingViewController pageReset:nil];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBSecondMatchingViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBSecondMatchingViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBSecondMatchingViewController.view];
    
    [m_SBSecondMatchingViewController pageReset:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goEndtimeView:(id)sender
{
    if(m_SBBloodEndTimeViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBBloodEndTimeViewController = [[SBBloodEndTimeViewController alloc] initWithNibName:@"SBBloodEndTimeViewController"
                                                                                            bundle:nil];
        }else{
            m_SBBloodEndTimeViewController = [[SBBloodEndTimeViewController alloc] initWithNibName:@"SBBloodEndTimeViewController3"
                                                                                            bundle:nil];
        }
    }
    
    [m_SBBloodEndTimeViewController setUserInfo:self.m_SBUserInfoVO];
    
    [m_SBBloodEndTimeViewController timerStart];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBBloodEndTimeViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBBloodEndTimeViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBBloodEndTimeViewController.view];
    
    [m_SBBloodEndTimeViewController pageReset:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goMgrInfoView:(id)sender
{
    if(m_SBMgrInfoViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBMgrInfoViewController = [[SBMgrInfoViewController alloc] initWithNibName:@"SBMgrInfoViewController"
                                                                                  bundle:nil];
        }else{
            m_SBMgrInfoViewController = [[SBMgrInfoViewController alloc] initWithNibName:@"SBMgrInfoViewController3"
                                                                                  bundle:nil];
        }
    }
    
    m_SBMgrInfoViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBMgrInfoViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBMgrInfoViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBMgrInfoViewController.view];
    
    [m_SBMgrInfoViewController pageReset:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goNotificationView:(id)sender
{
    if(m_SBBloodGatheringListViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBBloodGatheringListViewController = [[SBBloodGatheringListViewController alloc] initWithNibName:@"SBBloodGatheringListViewController"
                                                                                                        bundle:nil];
        }else{
            m_SBBloodGatheringListViewController = [[SBBloodGatheringListViewController alloc] initWithNibName:@"SBBloodGatheringListViewController3"
                                                                                                        bundle:nil];
        }
    }
    
    m_SBBloodGatheringListViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBBloodGatheringListViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBBloodGatheringListViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBBloodGatheringListViewController.view];
    
    [m_SBBloodGatheringListViewController pageReset];
    
    [UIView commitAnimations];
}


- (IBAction)goInfoView:(id)sender
{
    static UIViewAnimationTransition orders[4] = {
    	UIViewAnimationTransitionCurlDown,
    	UIViewAnimationTransitionCurlUp,
    	UIViewAnimationTransitionFlipFromLeft,
    	UIViewAnimationTransitionFlipFromRight,
    };
    
    if(m_SBInfoViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBInfoViewController = [[SBInfoViewController alloc] initWithNibName:@"SBInfoViewController"
                                                                            bundle:nil];
        }else{
            m_SBInfoViewController = [[SBInfoViewController alloc] initWithNibName:@"SBInfoViewController3"
                                                                            bundle:nil];
        }
        
        [m_SBInfoViewController setDelegate:self selector:@selector(getNewNoticeInfo)];
    }
    
    m_SBInfoViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
//    [m_SBInfoViewController pageReset];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    m_SBInfoViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
	
	[UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:orders[0]
    					   forView:self.view
                             cache:YES];
    
    [self.view addSubview:m_SBInfoViewController.view];
    
    [UIView commitAnimations];
}


- (IBAction)goPcResultView:(id)sender
{
    if(m_SBPcResultViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBPcResultViewController = [[SBPcResultViewController alloc] initWithNibName:@"SBPcResultViewController"
                                                                                    bundle:nil];
        }else{
            m_SBPcResultViewController = [[SBPcResultViewController alloc] initWithNibName:@"SBPcResultViewController3"
                                                                                    bundle:nil];
        }
    }
    
    m_SBPcResultViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
//    [m_SBPcResultViewController setCustomNumberPadConfig];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBPcResultViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBPcResultViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBPcResultViewController.view];
    
    [m_SBPcResultViewController pageReset];
    
    [UIView commitAnimations];
}


- (IBAction)goBoardView:(id)sender
{
    if(m_SBBoardViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBBoardViewController = [[SBBoardViewController alloc] initWithNibName:@"SBBoardViewController"
                                                                              bundle:nil];
        }else{
            m_SBBoardViewController = [[SBBoardViewController alloc] initWithNibName:@"SBBoardViewController3"
                                                                              bundle:nil];
        }
    }
    
    [m_SBBoardViewController setDelegate:self selector:@selector(getBoardListCnt)];
    
    m_SBBoardViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
//    [m_SBBoardViewController pageReset];
//    [m_SBBoardViewController setCustomNumberPadConfig];
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBBoardViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBBoardViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBBoardViewController.view];
    
    [m_SBBoardViewController.m_switch setOn:YES];
    [m_SBBoardViewController onSearch:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goEtcSrchStaView:(id)sender
{
    if(m_SBEtcSrchStaViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBEtcSrchStaViewController = [[SBEtcSrchStaViewController alloc] initWithNibName:@"SBEtcSrchStaViewController"
                                                                                        bundle:nil];

        }else{
            m_SBEtcSrchStaViewController = [[SBEtcSrchStaViewController alloc] initWithNibName:@"SBEtcSrchStaViewController3"
                                                                                        bundle:nil];

        }
    }
    
    m_SBEtcSrchStaViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBEtcSrchStaViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBEtcSrchStaViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBEtcSrchStaViewController.view];

    [m_SBEtcSrchStaViewController onSearch:nil];
    
    [UIView commitAnimations];
}


- (IBAction)goTakeOverActionView:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BloodTakeover" bundle:nil];
    TakeoverBloodRegisterViewController * tvcc = [storyboard
                                                  instantiateViewControllerWithIdentifier:@"TakeoverBloodRegisterViewController"];
    tvcc.m_SBUserInfoVO = m_SBUserInfoVO;
    
    UINavigationController* nav = [[UINavigationController new] initWithRootViewController:tvcc];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController: nav animated: nil completion: nil];
}


- (IBAction)goTakeOverView:(id)sender
{
    if(m_SBTakeOverViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBTakeOverViewController = [[SBTakeOverViewController alloc] initWithNibName:@"SBTakeOverViewController"
                                                                                    bundle:nil];
            
        }else{
            // Not to do...
            //            m_SBEtcSrchStaViewController = [[SBEtcSrchStaViewController alloc] initWithNibName:@"SBEtcSrchStaViewController3"
            //                                                                                        bundle:nil];
            // 예전 아이폰 화면사이즈 지원불가
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:@"이 버전의 아이폰은 지원하지 않습니다"
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            
            [alertView show];
            [alertView release];
            
            return;
        }
    }
    
    m_SBTakeOverViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBTakeOverViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBTakeOverViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBTakeOverViewController.view];
    
    [m_SBTakeOverViewController pageReset:nil];
    [m_SBTakeOverViewController onSearch:nil];
    
    [UIView commitAnimations];
}

- (IBAction)goTakeOverInfoView:(id)sender
{
    if(m_SBTakeOverInfoViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBTakeOverInfoViewController = [[SBTakeOverInfoViewController alloc] initWithNibName:@"SBTakeOverInfoViewController"
                                                                                    bundle:nil];
            
        }else{
            // Not to do...
            //            m_SBTakeOverInfoViewController = [[SBTakeOverInfoViewController alloc] initWithNibName:@"SBTakeOverInfoViewController3"
            //                                                                                        bundle:nil];
            // 예전 아이폰 화면사이즈 지원불가
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:@"이 버전의 아이폰은 지원하지 않습니다"
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            
            [alertView show];
            [alertView release];
            
            return;
        }
    }
    
    m_SBTakeOverInfoViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBTakeOverInfoViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBTakeOverInfoViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBTakeOverInfoViewController.view];
    
    [m_SBTakeOverInfoViewController pageReset:nil];
    [m_SBTakeOverInfoViewController onSearch:nil];
    
    [UIView commitAnimations];
}

// 2022.04.28 ADD HMWOO 수거자 등록 다이얼 로그 추가
- (IBAction)listener_call_reg_collector_dialog:(id)sender
{
    // 2022.05.18 ADD HMWOO 인계정보 조회 URL을 호출하여 수거자가 인계 정보를 확인할 수 있도록 함
    NSString* url = URL_MANAGE_TAKEOVER_INFO;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"getTakeOverInfo", @"reqId",
                                m_SBUserInfoVO.szBimsOrgcode, @"orgcode",
                                m_SBUserInfoVO.szBimsCarcode, @"carcode",
                                nil];

    [SBUtils showLoading];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveTakeOverInfo:)];
    
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
}

- (void)didReceiveTakeOverInfo:(id)result
{
    @try
    {
        NSString* strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
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
        
        dictionary = [jsonParser objectWithString:strData error:nil];
        
        // 인계혈액이 존재하는지 여부 체크
        if([[dictionary valueForKey:@"rowcnt"] intValue] <= 0)
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:@"등록된 인계혈액이 존재하지 않습니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            [alertView show];
            [alertView release];
            
            return;
        }
        
        if(self.takeOverInfoMap != nil)
        {
            self.takeOverInfoMap = nil;
            [self.takeOverInfoMap release];
        }
        
        self.takeOverInfoMap = [NSMutableDictionary dictionary];
        
        SBTakeOverInfoVO *tempSBTakeOverInfoVO;

        NSMutableArray *tmpTakeOverInfo = [dictionary valueForKey:@"result"];
        
        for(int i = 0; i < [tmpTakeOverInfo count]; i++)
        {
            NSDictionary *data = [tmpTakeOverInfo objectAtIndex:i];
            
            NSString *seq = [data objectForKey:@"takeoverseq"];
            
            if(seq != nil && [seq isEqualToString:@""] == false)
            {
                tempSBTakeOverInfoVO = [SBTakeOverInfoVO new];
                
                [tempSBTakeOverInfoVO setBloodcnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"bloodcnt"]];
                [tempSBTakeOverInfoVO setBloodcnt2:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"bloodcnt2"]];
                [tempSBTakeOverInfoVO setBloodsamplecnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"bloodsamplecnt"]];
                [tempSBTakeOverInfoVO setEtcsamplecnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"etcsamplecnt"]];
                [tempSBTakeOverInfoVO setIcepackcnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"icepackcnt"]];
                [tempSBTakeOverInfoVO setCoolantcnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"coolantcnt"]];
                [tempSBTakeOverInfoVO setBloodboxcnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"bloodboxcnt"]];
                [tempSBTakeOverInfoVO setHrgsamplecnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"hrgsamplecnt"]];
                [tempSBTakeOverInfoVO setHrgsamplecnt2:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"hrgsamplecnt2"]];
                [tempSBTakeOverInfoVO setAssignedcnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"assignedcnt"]];
                [tempSBTakeOverInfoVO setMarsamplecnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"marsamplecnt"]];
                [tempSBTakeOverInfoVO setSpcsamplecnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"spcsamplecnt"]];
                [tempSBTakeOverInfoVO setSpcsamplecnt2:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"spcsamplecnt2"]];
                [tempSBTakeOverInfoVO setGbmal1cnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"gbmal1cnt"]];
                [tempSBTakeOverInfoVO setGbmal2cnt:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"gbmal2cnt"]];
                [tempSBTakeOverInfoVO setTakername:[[tmpTakeOverInfo objectAtIndex:i] objectForKey:@"takername"]];
                
                [self.takeOverInfoMap setObject:tempSBTakeOverInfoVO forKey:seq];
            }
        }
                
        self.sp_takeover_seq.delegate = self;
        self.sp_takeover_seq.dataSource = self;
        self.sp_takeover_seq.rowHeight = 34;
        self.sp_takeover_seq.hidden = YES;
        
        int spinner_height = [tmpTakeOverInfo count] * self.sp_takeover_seq.rowHeight;
        
        if([tmpTakeOverInfo count] > 3)
        {
            spinner_height = self.sp_takeover_seq.rowHeight * 3;
        }
        
        self.sp_takeover_seq.frame = CGRectMake
        (
            self.sp_takeover_seq.frame.origin.x, self.sp_takeover_seq.frame.origin.y,
            self.sp_takeover_seq.frame.size.width, spinner_height
         );
        
        [self.sp_takeover_seq reloadData];
        
        NSInteger *lastIndex = [tmpTakeOverInfo count] - 1;
        NSIndexPath *lastItemIndex = [NSIndexPath indexPathForRow:lastIndex inSection:0];
        
        [self.btn_takeover_seq setTitle:[[[takeOverInfoMap allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:lastIndex] forState:UIControlStateNormal];
        [self.sp_takeover_seq selectRowAtIndexPath:lastItemIndex animated:NO scrollPosition:UITableViewScrollPositionTop];
                
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
                
        self.dialog_reg_collector.frame = CGRectMake(8, 51, 304, 220);
        
        CGFloat alpha = 0.5;
        [self.layout_dialog_back setAlpha:alpha];
    
        self.et_collector_id.text = @"";
        self.et_collector_pw.text = @"";
            
        [self.et_collector_id becomeFirstResponder];
        
        [UIView commitAnimations];
    }
    @catch(NSException *ex)
    {
        TRACE(@"%@%@", [ex name], [ex reason]);
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자 등록 데이터 조회를 실패하였습니다.\n오류가 지속될 경우 담당자에게\n문의 부탁 드립니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
    @finally
    {
        [SBUtils hideLoading];
    }
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    NSUInteger strLength = textField.text.length;
    
    switch(nTag){
        case kTakerUserIdNoTextFieldTag :
            if(strLength < 4)
            {
                et_collector_id.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"입력하신 수거자아이디가 너무 짧습니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                [alertView show];
                [alertView release];
                
                return NO;
            }
            else
            {
                self.et_collector_id.text = [textField.text uppercaseString];
                [et_collector_pw becomeFirstResponder];
            }
            break;
        case kTakerPasswordTextFieldTag :
            if(strLength < 4){
                et_collector_pw.text = @"";
                
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
                [self listener_reg_collector:nil];
            }
            break;
        default:
            return YES;
    }
 
    return YES;
}

- (IBAction)pageControllerValueChanged:(id)sender
{
    TRACE(@"pageControllerValueChanged := %ld", (long)self.m_pageControl.currentPage);
    
    if(self.m_pageControl.currentPage == 0){
        CGPoint point = CGPointMake(0, 0);
        [m_scrollView setContentOffset:point animated:YES];
    }else if(self.m_pageControl.currentPage == 1){
        CGPoint point = CGPointMake(300, 0);
        [m_scrollView setContentOffset:point animated:YES];
    }
    // 2022.04.27 ADD HMWOO Scroll Page Add
    else if(self.m_pageControl.currentPage == 2){
        CGPoint point = CGPointMake(600, 0);
        [m_scrollView setContentOffset:point animated:YES];
    }
    else{
        
    }
}


- (void)showNewInfoButton:(BOOL)showCondition
{
//    if(isTimerON == YES){
//        [m_timer invalidate];
//    }
    
    if(showCondition == YES){
        if(isTimerON == NO){
            isTimerON = YES;
            m_timer = [NSTimer scheduledTimerWithTimeInterval:0.6
                                                       target:self
                                                     selector:@selector(newInfoLabel)
                                                     userInfo:nil
                                                      repeats:NO];
        }
        
//        m_testButton.hidden = NO;
        m_newInfoButton.hidden = NO;
        m_infoButton.hidden = YES;
        m_newInfoLabel.hidden = NO;
    }else{
        if(isTimerON == YES){
            [m_timer invalidate];
            isTimerON = NO;
        }
//        m_testButton.hidden = YES;
        m_newInfoButton.hidden = YES;
        m_infoButton.hidden = NO;
        m_newInfoLabel.hidden = YES;
    }
}

- (void)newInfoLabel
{
    if(m_newInfoLabel.hidden){
        m_newInfoLabel.hidden = NO;
    }else{
        m_newInfoLabel.hidden = YES;
    }
    
    m_timer = [NSTimer scheduledTimerWithTimeInterval:0.6
                                               target:self
                                             selector:@selector(newInfoLabel)
                                             userInfo:nil
                                              repeats:NO];
}


// For module Test
- (IBAction)goPictureLibView:(id)sender
{
    if(m_pictureLibViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_pictureLibViewController = [[PictureLibViewController alloc] initWithNibName:@"PictureLibViewController"
                                                                                    bundle:nil];
        }else{
            m_pictureLibViewController = [[PictureLibViewController alloc] initWithNibName:@"PictureLibViewController3"
                                                                                    bundle:nil];
        }
    }
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_pictureLibViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_pictureLibViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_pictureLibViewController.view];
    
    [UIView commitAnimations];
}


- (IBAction)goPairingBarcodeView:(id)sender
{
    if(m_SBPairingBarcodeViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBPairingBarcodeViewController = [[SBPairingBarcodeViewController alloc] initWithNibName:@"SBPairingBarcodeViewController"
                                                                                                bundle:nil];
        }else{
//            m_SBPariingBarcodeViewController = [[PictureLibViewController alloc] initWithNibName:@"PictureLibViewController3"
//                                                                                    bundle:nil];
        }
    }
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBPairingBarcodeViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBPairingBarcodeViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBPairingBarcodeViewController.view];
    
    [UIView commitAnimations];
}


- (void)getNewNoticeInfo
{
    NSString* strId = m_SBUserInfoVO.szBimsId;
    NSString* strOrgCode = m_SBUserInfoVO.szBimsOrgcode;
    
    TRACE(@"%@, %@", strId, strOrgCode);

    NSString* url = URL_NOTICE_INFO;
	NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"beNewList", @"reqId",
                                strId, @"idno",
                                strOrgCode, @"orgcode",
                                nil];
	[m_httpRequest setDelegate:self
					  selector:@selector(didReceiveGetNoticeInfoResponse:)];
	[m_httpRequest requestURL:url
				   bodyObject:bodyObject];
}


- (void)didReceiveGetNoticeInfoResponse:(id)result
{
    NSString* strData = (NSString*)result;
    NSString* strRetCnt = @"";
    
    strData = [strData stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"didReceiveGetNoticeInfoResponse strData := [%@]", strData);
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        [self showNewInfoButton:NO];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strRetCnt = [dictionary valueForKey:@"cnt"];
    
    if([strRetCnt isEqualToString:@"0"] == YES){
        [self showNewInfoButton:NO];
    }else{
        [self showNewInfoButton:YES];
    }
    
    [self getBoardListCnt];
}

- (IBAction)showOrgTalk:(id)sender {

    if(m_SBTakeOverActionViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_SBTakeOverActionViewController = [[SBTakeOverActionViewController alloc] initWithNibName:@"SBTakeOverActionViewController"
                                                                                        bundle:nil];
            
        }else{
            // Not to do...
//            m_SBEtcSrchStaViewController = [[SBEtcSrchStaViewController alloc] initWithNibName:@"SBEtcSrchStaViewController3"
//                                                                                        bundle:nil];
            // 예전 아이폰 화면사이즈 지원불가
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:@"이 버전의 아이폰은 지원하지 않습니다"
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            
            [alertView show];
            [alertView release];
            
            return;
        }
    }
    
    m_SBTakeOverActionViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    CGRect frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBTakeOverActionViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBTakeOverActionViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [self.view addSubview:m_SBTakeOverActionViewController.view];
    
    [m_SBTakeOverActionViewController pageReset:nil];
    
    [UIView commitAnimations];
}

- (void)getBoardListCnt
{
    NSString* tempOrgCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"list_cnt";
    
    TRACE(@"***** getBoardListCnt");
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"001";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
    }
    
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    NSString* url = URL_NOT_CONFIRM_NOTICE_CNT;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                tempOrgCode, @"orgcode",
                                tempUserId, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveBoardListCnt:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
}

- (void)didReceiveBoardListCnt:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"BoardListCnt strData := [%@]", strData);
    
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
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strRowCnt = [dictionary valueForKey:@"list_cnt"];
    
    m_newBoardListLabel.text = strRowCnt;
}



#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = m_scrollView.frame.size.width;
    // 2022.04.27 ADD HMWOO ScrollView pageWidth Change
	int page = (int) ((m_scrollView.contentOffset.x + pageWidth/3) / pageWidth);
    
    TRACE(@"scrollView pageWidth = [%f], pageHeight = [%f]", pageWidth, m_scrollView.frame.size.height);
	
	m_pageControl.currentPage = page;
}

#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kLogoutActionSheetTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            //        TRACE(@"YES");
            self.m_SBUserInfoVO = nil;
            // 2022.05.25 ADD HMWOO 수거자 등록 대응
            self.takeOverInfoMap = nil;
            CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
            self.view.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
            
            //[self.view removeFromSuperview];
            [UIView commitAnimations];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(logoutAction)
                                           userInfo:nil
                                            repeats:NO];
        }else{
            //        TRACE(@"cancel");
        }
    }
    // 2022.05.25 ADD HMWOO 수거자 등록 대응
    else if(alertView.tag == kDirectConfirmCollectorChange)
    {
        if(buttonIndex != [alertView cancelButtonIndex])
        {
            [self confirmRegistCollector:@"Y"];
        }
    }
    else if(alertView.tag == kConfirmCollectorChange)
    {
        if(buttonIndex != [alertView cancelButtonIndex])
        {
            [self confirmRegistCollector:@""];
        }
    }
    else if(alertView.tag == kDirectRegistCollectorTag)
    {
        if(buttonIndex != [alertView cancelButtonIndex])
        {
            [self registTakerOverCollector:@"Y"];
        }
    }
    else if(alertView.tag == kRegistCollectorTag)
    {
        if(buttonIndex != [alertView cancelButtonIndex])
        {
            [self registTakerOverCollector:@""];
        }
    }
    else if(alertView.tag == kTakerDialogClearTag)
    {
        [self listener_dialog_back:nil];
    }
}


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == kLogoutActionSheetTag){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            //        TRACE(@"YES");
            self.m_SBUserInfoVO = nil;
            // 2022.05.19 ADD HMWOO 수거자 등록 대응
            self.takeOverInfoMap = nil;
            CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
            self.view.frame = frame;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
            
            //[self.view removeFromSuperview];
            [UIView commitAnimations];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(logoutAction)
                                           userInfo:nil
                                            repeats:NO];
        }else{
            //        TRACE(@"cancel");
        }
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

- (void)viewDidLayoutSubviews
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    TRACE(@"viewWillAppear!");
    // 현재 날짜와 시간.
    NSDate *now = [[NSDate alloc] init];
    NSDate *termWB = [NSDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 34)]; 
    NSDate *termPLT = [NSDate dateWithTimeIntervalSinceNow:(60 * 60 * 120)];
//    NSDate *termPL = [NSDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 365)];
//    NSDate* later = [now addTimeInterval:(60 * 60 * 24 * 34)];
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:02];
    [comp setDay:-1];
//    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *termPL = [myCal dateByAddingComponents:comp toDate:now options:0];
    
    // 날짜 포맷.
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    // 시간 포맷.
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    TRACE(@"termPL2: %@", [dateFormat stringFromDate:termPL]);
    
    NSString* nowDate = [dateFormat stringFromDate:now];
    NSString* laterDate = [dateFormat stringFromDate:termWB];
    NSString* nowDateTime = [timeFormat stringFromDate:now];
    NSString* laterDateTime = [timeFormat stringFromDate:termPLT];
    NSString* laterDatePL = [dateFormat stringFromDate:termPL];
    
    TRACE(@"now : %@, later : %@, plt:%@", nowDate, laterDate, laterDateTime);
    
    NSString* strValidTermWB = [NSString stringWithFormat:@"%@ ~ %@", nowDate, laterDate];
    NSString* strValidTermPLT = [NSString stringWithFormat:@"%@ ~ %@", nowDateTime, laterDateTime];
    NSString* strValidTermPL = [NSString stringWithFormat:@"%@ ~ %@", nowDate, laterDatePL];
    
    m_validTermWBLabel.text = strValidTermWB;
    m_validTermPLTLabel.text = strValidTermPLT;
    m_validTermPLLabel.text = strValidTermPL;
    
    [dateFormat release];
    [timeFormat release];
//    [termPLT release];
//    [termWB release];
    [now release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
    
    TRACE(@"BIMS id is %@", m_SBUserInfoVO.szBimsId);
    
    isTimerON = NO;
    [self getNewNoticeInfo];
//    [self getBoardListCnt];
    
    m_orgNameLabel.text = m_SBUserInfoVO.szBimsOrgname;
    m_userNameLabel.text = m_SBUserInfoVO.szBimsName;
    m_siteNameLabel.text = m_SBUserInfoVO.szBimsSitename;
    
    // For Module Test
    
    CGSize size;
    // 2016.10.20: iOS10에서는 이상하게 m_btnContainerView 의 사이즈가 커진다... 직접 설정하도록 소스 수정
    size.height = self.m_btnContainerView.frame.size.height;
    size.width = self.m_btnContainerView.frame.size.width;
    
    size.height = 240;
    
    // 2022.04.27 MOD HMWOO ScrollView Size Change
    size.width = 900;
    
    TRACE(@"width : %f, height : %f", size.width, size.height);
    
    self.m_scrollView.contentSize = size;
    
    [self.view addSubview:m_scrollView];
    [m_scrollView addSubview:m_btnContainerView];
    
    m_pageControl.numberOfPages = 3;
    
    // 2022.04.28 ADD HMWOO 수거자 등록 다이얼 로그 추가
    self.layout_dialog_back.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.dialog_reg_collector.frame = CGRectMake(8, winHeight, 304, 220);
    
    [self.view addSubview:layout_dialog_back];
    [self.view addSubview:dialog_reg_collector];
}

- (IBAction)listener_dialog_back:(id)sender
{
    if(self.layout_dialog_back.alpha > 0)
    {
        CGFloat alpha = 0;
        [self.layout_dialog_back setAlpha:alpha];
        
        if(self.dialog_reg_collector.frame.origin.y < 60)
        {
            [self.et_collector_id resignFirstResponder];
            [self.et_collector_pw resignFirstResponder];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            self.dialog_reg_collector.frame = CGRectMake(8, winHeight, 304, 220);
                        
            [UIView commitAnimations];
        }
    }
}

- (IBAction)listener_change_takeover_seq:(id)sender
{
    self.sp_takeover_seq.hidden = NO;
}

- (IBAction)listener_direct_takeover:(id)sender
{
    [self vailidationRegistCollector:@"Y"];
}

// 2022.05.19 ADD HMWOO 수거자 등록 버튼 리스너 추가
- (IBAction)listener_reg_collector:(id)sender
{
    [self vailidationRegistCollector:@""];
}

- (void)vailidationRegistCollector:(NSString *)directFlag
{
    @try
    {
        if([directFlag isEqualToString:@"Y"] == false)
        {
            if(self.et_collector_id.text.length <= 4)
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                    message:@"수거자 아이디가 부정확합니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                
                [alertView show];
                [alertView release];
                
                return;
            }
            else if(self.et_collector_pw.text.length <= 4)
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                    message:@"수거자 비밀번호가 부정확합니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                
                [alertView show];
                [alertView release];
                
                return;
            }
        }
        
        NSString *takeoverseq = btn_takeover_seq.titleLabel.text;
        
        SBTakeOverInfoVO *takeOverInfoVO = [self.takeOverInfoMap valueForKey:takeoverseq];
        
        if(takeOverInfoVO.takername != nil)
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:[NSString stringWithFormat:@"수거자[%@]가 이미 등록되어 있습니다.\n수거자를 변경하시곘습니까?", takeOverInfoVO.takername]
                                                               delegate:self
                                                      cancelButtonTitle:@"아니오"
                                                      otherButtonTitles:@"예", nil];
            if([directFlag isEqualToString:@"Y"])
            {
                alertView.tag = kDirectConfirmCollectorChange;
            }
            else
            {
                alertView.tag = kConfirmCollectorChange;
            }
            
            
            [alertView show];
            [alertView release];
            
            return;
        }
        
        [self confirmRegistCollector:directFlag];
    }
    @catch(NSException* ex)
    {
        TRACE(@"%@%@", [ex name], [ex reason]);
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자 등록을 실패하였습니다.\n오류가 지속될 경우 담당자에게\n문의 부탁 드립니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}

- (void)confirmRegistCollector:(NSString *)directFlag
{
    @try
    {
        
        NSString *takeoverseq = btn_takeover_seq.titleLabel.text;
        
        SBTakeOverInfoVO *takeOverInfoVO = [self.takeOverInfoMap valueForKey:takeoverseq];
        
        NSMutableString* comp1 = [NSMutableString stringWithString:(takeOverInfoVO.bloodcnt)];
        
        NSString* comp2 = takeOverInfoVO.bloodcnt2;
        if([comp1 isEqualToString:comp2] == NO)
        {
            [comp1 appendString:@"("];
            [comp1 appendString:comp2];
            [comp1 appendString:@")"];
        }
        
        NSString* strTempMsg =
        [NSString stringWithFormat:
         @"혈액[%@]\n 헌혈검체[%@]\n 기타검체[%@]\n 아이스팩[%@]\n PCM냉매제[%@]\n 혈액박스[%@]\n---------------\n 안전성검사[%@건 %@개]\n 지정헌혈[%@]\n 조혈모세포[%@]\n 특검[%@건 %@개]\n 말라리아[전혈:%@, 혈장:%@]\n에 대한 수거자 등록을 진행하시겠습니까?",
         comp1,
         takeOverInfoVO.bloodsamplecnt,
         takeOverInfoVO.etcsamplecnt,
         takeOverInfoVO.icepackcnt,
         takeOverInfoVO.coolantcnt,
         takeOverInfoVO.bloodboxcnt,
         takeOverInfoVO.hrgsamplecnt2,
         takeOverInfoVO.hrgsamplecnt,
         takeOverInfoVO.assignedcnt,
         takeOverInfoVO.marsamplecnt,
         takeOverInfoVO.spcsamplecnt2,
         takeOverInfoVO.spcsamplecnt,
         takeOverInfoVO.gbmal1cnt,
         takeOverInfoVO.gbmal2cnt
        ];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:strTempMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        if([directFlag isEqualToString:@"Y"])
        {
            alertView.tag = kDirectRegistCollectorTag;
        }
        else
        {
            alertView.tag = kRegistCollectorTag;
        }
        
        [alertView show];
        [alertView release];
    }
    @catch(NSException* ex)
    {
        TRACE(@"%@%@", [ex name], [ex reason]);
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자 등록을 실패하였습니다.\n오류가 지속될 경우 담당자에게\n문의 부탁 드립니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}

// 2022.05.25 ADD HMWOO 수거자 등록 기능 추가
- (void)registTakerOverCollector:(NSString *)directlFlag
{
    @try
    {
        NSString* tempReqId = @"registCollectorInfo";
        NSString* tempTakeOverSeq = btn_takeover_seq.titleLabel.text;
        NSString* tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        NSString* tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
        
        NSString* tempTakerUserIdNo;
        NSString* tempTakerPassword;
        
        
        if([directlFlag isEqualToString:@"Y"])
        {
            tempTakerUserIdNo = m_SBUserInfoVO.szBimsId;
            tempTakerPassword = @"";

        }
        else
        {
            tempTakerUserIdNo = [NSString stringWithString:et_collector_id.text];
            tempTakerPassword = [NSString stringWithString:et_collector_pw.text];
        }
        
        // 수거자 인증요청
        NSString* url = URL_MANAGE_TAKEOVER_INFO;
        
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    tempReqId, @"reqId",
                                    tempTakeOverSeq, @"takeoverseq",
                                    tempOrgCode, @"orgcode",
                                    tempCarCode, @"carcode",
                                    tempTakerUserIdNo, @"takerUserIdNo",
                                    m_SBUserInfoVO.szBimsId, @"strTurnUserIdNo",
                                    tempTakerPassword, @"takerPassword",
                                    directlFlag, @"directFlag",
                                    nil];
        
        [SBUtils showLoading];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveRegistCollector:)];
        
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
    }
    @catch(NSException *ex)
    {
        TRACE(@"%@%@", [ex name], [ex reason]);
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"수거자 등록을 실패하였습니다.\n오류가 지속될 경우 담당자에게\n문의 부탁 드립니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
    }
}

- (void)didReceiveRegistCollector:(id)result
{
    [SBUtils hideLoading];
    
    NSString* strData;
    NSString* strResult;
    NSString* strResultMsg;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
        
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES)
    {
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
    strResultMsg = [dictionary valueForKey:@"resultmsg"];
    
    
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                        message:strResultMsg
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles: nil];
    
    // 정상등록이 되면 'Y' 값 리턴
    if([strResult isEqualToString:@"Y"])
    {
        [alertView setTag:kTakerDialogClearTag];
    }
    
    [alertView show];
    [alertView release];
    
}

//- (void)makeTrafficForVPN
//{
//    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/index.jsp";
//    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:nil];
//    [m_httpRequest setDelegate:self
////                      selector:@selector(didReceiveResponse:)];
//                      selector:nil];
//    [m_httpRequest requestURL:url
//                   bodyObject:bodyObject];
//
//    TRACE(@"***************** makeTrafficForVPN *****************");
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_SBUserInfoVO = nil;
    self.m_httpRequest = nil;
    
    self.m_orgNameLabel = nil;
    self.m_userNameLabel = nil;
    self.m_siteNameLabel = nil;
    
    self.m_validTermWBLabel = nil;
    self.m_validTermPLTLabel = nil;
    self.m_validTermPLLabel = nil;
    
    self.m_boardLabel = nil;
    
    self.m_donorManageButton = nil;
    self.m_matching1Button = nil;
    self.m_matching2Button = nil;
    self.m_endtimeButton = nil;
    self.m_bldprocButton = nil;
    self.m_infoButton = nil;
    self.m_newInfoButton = nil;
    self.m_newInfoLabel = nil;
    self.m_newBoardListLabel = nil;
    
    self.m_target = nil;
    self.m_selector = nil;
    
    self.m_scrollView = nil;
    self.m_btnContainerView = nil;
    self.m_pageControl = nil;
    
    self.m_testButton = nil;
    self.m_pairingBarcodeButton = nil;
    self.m_pictureLibViewController = nil;
    
    // 2022.05.19 ADD HMWOO 수거자 등록 다이얼 로그 추가 대응
    self.sp_takeover_seq = nil;
    self.btn_takeover_seq = nil;
    self.takeOverInfoMap = nil;
}

- (void)dealloc
{
    [m_SBUserInfoVO release];
    [m_httpRequest release];
    [m_orgNameLabel release];
    [m_userNameLabel release];
    [m_siteNameLabel release];
    [m_validTermWBLabel release];
    [m_validTermPLTLabel release];
    [m_validTermPLLabel release];
    [m_boardLabel release];
    [m_donorManageButton release];
    [m_matching1Button release];
    [m_matching2Button release];
    [m_endtimeButton release];
    [m_bldprocButton release];
    [m_infoButton release];
    [m_newInfoButton release];
    [m_newInfoLabel release];
    [m_newBoardListLabel release];
    
    [m_scrollView release];
    [m_btnContainerView release];
    [m_pageControl release];
    
    [m_testButton release];
    [m_pairingBarcodeButton release];
    [m_pictureLibViewController release];
    
    // 2022.05.24 ADD HMWOO 수거자 등록 다이얼 로그 추가 대응
    [sp_takeover_seq release];
    [btn_takeover_seq release];
    [takeOverInfoMap release];

    [btnOrgTalk release];
    [super dealloc];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// 2022.05.24 ADD HMWOO 수거자 등록 다이얼 로그 추가 대응
#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 데이터 선택시 선택한 데이터를 버튼 표시 텍스트로 설정
    UITableViewCell *cell = [self.sp_takeover_seq cellForRowAtIndexPath:indexPath];
    [self.btn_takeover_seq setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    // 데이터 선택시 셀렉트 박스 비활성화
    self.sp_takeover_seq.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.takeOverInfoMap count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //cell.textLabel.text = [[self.takeOverInfoMap allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = [[NSNumber numberWithInt:(int)indexPath.row + 1] stringValue];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

@end
