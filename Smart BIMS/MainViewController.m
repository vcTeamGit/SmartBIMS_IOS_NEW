//
//  MainViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
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

    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBNoticeWithConfirmInfoDAO.jsp";
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
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBBoardDAO.jsp";
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


#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == kLogoutActionSheetTag){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            //        TRACE(@"YES");
            self.m_SBUserInfoVO = nil;
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
}


//- (void)makeTrafficForVPN
//{
//    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/index.jsp";
//	NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:nil];
//	[m_httpRequest setDelegate:self
////					  selector:@selector(didReceiveResponse:)];
//                      selector:nil];
//	[m_httpRequest requestURL:url
//				   bodyObject:bodyObject];
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

    [btnOrgTalk release];
    [super dealloc];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
