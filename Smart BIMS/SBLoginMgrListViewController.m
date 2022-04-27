//
//  SBLoginMgrListViewController.m
//  SmartBIMS
//
//  Created by  on 12. 1. 10..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "SBLoginMgrListViewController.h"
#import "SBLoginMgrListViewCell.h"

@implementation SBLoginMgrListViewController

@synthesize m_tableView;
@synthesize m_array;

@synthesize m_target;
@synthesize m_selector;



- (void) setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
	self.m_selector = selector;
}

- (IBAction)onCancel:(id)sender
{
    if(m_target){
        [m_target performSelector:m_selector withObject:nil];
    }
}


#pragma mark -
#pragma mark UITableDelegate
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    TRACE(@"didSelectRowAtIndexPath row := [%lu]", (unsigned long)row);
    
    TRACE(@"m_array index[%lu] data := [%@]", (unsigned long)row, [m_array objectAtIndex:row]);
    
//    NSString* tempStr = [[NSString alloc] initWithString:[m_array objectAtIndex:row]];
    
    if(m_target){
        [m_target performSelector:m_selector withObject:[m_array objectAtIndex:row]];
    }
//    [m_target performSelector:m_selector];
//    [self.view removeFromSuperview];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_array count];
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{	
	static NSString* cellid = @"cellId";
    SBLoginMgrListViewCell* cell = (SBLoginMgrListViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
//    UITableViewCell* cell;
//    cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBLoginMgrListViewCell"
													 owner:self
												   options:nil];
		for(id oneObject in nib){
			if([oneObject isKindOfClass:[SBLoginMgrListViewCell class]]){
				cell = (SBLoginMgrListViewCell*)oneObject;
			}
		}
	}
    
    NSArray* tempArray = [[m_array objectAtIndex:indexPath.row] componentsSeparatedByString:@":"];
    
    int nCarCode = [[tempArray objectAtIndex:2] intValue];
    
//    TRACE(@"nCarCode := [%d]", nCarCode);
    
    if(nCarCode < 50){
        cell.m_carNameTitleLabel.text = @"차  량  명";
    }else{
        cell.m_carNameTitleLabel.text = @"센  터  명";
    }
    
    cell.m_siteCodeLabel.text = [tempArray objectAtIndex:0];
    cell.m_siteNameLabel.text = [tempArray objectAtIndex:1];
    cell.m_carNameLabel.text = [tempArray objectAtIndex:3];
	
//    cell.textLabel.text = [tempArray objectAtIndex:0];
//    cell.detailTextLabel.text = [tempArray objectAtIndex:1];
    
	return cell;
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_tableView = nil;
    self.m_array = nil;
    
    self.m_target = nil;
    self.m_selector = nil;
}

- (void)dealloc
{
    [m_tableView release];
    [m_array release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
