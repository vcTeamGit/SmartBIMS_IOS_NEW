//
//  SBMgrDatePickerViewController.h
//  SmartBIMS
//
//  Created by  on 11. 11. 1..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBMgrDatePickerViewController : UIViewController <UIPickerViewDelegate>
{
    UIButton* m_confirmButton;
    UIDatePicker* m_datePicker;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) IBOutlet UIButton* m_confirmButton;
@property (nonatomic, retain) IBOutlet UIDatePicker* m_datePicker;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


- (IBAction)onSelectMgrDate:(id)sender;

- (void) setDelegate:(id)target selector:(SEL)selector;

@end
