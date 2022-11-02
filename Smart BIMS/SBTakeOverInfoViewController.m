//
//  SBTakeOverInfoViewController.m
//  SmartBIMS
//
//  Created by wireline on 2017. 9. 26..
//
//

#import "SBTakeOverInfoViewController.h"

#import "SBTakeOverInfoPageViewController.h"
#import "Smart_BIMSAppDelegate.h"
#import "SmartBIMS-Swift.h"
#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

@interface SBTakeOverInfoViewController ()

@end

@implementation SBTakeOverInfoViewController

@synthesize m_SBUserInfoVO;
@synthesize m_httpRequest;
@synthesize m_pageControl;
@synthesize m_scrollView;
@synthesize m_mPageArray;
@synthesize m_strPageCnt;

@synthesize m_totalTakeOverSeqLabel;
@synthesize m_totalTakeOverBloodCntLabel;

@synthesize m_activityIndicatorView;

@synthesize m_target;
@synthesize m_selector;


#pragma mark - 
#pragma Custom Methods

- (IBAction)onHomeButtonTab:(id)sender
{
//    [self backgroundTab:nil];
    
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
- (IBAction)changeBloodLevelInfoButtonTapped:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"TakeOverChangeBloodLevelInfo" bundle:nil];
    TakeOverChangeBloodLevelInfoViewController * vc = [storyboard
                                                  instantiateViewControllerWithIdentifier:@"TakeOverChangeBloodLevelInfoViewController"];
    vc.m_SBUserInfoVO = m_SBUserInfoVO;
    vc.bloodLevel = m_pageControl.currentPage + 1;
    vc.delegateVC = self;
    
    UINavigationController* nav = [[UINavigationController new] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController: nav animated: YES completion: nil]; // --------- nil
}


- (void) onToHomeViewSelector
{
    //    [self.m_bldProcPickerViewController.view removeFromSuperview];
    [m_target performSelector:m_selector withObject:nil];
    [self.view removeFromSuperview];
}


- (void)pageReset:(id)sender
{
//    [self setPages];
}

- (IBAction)changePage:(id)sender
{
    CGRect frame = m_scrollView.frame;
    frame.origin.x = m_pageControl.currentPage * frame.size.width;
    
    [m_scrollView scrollRectToVisible:frame animated:YES];
}


- (void)onSearch:(id)sender
{
    [self setPages];
}


- (void)setPages
{
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    
    if(m_httpRequest == nil){
        m_httpRequest = [[HttpRequest alloc] init];
    }
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2022106"]){
        tempOrgCode = @"001";
        tempCarCode = @"50";
        tempUserId = @"R2020045";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    
    // 2022.05.18 MOD HMWOO 인계정보 조회 URL을 URL 관리 페이지에서 조회하도록 수정
    NSString* url = URL_QUERY_TAKEOVER_INFO;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"takeOverInfoList", @"reqId",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                nil];

    [m_httpRequest setDelegate:self
                      selector:@selector(didReceivePageInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [m_activityIndicatorView startAnimating];
}


- (void)didReceivePageInfo:(id)result
{
    NSString* strData;
    CGRect frame = m_scrollView.frame;
    
    TRACE(@"didReceivePageInfo");
    
    [m_activityIndicatorView stopAnimating];
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData=[%@]", strData);
    
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
    if([[dictionary valueForKey:@"rowcnt"] intValue] <= 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"당일 인계혈액이 존재하지 않습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kIsNoTakeOverInfoTag;
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    
    self.m_totalTakeOverSeqLabel.text = [NSString stringWithFormat:@"%ld/%d", m_pageControl.currentPage + 1,[[dictionary valueForKey:@"maxtakeoverseq"] intValue]];
    self.m_totalTakeOverBloodCntLabel.text = [dictionary valueForKey:@"bldcnt"];
    
    
    for(UIView* view in m_scrollView.subviews){
        [view removeFromSuperview];
    }

    if(m_mPageArray == nil){
        m_mPageArray = [[NSMutableArray alloc] initWithCapacity:16];
    }
    m_mPageArray = [dictionary valueForKey:@"result"];
    
    
    
    for(int i = 0; i < [m_mPageArray count]; i++){
        
        SBTakeOverInfoPageViewController* controller = [[[SBTakeOverInfoPageViewController alloc] init] autorelease];
        
        CGRect tempFrame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        controller.view.frame = tempFrame;
        frame.origin.x += frame.size.width;
        
        [controller setPageValues:[[m_mPageArray objectAtIndex:i] objectForKey:@"spcsamplecnt"]
                    spcSampleCnt2:[[m_mPageArray objectAtIndex:i] objectForKey:@"spcsamplecnt2"]
                     enrSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"enrsamplecnt"]
                     etcSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"etcsamplecnt"]
                     hrgSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"hrgsamplecnt"]
                    hrgSampleCnt2:[[m_mPageArray objectAtIndex:i] objectForKey:@"hrgsamplecnt2"]
                     hbvSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"hbvsamplecnt"]
                     marSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"marsamplecnt"]
                     rhnSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"rhnsamplecnt"]
                       icepackCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"icepackcnt"]
                       coolantCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"coolantcnt"]
                         bloodCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"bloodcnt"]
                   bloodSampleCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"bloodsamplecnt"]
                         paperCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"papercnt"]
                        ePaperCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"epapercnt"]
                 assignedBloodCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"assignedcnt"]
             rhnEmergencyBloodCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"rhnemergencybloodcnt"]
                    unfitPaperCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"unfitpapercnt"]
                   eUnfitPaperCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"eunfitpapercnt"]
                          mal1Cnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"mal1cnt"]
//                          mal3Cnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"mal3cnt"]
                          mal3Cnt:@"0"
                      bloodBoxCnt:[[m_mPageArray objectAtIndex:i] objectForKey:@"bloodboxcnt"]
                        takerName:[[m_mPageArray objectAtIndex:i] objectForKey:@"takername"]
                     takeOverTime:[[m_mPageArray objectAtIndex:i] objectForKey:@"takeovertime"]
                        totalPage:[m_mPageArray count]];
        
        [m_scrollView addSubview:controller.view];

    }
    
    m_pageControl.numberOfPages = [m_mPageArray count];
    m_scrollView.contentSize = CGSizeMake(frame.size.width * [m_mPageArray count], frame.size.height);
}


- (IBAction)pageControllerValueChanged:(id)sender
{
    TRACE(@"pageControllerValueChanged := %ld", (long)self.m_pageControl.currentPage);
    
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int pageX = (int)self.m_pageControl.currentPage * (int)pageWidth;
    CGPoint point = CGPointMake(320*pageX, 0);
    [m_scrollView setContentOffset:point animated:YES];
}



#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    self.m_totalTakeOverSeqLabel.text = [NSString stringWithFormat:@"%d/%ld", page+1, (long)m_pageControl.numberOfPages];
    
    m_pageControl.currentPage = page;
}



#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{    
    if(alertView.tag == kIsNoTakeOverInfoTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
        }else{
            [self onHomeButtonTab:nil];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
