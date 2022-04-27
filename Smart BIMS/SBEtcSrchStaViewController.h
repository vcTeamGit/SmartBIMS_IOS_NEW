//
//  SBEtcSrchStaViewController.h
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 16..
//
//

#import <UIKit/UIKit.h>

@class SBUserInfoVO;
@class HttpRequest;

@interface SBEtcSrchStaViewController : UIViewController<UITabBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    SBUserInfoVO* m_SBUserInfoVO;
    HttpRequest* m_httpRequest;
    
    NSMutableArray* m_mDataArray;
    
    UIActivityIndicatorView* m_activityIndicatorView;
    
    UITabBar* m_tabbar;
    UITableView* m_tableView;
    
    UIView* m_view0;
    UIView* m_view1;
    
    
    //
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
    //
    
    UILabel* m_bldCntLabel;
    UILabel* m_bldRegCntLabel;
    UILabel* m_spcCntLabel;
    UILabel* m_notCntLabel;
    UILabel* m_unfitnessDocumentCntLabel;
    
    UILabel* m_unfitnessEDocumentCntLabel;
    UILabel* m_regCntLabel;
    UILabel* m_golsuCntLabel;
    UILabel* m_eEmiCntLabel;
    UILabel* m_registerFingerCntLabel;
    
    UILabel* m_lftCntLabel;
    UILabel* m_cbcCntLabel;
    UILabel* m_ddrReleaseCntLabel;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) SBUserInfoVO* m_SBUserInfoVO;
@property (nonatomic, retain) NSMutableArray* m_mDataArray;
@property (nonatomic, retain) IBOutlet UITableView* m_tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* m_activityIndicatorView;

@property (nonatomic, retain) IBOutlet UITabBar* m_tabbar;

@property (nonatomic, retain) IBOutlet UIView* m_view0;
@property (nonatomic, retain) IBOutlet UIView* m_view1;

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

//
@property (nonatomic, retain) IBOutlet UILabel* m_bldCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bldRegCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_spcCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_notCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_unfitnessDocumentCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_unfitnessEDocumentCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_regCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_golsuCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_eEmiCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_registerFingerCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_lftCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_cbcCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ddrReleaseCntLabel;

- (void)onSearch:(NSString*)tag;
- (IBAction)onBack:(id)sender;
- (IBAction)pageReset:(id)sender;

@end
