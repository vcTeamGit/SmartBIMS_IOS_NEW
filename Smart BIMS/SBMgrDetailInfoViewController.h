//
//  SBMgrDetailInfoViewController.h
//  SmartBIMS
//
//  Created by  on 11. 10. 25..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBMgrDetailInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UILabel* m_carNameLabel;
    UILabel* m_siteNameLabel;
    UILabel* m_siteCodeLabel;
    UILabel* m_envNameLabel;
    UILabel* m_malStatusLabel;
    UILabel* m_planCntLabel;
    UILabel* m_departTimeLabel;
    UILabel* m_returnTimeLabel;
    
    NSString* m_strRemark;
    NSString* m_strMember;
    
    UITextView* m_remarkTextView;
    
    UITableView* m_membersTableView;
    
    UIImageView* m_descBgImageView;
    
    NSMutableArray* m_mMemberArray;
    NSMutableArray* m_mGbSessionNameArray;
    NSMutableArray* m_mIdNameArray;
    NSMutableArray* m_mIdNoArray;
    
    UILabel* m_carNameTitleLabel;
    
    UIButton* m_remarkTabBtn;
    UIButton* m_memberTabBtn;
    
    int viewWidth;
    int viewHeight;
    int winHeight;
}

@property (nonatomic, retain) IBOutlet UILabel* m_carNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_siteNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_siteCodeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_envNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_malStatusLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_planCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_departTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_returnTimeLabel;

@property (nonatomic, retain) NSString* m_strRemark;
@property (nonatomic, retain) NSString* m_strMember;

@property (nonatomic, retain) IBOutlet UITextView* m_remarkTextView;
@property (nonatomic, retain) IBOutlet UITableView* m_membersTableView;
@property (nonatomic, retain) IBOutlet UIImageView* m_descBgImageView;

@property (nonatomic, retain) NSMutableArray* m_mMemberArray;
@property (nonatomic, retain) NSMutableArray* m_mGbSessionNameArray;
@property (nonatomic, retain) NSMutableArray* m_mIdNameArray;
@property (nonatomic, retain) NSMutableArray* m_mIdNoArray;

@property (nonatomic, retain) IBOutlet UILabel* m_carNameTitleLabel;

@property (nonatomic, retain) IBOutlet UIButton* m_remarkTabBtn;
@property (nonatomic, retain) IBOutlet UIButton* m_memberTabBtn;

- (void)setValuesWithCarName:(NSString*)strCarName
                    sitename:(NSString*)strSiteName
                    sitecode:(NSString*)strSiteCode 
                         env:(NSString*)strEnv 
                   malStatus:(NSString*)strGBMal
                     plancnt:(NSString*)strPlanCnt
                  departTime:(NSString*)strDepartTime
                  returnTime:(NSString*)strReturnTime
                      remark:(NSString*)strRemark
                     members:(NSString*)strMembers
               gbsessionname:(NSString*)strGbSessionName
                      idname:(NSString*)strIdName
                        idno:(NSString*)strIdno;


- (IBAction)showRemark:(id)sender;
- (IBAction)showMember:(id)sender;

@end
