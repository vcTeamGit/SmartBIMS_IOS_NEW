//
//  SBNoticeBodyViewController.m
//  SmartBIMS
//
//  Created by  on 11. 11. 17..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBNoticeBodyViewController.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"


@implementation SBNoticeBodyViewController

@synthesize m_titleLabel;
@synthesize m_notifierLabel;
@synthesize m_dateLabel;
@synthesize m_targetLabel;

@synthesize m_textView;

@synthesize m_target;
@synthesize m_selector;


- (IBAction)onToBackBtnTab:(id)sender
{
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
	self.view.frame = frame;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	
	self.view.frame = CGRectMake(768, 0, viewWidth, viewHeight);
	
	[UIView commitAnimations];
	[NSTimer scheduledTimerWithTimeInterval:0.5
									 target:self
								   selector:@selector(onToBackViewSelector)
								   userInfo:nil
									repeats:NO];
}


- (void) onToBackViewSelector
{
    [m_target performSelector:m_selector];
	[self.view removeFromSuperview];
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


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
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
    self.m_titleLabel = nil;
    self.m_notifierLabel = nil;
    self.m_dateLabel = nil;
    self.m_targetLabel = nil;
    
    self.m_textView = nil;
    
    self.m_target = nil;
    self.m_selector = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
