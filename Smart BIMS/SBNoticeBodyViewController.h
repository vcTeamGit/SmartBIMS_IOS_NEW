//
//  SBNoticeBodyViewController.h
//  SmartBIMS
//
//  Created by  on 11. 11. 17..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class HttpRequest;

@interface SBNoticeBodyViewController : UIViewController
{
//    HttpRequest* m_httpRequest;
    
    UILabel* m_titleLabel;
    UILabel* m_notifierLabel;
    UILabel* m_dateLabel;
    UILabel* m_targetLabel;
    
    UITextView* m_textView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
	SEL m_selector;
}

//@property (nonatomic, retain) HttpRequest* m_httpRequest;
@property (nonatomic, retain) IBOutlet UILabel* m_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_notifierLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_targetLabel;

@property (nonatomic, retain) IBOutlet UITextView* m_textView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (void) setDelegate:(id)target selector:(SEL)selector;

//- (void)pageReset;
//- (void)getNoticeData;
- (IBAction)onToBackBtnTab:(id)sender;

@end
