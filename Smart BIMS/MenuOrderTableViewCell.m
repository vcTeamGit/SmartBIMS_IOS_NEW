//
//  MenuOrderTableViewCell.m
//  SmartBIMS
//
//  Created by hmwoo on 2023/04/03.
//

#import "MenuOrderTableViewCell.h"

@implementation MenuOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_orderLabel release];
    [_iconImageView release];
    [_titleLabel release];
    [super dealloc];
}
@end
