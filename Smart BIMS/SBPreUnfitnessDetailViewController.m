//
//  SBPreUnfitnessDetailViewController.m
//  Smart BIMS
//
//  Created by  on 11. 9. 2..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBPreUnfitnessDetailViewController.h"

#import "SBPreUnfitnessPageViewController.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBPreUnfitnessDetailViewController

@synthesize m_httpRequest;

@synthesize m_pageControl;
@synthesize m_scrollView;

@synthesize m_mPageArray;

@synthesize m_strJumin1;
@synthesize m_strJumin2;
@synthesize m_strPageCnt;

@synthesize m_activityIndicatorView;


- (id)initWithPageCnt:(NSString*)strCnt jumin1:(NSString*)strJumin1 jumin2:(NSString*)strJumin2
{
	if(self = [super init]){
        TRACE(@"initWithPageCnt");
		self.m_strPageCnt = strCnt;
        self.m_strJumin1 = strJumin1;
        self.m_strJumin2 = strJumin2;
        
        [self setPages];
	}
	
	return self;
}


- (void)setValuesWithPageCnt:(NSString*)strCnt jumin1:(NSString*)strJumin1 jumin2:(NSString*)strJumin2
{
    self.m_strPageCnt = strCnt;
    self.m_strJumin1 = strJumin1;
    self.m_strJumin2 = strJumin2;
    
    [self setPages];
}


- (void)setPages
{	
    TRACE(@"setPages");
    if(m_httpRequest == nil){
        m_httpRequest = [[HttpRequest alloc] init];
    }
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBDonorFitnessCheckDetailCommonDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"bissNurInv", @"reqId", 
                                m_strJumin1, @"strJumin1",
                                m_strJumin2, @"strJumin2",
                                nil];
    
//    m_httpRequest = [[HttpRequest alloc] init];
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
    dictionary = [jsonParser objectWithString:strData error:nil];
    
    for(UIView* view in m_scrollView.subviews){
        [view removeFromSuperview];
//        [view release];
    }
    
//    m_mPageArray = [[NSMutableArray alloc] initWithCapacity:16];
//    [m_mPageArray removeAllObjects];
    if(m_mPageArray == nil){
        m_mPageArray = [[NSMutableArray alloc] initWithCapacity:16];
    }
    m_mPageArray = [dictionary valueForKey:@"result"];
    
    for(int i = 0; i < [m_mPageArray count]; i++){
        
        NSArray* arrVO = [[[m_mPageArray objectAtIndex:i] objectForKey:@"val"] componentsSeparatedByString:@"|"];
        
        SBPreUnfitnessPageViewController* controller = [[[SBPreUnfitnessPageViewController alloc] init] autorelease];
        
        CGRect tempFrame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        controller.view.frame = tempFrame;
        frame.origin.x += frame.size.width;
        
        [controller setPageValuesWithDate:[arrVO objectAtIndex:1]
                                  carName:[arrVO objectAtIndex:2]
                                   reason:[arrVO objectAtIndex:3]
                               reasonText:[arrVO objectAtIndex:4]
                                pageIndex:(i + 1)
                                totalPage:[m_mPageArray count]];
        [m_scrollView addSubview:controller.view];
        
//        [controller release];
    }
    
    m_pageControl.numberOfPages = [m_mPageArray count];
    m_scrollView.contentSize = CGSizeMake(frame.size.width * [m_mPageArray count], frame.size.height);
}


- (IBAction)changePage:(id)sender
{
	CGRect frame = m_scrollView.frame;
	frame.origin.x = m_pageControl.currentPage * frame.size.width;
	
	[m_scrollView scrollRectToVisible:frame animated:YES];
}
                      
                      
- (void)requestPreUnFitnessInfo:(NSString*)pageNum
{    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBDonorFitnessCheckDetailCommonDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:pageNum, @"strPageNum", 
                                m_strJumin1, @"strJumin1",
                                m_strJumin2, @"strJumin2",
                                nil];
    
//    m_httpRequest = [[HttpRequest alloc] init];
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveDonorFitnessInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
}


- (IBAction)onBack:(id)sender
{
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
									 target:self
								   selector:@selector(onToSBFitnessCheckViewControllerSelector)
								   userInfo:nil
									repeats:NO];
}


- (void)onToSBFitnessCheckViewControllerSelector
{
    [m_scrollView removeFromSuperview];
    [self.view removeFromSuperview];
}



#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = m_scrollView.frame.size.width;
	int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
	
	m_pageControl.currentPage = page;
}




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
    
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    if(winHeight == kWINDOW_HEIGHT){
//        self.m_scrollView.frame = CGRectMake(0, 44, 320, 460);
    }else{
//        self.m_scrollView.frame = CGRectMake(0, 44, 320, 460);
        self.m_pageControl.frame = CGRectMake(20, 420, 280, 36);
    }
    
    self.m_httpRequest = [[HttpRequest alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    
    self.m_pageControl = nil;
    self.m_scrollView = nil;
    
    self.m_mPageArray = nil;
    
    self.m_strJumin1 = nil;
    self.m_strJumin2 = nil;
    self.m_strPageCnt = nil;
    
    self.m_activityIndicatorView = nil;
}

- (void)dealloc
{
    TRACE(@"SBPreUnfitnessDetailViewController is dealloced!");
    
    [m_httpRequest release];
    
    [m_pageControl release];
    [m_scrollView release];
    
    [m_mPageArray release];
    
    [m_strJumin1 release];
    [m_strJumin2 release];
    [m_strPageCnt release];
    
    [m_activityIndicatorView release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
