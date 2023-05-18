//
//  Smart_BIMSViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "Smart_BIMSViewController.h"
#import "SBLoginViewController.h"
#import "SBDeviceConfirmViewController.h"

#import "Smart_BIMSAppDelegate.h"

#import "SBUtils.h"

@implementation Smart_BIMSViewController

@synthesize m_SBLoginViewController;
@synthesize m_SBDeviceConfirmViewController;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    self.view.backgroundColor = UIColor.blueColor;
    NSLog(@"%f", self.view.frame.size.width);
    //    CGRect rect = [[UIScreen mainScreen] bounds];
//    [self.view setFrame:rect];
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        // The device is an iPad running iPhone 3.2 or later.
//        m_SBLoginViewController = [[SBLoginViewController alloc] initWithNibName:@"SBLoginViewController_iPad"
//                                                                          bundle:nil];
//    }else{
//        // The device is an iPhone or iPod touch.
//        m_SBLoginViewController = [[SBLoginViewController alloc] initWithNibName:@"SBLoginViewController"
//                                                                          bundle:nil];
//    }
    
    
    
//    UIApplication* app = [UIApplication sharedApplication];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(applicationWillResignActiveWithConfigSave:) 
//                                                 name:UIApplicationWillResignActiveNotification
//                                               object:app];
//    
////    UIApplication* app = [UIApplication sharedApplication];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(applicationDidBecomeActiveWithConfigGain:) 
//                                                 name:UIApplicationDidBecomeActiveNotification
//                                               object:app];
    
//    myAppDelegate *appDelegate 
//	= (myAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [[[appDelegate rootViewController] flipsideViewController] myMethod];
    
//    Smart_BIMSAppDelegate* appDelegate = (Smart_BIMSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
//    NSString* phoneNo = appDelegate.m_strPhoneNo;
//    NSString* confirmNo = appDelegate.m_strConfirmNo;
    
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//    delegate.g_strPhoneNo = m_phoneNoTextField.text;
//    delegate.g_strConfirmNo = m_confirmNoTextField.text;
//    TRACE(@"hahaha = %f, %f", [delegate.g_winHeight doubleValue], [delegate.g_viewWidth doubleValue]);
//    TRACE(@"g_winHeight = [%d]", [delegate.g_winHeight intValue]);
    
    TRACE(@"단말 OS버전 [%f]", [[UIDevice currentDevice].systemVersion floatValue]);
    
    
    if([delegate.g_winHeight intValue] == kWINDOW_HEIGHT){
//        m_SBLoginViewController = [[SBLoginViewController alloc] initWithNibName:@"SBLoginViewController"
//                                                                          bundle:nil];
        m_SBLoginViewController = [[SBLoginViewController alloc] initWithNibName:@"SBLoginNewViewController"
                                                                                  bundle:nil];
        
//
        
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            m_SBLoginViewController.view.frame = CGRectMake(0, 0, [delegate.g_viewWidth intValue], [delegate.g_viewHeight intValue]);
        }else{
            m_SBLoginViewController.view.frame = CGRectMake(0, self.view.safeAreaLayoutGuide.layoutFrame.origin.y, [delegate.g_viewWidth intValue], [delegate.g_viewHeight intValue]);
        }
        
        
        
    }else{
//        m_SBLoginViewController = [[SBLoginViewController alloc] initWithNibName:@"SBLoginViewController3"
//                                                                          bundle:nil];
        m_SBLoginViewController = [[SBLoginViewController alloc] initWithNibName:@"SBLoginNewViewController"
                                                                          bundle:nil];
        
        if([[UIDevice currentDevice].systemVersion floatValue] < 7){
            m_SBLoginViewController.view.frame = CGRectMake(0, 0, [delegate.g_viewWidth intValue], [delegate.g_viewHeight intValue]);
        }else{
            m_SBLoginViewController.view.frame = CGRectMake(0, 0, [delegate.g_viewWidth intValue], [delegate.g_viewHeight intValue]);
        }
    }
    
    [self.view addSubview:m_SBLoginViewController.view];
    return;
}


//- (void)applicationWillResignActiveWithConfigSave:(NSNotification *)notification
//{
//    NSMutableDictionary* tempMDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//    
//    [tempMDic setObject:m_strConfirmNo forKey:@"confirmNo"];
//    [tempMDic setObject:m_strPhoneNo forKey:@"phoneNo"];
//
//    [tempMDic writeToFile:[self dataFilePath]
//               atomically:YES];
//    [tempMDic release];
//}
//
//- (void)applicationDidBecomeActiveWithConfigGain:(NSNotification*)notification
//{
//    
//}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_SBLoginViewController = nil;
    self.m_SBDeviceConfirmViewController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
