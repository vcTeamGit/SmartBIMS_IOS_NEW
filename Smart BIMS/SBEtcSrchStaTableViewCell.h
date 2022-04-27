//
//  SBEtcSrchStaTableViewCell.h
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 16..
//
//

#import <UIKit/UIKit.h>

@interface SBEtcSrchStaTableViewCell : UITableViewCell
{
    UILabel* m_label21;
    UILabel* m_labelTotal;
    
    UILabel* m_label31;
    UILabel* m_label32;
    
    UILabel* m_label61;
    UILabel* m_label62;
    UILabel* m_label63;
    UILabel* m_label64;
    UILabel* m_label65;
    UILabel* m_label66;
    
    UIImageView* m_bgImageView;
}

@property (nonatomic, retain) IBOutlet UILabel* m_label21;
@property (nonatomic, retain) IBOutlet UILabel* m_labelTotal;

@property (nonatomic, retain) IBOutlet UILabel* m_label31;
@property (nonatomic, retain) IBOutlet UILabel* m_label32;

@property (nonatomic, retain) IBOutlet UILabel* m_label61;
@property (nonatomic, retain) IBOutlet UILabel* m_label62;
@property (nonatomic, retain) IBOutlet UILabel* m_label63;
@property (nonatomic, retain) IBOutlet UILabel* m_label64;
@property (nonatomic, retain) IBOutlet UILabel* m_label65;
@property (nonatomic, retain) IBOutlet UILabel* m_label66;

@property (nonatomic, retain) IBOutlet UIImageView* m_bgImageView;

@end
