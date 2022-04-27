//
//  SBSideEffectPageViewController.h
//  Smart BIMS
//
//  Created by  on 11. 9. 19..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSideEffectPageViewController : UIViewController
{
    NSUInteger m_pageIndex;
    
    UILabel* m_pageIndexLabel;
    UILabel* m_dateLabel;
    UILabel* m_carNameLabel;
    UILabel* m_bldProcNameLabel;
    UILabel* m_hospitalLabel;
    UILabel* m_reasonLabel;
    
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
@property (nonatomic, retain) IBOutlet UILabel* m_hospitalLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_reasonLabel;

@property (nonatomic, retain) IBOutlet UITextView* m_reasonTextView;


- (void)setPageValuesWithDate:(NSString*)date carName:(NSString*)carName bldProcName:(NSString*)bldProcName hospital:(NSString*)hospital reason:(NSString*)reason reasonText:(NSString*)reasonText pageIndex:(NSInteger)pageIndex  totalPage:(NSInteger)totalPage;

@end
