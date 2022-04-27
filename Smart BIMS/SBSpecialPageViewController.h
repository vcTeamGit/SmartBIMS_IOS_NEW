//
//  SBSpecialPageViewController.h
//  Smart BIMS
//
//  Created by  on 11. 9. 20..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSpecialPageViewController : UIViewController
{
    NSUInteger m_pageIndex;
    
    UILabel* m_pageIndexLabel;
    UILabel* m_dateLabel;
    UILabel* m_carNameLabel;
    UILabel* m_bldProcNameLabel;
    
    UITextView* m_reasonTextView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, assign) NSUInteger m_pageIndex;

@property (nonatomic, retain) IBOutlet UILabel* m_pageIndexLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_carNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bldProcNameLabel;

@property (nonatomic, retain) IBOutlet UITextView* m_reasonTextView;


- (void)setPageValuesWithDate:(NSString*)date carName:(NSString*)carName bldProcName:(NSString*)bldProcName 
                   reasonText:(NSString*)reasonText pageIndex:(NSInteger)pageIndex totalPage:(NSInteger)totalPage;

@end
