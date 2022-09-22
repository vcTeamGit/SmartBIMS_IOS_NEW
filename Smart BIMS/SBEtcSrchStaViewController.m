//
//  SBEtcSrchStaViewController.m
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 16..
//
//

#import "SBEtcSrchStaViewController.h"

#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"

#import "SBEtcSrchStaTableViewCell.h"

@interface SBEtcSrchStaViewController ()

@end

@implementation SBEtcSrchStaViewController

@synthesize m_SBUserInfoVO;
@synthesize m_mDataArray;
@synthesize m_tableView;
@synthesize m_activityIndicatorView;

@synthesize m_tabbar;
@synthesize m_view0;
@synthesize m_view1;

@synthesize m_label21;
@synthesize m_labelTotal;

@synthesize m_label31;
@synthesize m_label32;

@synthesize m_label61;
@synthesize m_label62;
@synthesize m_label63;
@synthesize m_label64;
@synthesize m_label65;
@synthesize m_label66;


@synthesize m_bldCntLabel;
@synthesize m_bldRegCntLabel;
@synthesize m_spcCntLabel;
@synthesize m_notCntLabel;
@synthesize m_unfitnessDocumentCntLabel;

@synthesize m_unfitnessEDocumentCntLabel;
@synthesize m_regCntLabel;
@synthesize m_golsuCntLabel;
@synthesize m_eEmiCntLabel;
@synthesize m_registerFingerCntLabel;

@synthesize m_lftCntLabel;
@synthesize m_cbcCntLabel;
@synthesize m_ddrReleaseCntLabel;



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
								   selector:@selector(onToHomeViewSelector)
								   userInfo:nil
									repeats:NO];
}

- (void) onToHomeViewSelector
{
	[self.view removeFromSuperview];
}



- (IBAction)pageReset:(id)sender
{
    m_label21.text = @"";
    m_label31.text = @"";
    m_label32.text = @"";
    m_label61.text = @"";
    m_label62.text = @"";
    m_label63.text = @"";
    m_label64.text = @"";
    m_label65.text = @"";
    m_label66.text = @"";
    m_labelTotal.text = @"";
    
    m_bldCntLabel.text = @"";
    m_bldRegCntLabel.text = @"";
    m_spcCntLabel.text = @"";
    m_notCntLabel.text = @"";
    m_unfitnessDocumentCntLabel.text = @"";
    
    m_unfitnessEDocumentCntLabel.text = @"";
    m_regCntLabel.text = @"";
    m_golsuCntLabel.text = @"";
    m_eEmiCntLabel.text = @"";
    m_registerFingerCntLabel.text = @"";
    
    m_lftCntLabel.text = @"";
    m_cbcCntLabel.text = @"";
    m_ddrReleaseCntLabel.text = @"";
}


- (void)onSearch:(NSString*)tag
{
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    NSString* tempSiteCode = nil;
    NSString* tempReqId = @"board_body";
    
    //    m_noDataLabel.hidden = YES;
    //    m_rowCntLabel.text = @"0";
    
    TRACE(@"%ld", (long)m_tabbar.selectedItem.tag);
    
    if(m_tabbar.selectedItem.tag == 1){
        tempReqId = @"all";
    }else if(m_tabbar.selectedItem.tag == 2){
        tempReqId = @"wbbag";
    }else if(m_tabbar.selectedItem.tag == 3){
        tempReqId = @"sdp";
    }else if(m_tabbar.selectedItem.tag == 4){
        tempReqId = @"abo";
    }else{
        tempReqId = @"summary";
    }
    
//    m_label21.text = @"";
//    m_label31.text = @"";
//    m_label32.text = @"";
//    m_label61.text = @"";
//    m_label62.text = @"";
//    m_label63.text = @"";
//    m_label64.text = @"";
//    m_label65.text = @"";
//    m_label66.text = @"";
//    m_labelTotal.text = @"";
    [self pageReset:nil];
    
    if(m_tabbar.selectedItem.tag == 0){
        
    }else if(m_tabbar.selectedItem.tag == 1){
        m_label21.text = @"헌혈종류";
        m_labelTotal.text = @"계";
    }else if(m_tabbar.selectedItem.tag == 2){
        m_label31.text = @"헌혈종류";
        m_label32.text = @"백종류";
        m_labelTotal.text = @"계";
    }else if(m_tabbar.selectedItem.tag == 3){
        m_label31.text = @"성분헌혈";
        m_label32.text = @"장비명";
        m_labelTotal.text = @"계";
    }else if(m_tabbar.selectedItem.tag == 4){
        m_label61.text = @"구분";
        m_label62.text = @"종류";
        m_label63.text = @"O";
        m_label64.text = @"A";
        m_label65.text = @"B";
        m_label66.text = @"AB";
        m_labelTotal.text = @"계";
    }

    
//    int nTag = [tag intValue];
//    
//    switch(nTag){
//        case 1:
//            tempReqId = @"all";
//            break;
//        case 2:
//            tempReqId = @"wbbag";
//            break;
//        case 3:
//            tempReqId = @"sdp";
//            break;
//        case 4:
//            tempReqId = @"abo";
//            break;
//        case 0:
//            tempReqId = @"summary";
//            break;
//        default:
//            tempReqId = @"summary";
//            break;
//    } 
    
    TRACE(@"%@", tempReqId);
    
    TRACE(@"onSearch Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"001";
        tempCarCode = @"02";
        tempSiteCode = @"";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
        tempSiteCode = [NSString stringWithString:m_SBUserInfoVO.szBimsSitecode];
    }
    
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    TRACE(@"onSearch tempUserId [%@]", tempUserId);
    
    if(m_tabbar.selectedItem.tag == 0){
        // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
        NSString* url = URL_STAT_BLOOD_COLLECTION;
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    tempReqId, @"reqId",
                                    tempOrgCode, @"orgcode",
                                    tempCarCode, @"carcode",
                                    tempSiteCode, @"sitecode",
                                    nil];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveSummary:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
    }else{
        // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
        NSString* url = URL_STAT_BLOOD_COLLECTION;
        NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    tempReqId, @"reqId",
                                    tempOrgCode, @"orgcode",
                                    tempCarCode, @"carcode",
//                                    tempSiteCode, @"sitecode",
                                    nil];
        
        [m_httpRequest setDelegate:self
                          selector:@selector(didReceiveList:)];
        [m_httpRequest requestURL:url
                       bodyObject:bodyObject];
    }
    
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveSummary:(id)result
{
    NSString* strData;
//    NSString* strRowCnt;
    
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
    
    m_bldCntLabel.text = [dictionary valueForKey:@"bld_cnt"];
    m_bldRegCntLabel.text = [dictionary valueForKey:@"bld_reg_cnt"];
    m_spcCntLabel.text = [dictionary valueForKey:@"spc_cnt"];
    m_notCntLabel.text = [dictionary valueForKey:@"not_cnt"];
    m_unfitnessDocumentCntLabel.text = [dictionary valueForKey:@"unfitness_document_cnt"];
    
    m_unfitnessEDocumentCntLabel.text = [dictionary valueForKey:@"unfitness_e_document_cnt"];
    m_regCntLabel.text = [dictionary valueForKey:@"reg_cnt"];
    m_golsuCntLabel.text = [dictionary valueForKey:@"golsu_cnt"];
    m_eEmiCntLabel.text = [dictionary valueForKey:@"e_emi_cnt"];
    m_registerFingerCntLabel.text = [dictionary valueForKey:@"register_finger_cnt"];
    
    m_lftCntLabel.text = [dictionary valueForKey:@"lft_cnt"];
    m_cbcCntLabel.text = [dictionary valueForKey:@"cbc_cnt"];
    m_ddrReleaseCntLabel.text = [dictionary valueForKey:@"ddr_release_cnt"];
}



- (void)didReceiveList:(id)result
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
    
    int nListCnt = [strRowCnt intValue];
    
    if(nListCnt > 0){
        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
    }else{
        [m_mDataArray removeAllObjects];
    }
    
    [self.m_tableView reloadData];
}



#pragma mark -
#pragma mark UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    TRACE(@"TabBar selected=[%ld]", (long)item.tag);
    
    switch(item.tag)
    {
        case 0:
            [self.view bringSubviewToFront:m_view0];
            [self onSearch:@"0"];
            break;
        case 1:
            [self.view bringSubviewToFront:m_view1];
            [self onSearch:@"1"];
            break;
        case 2:
            [self.view bringSubviewToFront:m_view1];
            [self onSearch:@"2"];
            break;
        case 3:
            [self.view bringSubviewToFront:m_view1];
            [self onSearch:@"3"];
            break;
        default:
            [self.view bringSubviewToFront:m_view1];
            [self onSearch:@"4"];
            break;
    }
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
    
    static NSString* cellid = @"SBEtcSrchStaTableViewCellId";
    SBEtcSrchStaTableViewCell* cell = (SBEtcSrchStaTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBEtcSrchStaTableViewCell"
													 owner:self
												   options:nil];
		for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBEtcSrchStaTableViewCell class]]){
				cell = (SBEtcSrchStaTableViewCell*)oneObject;
			}
		}
	}
    
    int nRow = (int)indexPath.row;
    
    cell.m_label21.text = @"";
    cell.m_label31.text = @"";
    cell.m_label32.text = @"";
    cell.m_label61.text = @"";
    cell.m_label62.text = @"";
    cell.m_label63.text = @"";
    cell.m_label64.text = @"";
    cell.m_label65.text = @"";
    cell.m_label66.text = @"";
    cell.m_labelTotal.text = @"";
    
    if(m_tabbar.selectedItem.tag == 0){
//        cell.m_enterDateLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"enterdate"];
//        cell.m_enterTimeLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"entertime"];
    }else if(m_tabbar.selectedItem.tag == 1){
        cell.m_label21.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocname"];
        cell.m_labelTotal.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"cnt"];
        if([cell.m_label21.text isEqualToString:@"소계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:0.87f green:0.98f blue:0.83f alpha:1.0f];
        }else if([cell.m_label21.text isEqualToString:@"합계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:0.81f blue:0.81f alpha:1.0f];
        }else{
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        }
    }else if(m_tabbar.selectedItem.tag == 2){
        cell.m_label31.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocname"];
        cell.m_label32.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bagname"];
        cell.m_labelTotal.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"cnt"];
        if([cell.m_label32.text isEqualToString:@"소계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:0.87f green:0.98f blue:0.83f alpha:1.0f];
        }else if([cell.m_label32.text isEqualToString:@"합계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:0.81f blue:0.81f alpha:1.0f];
        }else{
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        }
    }else if(m_tabbar.selectedItem.tag == 3){
        cell.m_label31.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocname"];
        cell.m_label32.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocinterface"];
        cell.m_labelTotal.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"cnt"];
        if([cell.m_label32.text isEqualToString:@"소계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:0.87f green:0.98f blue:0.83f alpha:1.0f];
        }else if([cell.m_label32.text isEqualToString:@"합계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:0.81f blue:0.81f alpha:1.0f];
        }else{
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        }
    }else if(m_tabbar.selectedItem.tag == 4){
        cell.m_label61.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocname"];
        cell.m_label62.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"name"];
        cell.m_label63.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"O"];
        cell.m_label64.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"A"];
        cell.m_label65.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"B"];
        cell.m_label66.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"AB"];
        cell.m_labelTotal.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"CNT"];
        
        if([cell.m_label62.text isEqualToString:@"소계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:0.87f green:0.98f blue:0.83f alpha:1.0f];
        }else if([cell.m_label62.text isEqualToString:@"합계"]){
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:0.81f blue:0.81f alpha:1.0f];
        }else{
            cell.m_bgImageView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        }
    }
	
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int nRow = (int)indexPath.row;
    TRACE(@"seqno=[%@]", [[m_mDataArray objectAtIndex:nRow] objectForKey:@"seqno"]);
}




#pragma mark -
#pragma mark default

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
    
    m_mDataArray = [[NSMutableArray alloc] initWithCapacity:64];
    
    [self pageReset:nil];
    
//    [self.view addSubview:m_view4];
//    CGRect frame = CGRectMake(0, 44, 320, 455);
//	m_view4.frame = CGRectMake(0, 44, 320, 455);
//    [self.view addSubview:m_view3];
//    m_view3.frame = CGRectMake(0, 44, 320, 455);
//    [self.view addSubview:m_view2];
//    m_view2.frame = CGRectMake(0, 44, 320, 455);
    
    if(winHeight == kWINDOW_HEIGHT){
        [self.view addSubview:m_view1];
        m_view1.frame = CGRectMake(0, 44, 320, 455);
        [self.view addSubview:m_view0];
        m_view0.frame = CGRectMake(0, 44, 320, 455);
        TRACE(@"************************** iPhone5 *****************************");
    }else{
        [self.view addSubview:m_view1];
        m_view1.frame = CGRectMake(0, 44, 320, 367);
        [self.view addSubview:m_view0];
        m_view0.frame = CGRectMake(0, 44, 320, 367);
        TRACE(@"************************** iPhone4 *****************************");
    }

    
//    [self onSearch:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    // iOS 버전에 따른 UI분기
//    if([[UIDevice currentDevice].systemVersion floatValue] < 7){
//        m_tabbar.frame = CGRectMake(0, 519, 320, 49);
//        TRACE(@"************************** iOS6 *****************************");
//    }else{
//        // handling statusBar (iOS7)
//        m_tabbar.frame = CGRectMake(0, 499, 320, 49);
//        TRACE(@"************************** iOS7 *****************************");
//    }
    
//    if(winHeight == kWINDOW_HEIGHT){
//        m_tabbar.frame = CGRectMake(0, 499, 320, 49);
//        TRACE(@"************************** iPhone5 *****************************");
//    }else{
//        // handling statusBar (iOS7)
//        m_tabbar.frame = CGRectMake(0, 382, 320, 49);
//        TRACE(@"************************** iPhone4 *****************************");
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
