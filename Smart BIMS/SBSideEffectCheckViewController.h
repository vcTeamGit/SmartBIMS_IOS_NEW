//
//  SBSideEffectCheckViewController.h
//  Smart BIMS
//
//  Created by  on 11. 9. 19..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

@class HttpRequest;


@interface SBSideEffectCheckViewController : UIViewController <UIScrollViewDelegate>
{
    HttpRequest* m_httpRequest;
    
    UIPageControl* m_pageControl;
    UIScrollView* m_scrollView;
    
    NSMutableArray* m_mPageArray;
    
    NSString* m_strJumin1;
    NSString* m_strJumin2;
    NSString* m_strPageCnt;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) HttpRequest* m_httpRequest;

@property (nonatomic, retain) IBOutlet UIPageControl* m_pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView* m_scrollView;
@property (nonatomic, retain) NSMutableArray* m_mPageArray;

@property (nonatomic, retain) NSString* m_strJumin1;
@property (nonatomic, retain) NSString* m_strJumin2;
@property (nonatomic, retain) NSString* m_strPageCnt;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

- (void)setValuesWithPageCnt:(NSString*)strCnt jumin1:(NSString*)strJumin1 jumin2:(NSString*)strJumin2;

- (IBAction)onBack:(id)sender;
- (IBAction)changePage:(id)sender;
- (void)setPages;


@end
