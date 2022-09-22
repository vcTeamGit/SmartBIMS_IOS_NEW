//
//  SBBoardContentViewController.h
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 15..
//
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

@class HttpRequest;
@class SBUserInfoVO;

@interface SBBoardContentViewController : UIViewController
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    UILabel* m_enterDateLabel;
    UILabel* m_enterTimeLabel;
    UILabel* m_startDateLabel;
    UILabel* m_endDateLabel;
    UILabel* m_enterNameLabel;
    UILabel* m_boardTitleLabel;
    
    UITextView* m_boardRemarkTextView;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    NSString* m_seqno;
    NSString* m_writeDate;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;

@property (nonatomic, retain) IBOutlet UILabel* m_enterDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_enterTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_startDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_endDateLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_enterNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_boardTitleLabel;

@property (nonatomic, retain) IBOutlet UITextView* m_boardRemarkTextView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) NSString* m_seqno;
@property (nonatomic, retain) NSString* m_writeDate;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (void) setDelegate:(id)target selector:(SEL)selector;

- (IBAction)onBack:(id)sender;

@end
