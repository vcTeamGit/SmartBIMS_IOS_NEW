//
//  MenuOrderTableViewCell.h
//  SmartBIMS
//
//  Created by hmwoo on 2023/04/03.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuOrderTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *orderLabel;
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;
@property (retain, nonatomic) IBOutlet UIView *titleLabel;

@end

NS_ASSUME_NONNULL_END
