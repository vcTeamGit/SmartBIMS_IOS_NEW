//
//  SBBldProcPickerViewController.m
//  Smart BIMS
//
//  Created by  on 11. 8. 12..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBBldProcPickerViewController.h"

@implementation SBBldProcPickerViewController


@synthesize m_arrBldProc1;
@synthesize m_arrBldProc2;
@synthesize m_arrBldProc3;

@synthesize m_dicBldProcName1;
@synthesize m_dicBldProcName2;
@synthesize m_dicBldProcName3;

@synthesize m_nFirstCompIndex;
@synthesize m_nSecondCompIndex;
@synthesize m_nThirdCompIndex;

@synthesize m_pickerView;

@synthesize m_target;
@synthesize m_selector;



#pragma mark -
#pragma mark Custom Methods

- (NSString*)getBldProc1TitleNameByValue:(NSString*)value
{
    int len = (int)[m_arrBldProc1 count];
    
    for(int i = 0; i < len; i++){
        if([value isEqualToString:[m_arrBldProc1 objectAtIndex:i]] == YES){
            [m_pickerView selectRow:i inComponent:0 animated:YES];
            break;
        }
    }
    
    return [self.m_dicBldProcName1 objectForKey:value];
}


- (NSString*)getBldProc2TitleNameByValue:(NSString*)value
{
    int len = (int)[m_arrBldProc2 count];
    
    for(int i = 0; i < len; i++){
        if([value isEqualToString:[m_arrBldProc2 objectAtIndex:i]] == YES){
            [m_pickerView selectRow:i inComponent:1 animated:YES];
            break;
        }
    }
    return [self.m_dicBldProcName2 objectForKey:value];
}


- (NSString*)getBldProc3TitleNameByValue:(NSString*)value
{
    int len = (int)[m_arrBldProc3 count];
    
    for(int i = 0; i < len; i++){
        if([value isEqualToString:[m_arrBldProc3 objectAtIndex:i]] == YES){
            [m_pickerView selectRow:i inComponent:2 animated:YES];
            break;
        }
    }
    return [self.m_dicBldProcName3 objectForKey:value];
}


- (IBAction)onSelectBldProc:(id)sender
{
    NSString* strTempBldProcCode1 = [m_arrBldProc1 objectAtIndex:[m_pickerView selectedRowInComponent:0]];
    NSString* strTempBldProcCode2 = [m_arrBldProc2 objectAtIndex:[m_pickerView selectedRowInComponent:1]];
    NSString* strTempBldProcCode3 = [m_arrBldProc3 objectAtIndex:[m_pickerView selectedRowInComponent:2]];
    
    NSString* strTempBldProcName1 = [m_dicBldProcName1 objectForKey:strTempBldProcCode1];
    NSString* strTempBldProcName2 = [m_dicBldProcName2 objectForKey:strTempBldProcCode2];
    NSString* strTempBldProcName3 = [m_dicBldProcName3 objectForKey:strTempBldProcCode3];
    
    if([strTempBldProcCode1 isEqualToString:@"50"] && [strTempBldProcCode2 isEqualToString:@"00"]){
        strTempBldProcCode1 = @"00";
    }
    
    if(m_target){
        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithCapacity:6];
        [dictionary setObject:strTempBldProcName1 forKey:@"bldprocname1"];
        [dictionary setObject:strTempBldProcName2 forKey:@"bldprocname2"];
        [dictionary setObject:strTempBldProcName3 forKey:@"bldprocname3"];
        [dictionary setObject:strTempBldProcCode1 forKey:@"bldproccode1"];
        [dictionary setObject:strTempBldProcCode2 forKey:@"bldproccode2"];
        [dictionary setObject:strTempBldProcCode3 forKey:@"bldproccode3"];
        
		[m_target performSelector:m_selector withObject:dictionary];
	}
}


- (void)reloadBldProcNameComponents
{
    [m_pickerView reloadAllComponents];
}


- (void)reloadBldProcNameComponentsByBldProccode:(NSString*)value
{
    int nLen1 = (int)[m_arrBldProc1 count];
    int nLen2 = (int)[m_arrBldProc2 count];
    int nLen3 = (int)[m_arrBldProc3 count];
    
    [m_pickerView reloadAllComponents];
    
    for(int i = 0; i < nLen1; i++){
        if([value isEqualToString:[m_arrBldProc1 objectAtIndex:i]] == YES){
            [m_pickerView selectRow:i inComponent:0 animated:YES];
            break;
        }
    }
    
    for(int i = 0; i < nLen2; i++){
        if([value isEqualToString:[m_arrBldProc2 objectAtIndex:i]] == YES){
            [m_pickerView selectRow:i inComponent:1 animated:YES];
            break;
        }
    }
    
    for(int i = 0; i < nLen3; i++){
        if([value isEqualToString:[m_arrBldProc3 objectAtIndex:i]] == YES){
            [m_pickerView selectRow:i inComponent:2 animated:YES];
            break;
        }
    }
}


// PickerView에 보여질 데이터를 세팅한다.
- (void)setBldProcArrays:(NSString *)bldproccode
{
    [self setBldProcArray1:bldproccode];
    [self setBldProcArray2:bldproccode];
    [self setBldProcArray3:bldproccode];
}


- (void)setBldProcArray1:(NSString *)bldproccode
{
    NSString* strBldProcCode = bldproccode;
    
    if(self.m_arrBldProc1 != nil){
        [m_arrBldProc1 removeAllObjects];
        m_arrBldProc1 = nil;
    }
    
    m_arrBldProc1 = [[NSMutableArray alloc] initWithCapacity:8];
    
//    if([strBldProcCode isEqualToString:@"50"] || [strBldProcCode isEqualToString:@"00"]){
//        [self.m_arrBldProc1 addObject:@"00"];
//        [self.m_arrBldProc1 addObject:@"50"];
//    }
    if([strBldProcCode isEqualToString:@"00"]){
        [self.m_arrBldProc1 addObject:@"00"];
    }else if([strBldProcCode isEqualToString:@"50"]){
//        [self.m_arrBldProc1 addObject:@"00"];
        [self.m_arrBldProc1 addObject:@"50"];
    }else if([strBldProcCode isEqualToString:@"71"]){
        [self.m_arrBldProc1 addObject:@"71"];
    }else if([strBldProcCode isEqualToString:@"72"] || [strBldProcCode isEqualToString:@"76"]){
        [self.m_arrBldProc1 addObject:@"72"];
        [self.m_arrBldProc1 addObject:@"76"];
    }else if([strBldProcCode isEqualToString:@"88"] || [strBldProcCode isEqualToString:@"85"] || [strBldProcCode isEqualToString:@"82"] || [strBldProcCode isEqualToString:@"91"] || [strBldProcCode isEqualToString:@"94"]){
        [self.m_arrBldProc1 addObject:@"88"];
        [self.m_arrBldProc1 addObject:@"85"];
        [self.m_arrBldProc1 addObject:@"82"];
        [self.m_arrBldProc1 addObject:@"91"];
        [self.m_arrBldProc1 addObject:@"94"];
    }else{
        // TO DO - Wrong parameter Handling
    }
}


- (void)setBldProcArray2:(NSString*)bldproccode
{
    NSString* strBldProcCode = bldproccode;
    
    if(self.m_arrBldProc2 != nil){
        [self.m_arrBldProc2 removeAllObjects];
        self.m_arrBldProc2 = nil;
    }
    
    m_arrBldProc2 = [[NSMutableArray alloc] initWithCapacity:8];
    
    if([strBldProcCode isEqualToString:@"50"]){
        [self.m_arrBldProc2 addObject:@"50"];
        [self.m_arrBldProc2 addObject:@"00"];
    }else if([strBldProcCode isEqualToString:@"00"]){
        [self.m_arrBldProc2 addObject:@"00"];
    }else if([strBldProcCode isEqualToString:@"71"]){
        [self.m_arrBldProc2 addObject:@"71"];
    }else if([strBldProcCode isEqualToString:@"72"] || [strBldProcCode isEqualToString:@"76"]){
        [self.m_arrBldProc2 addObject:@"72"];
        [self.m_arrBldProc2 addObject:@"76"];
    }else if([strBldProcCode isEqualToString:@"88"] || [strBldProcCode isEqualToString:@"85"] || [strBldProcCode isEqualToString:@"82"] || [strBldProcCode isEqualToString:@"91"] || [strBldProcCode isEqualToString:@"94"]){
        [self.m_arrBldProc2 addObject:@"88"];
        [self.m_arrBldProc2 addObject:@"85"];
        [self.m_arrBldProc2 addObject:@"82"];
        [self.m_arrBldProc2 addObject:@"91"];
        [self.m_arrBldProc2 addObject:@"94"];
    }else{
        // TO DO - Wrong parameter handling.
    }
}


- (void)setBldProcArray3:(NSString *)bldproccode
{
    NSString* strBldProcCode = bldproccode;
    
    if(self.m_arrBldProc3 != nil){
        [self.m_arrBldProc3 removeAllObjects];
        m_arrBldProc3 = nil;
    }
    
    m_arrBldProc3 = [[NSMutableArray alloc] initWithCapacity:8];
    
    if([strBldProcCode isEqualToString:@"50"]){
        [self.m_arrBldProc3 addObject:@"4,0"];
        [self.m_arrBldProc3 addObject:@"3,0"];
        [self.m_arrBldProc3 addObject:@"2,0"];
        [self.m_arrBldProc3 addObject:@"1,0"];
    }else if([strBldProcCode isEqualToString:@"00"]){
        [self.m_arrBldProc3 addObject:@"3,0"];
        [self.m_arrBldProc3 addObject:@"2,0"];
        [self.m_arrBldProc3 addObject:@"1,0"];
    }else if([strBldProcCode isEqualToString:@"71"]){
        [self.m_arrBldProc3 addObject:@"1,1"];
        [self.m_arrBldProc3 addObject:@"1,3"];
//        [self.m_arrBldProc3 addObject:@"1,5"];  // 2013.12.26 삭제 - 안전관리팀 요청
    }else if([strBldProcCode isEqualToString:@"72"] || [strBldProcCode isEqualToString:@"76"]){
        [self.m_arrBldProc3 addObject:@"1,5"];
        [self.m_arrBldProc3 addObject:@"1,6"];
        [self.m_arrBldProc3 addObject:@"1,7"];
    }else if([strBldProcCode isEqualToString:@"88"] || [strBldProcCode isEqualToString:@"85"] || [strBldProcCode isEqualToString:@"82"] || [strBldProcCode isEqualToString:@"91"] || [strBldProcCode isEqualToString:@"94"]){
        [self.m_arrBldProc3 addObject:@"2,5"];
        [self.m_arrBldProc3 addObject:@"2,6"];
        [self.m_arrBldProc3 addObject:@"2,7"];
        [self.m_arrBldProc3 addObject:@"2,9"];
    }else{
        // TO DO - wrong parameter handling.
    }
}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}






#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return kBldprocPickerComponentNumber;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger nComponentIndex = component;
    
    if(nComponentIndex == 0){
//        TRACE(@"%d is m_arrBldProc1 count", m_arrBldProc1.count);
        return m_arrBldProc1.count;
    }else if(nComponentIndex == 1){
        return m_arrBldProc2.count;
    }else{
        return [m_arrBldProc3 count];
    }
}


#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger nComponentIndex = component;
    
    if(nComponentIndex == 0){
        return [m_dicBldProcName1 objectForKey:[m_arrBldProc1 objectAtIndex:row]];
    }else if(nComponentIndex == 1){
        return [m_dicBldProcName2 objectForKey:[m_arrBldProc2 objectAtIndex:row]];
    }else if(nComponentIndex == 2){
        return [m_dicBldProcName3 objectForKey:[m_arrBldProc3 objectAtIndex:row]];
    }else{
        return nil;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString* strSelectedBldProcCode = @"";
    NSString* strSelectedBldProcCode2 = @"";
    
    if(component == 0){
        strSelectedBldProcCode = [self.m_arrBldProc1 objectAtIndex:row];
        
        [self setBldProcArray2:strSelectedBldProcCode];
        [self setBldProcArray3:strSelectedBldProcCode];
        
        [m_pickerView reloadComponent:1];
        [m_pickerView reloadComponent:2];
    }else if(component == 1){
        strSelectedBldProcCode2 = [self.m_arrBldProc2 objectAtIndex:row];
        
        if([strSelectedBldProcCode2 isEqualToString:@"00"] || [strSelectedBldProcCode2 isEqualToString:@"50"]){
            [self setBldProcArray3:strSelectedBldProcCode2];
            [m_pickerView reloadComponent:2];
        }
    }
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
    
    self.m_dicBldProcName1 = [[NSMutableDictionary alloc] initWithCapacity:8];
    
    [m_dicBldProcName1 setValue:@"전혈" forKey:@"50"];
    [m_dicBldProcName1 setValue:@"전혈" forKey:@"00"];
    [m_dicBldProcName1 setValue:@"혈장" forKey:@"71"];
    [m_dicBldProcName1 setValue:@"혈소판" forKey:@"72"];
    [m_dicBldProcName1 setValue:@"혈소판" forKey:@"76"];
    [m_dicBldProcName1 setValue:@"다종" forKey:@"88"];
    [m_dicBldProcName1 setValue:@"다종" forKey:@"85"];
    [m_dicBldProcName1 setValue:@"다종" forKey:@"82"];
    [m_dicBldProcName1 setValue:@"다종" forKey:@"91"];
    [m_dicBldProcName1 setValue:@"다종" forKey:@"94"];
    
    self.m_dicBldProcName2 = [[NSMutableDictionary alloc] initWithCapacity:8];
    
    [m_dicBldProcName2 setValue:@"400mL" forKey:@"50"];
    [m_dicBldProcName2 setValue:@"320mL" forKey:@"00"];
    [m_dicBldProcName2 setValue:@"PL-A" forKey:@"71"];
    [m_dicBldProcName2 setValue:@"A-PLT" forKey:@"72"];
    [m_dicBldProcName2 setValue:@"SDP" forKey:@"76"];
    [m_dicBldProcName2 setValue:@"2RBC" forKey:@"88"];
    [m_dicBldProcName2 setValue:@"2PLT" forKey:@"85"];
    [m_dicBldProcName2 setValue:@"PLT/P" forKey:@"82"];
    [m_dicBldProcName2 setValue:@"RBC/P" forKey:@"91"];
    [m_dicBldProcName2 setValue:@"RBC/PLT" forKey:@"94"];
    
    self.m_dicBldProcName3 = [[NSMutableDictionary alloc] initWithCapacity:8];
    
    [m_dicBldProcName3 setValue:@"Q/B" forKey:@"4,0"];
    [m_dicBldProcName3 setValue:@"T/B" forKey:@"3,0"];
    [m_dicBldProcName3 setValue:@"D/B" forKey:@"2,0"];
    [m_dicBldProcName3 setValue:@"S/B" forKey:@"1,0"];
    [m_dicBldProcName3 setValue:@"Auto-C" forKey:@"1,1"];
    [m_dicBldProcName3 setValue:@"PCS2" forKey:@"1,3"];
    [m_dicBldProcName3 setValue:@"MCS+" forKey:@"1,5"];
    [m_dicBldProcName3 setValue:@"Trima" forKey:@"1,6"];
    [m_dicBldProcName3 setValue:@"Amicus" forKey:@"1,7"];
    [m_dicBldProcName3 setValue:@"MCS+" forKey:@"2,5"];
    [m_dicBldProcName3 setValue:@"Trima" forKey:@"2,6"];
    [m_dicBldProcName3 setValue:@"Amicus" forKey:@"2,7"];
    [m_dicBldProcName3 setValue:@"ALYX" forKey:@"2,9"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.m_arrBldProc1 = nil;
    self.m_arrBldProc2 = nil;
    self.m_arrBldProc3 = nil;
    self.m_dicBldProcName1 = nil;
    self.m_dicBldProcName2 = nil;
    self.m_dicBldProcName3 = nil;
    
    self.m_pickerView = nil;
    
    self.m_target = nil;
    self.m_selector = nil;
}

- (void)dealloc
{
    [m_arrBldProc1 release];
    [m_arrBldProc2 release];
    [m_arrBldProc3 release];
    [m_dicBldProcName1 release];
    [m_dicBldProcName2 release];
    [m_dicBldProcName3 release];
    
    [m_pickerView release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
