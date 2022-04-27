//
//  SBPairingBarcodeViewController.m
//  SmartBIMS
//
//  Created by wireline on 2017. 12. 8..
//

#import "SBPairingBarcodeViewController.h"

#import "Smart_BIMSAppDelegate.h"

@interface SBPairingBarcodeViewController ()

@end

@implementation SBPairingBarcodeViewController


- (IBAction)onHomeButtonTab:(id)sender
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
