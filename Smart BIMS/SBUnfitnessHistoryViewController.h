//
//  SBUnfitnessHistoryViewController.h
//  Smart BIMS
//
//  Created by  on 11. 9. 21..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBUnfitnessHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* m_mDateArray;
    NSMutableArray* m_mDescArray;
    
    UITableView* m_tableView;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) NSMutableArray* m_mDateArray;
@property (nonatomic, retain) NSMutableArray* m_mDescArray;
@property (nonatomic, retain) IBOutlet UITableView* m_tableView;

- (IBAction)onBack:(id)sender;

@end
