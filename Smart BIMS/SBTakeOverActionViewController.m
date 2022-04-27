//
//  SBTakeOverActionViewController.m
//  SmartBIMS
//
//  Created by wireline on 2017. 8. 17..
//
//

#import "SBTakeOverActionViewController.h"

#import "SBTakeOverActionTableViewCell.h"

#import "SBUserInfoVO.h"
#import "JSON.h"
#import "HttpRequest.h"
#import "SBUtils.h"

#import "Smart_BIMSAppDelegate.h"


@interface SBTakeOverActionViewController ()

@end

@implementation SBTakeOverActionViewController

@synthesize m_SBUserInfoVO;
@synthesize m_mDataArray;
@synthesize m_tableView;
@synthesize m_activityIndicatorView;

@synthesize m_pageTitleLabel;

@synthesize m_bloodNoTextField;
@synthesize m_assignedBloodNoTextField;
@synthesize m_rhnEmergencyBloodNoTextField;

@synthesize m_bldProcNameShLabel;
@synthesize m_bldProcCodeLabel;
@synthesize m_bldProcBarCodeTextField;

@synthesize m_takeOverSeqLabel;
@synthesize m_takeOverBloodCntLabel;

@synthesize m_assignedBloodNoLabel;
@synthesize m_bloodNoToLeftLabel;
@synthesize m_bloodNoToRightLabel;
@synthesize m_rhnEmergencyBloodNoLabel;
@synthesize m_toLeftBtn;
@synthesize m_toRightBtn;

@synthesize m_target;
@synthesize m_selector;

@synthesize m_scrollView;
@synthesize m_containerView;

@synthesize numOfRBC;
@synthesize numOfFRBC;
@synthesize numOfPLA;
@synthesize numOfPLAM;
@synthesize numOfAPLT;
@synthesize numOfAPLTM;
@synthesize numOfWB;
@synthesize m_chkmal;

@synthesize m_numOfBlood;
@synthesize m_numOfBloodBag;

- (IBAction)bgtab:(id)sender {
    [self.m_bloodNoTextField resignFirstResponder];
    [self.m_assignedBloodNoTextField resignFirstResponder];
    [self.m_rhnEmergencyBloodNoTextField resignFirstResponder];
    [self.m_bldProcBarCodeTextField resignFirstResponder];
    
    self.m_bldProcNameShLabel.text = @"";
    self.m_bldProcCodeLabel.text = @"";
    self.m_bldProcBarCodeTextField.text = @"";
    self.m_chkmal.text = @"";
}

- (IBAction)pageReset:(id)sender
{
    if([self.m_activityIndicatorView isAnimating]){
        [m_activityIndicatorView stopAnimating];
    }
    
    [m_mDataArray removeAllObjects];
    [self backgroundTab:nil];
    
    [self getTakeOverBloodInfoWithSeq:nil];
    
//    [self.m_bloodNoTextField becomeFirstResponder];
}


- (IBAction)onHomeButtonTab:(id)sender
{
    [self backgroundTab:nil];
    
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.view.frame = CGRectMake(0, winHeight, viewWidth, viewHeight);
    
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(onToHomeViewSelector)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) onToHomeViewSelector
{
    //    [self.m_bldProcPickerViewController.view removeFromSuperview];
    [m_target performSelector:m_selector withObject:nil];
    [self.view removeFromSuperview];
}



- (void)backgroundTab:(id)sender
{
    [self.m_bloodNoTextField resignFirstResponder];
    [self.m_assignedBloodNoTextField resignFirstResponder];
    [self.m_rhnEmergencyBloodNoTextField resignFirstResponder];
    
    self.m_bldProcNameShLabel.text = @"";
    self.m_bldProcCodeLabel.text = @"";
    self.m_bldProcBarCodeTextField.text = @"";
    self.m_chkmal.text = @"";
    
    [self scrollViewScrollWithPageNumber:1];
}

- (void) setDelegate:(id)target selector:(SEL)selector
{
    self.m_target = target;
    self.m_selector = selector;
}


#pragma mark -
#pragma mark Custom Methods
- (void)getBloodNoInfo:(NSString*)strBloodNo
{
    TRACE(@"getBloodNoInfo Occurred!");

    NSString* tempReqId = @"getBloodNoInfo";
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                strBloodNo, @"bloodno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveGetBloodNoInfo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    //    m_searchBtn.enabled = NO;
    [self.m_activityIndicatorView startAnimating];
}

- (void)didReceiveGetBloodNoInfo:(id)result
{
    NSString* strData;
    NSString* strBloodNo;
    NSString* strBldProcCode;
    NSString* strBldProcName;
    NSString* strBldProcNameSh;
    NSString* strBloodNoCnt;
    NSString* strEndResult;
    NSString* chkmal;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    //    m_searchBtn.enabled = YES;
    [self.m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strBloodNo = [dictionary valueForKey:@"bloodno"];
    strBldProcCode = [dictionary valueForKey:@"bldproccode"];
    strBldProcName = [dictionary valueForKey:@"bldprocname"];
    strBldProcNameSh = [dictionary valueForKey:@"bldprocnamesh"];
    strBloodNoCnt = [dictionary valueForKey:@"cnt"];
    strEndResult = [dictionary valueForKey:@"endresult"];
    chkmal = [dictionary valueForKey:@"chkmal"];
    
    int nBloodNoCnt = [strBloodNoCnt intValue];
    
    if(nBloodNoCnt > 0)
    {
        
        // 다종일 경우 백종류바코드 배경색 변경
        
        if([strEndResult isEqualToString:@"N"] == YES) // == 수정
        {
                    self.m_bldProcBarCodeTextField.text = @"";
                    self.m_chkmal.text = @"";
            //        self.m_bldProcCodeLabel.text = @"";
                    self.m_bldProcNameShLabel.text = @"";
                    self.m_bldProcCodeLabel.text = @"";
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                        message:@"종료시간 미입력 혈액입니다."
                                                                       delegate:self
                                                              cancelButtonTitle:@"확인"
                                                              otherButtonTitles: nil];
                    
                    
                    [alertView show];
                    [alertView release];
                    
                    [self setFocusTextFieldWithTimer];
                    
                    return;
        }
        
        
        if([strBldProcCode isEqualToString:@"82"] == YES){
            self.m_bldProcBarCodeTextField.backgroundColor = UIColor.blueColor;
        }
        
//      self.m_bldProcCodeLabel.text = strBldProcCode;
        self.m_bldProcNameShLabel.text = strBldProcNameSh;
        self.m_bldProcCodeLabel.text = strBldProcCode;
        self.m_chkmal.text = [chkmal isEqualToString:@"Y"] ? @"제한": @"";
        
        self.m_bldProcBarCodeTextField.text = @"";
        [self.m_bldProcBarCodeTextField becomeFirstResponder];

    }else
    {
        self.m_bldProcBarCodeTextField.text = @"";
//      self.m_bldProcCodeLabel.text = @"";
        self.m_bldProcNameShLabel.text = @"";
        self.m_bldProcCodeLabel.text = @"";
        self.m_chkmal.text = @"";
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"해당 혈액번호가 존재하지 않습니다."
                                                            //message:@"해당 혈액번호가 존재하지 않습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        [self setFocusTextFieldWithTimer];
        
        return;
    }
}

// 현재 혈액번호 입력란 Scroll Page return
- (int)getBloodNoPage
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    return page;
}

// 지정, Rh(-)긴급, 일반 혈액번호 중 현재 선택된 혈액번호에 fucusing
- (void)setFocusBloodNo
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    if(page == 0){
        self.m_assignedBloodNoTextField.text = @"";
        [m_assignedBloodNoTextField becomeFirstResponder];
    }else if(page == 1){
        self.m_bloodNoTextField.text = @"";
        [m_bloodNoTextField becomeFirstResponder];
    }else if(page == 2){
        self.m_rhnEmergencyBloodNoTextField.text = @"";
        [m_rhnEmergencyBloodNoTextField becomeFirstResponder];
    }
}


- (void)chkBldProcBarCode
{
    TRACE(@"chkBldProcBarCode Occurred!");
    
    NSString* strBloodNo = @"";
    NSString* strBldProcBarCode = m_bldProcBarCodeTextField.text;
    
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);

    if(page == 0){
        strBloodNo = m_assignedBloodNoTextField.text;
    }else if(page == 1){
        strBloodNo = m_bloodNoTextField.text;
    }else if(page == 2){
        strBloodNo = m_rhnEmergencyBloodNoTextField.text;
    }
    
    
    
    NSString* tempReqId = @"chkBldProcBarCode";
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                strBloodNo, @"bloodno",
                                strBldProcBarCode, @"bldprocbarcode",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveChkBldProcBarCode:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    //    m_searchBtn.enabled = NO;
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveChkBldProcBarCode:(id)result
{
    NSString* strData;
    NSString* strRetVal;
    NSString* strBloodNo;
    NSString* strBldProcCode;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    TRACE(@"strBldProcCode := [%@]", self.m_bldProcCodeLabel.text);
    
    //    m_searchBtn.enabled = YES;
    [self.m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strBloodNo = [dictionary valueForKey:@"bloodno"];
    strRetVal = [dictionary valueForKey:@"validbldprocbarcode"];  // 다종일 경우 대표되는 헌혈종류(decode), 단일종일 경우 그냥 헌혈종류(nur_master)
    strBldProcCode = [dictionary valueForKey:@"bldproccode"];
    
    if([strRetVal isEqualToString:@"N"] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[주 의]"
                                                            message:@"존재하지 않는 혈액번호와 헌혈종류입니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        [self setFocusTextFieldWithTimer];
        
        return;
    }
    
    if([strBldProcCode isEqualToString:self.m_bldProcCodeLabel.text] == NO){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[주 의]"
                                                            message:@"혈액번호의 헌혈종류와 제제코드의 헌혈종류가 일치하지 않습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        [self setFocusTextFieldWithTimer];
        
        return;
    }
    
    // 중복체크 기능 넣을꺼임
    int nSize = (int)m_mDataArray.count;
    int i;
    
    for(i = 0; i < nSize; i++){
        if([[SBUtils formatBloodNo:strBloodNo] isEqualToString:[[m_mDataArray objectAtIndex:i] objectForKey:@"labelno"]]
           && [m_bldProcBarCodeTextField.text isEqualToString:[[m_mDataArray objectAtIndex:i] objectForKey:@"bldprocbarcode"]]){
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                                message:@"이미 등록된 헌혈종류와 혈액번호입니다"
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles: nil];
            
            alertView.tag = kIsDuplicatedBloodNoTag;
            
            [alertView show];
            [alertView release];
            
            return;
        }
    }
    
    NSString* tempIsAssignmentBlood = @"N";
    NSString* tempIsRhnEmergencyBlood = @"N";
    
    int page = [self getBloodNoPage];
    
    if(page == 0){
        tempIsAssignmentBlood = @"Y";
    }else if(page == 1){
        // Nothing to do...
    }else if(page == 2){
        tempIsRhnEmergencyBlood = @"Y";
    }
    
    [m_mDataArray insertObject:@{@"issaved" : @"N",
                              @"labelno" : [SBUtils formatBloodNo:strBloodNo],
                              @"bloodno" : [SBUtils getParameterTypeBloodNo:strBloodNo],
                              @"bldprocbarcode" : self.m_bldProcBarCodeTextField.text,
                              @"bldprocnamesh" : strRetVal,
                              @"isassigned" : tempIsAssignmentBlood,
                              @"rhnemergency" : tempIsRhnEmergencyBlood}
                       atIndex:0];
    
    //    [self.m_assignmentBloodSwitch setOn:NO];
    //    [self.m_rhnEmergencyBloodSwitch setOn:NO];
    
    [m_tableView reloadData];
    
    //    - (void)scrollRowToVisible:(NSInteger)row;
    NSIndexPath* bottom = [NSIndexPath indexPathForRow:[m_mDataArray count]-1
                                             inSection:0];
    [self.m_tableView scrollToRowAtIndexPath:bottom atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    self.m_takeOverBloodCntLabel.text = (NSString*)[NSString stringWithFormat:@"%lu", (unsigned long)m_mDataArray.count];
    
    [self setFocusTextField];
}


//- (void)addBloodNo:(NSString*)strBloodNo bloodType:(NSString*)strBloodType
//{
//    // strBloodType: B(일반혈액), A(지정혈액), R(Rh(-)긴급혈액)
//    TRACE(@"addBloodNo Occurred");
//
//    NSString* tempIsAssignmentBlood = @"N";
//    NSString* tempIsRhnEmergencyBlood = @"N";
//
//    if([strBloodType isEqualToString:@"B"]){
//        // Nothing to do...
//    }else if([strBloodType isEqualToString:@"A"]){
//        tempIsAssignmentBlood = @"Y";
//    }else if([strBloodType isEqualToString:@"R"]){
//        tempIsRhnEmergencyBlood = @"Y";
//    }else{
//        // Nothing to do...
//    }
//
//    // 중복체크 기능 넣을꺼임
//    int nSize = (int)m_mDataArray.count;
//    int i;
//
//    for(i = 0; i < nSize; i++){
//        if([[SBUtils formatBloodNo:strBloodNo] isEqualToString:[[m_mDataArray objectAtIndex:i] objectForKey:@"labelno"]]){
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
//                                                                message:@"이미 등록된 혈액번호입니다"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"확인"
//                                                      otherButtonTitles: nil];
//
//            alertView.tag = kIsDuplicatedBloodNoTag;
//
//            [alertView show];
//            [alertView release];
//
//            return;
//        }
//    }
//
//    [m_mDataArray addObject:@{@"issaved" : @"N",
//                              @"labelno" : [SBUtils formatBloodNo:strBloodNo],
//                              @"bloodno" : [SBUtils getParameterTypeBloodNo:strBloodNo],
//                              @"isassigned" : tempIsAssignmentBlood,
//                              @"rhnemergency" : tempIsRhnEmergencyBlood}];
//
////    [self.m_assignmentBloodSwitch setOn:NO];
////    [self.m_rhnEmergencyBloodSwitch setOn:NO];
//
//    [m_tableView reloadData];
//
////    - (void)scrollRowToVisible:(NSInteger)row;
//    NSIndexPath* bottom = [NSIndexPath indexPathForRow:[m_mDataArray count]-1 inSection:0];
//    [self.m_tableView scrollToRowAtIndexPath:bottom atScrollPosition:UITableViewScrollPositionTop animated:YES];
//
//
//    self.m_takeOverBloodCntLabel.text = (NSString*)[NSString stringWithFormat:@"%lu", (unsigned long)m_mDataArray.count];
//
//    [self setFocusTextField];
//}


- (void)setFocusTextFieldWithTimer
{
    [self.m_bloodNoTextField resignFirstResponder];
    [self.m_assignedBloodNoTextField resignFirstResponder];
    [self.m_rhnEmergencyBloodNoTextField resignFirstResponder];
    
    self.m_bldProcNameShLabel.text = @"";
    self.m_bldProcCodeLabel.text = @"";
    self.m_bldProcBarCodeTextField.text = @"";
    self.m_chkmal.text = @"";
    
//    CGFloat pageWidth = m_scrollView.frame.size.width;
//    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    [NSTimer scheduledTimerWithTimeInterval:0.6
                                     target:self
                                   selector:@selector(setFocusTextField)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)setFocusTextField
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    self.m_bldProcNameShLabel.text = @"";
    self.m_bldProcCodeLabel.text = @"";
    self.m_bldProcBarCodeTextField.text = @"";
    self.m_chkmal.text = @"";
    
    if(page == 0){
        self.m_assignedBloodNoTextField.text = @"";
        [self.m_assignedBloodNoTextField becomeFirstResponder];
    }else if(page == 1){
        self.m_bloodNoTextField.text = @"";
        [self.m_bloodNoTextField becomeFirstResponder];
    }else if(page == 2){
        self.m_rhnEmergencyBloodNoTextField.text = @"";
        [self.m_rhnEmergencyBloodNoTextField becomeFirstResponder];
    }else{
        
    }
}



- (IBAction)getTakeOverBloodInfoWithSeq:(id)sender
{
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"takeOverBloodInfoWithSeq";
    
    
    TRACE(@"%@", tempReqId);
    
    TRACE(@"onSearch Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"009";
        tempCarCode = @"55";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
    }
    
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    
    TRACE(@"getTakeOverBloodInfoWithSeq Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempUserId = @"R2019014";
    }else{
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    
    TRACE(@"getTakeOverBloodInfoWithSeq tempUserId [%@]", tempUserId);
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                tempUserId, @"userId",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveTakeOverBloodInfoWithSeq:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
//    m_searchBtn.enabled = NO;
    [self.m_activityIndicatorView startAnimating];
}

- (void)didReceiveTakeOverBloodInfoWithSeq:(id)result
{
    NSString* strData;
    NSString* strNextTakeOverSeq;
    NSString* strBloodCnt;
    NSString* strBloodCntInfo;
    
    NSString* numOfAPLT;
    NSString* numOfAPLTM;
    NSString* numOfRBC;
    NSString* numOfRBC400;
    NSString* numOfFRBC;
    NSString* numOfPLA;
    NSString* numOfPLAM;
    NSString* numOfWB;
    
    NSString* numOfBlood;
    NSString* numOfBloodBag;
//    NSString* strBldBagCnt;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
//    m_searchBtn.enabled = YES;
    [self.m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strNextTakeOverSeq = [dictionary valueForKey:@"nexttakeoverseq"];
    strBloodCnt = [dictionary valueForKey:@"bloodcnt"];
    strBloodCntInfo = [dictionary valueForKey:@"bloodcntinfo"];
    
    numOfAPLT = [dictionary valueForKey:@"numOfAPLT"];
    numOfAPLTM = [dictionary valueForKey:@"numOfAPLTM"];
    numOfRBC = [dictionary valueForKey:@"numOfRBC"];
    numOfRBC400 = [dictionary valueForKey:@"numOfRBC400"];
    numOfFRBC = [dictionary valueForKey:@"numOfFRBC"];
    numOfPLA = [dictionary valueForKey:@"numOfPLA"];
    numOfPLAM = [dictionary valueForKey:@"numOfPLAM"];
    //numOfWB = [dictionary valueForKey:@"numOfWB"];
    numOfBlood = [dictionary valueForKey:@"numOfBlood"];
    numOfBloodBag = [dictionary valueForKey:@"numOfBloodBag"];
    
    self.m_takeOverSeqLabel.text = strNextTakeOverSeq;

    
    int nBloodNoCnt = [strBloodCnt intValue];
    
    if(nBloodNoCnt > 0){
        m_mDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"result"]];
//        m_tableView.hidden = NO;
        
        self.m_takeOverBloodCntLabel.text = strBloodCntInfo;
        
        self.numOfAPLT.text = numOfAPLT;
        self.numOfAPLTM.text = numOfAPLTM;
        self.numOfRBC.text = numOfRBC;
        self.numOfRBC400.text = numOfRBC400;
        self.numOfFRBC.text = numOfFRBC;
        self.numOfPLA.text = numOfPLA;
        self.numOfPLAM.text = numOfPLAM;
        //self.numOfWB.text = numOfWB;
        self.m_numOfBlood.text = numOfBlood;
        self.m_numOfBloodBag.text = numOfBloodBag;
    }else{
        [m_mDataArray removeAllObjects];
//        m_tableView.hidden = YES;
        
        self.m_takeOverBloodCntLabel.text = strBloodCntInfo;
        
        self.numOfAPLT.text = @"0";
        self.numOfAPLTM.text = @"0";
        self.numOfRBC.text = @"0";
        self.numOfRBC400.text = @"0";
        self.numOfFRBC.text = @"0";
        self.numOfPLA.text = @"0";
        self.numOfPLAM.text = @"0";
        //self.numOfWB.text = numOfWB;
        self.m_numOfBlood.text = @"0";
        self.m_numOfBloodBag.text = @"0";
    }

    [self.m_tableView reloadData];
    
    [self setFocusTextFieldWithTimer];
}

- (void)scrollViewScrollWithPageNumber:(int)pageInt
{
    // 두 번째 페이지로 강제 이동
    CGRect bounds = m_scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * pageInt;
    bounds.origin.y = 0;
    
    [m_scrollView scrollRectToVisible:bounds animated:YES];
    
    if(pageInt == 0){
        self.m_toLeftBtn.hidden = YES;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = NO;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
//        [self.m_assignedBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
        
    }else if(pageInt == 1){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = NO;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = NO;
        
//        [self.m_bloodNoTextField becomeFirstResponder]
        [self setFocusTextFieldWithTimer];;
    }else if(pageInt == 2){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = YES;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = NO;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
//        [self.m_rhnEmergencyBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }
}


- (IBAction)onScrollMoveLeftBtn:(id)sender
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int pageInt = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    CGRect bounds = m_scrollView.bounds;
    
    bounds.origin.x = CGRectGetWidth(bounds) * (--pageInt);
    bounds.origin.y = 0;
    
    [m_scrollView scrollRectToVisible:bounds animated:YES];
    
    if(pageInt == 0){
        self.m_toLeftBtn.hidden = YES;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = NO;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
        //        [self.m_assignedBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
        
    }else if(pageInt == 1){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = NO;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = NO;
        
        //        [self.m_bloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }else if(pageInt == 2){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = YES;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = NO;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
        //        [self.m_rhnEmergencyBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }
}

- (IBAction)onScrollMoveRightBtn:(id)sender
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int pageInt = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    CGRect bounds = m_scrollView.bounds;
    
    bounds.origin.x = CGRectGetWidth(bounds) * (++pageInt);
    bounds.origin.y = 0;
    
    [m_scrollView scrollRectToVisible:bounds animated:YES];
    
    if(pageInt == 0){
        self.m_toLeftBtn.hidden = YES;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = NO;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
        //        [self.m_assignedBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
        
    }else if(pageInt == 1){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = NO;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = NO;
        
        //        [self.m_bloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }else if(pageInt == 2){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = YES;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = NO;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
        //        [self.m_rhnEmergencyBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }
}


- (void)onDeleteSavedBloodNo:(NSString*)strBloodNo bldprocbarcode:(NSString*)strBldProcBarCode
{
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"takeOverBloodDelete";
    
    TRACE(@"onDeleteSavedBloodNo Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"001";
        tempCarCode = @"72";
        tempUserId = @"R2019014";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    
    TRACE(@"strBloodNo = [%@]", strBloodNo);
    TRACE(@"strBldProcBarCode = [%@]", strBldProcBarCode);
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                strBloodNo, @"bloodno",
                                strBldProcBarCode, @"bldprocbarcode",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                tempUserId, @"idno",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveDeleteSavedBloodNo:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveDeleteSavedBloodNo:(id)result
{
    NSString* strData;
    NSString* strRetVal;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    //    m_searchBtn.enabled = YES;
    [self.m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strRetVal = [dictionary valueForKey:@"resultcode"];
    
    TRACE(@"strRetVal = [%@]", strRetVal);
    TRACE(@"strResultmsg = [%@]", [dictionary valueForKey:@"resultmsg"]);
    
    if([strRetVal isEqualToString:@"S"]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"성공"
                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kDeleteSavedBloodNoSuccessTag;
        
        [alertView show];
        [alertView release];
    }else{
        NSString* strTempMsg = [NSString stringWithFormat:@"오류코드[%@] \n%@", strRetVal, [dictionary valueForKey:@"resultmsg"]];
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strTempMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kDeleteSavedBloodNoFailTag;
        
        [alertView show];
        [alertView release];
        
    }
}



- (IBAction)onSave:(id)sender
{
    TRACE(@"onSave occurred!");
    
    NSString* tempOrgCode = nil;
    NSString* tempCarCode = nil;
    NSString* tempUserId = nil;
    NSString* tempReqId = @"takeOverBloodSave";
    
    
    TRACE(@"%@", tempReqId);
    
    TRACE(@"onSearch Occurred [%@]", m_SBUserInfoVO.szBimsId);
    
    // 저장되지 않은 혈액번호:혈액제제바코드가 있는지 확인
    int nSize = (int)m_mDataArray.count;
    int i;
    int nUnSavedBloodNoCnt = 0;
    
    for(i = 0; i < nSize; i++){
        if([[[m_mDataArray objectAtIndex:i] objectForKey:@"issaved"] isEqualToString: @"N"]){
            nUnSavedBloodNoCnt++;
            break;
        }
    }
    
    if(nUnSavedBloodNoCnt <= 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:@"새로 등록된 혈액번호가 없습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
//        alertView.tag = kIsDuplicatedBloodNoTag;
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    if([m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"] || [m_SBUserInfoVO.szBimsId isEqualToString:@"R2011202"]|| [m_SBUserInfoVO.szBimsId isEqualToString:@"R2020045"]){
        tempOrgCode = @"001";
        tempCarCode = @"72";
        tempUserId = @"R2009129";
    }else{
        tempOrgCode = [NSString stringWithString:m_SBUserInfoVO.szBimsOrgcode];
        tempCarCode = [NSString stringWithString:m_SBUserInfoVO.szBimsCarcode];
        tempUserId = [NSString stringWithString:m_SBUserInfoVO.szBimsId];
    }
    
    //    SBJsonWriter* writer = [[SBJsonWriter alloc] init];
    SBJsonWriter* jsonWriter = [SBJsonWriter new];
    [jsonWriter setHumanReadable:YES];
    
    NSString* jsonString = [jsonWriter stringWithObject:self.m_mDataArray];
    
    TRACE(@"onSave:%@", jsonString);
    
    [jsonWriter release];
    
    NSString* url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBTakeOverBloodDAONew_TEST1.jsp";
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                tempReqId, @"reqId",
                                tempOrgCode, @"orgcode",
                                tempCarCode, @"carcode",
                                self.m_takeOverSeqLabel.text, @"takeoverseq",
                                tempUserId, @"userId",
                                jsonString, @"bloodnoList",
                                nil];
    
    [m_httpRequest setDelegate:self
                      selector:@selector(didReceiveTakeOverBloodNoSave:)];
    [m_httpRequest requestURL:url
                   bodyObject:bodyObject];
    
    //    m_searchBtn.enabled = NO;
    [self.m_activityIndicatorView startAnimating];
}


- (void)didReceiveTakeOverBloodNoSave:(id)result
{
    NSString* strData;
    NSString* strRetVal;
    
    strData = [(NSString*)result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    TRACE(@"strData := [%@]", strData);
    
    //    m_searchBtn.enabled = YES;
    [self.m_activityIndicatorView stopAnimating];
    
    // 응답값 확인
    if([strData isEqualToString:kREQUEST_TIMEOUT_TYPE] == YES){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알 림]"
                                                            message:kREQUEST_TIMEOUT_MSG
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        
        [alertView show];
        [alertView release];
        
        return;
    }
    
    SBJsonParser* jsonParser = [SBJsonParser new];
    NSDictionary* dictionary = nil;
    
    // JSON 문자열을 객체로 변환
    dictionary = [jsonParser objectWithString:strData];
    
    strRetVal = [dictionary valueForKey:@"result"];
    
    TRACE(@"strRetVal = [%@]", strRetVal);
    TRACE(@"strResultmsg = [%@]", [dictionary valueForKey:@"resultmsg"]);
    
    if([strRetVal isEqualToString:@"Y"]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"성공"
                                                            message:[dictionary valueForKey:@"resultmsg"]
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kBloodInfoSaveSuccessTag;
        
        [alertView show];
        [alertView release];
        
        [self getTakeOverBloodInfoWithSeq:nil];
        
    }else{
        NSString* strTempMsg = [NSString stringWithFormat:@"오류코드[%@] \n%@",
                                strRetVal, [dictionary valueForKey:@"resultmsg"]];
        [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"오류"
                                                            message:strTempMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
        
        alertView.tag = kBloodInfoSaveFailTag;
        
        [alertView show];
        [alertView release];

    }
}




#pragma -
#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    TRACE(@"scrollView pageIndex = [%d], pageWidth = [%f], pageHeight = [%f]", page, pageWidth, m_scrollView.frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = m_scrollView.frame.size.width;
    int page = (int) ((m_scrollView.contentOffset.x + pageWidth/2) / pageWidth);
    
    if(page == 0){
        self.m_toLeftBtn.hidden = YES;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = NO;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
//        [self.m_assignedBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
        
    }else if(page == 1){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = NO;
        self.m_assignedBloodNoLabel.hidden = NO;
        self.m_bloodNoToLeftLabel.hidden = YES;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = NO;
        
//        [self.m_bloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }else if(page == 2){
        self.m_toLeftBtn.hidden = NO;
        self.m_toRightBtn.hidden = YES;
        self.m_assignedBloodNoLabel.hidden = YES;
        self.m_bloodNoToLeftLabel.hidden = NO;
        self.m_bloodNoToRightLabel.hidden = YES;
        self.m_rhnEmergencyBloodNoLabel.hidden = YES;
        
//        [self.m_rhnEmergencyBloodNoTextField becomeFirstResponder];
        [self setFocusTextFieldWithTimer];
    }

}


#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    TRACE(@"hahaha buttonIndex [%ld]", (long)buttonIndex);
    TRACE(@"hahaha buttonIndex [%@]", alertView.title);
    
    if(alertView.tag == kIsDuplicatedBloodNoTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
        }else{
            [self setFocusTextFieldWithTimer];
        }
    }else if(alertView.tag == kWrongBloodNoInsertedTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
            
        }else{
            [self setFocusTextFieldWithTimer];
        }
    }else if(alertView.tag == kWrongAssingedBloodNoInsertTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
            
        }else{
            [self setFocusTextFieldWithTimer];
        }
    }else if(alertView.tag == kWrongRhnEmergencyBloodNoTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
            
        }else{
            [self setFocusTextFieldWithTimer];
        }
    }else if(alertView.tag == kDeleteBloodNoTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
            if([[m_mDataArray objectAtIndex:[m_tableView indexPathForSelectedRow].row] objectForKey:@"issaved"]){
                
            }
            
            [self.m_mDataArray removeObjectAtIndex:[m_tableView indexPathForSelectedRow].row];
            [m_tableView reloadData];
            
            self.m_takeOverBloodCntLabel.text = (NSString*)[NSString stringWithFormat:@"%lu", (unsigned long)m_mDataArray.count];
        }else{
            
        }
    }else if(alertView.tag == kDeleteSavedBloodNoTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            [self onDeleteSavedBloodNo: m_deleteBloodNo
                        bldprocbarcode: m_deleteBloodProcode];
        }else{
            // Not to do...
        }
    }else if(alertView.tag == kBloodInfoSaveSuccessTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
        }else{
            [self pageReset:nil];
        }
    }else if(alertView.tag == kBloodInfoSaveFailTag){
//        [self pageReset:nil];
        if([self.m_activityIndicatorView isAnimating]){
            [m_activityIndicatorView stopAnimating];
        }
        
//        [m_mDataArray removeAllObjects];
        [self backgroundTab:nil];
        
    }else if(alertView.tag == kDeleteSavedBloodNoSuccessTag){
        if(buttonIndex != [alertView cancelButtonIndex]){
            // TO DO...
        }else{
            [self.m_mDataArray removeObjectAtIndex: m_deleteRow];
            [m_tableView reloadData];
            
            self.m_takeOverBloodCntLabel.text = (NSString*)[NSString stringWithFormat:@"%lu", (unsigned long)m_mDataArray.count];
            
            [self setFocusTextFieldWithTimer];
        }
    }
}



#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nTag = textField.tag;
    //    NSString* strInput = textField.text;
    NSUInteger strLength = textField.text.length;
//    NSString* strAlertMsg = @"혈액번호 형식이 틀립니다.";
    
    switch(nTag){
        case kBloodNoTextField :
            if(strLength < 12){
//                self.m_strBarcodeBloodNo = nil;
//                [m_strBarcodeBloodNo release];
//                self.m_strBarcodeBloodNo = [[NSMutableString alloc] initWithCapacity:16];
                
                m_bloodNoTextField.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"혈액번호형식이 틀립니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                alertView.tag = kWrongBloodNoInsertedTag;
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else if(strLength == 12){
//                [self addBloodNo:m_bloodNoTextField.text bloodType:@"B"];
//                strBloodtype = @"B";
                [self getBloodNoInfo:m_bloodNoTextField.text];
            }
            break;
        case kAssignedBloodNoTextField :
            if(strLength < 12){
                m_assignedBloodNoTextField.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"지정혈액번호형식이 틀립니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                alertView.tag = kWrongAssingedBloodNoInsertTag;
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else if(strLength == 12){
//                [self addBloodNo:m_assignedBloodNoTextField.text bloodType:@"A"];
//                strBloodtype = @"A";
                [self getBloodNoInfo:m_assignedBloodNoTextField.text];
            }
            break;
        case kRhnEmergencyBloodNoTextField :
            if(strLength < 12){
                m_rhnEmergencyBloodNoTextField.text = @"";
                
                [SBUtils playAlertSystemSoundWithSoundType:SOUND_ALERT_1];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"입력오류"
                                                                    message:@"긴급혈액번호형식이 틀립니다"
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles: nil];
                
                alertView.tag = kWrongRhnEmergencyBloodNoTag;
                
                [alertView show];
                [alertView release];
                
                return NO;
            }else if(strLength == 12){
//                [self addBloodNo:m_rhnEmergencyBloodNoTextField.text bloodType:@"R"];
//                strBloodtype = @"R";
                [self getBloodNoInfo:m_rhnEmergencyBloodNoTextField.text];
            }
            break;
        case kBldProcBarCodeTextField :
            [self chkBldProcBarCode];
            break;
        default:
            return YES;
    }
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString*)string
{
    NSInteger nTag = textField.tag;
    NSString* strInput = @"";
    
    strInput = [textField.text stringByReplacingCharactersInRange:range
                                                       withString:string];
    
    //    TRACE(@"%@'s length is [%d]", strInput, strInput.length);
    
    switch(nTag){
        case kBloodNoTextField :
            if(strInput.length > 12){
                return NO;
            }
            break;
        case kAssignedBloodNoTextField :
            if(strInput.length > 12){
                return NO;
            }
            break;
        case kRhnEmergencyBloodNoTextField :
            if(strInput.length > 12){
                return NO;
            }
            break;
        default:
            return YES;
    }
    
    return YES;
}


#pragma mark -
#pragma mark UITableDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRACE(@"Table view selected: [%ld]", (long)indexPath.row);
    return indexPath;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)umberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_mDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellid = @"SBTakeOverActionTableViewCellId";
    SBTakeOverActionTableViewCell* cell = (SBTakeOverActionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell == nil){
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SBTakeOverActionTableViewCell"
                                                     owner:self
                                                   options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[SBTakeOverActionTableViewCell class]]){
                cell = (SBTakeOverActionTableViewCell*)oneObject;
            }
        }
    }
    
    int nRow = (int)indexPath.row;
    
    NSString* tempIsAssignmentBlood = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"isassigned"];
    NSString* tempIsRhnEmergencyBlood = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"rhnemergency"];
    
    TRACE(@"table nRow = [%d]", nRow);
    if([[[m_mDataArray objectAtIndex:nRow] objectForKey:@"issaved"] isEqualToString:@"Y"]){
        cell.m_savedFlagBtn.hidden = NO;
    }else{
        cell.m_savedFlagBtn.hidden = YES;
        cell.backgroundColor = [UIColor colorWithRed:252/255.0 green:198/255.0 blue:162/255.0 alpha:1];
    }
    
    
   cell.m_bloodNo.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"labelno"];
   cell.m_bldProcNameShLabel.text = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocnamesh"];
   if([tempIsAssignmentBlood isEqualToString:@"Y"]){
       cell.m_assignmentBloodLabel.hidden = NO;
   }else{
        cell.m_assignmentBloodLabel.hidden = YES;
    }
    
    if([tempIsRhnEmergencyBlood isEqualToString:@"Y"]){
        cell.m_rhnEmergencyBloodLabel.hidden = NO;
    }else{
        cell.m_rhnEmergencyBloodLabel.hidden = YES;
    }
    //chkmal
    NSString* chkmal = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"malchk"];
    
    if([chkmal isEqualToString:@"Y"]){
        cell.m_bldProcNameShLabel.backgroundColor = UIColor.yellowColor;
    }

    TRACE(@"bloodno = [%@]", [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodno"]);
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int nRow = (int)indexPath.row;
    TRACE(@"bloodno=[%@]", [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodno"]);
    m_deleteBloodNo = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bloodno"];
    m_deleteBloodProcode = [[m_mDataArray objectAtIndex:nRow] objectForKey:@"bldprocbarcode"];
    m_deleteRow = nRow;
    
    if([[[m_mDataArray objectAtIndex:nRow] objectForKey:@"issaved"] isEqualToString:@"Y"]){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[주 의]"
                                                            message:@"이미 저장된 혈액번호입니다.\n삭제하시겠습니까?"
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        alertView.tag = kDeleteSavedBloodNoTag;
        
        [alertView show];
        [alertView release];
        [self getTakeOverBloodInfoWithSeq:nil];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[등록삭제]"
                                                            message:@"삭제하시겠습니까?"
                                                           delegate:self
                                                  cancelButtonTitle:@"아니오"
                                                  otherButtonTitles:@"예", nil];
        
        alertView.tag = kDeleteBloodNoTag;
        
        [alertView show];
        [alertView release];
    }
}



#pragma mark -
#pragma mark Default methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Smart_BIMSAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    viewWidth = [delegate.g_viewWidth intValue];
    viewHeight = [delegate.g_viewHeight intValue];
    winHeight = [delegate.g_winHeight intValue];
    
    m_httpRequest = [[HttpRequest alloc] init];
    
    m_mDataArray = [[NSMutableArray alloc] initWithCapacity:128];
    
    CGSize size;
    // 2016.10.20: iOS10에서는 이상하게 m_btnContainerView 의 사이즈가 커진다... 직접 설정하도록 소스 수정
    size.height = self.m_containerView.frame.size.height;
    size.width = self.m_containerView.frame.size.width;
    
    size.height = 50;
    size.width = 960;
    
    TRACE(@"width : %f, height : %f", size.width, size.height);
    
    self.m_scrollView.contentSize = size;
    
    [self.view addSubview:m_scrollView];
    [m_scrollView addSubview:m_containerView];
    
    // 두 번째 페이지로 강제 이동
    [self scrollViewScrollWithPageNumber:1];
    
//    [self addBloodNo:@"010839990101" bloodType:nil];
//    [self addBloodNo:@"010839990201" bloodType:@"B"];
//    [self addBloodNo:@"010839990301" bloodType:nil];
//    [self addBloodNo:@"010839990401" bloodType:@"R"];
//    [self addBloodNo:@"010839990801" bloodType:nil];
//    [self addBloodNo:@"010839990501" bloodType:nil];
//    [self addBloodNo:@"010839990601" bloodType:@"A"];
//    [self addBloodNo:@"010839990701" bloodType:nil];
//    [self addBloodNo:@"010839990901" bloodType:nil];
//    [self addBloodNo:@"010839991001" bloodType:nil];
//    [self addBloodNo:@"010839991101" bloodType:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.m_pageTitleLabel = nil;
    
    self.m_SBUserInfoVO = nil;
    self.m_bloodNoTextField = nil;
    self.m_assignedBloodNoTextField = nil;
    self.m_rhnEmergencyBloodNoTextField = nil;
    
    self.m_bldProcNameShLabel = nil;
    self.m_bldProcCodeLabel = nil;
    self.m_bldProcBarCodeTextField = nil;
    
    self.m_tableView = nil;
    self.m_activityIndicatorView = nil;
    self.m_mDataArray = nil;
    
    self.m_takeOverSeqLabel = nil;
    self.m_takeOverBloodCntLabel = nil;
    
    self.m_assignedBloodNoLabel = nil;
    self.m_bloodNoToLeftLabel = nil;
    self.m_bloodNoToRightLabel = nil;
    self.m_rhnEmergencyBloodNoLabel = nil;
    self.m_toLeftBtn = nil;
    self.m_toRightBtn = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [m_pageTitleLabel release];
    [m_SBUserInfoVO release];
    [m_bloodNoTextField release];
    [m_assignedBloodNoTextField release];
    [m_rhnEmergencyBloodNoTextField release];
    [m_bldProcNameShLabel release];
    [m_bldProcCodeLabel release];
    [m_bldProcBarCodeTextField release];
    [m_assignedBloodNoLabel release];
    [m_tableView release];
    [m_activityIndicatorView release];
    
    [m_chkmal release];
    [m_numOfBlood release];
    [m_numOfBloodBag release];
    [super dealloc];
}
@end
