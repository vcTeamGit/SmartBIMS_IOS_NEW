//
//  SBSideEffectsListViewController.h
//  SmartBIMS
//
//  Created by wireline_mac2 on 2015. 2. 23..
//
//

#import <UIKit/UIKit.h>
#import "SBServerURLContent.h"

@class HttpRequest;

@interface SBSideEffectsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    HttpRequest* m_httpRequest;
    
    NSString* m_strBloodNo;
    NSMutableArray* m_mDataArray;
    UITableView* m_tableView;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
    
    id m_target;
    SEL m_selector;
}

@property (nonatomic, retain) NSString* m_strBloodNo;
@property (nonatomic, retain) NSMutableArray* m_mDataArray;
@property (nonatomic, retain) IBOutlet UITableView* m_tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (IBAction)onBack:(id)sender;
- (void)onSearch:(id)sender;
- (void)didReceiveSideEffectsInfo:(id)result;
- (void)setValuesWithBloodNo:(NSString*)strBloodNo;

- (void)pageReset;

- (void)setDelegate:(id)target selector:(SEL)selector;

@end
