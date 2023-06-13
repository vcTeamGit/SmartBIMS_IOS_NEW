//
//  SBMgrInfoViewController.m
//  SmartBIMS
//
//  Created by  on 11. 10. 25..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBMgrInfoViewController.h"

#import "HttpRequest.h"
#import "SBUserInfoVO.h"
#import "SBUtils.h"
#import "JSON.h"

#import "SBMgrDatePickerViewController.h"
#import "SBMgrDetailInfoViewController.h"

#import "Smart_BIMSAppDelegate.h"

@implementation SBMgrInfoViewController

@synthesize m_httpRequest;
@synthesize m_SBUserInfoVO;
@synthesize m_strMgrDateLabel;
@synthesize m_noDataLabel;

@synthesize m_datePickerShowBtn;
@synthesize m_beforeSchedulePageBtn;
@synthesize m_nextSchedulePageBtn;

@synthesize m_scrollView;
@synthesize m_activityIndicatorView;
@synthesize m_mPageArray;
@synthesize m_nDetailPageCnt;

@synthesize m_SBMgrDatePickerViewController;
@synthesize m_selectedDate;

@synthesize m_bPickerViewMode;


- (void)pageReset:(id)sender
{
    self.m_bPickerViewMode = NO;
    self.m_nextSchedulePageBtn.hidden = YES;
    self.m_beforeSchedulePageBtn.hidden = YES;
    
    for(UIView* view in m_scrollView.subviews){
        [view removeFromSuperview];
        //        [view release];
    }
    
    [self setMgrDateValue:nil];
}


- (void)requestMgrInfo
{    
    NSString* strMgrDate = m_strMgrDateLabel.text;
    
    self.m_datePickerShowBtn.enabled = NO;
    
    NSString* tempUserId = nil;
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2022106"]){
        tempUserId = @"R2009004";
    }else{
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_OPERATE_INFO;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"mgrInfo", @"reqId",
                                strMgrDate, @"mgrdate",
                                tempUserId, @"idNo",
//                                @"2011-11-01", @"mgrdate",
//                                @"R2009036", @"idNo",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveMgrInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveMgrInfo:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
//    NSString* strResult;
    CGRect frame = m_scrollView.frame;
    
    self.m_datePickerShowBtn.enabled = YES;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData= [%@]", strData);
    
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
    
    for(UIView* view in m_scrollView.subviews){
        [view removeFromSuperview];
        //        [view release];
    }
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strRowCnt = [dictionary valueForKey:@"cnt"];
//    self.m_strPageTotalNumLabel.text = strRowCnt;
    
    m_nDetailPageCnt = [strRowCnt intValue];
    
    if(m_nDetailPageCnt > 1){
        m_beforeSchedulePageBtn.hidden = YES;
        m_nextSchedulePageBtn.hidden = NO;
    }else{
        m_beforeSchedulePageBtn.hidden = YES;
        m_nextSchedulePageBtn.hidden = YES;
    }

    if(m_nDetailPageCnt > 0){
        m_mPageArray = [dictionary valueForKey:@"result"];
        
        for(int i = 0; i < [m_mPageArray count]; i++){
            
            NSString* strCarName = [[m_mPageArray objectAtIndex:i] objectForKey:@"carname"];
            NSString* strSiteName = [[m_mPageArray objectAtIndex:i] objectForKey:@"sitename"];
            NSString* strSiteCode = [[m_mPageArray objectAtIndex:i] objectForKey:@"sitecode"];
            NSString* strEnv = [[m_mPageArray objectAtIndex:i] objectForKey:@"env"];
            NSString* strGBMal = [[m_mPageArray objectAtIndex:i] objectForKey:@"gbmal"];
            NSString* strPlanCnt = [[m_mPageArray objectAtIndex:i] objectForKey:@"plancnt"];
            NSString* strRemark = [[m_mPageArray objectAtIndex:i] objectForKey:@"remark"];
            NSString* strDepartTime = [[m_mPageArray objectAtIndex:i] objectForKey:@"departtime"];
            NSString* strReturnTime = [[m_mPageArray objectAtIndex:i] objectForKey:@"returntime"];
            NSString* strMembers = [[m_mPageArray objectAtIndex:i] objectForKey:@"members"];
            NSString* strGbSessionName = [[m_mPageArray objectAtIndex:i] objectForKey:@"gbsessionname"];
            NSString* strIdName = [[m_mPageArray objectAtIndex:i] objectForKey:@"idname"];
            NSString* strIdNo = [[m_mPageArray objectAtIndex:i] objectForKey:@"idno"];
            
//            self.m_strCarNameLabel.text = strCarName;
            
//            SBMgrDetailInfoViewController* controller = [[[SBMgrDetailInfoViewController alloc] init] autorelease];
            //SBMgrDetailInfoViewController* controller = [[SBMgrDetailInfoViewController alloc] init];
            SBMgrDetailInfoViewController* controller = [[SBMgrDetailInfoViewController alloc] initWithNibName:@"SBMgrDetailInfoNewViewController" bundle:nil];
            
            CGRect tempFrame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
            controller.view.frame = tempFrame;
            frame.origin.x += frame.size.width;
            
            [controller setValuesWithCarName:strCarName
                                    sitename:strSiteName 
                                    sitecode:strSiteCode 
                                         env:strEnv 
                                   malStatus:strGBMal 
                                     plancnt:strPlanCnt 
                                  departTime:strDepartTime 
                                  returnTime:strReturnTime 
                                      remark:strRemark
                                     members:strMembers
                               gbsessionname:strGbSessionName
                                      idname:strIdName
                                        idno:strIdNo];
            
            [m_scrollView addSubview:controller.view];
        }
        
        m_scrollView.contentSize = CGSizeMake(frame.size.width * [m_mPageArray count], frame.size.height);
    }else{
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"조회결과"
//                                                            message:@"운영편성정보가 존재하지 않습니다."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"확인"
//                                                  otherButtonTitles: nil];
//        
//        [alertView show];
//        [alertView release];
        [m_scrollView addSubview:m_noDataLabel];
        m_scrollView.contentSize = CGSizeMake(frame.size.width * 1, frame.size.height);
    }
    
    [self backgroundTab:nil];
}




- (IBAction)backgroundTab:(id)sender
{
    if(m_bPickerViewMode){
        CGRect frame = CGRectMake(0, winHeight-272, viewWidth, 272);
        m_SBMgrDatePickerViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_SBMgrDatePickerViewController.view.frame = CGRectMake(0, winHeight, viewWidth, 272);
        
        [UIView commitAnimations];
        
        m_bPickerViewMode = NO;
    }
}


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
	[self.view removeFromSuperview];
}



- (IBAction)onPickerViewMode:(id)sender
{
    TRACE(@"onPickerViewMode");
    if(m_bPickerViewMode){
        TRACE(@"true!");
    }else{
        TRACE(@"false");
    }
    
    if(m_SBUserInfoVO != nil && !m_bPickerViewMode){
        TRACE(@"picker Up!");
        CGRect frame = CGRectMake(0, winHeight, viewWidth, 272);
        m_SBMgrDatePickerViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_SBMgrDatePickerViewController.view.frame = CGRectMake(0, winHeight-272, viewWidth, 272);
        
        [UIView commitAnimations];
        
        m_bPickerViewMode = YES;
    }
}


- (IBAction)toBeforeSchedulePage:(id)sender
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    
//    - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
    CGPoint contentPoint = m_scrollView.contentOffset;
    CGPoint point = CGPointMake(contentPoint.x - viewWidth, contentPoint.y);
    
    [m_scrollView setContentOffset:point animated:YES];
    
	int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    page ++;
	
    if(m_nDetailPageCnt > 1 && m_nDetailPageCnt == page){
        m_beforeSchedulePageBtn.hidden = NO;
        m_nextSchedulePageBtn.hidden = YES;
    }else if(m_nDetailPageCnt > 1 && page == 1){
        m_beforeSchedulePageBtn.hidden = YES;
        m_nextSchedulePageBtn.hidden = NO;
    }
}


- (IBAction)toNextSchedulePage:(id)sender
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    
    CGPoint contentPoint = m_scrollView.contentOffset;
    CGPoint point = CGPointMake(contentPoint.x + viewWidth, contentPoint.y);
    
    [m_scrollView setContentOffset:point animated:YES];
    
	int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    page ++;
	
    if(m_nDetailPageCnt > 1 && m_nDetailPageCnt == page){
        m_beforeSchedulePageBtn.hidden = NO;
        m_nextSchedulePageBtn.hidden = YES;
    }else if(m_nDetailPageCnt > 1 && page == 1){
        m_beforeSchedulePageBtn.hidden = YES;
        m_nextSchedulePageBtn.hidden = NO;
    }
}


- (IBAction)toTomorrowSchedule:(id)sender
{

}

- (IBAction)toYesterdaySchedule:(id)sender
{

}


- (void)setMgrDateValue:(id)date
{
    NSDate* tempDate;
    
    // 입력 값이 nil이면 내일날짜로 초기화한다.
    if(date == nil){
        NSTimeInterval secondPerDay = 24 * 60 * 60;
        tempDate = [[NSDate alloc] initWithTimeIntervalSinceNow:secondPerDay];
    }else{
        tempDate = (NSDate*)date;
    }
    
    m_selectedDate = tempDate;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"] autorelease]];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* strSelectedDate = [dateFormatter stringFromDate:tempDate];
    
    m_strMgrDateLabel.text = strSelectedDate;
    
    // datePicker 화면 밖으로 이동.
    CGRect frame = CGRectMake(0, winHeight-272, viewWidth, 272);
    m_SBMgrDatePickerViewController.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_SBMgrDatePickerViewController.view.frame = CGRectMake(0, winHeight, viewWidth, 272);
    
    [UIView commitAnimations];
    
    m_bPickerViewMode = NO;
    
    [self requestMgrInfo];
    
    [dateFormatter release];
}


#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = m_scrollView.frame.size.width;
	int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    page ++;
	
//    m_strPageNumLabel.text = [NSString stringWithFormat:@"%d", page + 1];
    if(m_nDetailPageCnt > 1 && m_nDetailPageCnt == page){
        m_beforeSchedulePageBtn.hidden = NO;
        m_nextSchedulePageBtn.hidden = YES;
    }else if(m_nDetailPageCnt > 1 && page == 1){
        m_beforeSchedulePageBtn.hidden = YES;
        m_nextSchedulePageBtn.hidden = NO;
    }
}




#pragma marks -
#pragma marks Defaults
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
    m_mPageArray = [[NSMutableArray alloc] initWithCapacity:16];
    
    // for iPhone5
//    m_scrollView.frame = CGRectMake(0, viewHeight+96, viewWidth, viewHeight-96);
    
    if(m_SBMgrDatePickerViewController == nil){
        m_SBMgrDatePickerViewController = [[SBMgrDatePickerViewController alloc] initWithNibName:@"SBMgrDatePickerViewController" 
                                                                                          bundle:nil];
    }
    CGRect bldProcPickerViewFrame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    m_SBMgrDatePickerViewController.view.frame = bldProcPickerViewFrame;
    [self.view addSubview:m_SBMgrDatePickerViewController.view];
    
    [m_SBMgrDatePickerViewController setDelegate:self selector:@selector(setMgrDateValue:)];
    
    [self setMgrDateValue:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.m_httpRequest = nil;
    self.m_SBUserInfoVO = nil;
    self.m_strMgrDateLabel = nil;
    self.m_noDataLabel = nil;
    
    self.m_datePickerShowBtn = nil;
    self.m_beforeSchedulePageBtn = nil;
    self.m_nextSchedulePageBtn = nil;
    
    self.m_scrollView = nil;
    self.m_activityIndicatorView = nil;
    self.m_mPageArray = nil;
    
    self.m_SBMgrDatePickerViewController = nil;
    self.m_selectedDate = nil;
}

- (void)dealloc
{
    [m_httpRequest release];
    
    [m_SBUserInfoVO release];
    [m_strMgrDateLabel release];
    [m_noDataLabel release];
    
    [m_datePickerShowBtn release];
    [m_beforeSchedulePageBtn release];
    [m_nextSchedulePageBtn release];
    
    [m_scrollView release];
    [m_activityIndicatorView release];
    
    [m_mPageArray release];
    
    [m_SBMgrDatePickerViewController release];
    [m_selectedDate release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
