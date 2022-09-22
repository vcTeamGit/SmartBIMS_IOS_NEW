//
//  SBBloodGatheringListViewController.m
//  SmartBIMS
//
//  Created by  on 11. 11. 10..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBBloodGatheringListViewController.h"

#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBBloodGatheringTableViewCell.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBBloodGatheringListViewController

@synthesize m_SBUserInfoVO;
@synthesize m_bloodNoTextField;
@synthesize m_searchBtn;
@synthesize m_searchConditionSwitch;
@synthesize m_searchConditionLabel;
@synthesize m_rowCntLabel;
@synthesize m_segmentedControl;
@synthesize m_tableView;
@synthesize m_activityIndicatorView;
@synthesize m_mDataArray;

@synthesize m_noDataLabel;



- (IBAction)onChangeSearchConditionSwitchValue:(id)sender
{
    if([m_searchConditionSwitch isOn] == YES){
        m_searchConditionLabel.textColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.0 alpha:1.0];
        m_searchConditionLabel.text = @"미완료";
    }else{
        m_searchConditionLabel.textColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.8 alpha:1.0];
        m_searchConditionLabel.text = @"전 체";
    }
    
    [self onSearch:nil];
}


- (IBAction)onListOrderingConditionChange:(id)sender
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
	[self.view removeFromSuperview];
}


- (IBAction)onSearch:(id)sender
{
    NSString* tempBloodNo = m_bloodNoTextField.text;
    
    NSString* tempUserId = nil;
    NSString* tempCondition = nil;
    NSString* tempSortCondition = nil;
    
    m_noDataLabel.hidden = YES;
    m_rowCntLabel.text = @"0";
    
    TRACE(@"onSearch Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempUserId = @"R2019015";
    }else{
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    
    TRACE(@"onSearch tempUserId [%@]", tempUserId);
    
    if([m_searchConditionSwitch isOn] == NO){
        tempCondition = @"bloodGatheringInfo";
    }else{
        tempCondition = @"bloodGatheringNotCompletedInfo";
    }
    
    // Sort Condition
    
    TRACE(@"selectedSegmentIndex : [%ld]", (long)m_segmentedControl.selectedSegmentIndex);
    if(m_segmentedControl.selectedSegmentIndex == 0){
//        tempSortCondition = @"bloodNoDESC";
        tempSortCondition = @"forCarCode";
    }else if(m_segmentedControl.selectedSegmentIndex == 1){
//        tempSortCondition = @"bloodEndTimeDESC";
        tempSortCondition = @"forSiteCode";
    }else{
        tempSortCondition = @"";
    }
    
    // 2022.09.22 MOD URL을 검수 및 상용으로 나누어 관리할 수 있도록 변경
    NSString* url = URL_SEARCH_BLOOD_COLLECTION;
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempCondition, @"reqId",
                                tempBloodNo, @"bloodno",
                                tempUserId, @"idno",
                                tempSortCondition, @"sortCondition",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveBloodGatheringInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    m_searchBtn.enabled = NO;
    [self.m_activityIndicatorView startAnimating];
}

- (void)didReceiveBloodGatheringInfo:(id)result
{
    NSString* strData;
    NSString* strRowCnt;
    
    m_noDataLabel.hidden = NO;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    m_searchBtn.enabled = YES;
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
    
    m_rowCntLabel.text = strRowCnt;
    
    int nDetailPageCnt = [strRowCnt intValue];
    
    if(nDetailPageCnt > 0){
        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
        m_tableView.hidden = NO;
    }else{
        [m_mDataArray removeAllObjects];
        m_tableView.hidden = YES;
    }
    
    [self backgroundTab:nil];
    [self.m_tableView reloadData];
    
//    strData = nil;
//    strRowCnt = nil;
}


- (IBAction)backgroundTab:(id)sender
{
    [m_bloodNoTextField resignFirstResponder];
}

- (void)pageReset
{
    [m_mDataArray removeAllObjects];
    [m_tableView reloadData];
    
    [self onSearch:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    NSUInteger strLength = textField.text.length;
    
    switch(nTag){
        case kBloodNoTextFieldTag :
            if(strLength == 12){
                [self onSearch:nil]; 
            }else{
                return NO;
            }
            break;
        default:
            return YES;
    }
    
    return YES;
}




#pragma mark -
#pragma mark UITableDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    static NSString* cellid = @"SBBloodGatheringTableViewCellId";
    SBBloodGatheringTableViewCell* cell = (SBBloodGatheringTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBBloodGatheringTableViewCell"
													 owner:self
												   options:nil];
		for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBBloodGatheringTableViewCell class]]){
				cell = (SBBloodGatheringTableViewCell*)oneObject;
			}
		}
	}
    
    int nRow = (int)indexPath.row;
    
    cell.m_rowNumLabel.text = [NSString stringWithFormat:@"%d", nRow+1];
    cell.m_bloodNoLabel.text = [SBUtils formatBloodNo:[[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodno"]];
    //
    [cell.m_strBarcodeBloodNo setString:[[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodno"]];
    cell.m_carNameLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"carname"];
    
    NSString* tempMatch01 = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"match01"];
    NSString* tempMatch02 = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"match02"];
    NSString* tempBloodEndTime = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodendtime"];
    NSString* tempChkFlagDesc = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"chkflagdesc"];
    NSString* tempistakeover = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"istakeover"];
    
    if([tempMatch01 isEqualToString:@"T"]){
        cell.m_firstMatchingImage.hidden = NO;
        cell.m_firstMatchingBtnNO.hidden = YES;
    }else{
        cell.m_firstMatchingImage.hidden = YES;
        cell.m_firstMatchingBtnNO.hidden = NO;
    }
    
    if([tempMatch02 isEqualToString:@"T"]){
        cell.m_secondMatchingImage.hidden = NO;
        cell.m_secondMatchingBtnNO.hidden = YES;
    }else{
        cell.m_secondMatchingImage.hidden = YES;
        cell.m_secondMatchingBtnNO.hidden = NO;
    }
    
    if([tempBloodEndTime isEqualToString:@"F"]){
        cell.m_bloodEndTimeImage.hidden = YES;
        cell.m_bloodEndTimeBtnNO.hidden = NO;
        cell.m_bloodEndTimeLabel.hidden = YES;
    }else{
        cell.m_bloodEndTimeImage.hidden = NO;
        cell.m_bloodEndTimeBtnNO.hidden = YES;
        cell.m_bloodEndTimeLabel.text = tempBloodEndTime;
    }
    

    if([tempChkFlagDesc isEqualToString:@"미입력"] || [tempChkFlagDesc isEqualToString:@""]|| [tempChkFlagDesc isEqualToString:@" "] || tempChkFlagDesc == nil){
        cell.m_equipmentImageNo.hidden = NO;
        cell.m_equipmentImage.hidden = YES;
        cell.m_equipmentLabel.hidden = YES;
    }else if([tempChkFlagDesc isEqualToString:@"정상"]){
        cell.m_equipmentImage.hidden = NO;
        cell.m_equipmentImageNo.hidden = YES;
        cell.m_equipmentLabel.hidden = YES;
    }else{
        cell.m_equipmentLabel.hidden = NO;
        cell.m_equipmentLabel.text = tempChkFlagDesc;
        cell.m_equipmentImage.hidden = YES;
        cell.m_equipmentImageNo.hidden = YES;
    }
	
    if([tempistakeover isEqualToString:@"N"]){
        cell.m_beforeTakeOver.hidden = NO;
        cell.m_afterTakeOver.hidden = YES;
    }else{
        cell.m_beforeTakeOver.hidden = YES;
        cell.m_afterTakeOver.hidden = NO;
    }
    
    
    return cell;
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
    
    self.m_bloodNoTextField.text = @"";
    
//    self.m_tableView.frame = CGRectMake(0, 138, 320, 450);
    
    [self onSearch:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_SBUserInfoVO = nil;
    self.m_bloodNoTextField = nil;
    self.m_searchBtn = nil;
    self.m_searchConditionSwitch = nil;
    self.m_searchConditionLabel = nil;
    self.m_rowCntLabel = nil;
    self.m_tableView = nil;
    self.m_activityIndicatorView = nil;
    self.m_mDataArray = nil;
    
    self.m_noDataLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
