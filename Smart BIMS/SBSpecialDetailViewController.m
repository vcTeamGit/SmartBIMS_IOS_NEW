//
//  SBSpecialDetailViewController.m
//  Smart BIMS
//
//  Created by  on 11. 9. 20..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBSpecialDetailViewController.h"

#import "SBSpecialPageViewController.h"
#import "HttpRequest.h"
#import "JSON.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBSpecialDetailViewController

@synthesize m_httpRequest;

@synthesize m_pageControl;
@synthesize m_scrollView;

@synthesize m_mPageArray;

@synthesize m_strJumin1;
@synthesize m_strJumin2;
@synthesize m_strPageCnt;

@synthesize m_activityIndicatorView;


- (void)setValuesWithPageCnt:(NSString*)strCnt jumin1:(NSString*)strJumin1 jumin2:(NSString*)strJumin2
{
    self.m_strPageCnt = strCnt;
    self.m_strJumin1 = strJumin1;
    self.m_strJumin2 = strJumin2;
    
    [self setPages];
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


- (IBAction)changePage:(id)sender
{
    CGRect frame = m_scrollView.frame;
	frame.origin.x = m_pageControl.currentPage * frame.size.width;
	
	[m_scrollView scrollRectToVisible:frame animated:YES];
}


- (void)setPages
{
    if(m_httpRequest == nil){
        m_httpRequest = [[HttpRequest alloc] init];
    }
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBDonorFitnessCheckDetailCommonDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:@"bissNurSpec", @"reqId", 
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
        
        SBSpecialPageViewController* controller = [[[SBSpecialPageViewController alloc] init] autorelease];
        
        CGRect tempFrame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        controller.view.frame = tempFrame;
        frame.origin.x += frame.size.width;
        
        [controller setPageValuesWithDate:[arrVO objectAtIndex:0]
                                  carName:[arrVO objectAtIndex:1]
                              bldProcName:[arrVO objectAtIndex:2]
                               reasonText:[arrVO objectAtIndex:3]
                                pageIndex:(i + 1)
                                totalPage:[m_mPageArray count]];
        [m_scrollView addSubview:controller.view];
        
        //        [controller release];
    }
    
    m_pageControl.numberOfPages = [m_mPageArray count];
    m_scrollView.contentSize = CGSizeMake(frame.size.width * [m_mPageArray count], frame.size.height);
}



#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = m_scrollView.frame.size.width;
	int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
	
	m_pageControl.currentPage = page;
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
