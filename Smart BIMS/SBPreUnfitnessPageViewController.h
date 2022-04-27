//
//  SBPreUnfitnessPageViewController.h
//  Smart BIMS
//
//  Created by  on 11. 9. 2..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

/*
 * 이전 헌혈 부적격 정보보기 페이지 뷰.
 */

#import <UIKit/UIKit.h>


@interface SBPreUnfitnessPageViewController : UIViewController
{
    NSUInteger m_pageIndex;
    
    UILabel* m_pageIndexLabel;
    UILabel* m_dateLabel;
    UILabel* m_carNameLabel;
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
@property (nonatomic, retain) IBOutlet UILabel* m_reasonLabel;

@property (nonatomic, retain) IBOutlet UITextView* m_reasonTextView;



- (id)initWithPage:(NSInteger)index date:(NSString*)date carName:(NSString*)carName reason:(NSString*)reason 
        reasonText:(NSString*)reasonText;
- (void)setPageValuesWithDate:(NSString*)date carName:(NSString*)carName reason:(NSString*)reason 
                   reasonText:(NSString*)reasonText pageIndex:(NSInteger)pageIndex totalPage:(NSInteger)totalPage;


@end
