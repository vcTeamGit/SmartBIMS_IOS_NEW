//
//  SBMgrDatePickerViewController.m
//  SmartBIMS
//
//  Created by  on 11. 11. 1..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBMgrDatePickerViewController.h"

@implementation SBMgrDatePickerViewController

@synthesize m_confirmButton;
@synthesize m_datePicker;

@synthesize m_target;
@synthesize m_selector;



- (IBAction)onSelectMgrDate:(id)sender
{
    [m_target performSelector:m_selector withObject:self.m_datePicker.date];
}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}



#pragma mark -
#pragma mark UIPickerViewDelegate

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
////    NSInteger nComponentIndex = component;
////    
////    if(nComponentIndex == 0){
////        return [m_dicBldProcName1 objectForKey:[m_arrBldProc1 objectAtIndex:row]];
////    }else if(nComponentIndex == 1){
////        return [m_dicBldProcName2 objectForKey:[m_arrBldProc2 objectAtIndex:row]];
////    }else if(nComponentIndex == 2){
////        return [m_dicBldProcName3 objectForKey:[m_arrBldProc3 objectAtIndex:row]];
////    }else{
////        return nil;
////    }
//}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSString* strSelectedBldProcCode = @"";
//    NSString* strSelectedBldProcCode2 = @"";
//    
//    if(component == 0){
//        strSelectedBldProcCode = [self.m_arrBldProc1 objectAtIndex:row];
//        
//        [self setBldProcArray2:strSelectedBldProcCode];
//        [self setBldProcArray3:strSelectedBldProcCode];
//        
//        [m_pickerView reloadComponent:1];
//        [m_pickerView reloadComponent:2];
//    }else if(component == 1){
//        strSelectedBldProcCode2 = [self.m_arrBldProc2 objectAtIndex:row];
//        
//        if([strSelectedBldProcCode2 isEqualToString:@"00"] || [strSelectedBldProcCode2 isEqualToString:@"50"]){
//            [self setBldProcArray3:strSelectedBldProcCode2];
//            [m_pickerView reloadComponent:2];
//        }
//    }
}




#pragma marks - 
#pragma marks Defaults
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
    NSTimeInterval secondPerDay = 24 * 60 * 60;
    self.m_datePicker.date = [[NSDate alloc] initWithTimeIntervalSinceNow:secondPerDay];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_confirmButton = nil;
    self.m_datePicker = nil;
    
    self.m_selector = nil;
    self.m_target = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
