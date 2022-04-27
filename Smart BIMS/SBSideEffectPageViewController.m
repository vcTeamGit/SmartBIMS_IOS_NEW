//
//  SBSideEffectPageViewController.m
//  Smart BIMS
//
//  Created by  on 11. 9. 19..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBSideEffectPageViewController.h"

#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"



@implementation SBSideEffectPageViewController

@synthesize m_pageIndex;
@synthesize m_pageIndexLabel;
@synthesize m_dateLabel;
@synthesize m_carNameLabel;
@synthesize m_bldProcNameLabel;
@synthesize m_hospitalLabel;
@synthesize m_reasonLabel;

@synthesize m_reasonTextView;


- (void)setPageValuesWithDate:(NSString*)date carName:(NSString*)carName bldProcName:(NSString*)bldProcName hospital:(NSString*)hospital reason:(NSString*)reason reasonText:(NSString*)reasonText pageIndex:(NSInteger)pageIndex  totalPage:(NSInteger)totalPage
{
    self.m_pageIndexLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)pageIndex, (long)totalPage];
    self.m_dateLabel.text = [SBUtils getDateFormatWithString:date];
    self.m_carNameLabel.text = carName;
    self.m_bldProcNameLabel.text = bldProcName;
    self.m_hospitalLabel.text = hospital;
    self.m_reasonLabel.text = reason;
    self.m_reasonTextView.text = reasonText;
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
    
    if(winHeight == kWINDOW_HEIGHT){
        self.m_reasonTextView.frame = CGRectMake(10, 216, 300, 227);
    }else{
        self.m_reasonTextView.frame = CGRectMake(10, 216, 300, 139);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.m_pageIndexLabel = nil;
    self.m_dateLabel = nil;
    self.m_carNameLabel = nil;
    self.m_bldProcNameLabel = nil;
    self.m_hospitalLabel = nil;
    self.m_reasonLabel = nil;
    
    self.m_reasonTextView = nil;
}

- (void)dealloc
{
    [m_pageIndexLabel release];
    [m_dateLabel release];
    [m_carNameLabel release];
    [m_bldProcNameLabel release];
    [m_hospitalLabel release];
    [m_reasonLabel release];
    
    [m_reasonTextView release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
