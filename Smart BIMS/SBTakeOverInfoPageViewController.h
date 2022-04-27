//
//  SBTakeOverInfoPageViewController.h
//  SmartBIMS
//
//  Created by wireline on 2017. 10. 18..
//
//

#import <UIKit/UIKit.h>

@interface SBTakeOverInfoPageViewController : UIViewController
{
    UILabel* m_spcSampleCntLabel;
    UILabel* m_spcSampleCntLabel2;
    UILabel* m_etcSampleCntLabel;
    UILabel* m_hrgSampleCntLabel;
    UILabel* m_hrgSampleCntLabel2;
    UILabel* m_hbvSampleCntLabel;
    UILabel* m_marSampleCntLabel;
    
    UILabel* m_enrSampleCntLabel;
    
    UILabel* m_rhnSampleCntLabel;
    
//    UILabel* m_rhnEmergencyBloodCntLabel;
    UILabel* m_icepackCntLabel;
    UILabel* m_coolantCntLabel;
    
    UILabel* m_bloodCntLabel;
    UILabel* m_bloodSampleCntLabel;
    UILabel* m_paperCntLabel;
    UILabel* m_ePaperCntLabel;
    UILabel* m_assignedBloodCntLabel;
    
    UILabel* m_rhnEmergencyBloodCntLabel;
    
    UILabel* m_unfitPaperCntLabel;
    UILabel* m_eUnfitPaperCntLabel;
    UILabel* m_mal1CntLabel;  // 제한
    UILabel* m_mal3CntLabel;  // 가능
    UILabel* m_bloodBoxCntLabel;
    
    UILabel* m_takerNameLabel;
    UILabel* m_takeOverTimeLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* m_spcSampleCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_spcSampleCntLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_etcSampleCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_hrgSampleCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_hrgSampleCntLabel2;
@property (nonatomic, retain) IBOutlet UILabel* m_hbvSampleCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_marSampleCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_enrSampleCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_rhnSampleCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_icepackCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_coolantCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_bloodCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodSampleCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_paperCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_ePaperCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_assignedBloodCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_rhnEmergencyBloodCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_unfitPaperCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_eUnfitPaperCntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_mal1CntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_mal3CntLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_bloodBoxCntLabel;

@property (nonatomic, retain) IBOutlet UILabel* m_takerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* m_takeOverTimeLabel;


- (void)setPageValues:(NSString*)spcSampleCnt spcSampleCnt2:(NSString*)spcSampleCnt2
         enrSampleCnt:(NSString*)enrSampleCnt etcSampleCnt:(NSString*)etcSampleCnt
         hrgSampleCnt:(NSString*)hrgSampleCnt hrgSampleCnt2:(NSString*)hrgSampleCnt2
         hbvSampleCnt:(NSString*)hbvSampleCnt marSampleCnt:(NSString*)marSampleCnt
         rhnSampleCnt:(NSString*)rhnSampleCnt icepackCnt:(NSString*)icepackCnt coolantCnt:(NSString*)coolantCnt
             bloodCnt:(NSString*)bloodCnt bloodSampleCnt:(NSString*)bloodSampleCnt paperCnt:(NSString*)paperCnt
            ePaperCnt:(NSString*)ePaperCnt assignedBloodCnt:(NSString*)assignedBloodCnt
      rhnEmergencyBloodCnt:(NSString*)rhnEmergencyBloodCnt unfitPaperCnt:(NSString*)unfitPaperCnt
       eUnfitPaperCnt:(NSString*)eUnfitPaperCnt mal1Cnt:(NSString*)mal1Cnt mal3Cnt:(NSString*)mal3Cnt
          bloodBoxCnt:(NSString*)bloodBoxCnt takerName:(NSString*)takerName takeOverTime:(NSString*)takeOverTime
            totalPage:pageCnt;


@end
