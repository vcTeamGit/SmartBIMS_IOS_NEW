//
//  SBBldProcPickerViewController.h
//  Smart BIMS
//
//  Created by  on 11. 8. 12..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBldprocPickerComponentNumber 3


@interface SBBldProcPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray* m_arrBldProc1;
    NSMutableArray* m_arrBldProc2;
    NSMutableArray* m_arrBldProc3;
    
    NSMutableDictionary* m_dicBldProcName1;
    NSMutableDictionary* m_dicBldProcName2;
    NSMutableDictionary* m_dicBldProcName3;
    
    int m_nFirstCompIndex;
    int m_nSecondCompIndex;
    int m_nThirdCompIndex;
    
    UIPickerView* m_pickerView;

    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) NSMutableArray* m_arrBldProc1;
@property (nonatomic, retain) NSMutableArray* m_arrBldProc2;
@property (nonatomic, retain) NSMutableArray* m_arrBldProc3;

@property (nonatomic, retain) NSMutableDictionary* m_dicBldProcName1;
@property (nonatomic, retain) NSMutableDictionary* m_dicBldProcName2;
@property (nonatomic, retain) NSMutableDictionary* m_dicBldProcName3;

@property (nonatomic, assign) int m_nFirstCompIndex;
@property (nonatomic, assign) int m_nSecondCompIndex;
@property (nonatomic, assign) int m_nThirdCompIndex;

@property (nonatomic, retain) IBOutlet UIPickerView* m_pickerView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (NSString*)getBldProc1TitleNameByValue:(NSString*)value;
- (NSString*)getBldProc2TitleNameByValue:(NSString*)value;
- (NSString*)getBldProc3TitleNameByValue:(NSString*)value;

- (void)reloadBldProcNameComponents;
- (void)reloadBldProcNameComponentsByBldProccode:(NSString*)value;

- (void)setBldProcArrays:(NSString*)bldproccode;

- (void)setBldProcArray1:(NSString*)bldproccode;
- (void)setBldProcArray2:(NSString*)bldproccode;
- (void)setBldProcArray3:(NSString *)bldproccode;

- (IBAction)onSelectBldProc:(id)sender;

- (void) setDelegate:(id)target selector:(SEL)selector;

@end
