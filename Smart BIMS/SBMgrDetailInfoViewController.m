//
//  SBMgrDetailInfoViewController.m
//  SmartBIMS
//
//  Created by  on 11. 10. 25..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBMgrDetailInfoViewController.h"
#import "SBMgrMemberTableViewCell.h"

#import "Smart_BIMSAppDelegate.h"
#import "SBUtils.h"


@implementation SBMgrDetailInfoViewController

@synthesize m_carNameLabel;
@synthesize m_siteNameLabel;
@synthesize m_siteCodeLabel;
@synthesize m_envNameLabel;
@synthesize m_malStatusLabel;
@synthesize m_planCntLabel;
@synthesize m_departTimeLabel;
@synthesize m_returnTimeLabel;

@synthesize m_strRemark;
@synthesize m_strMember;

@synthesize m_remarkTextView;
@synthesize m_membersTableView;
@synthesize m_descBgImageView;

@synthesize m_mMemberArray;
@synthesize m_mGbSessionNameArray;
@synthesize m_mIdNameArray;
@synthesize m_mIdNoArray;

@synthesize m_carNameTitleLabel;

@synthesize m_remarkTabBtn;
@synthesize m_memberTabBtn;



- (void)setValuesWithCarName:(NSString*)strCarName
                    sitename:(NSString*)strSiteName
                    sitecode:(NSString*)strSiteCode 
                         env:(NSString*)strEnv 
                   malStatus:(NSString*)strGBMal
                     plancnt:(NSString*)strPlanCnt
                  departTime:(NSString*)strDepartTime
                  returnTime:(NSString*)strReturnTime
                      remark:(NSString*)strRemark
                     members:(NSString*)strMembers
               gbsessionname:(NSString*)strGbSessionName
                      idname:(NSString*)strIdName
                        idno:(NSString*)strIdno
{
    m_carNameLabel.text = strCarName;
    m_siteNameLabel.text = strSiteName;
    m_siteCodeLabel.text = strSiteCode;
    m_envNameLabel.text = strEnv;
    
    // 2013.05.30 변경(기존 0: 정상, 1: 위험, 2: 고위험, 3: 잠재)
    if([strGBMal isEqualToString:@"0"]){
        m_malStatusLabel.text = @"정상";
    }else if([strGBMal isEqualToString:@"1"]){
        m_malStatusLabel.text = @"제한";
        m_malStatusLabel.textColor = [UIColor yellowColor];
    }else if([strGBMal isEqualToString:@"2"]){
        m_malStatusLabel.text = @"고위험";
        m_malStatusLabel.textColor = [UIColor redColor];
    }else if([strGBMal isEqualToString:@"3"]){
        m_malStatusLabel.text = @"가능";
        m_malStatusLabel.textColor = [UIColor blueColor];
    }
//    m_malStatusLabel.text = strGBMal;
    m_planCntLabel.text = strPlanCnt;
    m_departTimeLabel.text = strDepartTime;
    m_returnTimeLabel.text = strReturnTime;
    
    TRACE(@"remarks = [%@]", strRemark);
    
    if([strRemark length] == 0){
        m_strRemark = [[NSString alloc] initWithString:@"없음"];
    }else{
        m_strRemark = [[NSString alloc] initWithString:strRemark];
    }
    
    m_strMember = [[NSString alloc] initWithString:strMembers];
    
    m_remarkTextView.text = m_strRemark;
    
    if([strEnv isEqualToString:@"센터"]){
        m_carNameTitleLabel.text = @"센터명";
    }else{
        m_carNameTitleLabel.text = @"차량명";
    }
    
    m_remarkTabBtn.enabled = NO;
    m_memberTabBtn.enabled = YES;

    if([strMembers length] > 0){
//        NSArray* tempArray = [strMembers componentsSeparatedByString:@"\r\n"];
        NSArray* tempGbSessionNameArray = [strGbSessionName componentsSeparatedByString:@"|"];
        NSArray* tempIdNameArray = [strIdName componentsSeparatedByString:@"|"];
        NSArray* tempIdNoArray = [strIdno componentsSeparatedByString:@"|"];
        
        for(int i = 0; i < [tempGbSessionNameArray count]; i++){
//            TRACE(@"members := [%@]", [tempArray objectAtIndex:i]);
//            [m_mMemberArray addObject:[tempArray objectAtIndex:i]];
            [m_mGbSessionNameArray addObject:[tempGbSessionNameArray objectAtIndex:i]];
            [m_mIdNameArray addObject:[tempIdNameArray objectAtIndex:i]];
            [m_mIdNoArray addObject:[tempIdNoArray objectAtIndex:i]];
        }
        
        [self.m_membersTableView reloadData];
    }
}


- (IBAction)showRemark:(id)sender
{
//    m_remarkTextView.text = m_strRemark;
    m_remarkTextView.hidden = NO;
    m_membersTableView.hidden = YES;
    m_remarkTabBtn.enabled = NO;
    m_memberTabBtn.enabled = YES;
    
    return;
}

- (IBAction)showMember:(id)sender
{
//    m_remarkTextView.text = m_strMember;
    m_remarkTextView.hidden = YES;
    m_membersTableView.hidden = NO;
    m_remarkTabBtn.enabled = YES;
    m_memberTabBtn.enabled = NO;
    
    return;
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
    TRACE(@"self.m_membersTableView.frame.height = [%f]", self.m_membersTableView.frame.size.height);
    return [self.m_mGbSessionNameArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"MemberTableViewCellId";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
//                                       reuseIdentifier:CellIdentifier] autorelease];
//    }
    
    static NSString* cellid = @"SBMgrMemberTableViewCellId";
    SBMgrMemberTableViewCell* cell = (SBMgrMemberTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBMgrMemberTableViewCell"
													 owner:self
												   options:nil];
		for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBMgrMemberTableViewCell class]]){
				cell = (SBMgrMemberTableViewCell*)oneObject;
			}
		}
	}
	
//	cell.backgUIView.backgroundColor = [UIColor whiteColor];
//	cell.textLabel.text = [m_mMemberArray objectAtIndex:indexPath.row];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:15]; 
//    cell.imageView.image = tempImage;
    
    // Set up the cell...
    cell.m_idNoLabel.text = [m_mIdNoArray objectAtIndex:indexPath.row];
    cell.m_idNameLabel.text = [m_mIdNameArray objectAtIndex:indexPath.row];
    cell.m_gbSessionLabel.text = [m_mGbSessionNameArray objectAtIndex:indexPath.row];
	
    return cell;
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
    
    m_mMemberArray = [[NSMutableArray alloc] initWithCapacity:8];
    m_mGbSessionNameArray = [[NSMutableArray alloc] initWithCapacity:8];
    m_mIdNameArray = [[NSMutableArray alloc] initWithCapacity:8];
    m_mIdNoArray = [[NSMutableArray alloc] initWithCapacity:8];
    
    
    // for iphone5
    if(winHeight == kWINDOW_HEIGHT){
        self.m_membersTableView.frame = CGRectMake(11, 190, 298, 245);
        self.m_remarkTextView.frame = CGRectMake(11, 190, 298, 245);
        self.m_descBgImageView.frame = CGRectMake(10, 189, 300, 247);
    }else{
//        self.m_membersTableView.frame = CGRectMake(11, 190, 298, 164);
//        self.m_remarkTextView.frame = CGRectMake(11, 190, 298, 164);
//        self.m_descBgImageView.frame = CGRectMake(10, 189, 300, 166);
        self.m_membersTableView.frame = CGRectMake(11, 190, 298, 164 + 88);
        self.m_remarkTextView.frame = CGRectMake(11, 190, 298, 164);
        self.m_descBgImageView.frame = CGRectMake(10, 189, 300, 166);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_carNameLabel = nil;
    self.m_siteNameLabel = nil;
    self.m_siteCodeLabel = nil;
    self.m_envNameLabel = nil;
    self.m_malStatusLabel = nil;
    self.m_planCntLabel = nil;
    self.m_departTimeLabel = nil;
    self.m_returnTimeLabel = nil;
    
    self.m_strRemark = nil;
    self.m_strMember = nil;
    
    self.m_membersTableView = nil;
    
    self.m_mMemberArray = nil;
    self.m_mGbSessionNameArray = nil;
    self.m_mIdNameArray = nil;
    self.m_mIdNoArray = nil;
    
    self.m_carNameTitleLabel = nil;
    
    self.m_remarkTabBtn = nil;
    self.m_memberTabBtn = nil;
}

- (void)dealloc
{
    [m_carNameLabel release];
    [m_siteNameLabel release];
    [m_siteCodeLabel release];
    [m_envNameLabel release];
    [m_malStatusLabel release];
    [m_planCntLabel release];
    [m_departTimeLabel release];
    [m_returnTimeLabel release];
    
    [m_strRemark release];
    [m_strMember release];
    
    [m_membersTableView release];
    [m_mMemberArray release];
    [m_mGbSessionNameArray release];
    [m_mIdNameArray release];
    [m_mIdNoArray release];
    
    [m_carNameTitleLabel release];
    
    [m_remarkTabBtn release];
    [m_memberTabBtn release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
