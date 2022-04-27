//
//  SBPreUnfitnessPageViewController.m
//  Smart BIMS
//
//  Created by  on 11. 9. 2..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBPreUnfitnessPageViewController.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"



@implementation SBPreUnfitnessPageViewController

@synthesize m_pageIndex;

@synthesize m_pageIndexLabel;
@synthesize m_dateLabel;
@synthesize m_carNameLabel;
@synthesize m_reasonLabel;

@synthesize m_reasonTextView;


// PageView를 초기화할 때 멤버변수도 세팅.
- (id)initWithPage:(NSInteger)index date:(NSString*)date carName:(NSString*)carName reason:(NSString*)reason reasonText:(NSString*)reasonText
{
    if(self = [super init]){
        self.m_dateLabel.text = [NSString stringWithString:date];
        self.m_carNameLabel.text = carName;
        self.m_reasonLabel.text = reason;
        self.m_reasonTextView.text = reasonText;
        
        TRACE(@"date = [%@]", date);
        TRACE(@"self.m_dateLabel.text = [%@]", self.m_dateLabel.text);
    }
    
    return self;
}


// 초기화 이후 임의로 멤버변수 세팅.
- (void)setPageValuesWithDate:(NSString*)date carName:(NSString*)carName reason:(NSString*)reason 
                   reasonText:(NSString*)reasonText pageIndex:(NSInteger)pageIndex totalPage:(NSInteger)totalPage
{
    self.m_pageIndexLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)pageIndex, (long)totalPage];
    self.m_dateLabel.text = [SBUtils getDateFormatWithString:date];
    self.m_carNameLabel.text = carName;
    self.m_reasonLabel.text = reason;
    self.m_reasonTextView.text = reasonText;
}


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
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    if(winHeight == kWINDOW_HEIGHT){
        self.m_reasonTextView.frame = CGRectMake(10, 170, 300, 268);
    }else{
        self.m_reasonTextView.frame = CGRectMake(10, 170, 300, 180);
    }
    //TRACE(@"viewDidLoad");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
//    TRACE(@"viewDidUnload");
    self.m_pageIndexLabel = nil;
    self.m_dateLabel = nil;
    self.m_carNameLabel = nil;
    self.m_reasonLabel = nil;
    
    self.m_reasonTextView = nil;
}

- (void)dealloc
{
    [m_pageIndexLabel release];
    [m_dateLabel release];
    [m_carNameLabel release];
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
