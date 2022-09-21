//
//  SBInfoViewController.m
//  SmartBIMS
//
//  Created by  on 11. 11. 7..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBInfoViewController.h"
#import "HttpRequest.h"
#import "SBUserInfoVO.h"
#import "JSON.h"
#import "SBNoticeTableViewCell.h"
#import "SBUtils.h"
#import "SBNoticeBodyViewController.h"

#import "Smart_BIMSAppDelegate.h"

@implementation SBInfoViewController

@synthesize m_httpRequest;
@synthesize m_SBUserInfoVO;
@synthesize m_tableView;

@synthesize m_mDataArray;

@synthesize m_activityIndicatorView;

@synthesize m_SBNoticeBodyViewController;

@synthesize m_createNoticeBtn;

@synthesize m_target;
@synthesize m_selector;



- (void)pageReset
{
    [self onSearch:nil];
}


//- (IBAction)changeAPNSSwitch:(id)sender
//{
//    UIApplication* app = [UIApplication sharedApplication];
//    
//    if(m_APNSSwitch.on == YES){
//        //APNS 에 장치 등록
//        [app registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//        
//        //Badge 개수 설정
//        app.applicationIconBadgeNumber = 0;
//        
//        m_APNSStatusLabel.text = @"알림 메시지를 받습니다.";
//    }else{
//        [app unregisterForRemoteNotifications];
//        m_APNSStatusLabel.text = @"알림 메시지를 받지 않습니다.";
//    }
//}




- (IBAction)onSearch:(id)sender
{
    NSString* tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
    NSString* tempIdNo = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBNoticeWithConfirmInfoDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"notice_list", @"reqId",
                                tempOrgCode, @"orgcode",
                                tempIdNo, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveNoticeList:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}

- (void)didReceiveNoticeList:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
    
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
    
    strRowCnt = [dictionary valueForKey:@"cnt"];
    //    self.m_strPageTotalNumLabel.text = strRowCnt;
    
    int nDetailPageCnt = [strRowCnt intValue];
    
    if(nDetailPageCnt > 0){
        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
    }else{
        [m_mDataArray removeAllObjects];
    }

    [self.m_tableView reloadData];
}



- (IBAction)onToHomeBtnTab:(id)sender
{
    static UIViewAnimationTransition orders[4] = {
    	UIViewAnimationTransitionCurlDown,
    	UIViewAnimationTransitionCurlUp,
    	UIViewAnimationTransitionFlipFromLeft,
    	UIViewAnimationTransitionFlipFromRight,
    };
    
    [UIView beginAnimations:nil context:nil];
	
	[UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:orders[1]
    					   forView:self.view.superview
                             cache:YES];
    
    [self.view removeFromSuperview];
    
    [m_target performSelector:m_selector withObject:nil];
    
    
//    
//    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
//	self.view.frame = frame;
//	
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.5];
//	
//	self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
	
	[UIView commitAnimations];
//	[NSTimer scheduledTimerWithTimeInterval:1.25
//									 target:self
//								   selector:@selector(onToHomeViewSelector)
//								   userInfo:nil
//									repeats:NO];
}


- (void) onToHomeViewSelector
{
    //    [self.m_bldProcPickerViewController.view removeFromSuperview];
    [m_target performSelector:m_selector withObject:nil];
	[self.view removeFromSuperview];
}


- (void)onSelectTableViewCell:(id)seqObj
{
    TRACE(@"selectedTableVeiwCell seq = [%@]", (NSString*)seqObj);
    
    NSString* tempIdNo = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBNoticeWithConfirmInfoDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"notice_body", @"reqId",
                                (NSString*)seqObj, @"notice_seq",
                                tempIdNo, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveNoticeBody:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}

- (void)didReceiveNoticeBody:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
    
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
    
    strRowCnt = [dictionary valueForKey:@"cnt"];
    //    self.m_strPageTotalNumLabel.text = strRowCnt;
    
    int nDetailPageCnt = [strRowCnt intValue];
    
    if(nDetailPageCnt > 0){
        NSMutableArray* mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
        
        if(m_SBNoticeBodyViewController == nil){
            if(winHeight == kWINDOW_HEIGHT){
                m_SBNoticeBodyViewController = [[SBNoticeBodyViewController alloc] initWithNibName:@"SBNoticeBodyViewController"
                                                                                            bundle:nil];
            }else{
                m_SBNoticeBodyViewController = [[SBNoticeBodyViewController alloc] initWithNibName:@"SBNoticeBodyViewController3"
                                                                                            bundle:nil];
            }
        }
        
        //    m_SBNoticeBodyViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
        
        TRACE(@"title is [%@]", [NSString stringWithFormat:@"%@", [[mDataArray objectAtIndex:0] objectForKey:@"title"]]);
                                                                                                                                                                    
        [m_SBNoticeBodyViewController setDelegate:self selector:@selector(onSearch:)];
        
        CGRect frame = CGRectMake(768, 0, viewWidth, viewHeight);
        m_SBNoticeBodyViewController.view.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        m_SBNoticeBodyViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        [self.view addSubview:m_SBNoticeBodyViewController.view];
        
        [UIView commitAnimations];
        
        m_SBNoticeBodyViewController.m_titleLabel.text = [NSString stringWithFormat:@"%@", [[mDataArray objectAtIndex:0] objectForKey:@"title"]];
        m_SBNoticeBodyViewController.m_notifierLabel.text = [NSString stringWithFormat:@"%@ - [%@]", [[mDataArray objectAtIndex:0] objectForKey:@"idname"], [[mDataArray objectAtIndex:0] objectForKey:@"notifier_orgname"]];
        m_SBNoticeBodyViewController.m_dateLabel.text = [NSString stringWithFormat:@"%@ %@",[SBUtils getDateFormatWithString:[[mDataArray objectAtIndex:0] objectForKey:@"notice_day"]], [[mDataArray objectAtIndex:0] objectForKey:@"notice_time"]];
        m_SBNoticeBodyViewController.m_targetLabel.text = [[mDataArray objectAtIndex:0] objectForKey:@"orgname"];
        
        NSString* tempBody = [[mDataArray objectAtIndex:0] objectForKey:@"body"];
        
        m_SBNoticeBodyViewController.m_textView.text = [tempBody stringByReplacingOccurrencesOfString:@"\\" withString:@"\r\n"];
        
        [mDataArray release];
    }else{

    }
}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}




#pragma mark -
#pragma mark UITableDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strSeq = [[m_mDataArray objectAtIndex:indexPath.row] objectForKey:@"notice_seq"];
    NSString* tempIdNo = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBNoticeWithConfirmInfoDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"notice_body", @"reqId",
                                strSeq, @"notice_seq",
                                tempIdNo, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveNoticeBody:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
    
    return nil;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_mDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellid = @"SBNoticeTableViewCellId";
    SBNoticeTableViewCell* cell = (SBNoticeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBNoticeTableViewCell"
													 owner:self
												   options:nil];
		for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBNoticeTableViewCell class]]){
				cell = (SBNoticeTableViewCell*)oneObject;
			}
		}
	}
    
    int nRow = (int)indexPath.row;
    
    cell.m_strSeq = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"notice_seq"];
    cell.m_orgNameLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"orgname"];
//    cell.m_idNameLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"idname"];
    cell.m_dateLabel.text = [SBUtils getDateFormatWithString:[[m_mDataArray objectAtIndex:nRow] objectForKey:@"notice_day"]];
    
    cell.m_titleLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"title"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType = UITableViewCellAccessoryDetailButton;  //UITableViewCellAccessoryDetailDisclosureButton;
    
//    UITableViewCellAccessoryNone,
//    UITableViewCellAccessoryDisclosureIndicator,
//    UITableViewCellAccessoryDetailDisclosureButton,
//    UITableViewCellAccessoryCheckmark,
//    UITableViewCellAccessoryDetailButton
    
    if([[[m_mDataArray objectAtIndex:nRow] objectForKey:@"confirm_yn"] isEqualToString:@"Y"]){
        cell.m_newInfoLabel.hidden = YES;
    }else{
        cell.m_newInfoLabel.hidden = NO;
    }
	
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString* strSeq = [[m_mDataArray objectAtIndex:indexPath.row] objectForKey:@"notice_seq"];
//    
//    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBNoticeDAO.jsp";
//    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
//                                @"notice_body", @"reqId",
//                                strSeq, @"notice_seq",
//                                nil];
//    
//    [m_httpRequest setDelegate:self
//                      selector:@selector(didReceiveNoticeBody:)];
//    [m_httpRequest requestURL:url
//                   bodyObject:bodyObject];
//    
//    [self.m_activityIndicatorView startAnimating];
//}



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSString* strSeq = [[m_mDataArray objectAtIndex:indexPath.row] objectForKey:@"notice_seq"];
    NSString* tempIdNo = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBNoticeWithConfirmInfoDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"notice_body", @"reqId",
                                strSeq, @"notice_seq",
                                tempIdNo, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveNoticeBody:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}





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
    
    m_mDataArray = [[NSMutableArray alloc] initWithCapacity:64];
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] == YES || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"] == YES){
        m_createNoticeBtn.hidden = NO;
    }else{
        m_createNoticeBtn.hidden = YES;
    }
    
    // APNS switch 설정.
#ifdef APNS_TEST_MODE
//    UIApplication* app = [UIApplication sharedApplication];
//    int nRemoteNotificationTypes = [app enabledRemoteNotificationTypes];
//    
//    if(nRemoteNotificationTypes == 0){
//        m_APNSSwitch.on = NO;
//        m_APNSStatusLabel.text = @"알림 메시지를 받지 않습니다.";
//    }else{
//        m_APNSSwitch.on = YES;
//        m_APNSStatusLabel.text = @"알림 메시지를 받습니다.";
//    }
#else
//    m_APNSSwitch.on = NO;
//    m_APNSSwitch.enabled = NO;
//    m_APNSStatusLabel.text = @"개발중입니다.";
#endif
    
    [self onSearch:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_httpRequest = nil;
    self.m_SBUserInfoVO = nil;
    self.m_tableView = nil;
    
    self.m_mDataArray = nil;
    
    self.m_activityIndicatorView = nil;
    
    self.m_createNoticeBtn = nil;
//    self.m_APNSSwitch = nil;
//    self.m_APNSStatusLabel = nil;
    
    self.m_target = nil;
    self.m_selector = nil;
}

- (void)dealloc
{
    [m_httpRequest release];
    [m_SBUserInfoVO release];
    [m_tableView release];
    
    [m_mDataArray release];
    
    [m_activityIndicatorView release];
    
    [m_createNoticeBtn release];
//    [m_APNSSwitch release];
//    [m_APNSStatusLabel release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
