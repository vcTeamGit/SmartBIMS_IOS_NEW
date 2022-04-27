//
//  SBLoginMgrListViewController.h
//  SmartBIMS
//
//  Created by  on 12. 1. 10..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBLoginMgrListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView* m_tableView;
    
    NSArray* m_array;
    
    id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) IBOutlet UITableView* m_tableView;
@property (nonatomic, retain) NSArray* m_array;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (void) setDelegate:(id)target selector:(SEL)selector;
- (IBAction)onCancel:(id)sender;

@end
