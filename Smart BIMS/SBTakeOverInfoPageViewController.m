//
//  SBTakeOverInfoPageViewController.m
//  SmartBIMS
//
//  Created by wireline on 2017. 10. 18..
//
//

#import "SBTakeOverInfoPageViewController.h"

@interface SBTakeOverInfoPageViewController ()

@end

@implementation SBTakeOverInfoPageViewController

@synthesize m_spcSampleCntLabel;
@synthesize m_spcSampleCntLabel2;
@synthesize m_etcSampleCntLabel;
@synthesize m_hrgSampleCntLabel;
@synthesize m_hrgSampleCntLabel2;
@synthesize m_hbvSampleCntLabel;
@synthesize m_marSampleCntLabel;

@synthesize m_enrSampleCntLabel;

@synthesize m_rhnSampleCntLabel;
@synthesize m_icepackCntLabel;
@synthesize m_coolantCntLabel;

@synthesize m_bloodCntLabel;
@synthesize m_bloodSampleCntLabel;
@synthesize m_paperCntLabel;
@synthesize m_ePaperCntLabel;
@synthesize m_assignedBloodCntLabel;

@synthesize m_rhnEmergencyBloodCntLabel;

@synthesize m_unfitPaperCntLabel;
@synthesize m_eUnfitPaperCntLabel;
@synthesize m_mal1CntLabel;
@synthesize m_mal3CntLabel;
@synthesize m_bloodBoxCntLabel;

@synthesize m_takerNameLabel;
@synthesize m_takeOverTimeLabel;




- (void)setPageValues:(NSString*)spcSampleCnt
        spcSampleCnt2:(NSString*)spcSampleCnt2
         enrSampleCnt:(NSString*)enrSampleCnt
         etcSampleCnt:(NSString*)etcSampleCnt
         hrgSampleCnt:(NSString*)hrgSampleCnt
        hrgSampleCnt2:(NSString*)hrgSampleCnt2
         hbvSampleCnt:(NSString*)hbvSampleCnt
         marSampleCnt:(NSString*)marSampleCnt
         rhnSampleCnt:(NSString*)rhnSampleCnt
           icepackCnt:(NSString*)icepackCnt
           coolantCnt:(NSString*)coolantCnt
             bloodCnt:(NSString*)bloodCnt
       bloodSampleCnt:(NSString*)bloodSampleCnt
             paperCnt:(NSString*)paperCnt
            ePaperCnt:(NSString*)ePaperCnt
     assignedBloodCnt:(NSString*)assignedBloodCnt
 rhnEmergencyBloodCnt:(NSString*)rhnEmergencyBloodCnt
        unfitPaperCnt:(NSString*)unfitPaperCnt
       eUnfitPaperCnt:(NSString*)eUnfitPaperCnt
              mal1Cnt:(NSString*)mal1Cnt
              mal3Cnt:(NSString*)mal3Cnt
          bloodBoxCnt:(NSString*)bloodBoxCnt
            takerName:(NSString*)takerName
         takeOverTime:(NSString*)takeOverTime
            totalPage:pageCnt
{
    self.m_spcSampleCntLabel.text = spcSampleCnt;
    self.m_spcSampleCntLabel2.text = spcSampleCnt2;
    self.m_enrSampleCntLabel.text = enrSampleCnt;
    self.m_etcSampleCntLabel.text = etcSampleCnt;
    self.m_hrgSampleCntLabel.text = hrgSampleCnt;
    self.m_hrgSampleCntLabel2.text = hrgSampleCnt2;
    self.m_hbvSampleCntLabel.text = hbvSampleCnt;
    self.m_marSampleCntLabel.text = marSampleCnt;
    
    self.m_rhnSampleCntLabel.text = rhnSampleCnt;
    self.m_icepackCntLabel.text = icepackCnt;
    self.m_coolantCntLabel.text = coolantCnt;
    self.m_bloodCntLabel.text = bloodCnt;
    self.m_bloodSampleCntLabel.text = bloodSampleCnt;
    
    self.m_paperCntLabel.text = paperCnt;
    self.m_ePaperCntLabel.text = ePaperCnt;
    self.m_assignedBloodCntLabel.text = assignedBloodCnt;
    self.m_rhnEmergencyBloodCntLabel.text = rhnEmergencyBloodCnt;
    self.m_unfitPaperCntLabel.text = unfitPaperCnt;
    self.m_eUnfitPaperCntLabel.text = eUnfitPaperCnt;
    
    self.m_mal1CntLabel.text = mal1Cnt;
    self.m_mal3CntLabel.text = mal3Cnt;
    self.m_bloodBoxCntLabel.text = bloodBoxCnt;
    self.m_takerNameLabel.text = takerName;
    self.m_takeOverTimeLabel.text = takeOverTime;
    
    return;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
