//
//  SBSideEffectsListViewController.m
//  SmartBIMS
//
//  Created by wireline_mac2 on 2015. 2. 23..
//
//

#import "SBSideEffectsListViewController.h"

#import "SBUtils.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBSideEffectsTableViewCell.h"

#import "Smart_BIMSAppDelegate.h"

@interface SBSideEffectsListViewController ()

@end

@implementation SBSideEffectsListViewController

@synthesize m_strBloodNo;
@synthesize m_mDataArray;
@synthesize m_tableView;
@synthesize m_activityIndicatorView;

@synthesize m_target;
@synthesize m_selector;



- (void)setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
    self.m_selector = selector;
}


- (IBAction)onBack:(id)sender
{
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.view.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(onBackSelector)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) onBackSelector
{
//    if(m_target){
//        [self pageReset];
//        [m_target performSelector:m_selector];
//    }
    
    [self.view removeFromSuperview];
}


- (void)setValuesWithBloodNo:(NSString*)strBloodNo
{
    self.m_strBloodNo = strBloodNo;
    
    [self onSearch:nil];
}

- (void)pageReset
{
    [m_mDataArray removeAllObjects];
    [m_tableView reloadData];
}


- (void)onSearch:(id)sender
{
    TRACE(@"sideEffectsListViewController onSearch=[%@]", m_strBloodNo);
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBSideEffectsInfoDAO.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"sideEffectsByBloodNo", @"reqId",
                                self.m_strBloodNo, @"bloodno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveSideEffectsInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];

    [self.m_activityIndicatorView startAnimating];
}

- (void)didReceiveSideEffectsInfo:(id)result
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
    
    int nDetailPageCnt = [strRowCnt intValue];
    
    if(nDetailPageCnt > 0){
        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
        m_tableView.hidden = NO;
    }else{
        [m_mDataArray removeAllObjects];
        m_tableView.hidden = YES;
    }

    [self.m_tableView reloadData];
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
    
    static NSString* cellid = @"SBSideEffectsTableViewCellId";
    SBSideEffectsTableViewCell* cell = (SBSideEffectsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBSideEffectsTableViewCell"
                                                     owner:self
                                                   options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[SBSideEffectsTableViewCell class]]){
                cell = (SBSideEffectsTableViewCell*)oneObject;
            }
        }
    }
    
    int nRow = (int)indexPath.row;
    
//    cell.m_bloodDate.text = [NSString stringWithFormat:@"%d", nRow+1];
//    cell.m_bloodNo.text = [SBUtils formatBloodNo:[[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodno"]];
    cell.m_bloodNo.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"blood_no"];
    cell.m_bloodDate.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"blood_date"];
    cell.m_bldProcName.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bld_proc_name"];
    cell.m_sideEffectName.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"side_effects_name"];
    cell.m_occurrenceTime.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"occurrence_time"];
    cell.m_symptomDegree.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"symptom_degree"];
    
    return cell;
}




#pragma mark -
#pragma mark Defaults
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_mDataArray = [[NSMutableArray alloc] initWithCapacity:32];
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
    
    //    self.m_tableView.frame = CGRectMake(0, 138, 320, 450);
    
    [self onSearch:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_mDataArray = nil;
    self.m_tableView = nil;
    self.m_strBloodNo = nil;
}

- (void)dealloc
{
    [m_httpRequest release];
    [m_mDataArray release];
    [m_tableView release];
    [m_strBloodNo release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
