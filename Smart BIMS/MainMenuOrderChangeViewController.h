//
//  MainMenuOrderChangeViewController.h
//  SmartBIMS
//
//  Created by hmwoo on 2023/03/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainMenuOrderChangeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *menuListTableView;
@property (retain, nonatomic) NSMutableArray *contentArray;

@end

NS_ASSUME_NONNULL_END
