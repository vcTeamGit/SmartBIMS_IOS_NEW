//
//  SBBoardViewController.m
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 11..
//
//

#import "SBBoardViewController.h"

#import "SBBoardTableViewCell.h"

#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

#import "SBBoardContentViewController.h"

@interface SBBoardViewController ()

@end

@implementation SBBoardViewController

@synthesize m_SBUserInfoVO;
@synthesize m_mDataArray;
@synthesize m_tableView;
@synthesize m_activityIndicatorView;

@synthesize m_switch;
@synthesize m_switchStatusLabel;

@synthesize m_boardContentViewController;

@synthesize m_target;
@synthesize m_selector;



- (IBAction)onSearch:(id)sender
{
    NSString* tempOrgCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"board_body";
    
//    m_noDataLabel.hidden = YES;
//    m_rowCntLabel.text = @"0";
    
    if([m_switch isOn]){
        tempReqId = @"board_body";
        m_switchStatusLabel.text = @"확인한 공지사항 필터링 됨";
    }else{
        tempReqId = @"board_nonfiltered_body";
        m_switchStatusLabel.text = @"유효기간 내의 모든 공지사항 조회됨";
    }
    
    TRACE(@"%@", tempReqId);
    
    TRACE(@"onSearch Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2022106"]){
        tempOrgCode = @"002";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
    }
    
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    TRACE(@"onSearch tempUserId [%@]", tempUserId);
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_NOT_CONFIRM_NOTICE_CNT;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                tempOrgCode, @"orgcode",
                                tempUserId, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveBoardList:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    m_activityIndicatorView.hidden = FALSE;
    [m_activityIndicatorView startAnimating];

}

- (void)didReceiveBoardList:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    [m_activityIndicatorView stopAnimating];
    m_activityIndicatorView.hidden = TRUE;
    
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
    
    int nListCnt = [strRowCnt intValue];
    
    if(nListCnt > 0){
        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
    }else{
        [m_mDataArray removeAllObjects];
    }
    
    [self.m_tableView reloadData];
    
//    m_rowCntLabel.text = strRowCnt;
//    
//    int nDetailPageCnt = [strRowCnt intValue];
//    
//    if(nDetailPageCnt > 0){
//        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
//        m_tableView.hidden = NO;
//    }else{
//        [m_mDataArray removeAllObjects];
//        m_tableView.hidden = YES;
//    }
//    
//    [self backgroundTab:nil];
//    [self.m_tableView reloadData];
}

- (IBAction)onSearchBoardList:(id)sender
{
    
}

- (IBAction)onSearchBoardContentList:(id)sender
{
    
}


- (IBAction)onToHomeBtnTab:(id)sender
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
    [m_target performSelector:m_selector withObject:nil];
	[self.view removeFromSuperview];
}

- (IBAction)backgroundTab:(id)sender
{
    
}


//- (void)goToBoardContentView:(NSDictionary*)obj
- (void)goToBoardContentView:(NSString*)tempSeqNo indexID:(NSString*)tempIndexId
{
    //NSString* tempSeqNo = [obj valueForKey:@"seqno"];
    //NSString* tempIndexId = [obj valueForKey:@"indexId"];
    
    int nRowIndex = [tempIndexId intValue];
    
    TRACE(@"%@, %d", tempSeqNo, nRowIndex);
    
    
    if(m_boardContentViewController == nil){
        if(winHeight == kWINDOW_HEIGHT){
            m_boardContentViewController = [[SBBoardContentViewController alloc] initWithNibName:@"SBBoardContentViewController"
                                                                                          bundle:nil];
        }else{
            m_boardContentViewController = [[SBBoardContentViewController alloc] initWithNibName:@"SBBoardContentNewViewController"
                                                                                          bundle:nil];
        }
    }
    
    
    CGRect frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    m_boardContentViewController.view.frame = frame;
    m_boardContentViewController.m_SBUserInfoVO = self.m_SBUserInfoVO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    m_boardContentViewController.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    m_boardContentViewController.m_enterDateLabel.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"enterdate"];
    m_boardContentViewController.m_enterTimeLabel.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"entertime"];
    m_boardContentViewController.m_startDateLabel.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"startdate"];
    m_boardContentViewController.m_endDateLabel.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"enddate"];
    m_boardContentViewController.m_enterNameLabel.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"entername"];
    
    m_boardContentViewController.m_boardTitleLabel.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"boardtitle"];
    m_boardContentViewController.m_boardRemarkTextView.text = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"boardremark"];
    
    m_boardContentViewController.m_seqno = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"seqno"];
    
    m_boardContentViewController.m_writeDate = [[m_mDataArray objectAtIndex:nRowIndex] objectForKey:@"writedate"];
    
    [m_boardContentViewController setDelegate:self selector:@selector(onSearch:)];
    
    [self.view addSubview:m_boardContentViewController.view];
    
    [UIView commitAnimations];

}

- (IBAction)onSwitchStatusChange:(id)sender
{
//    TRACE(@"%", [m_switch isOn]);
    NSString* tempReqId = @"";
    if([m_switch isOn]){
        tempReqId = @"board_body";
        m_switchStatusLabel.text = @"유효기간 내의 모든 공지사항 조회됨";
    }else{
        tempReqId = @"board_nonfiltered_body";
        m_switchStatusLabel.text = @"확인한 공지사항 필터링 됨";
    }
    
    TRACE(@"%@", tempReqId);
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
    return indexPath;
    //return nil;
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
    static NSString* cellid = @"SBBoardTableViewCellId";
    SBBoardTableViewCell* cell = (SBBoardTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBBoardTableViewCell"
													 owner:self
												   options:nil];
        for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBBoardTableViewCell class]]){
				cell = (SBBoardTableViewCell*)oneObject;
			}
		}
    }
    
    int nRow = (int)indexPath.row;
    
    cell.m_enterDateLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"enterdate"];
    cell.m_enterTimeLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"entertime"];
    cell.m_startDateLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"startdate"];
    cell.m_endDateLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"enddate"];
    cell.m_enterNameLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"entername"];
    
    cell.m_boardTitleLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"boardtitle"];
    
    cell.m_seqno = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"seqno"];
    
    cell.m_indexId = [NSString stringWithFormat:@"%d", nRow];
    
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [cell setDelegate:self selector:@selector(goToBoardContentView:)];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int nRow = (int)indexPath.row;
    TRACE(@"seqno=[%@]", [[m_mDataArray objectAtIndex:nRow] objectForKey:@"seqno"]);
    TRACE(@"indexId=[%d]", nRow);
    
    [self goToBoardContentView:[[m_mDataArray objectAtIndex:nRow] objectForKey:@"seqno"] indexID:[@(nRow) stringValue]];
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
    
    m_activityIndicatorView.hidden = TRUE;
    
    m_httpRequest = [[HttpRequest alloc] init];
    m_mDataArray = [[NSMutableArray alloc] initWithCapacity:64];
    
//    if(m_boardContentViewController == nil){
//        m_boardContentViewController = [[SBBoardContentViewController alloc] initWithNibName:@"SBBoardContentViewController"
//                                                                                      bundle:nil];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
