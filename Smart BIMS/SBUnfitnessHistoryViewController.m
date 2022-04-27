//
//  SBUnfitnessHistoryViewController.m
//  Smart BIMS
//
//  Created by  on 11. 9. 21..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBUnfitnessHistoryViewController.h"
#import "SBUnfitnessHistoryTableCell.h"

#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBUnfitnessHistoryViewController

@synthesize m_mDateArray;
@synthesize m_mDescArray;
@synthesize m_tableView;


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
    [self.view removeFromSuperview];
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
	return [m_mDateArray count];
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{	
	static NSString* cellid = @"SBUnfitnessHistoryTableCellId";
    SBUnfitnessHistoryTableCell* cell = (SBUnfitnessHistoryTableCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
//	UITableViewCell* cell;
//	cell = [tableView dequeueReusableCellWithIdentifier:cellid];
	
	if(cell == nil){
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
//									  reuseIdentifier:cellid];
//		[cell autorelease];
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBUnfitnessHistoryTableCell"
													 owner:self
												   options:nil];
		for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBUnfitnessHistoryTableCell class]]){
				cell = (SBUnfitnessHistoryTableCell*)oneObject;
			}
		}
	}
	
//    cell.textLabel.text = [SBUtils getDateFormatWithString:[m_mDateArray objectAtIndex:indexPath.row]];
//    cell.detailTextLabel.text = [m_mDescArray objectAtIndex:indexPath.row];
    
    cell.m_dateLabel.text = [SBUtils getDateFormatWithString:[m_mDateArray objectAtIndex:indexPath.row]];
    cell.m_descLabel.text = [m_mDescArray objectAtIndex:indexPath.row];
    
	return cell;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return @"DDR History";
//}






#pragma mark - 
#pragma mark Defaults
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_mDateArray = [[NSMutableArray alloc] initWithCapacity:32];
        m_mDescArray = [[NSMutableArray alloc] initWithCapacity:32];
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
    
    // for iphone5
//    self.m_tableView.frame = CGRectMake(0, 44, viewWidth, viewHeight-44);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_mDateArray = nil;
    self.m_mDescArray = nil;
    self.m_tableView = nil;
}

- (void)dealloc
{
    [m_mDateArray release];
    [m_mDescArray release];
    [m_tableView release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
