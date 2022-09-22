//
//  SBBoardContentViewController.m
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 15..
//
//

#import "SBBoardContentViewController.h"

#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

@interface SBBoardContentViewController ()

@end

@implementation SBBoardContentViewController

@synthesize m_SBUserInfoVO;

@synthesize m_enterDateLabel;
@synthesize m_enterTimeLabel;
@synthesize m_startDateLabel;
@synthesize m_endDateLabel;
@synthesize m_enterNameLabel;
@synthesize m_boardTitleLabel;

@synthesize m_boardRemarkTextView;
@synthesize m_activityIndicatorView;

@synthesize m_seqno;
@synthesize m_writeDate;

@synthesize m_selector;
@synthesize m_target;


- (IBAction)onBack:(id)sender
{
    NSString* strTempIdNo = m_SBUserInfoVO.szBimsId;
    NSString* strTempIdName = m_SBUserInfoVO.szBimsName;
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_NOTICE_INFO;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"read_check", @"reqId",
                                strTempIdNo, @"idno",
                                strTempIdName, @"idname",
                                self.m_seqno, @"seqno",
                                self.m_writeDate, @"writedate",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveReadCheckResult:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void) onToHomeViewSelector
{
    [m_target performSelector:m_selector withObject:nil];
	[self.view removeFromSuperview];
}


- (void)didReceiveReadCheckResult:(id)result
{
    NSString* strData;
    NSString* strResult;
    NSString* strAlertMsg = @"";
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
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
    
    if([strResult isEqualToString:@"0"] == NO){
        CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
        self.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        self.view.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
        
        [UIView commitAnimations];
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(onToHomeViewSelector)
                                       userInfo:nil
                                        repeats:NO];

    }else{
        strAlertMsg = @"공지사항의 확인체크 작업에 실패하였습니다. \n다시 시도하세요.";
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


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
