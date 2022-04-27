//
//  SBDonorFitnessInfoVO.h
//  Smart BIMS
//
//  Created by  on 11. 9. 2..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBDonorFitnessInfoVO : NSObject
{
    NSString* strCheckDigit;
    NSString* strName;
    NSString* strABOCode;
    NSString* strSUB;
    NSString* strABS;
    
    NSString* strRecentBloodDate;
    NSString* strRecentBldProcName;
    NSString* strPastOneTotalCnt;
    NSString* strPastOneWBCnt;
    NSString* strPastOnePlapCnt;
    
    NSString* strPastOneLrsdpSdpCnt;
    NSString* strPastOnePltpCnt;
    
    NSString* strPastOne2PltCnt;
    NSString* strPastOne2RbcCnt;
    NSString* strPastOneEtcCnt;
    NSString* strBloodCnt;
    NSString* strGbMalResult;
    
    NSString* strRegister;
    NSString* strInvalidText;
    NSString* strPreviousCheckLog;
    NSString* strUnfitnessValue;
    NSString* strErrValue;
    
    NSString* strSpecValue;
    NSString* strStatusValue;
    
    NSString* strFitnessResult;
}

@property (nonatomic, retain) NSString* strCheckDigit;
@property (nonatomic, retain) NSString* strName;
@property (nonatomic, retain) NSString* strABOCode;
@property (nonatomic, retain) NSString* strSUB;
@property (nonatomic, retain) NSString* strABS;

@property (nonatomic, retain) NSString* strRecentBloodDate;
@property (nonatomic, retain) NSString* strRecentBldProcName;
@property (nonatomic, retain) NSString* strPastOneTotalCnt;
@property (nonatomic, retain) NSString* strPastOneWBCnt;
@property (nonatomic, retain) NSString* strPastOnePlapCnt;

@property (nonatomic, retain) NSString* strPastOneLrsdpSdpCnt;
@property (nonatomic, retain) NSString* strPastOnePltpCnt;

@property (nonatomic, retain) NSString* strPastOne2PltCnt;
@property (nonatomic, retain) NSString* strPastOne2RbcCnt;
@property (nonatomic, retain) NSString* strPastOneEtcCnt;
@property (nonatomic, retain) NSString* strBloodCnt;
@property (nonatomic, retain) NSString* strGbMalResult;

@property (nonatomic, retain) NSString* strRegister;
@property (nonatomic, retain) NSString* strInvalidText;
@property (nonatomic, retain) NSString* strPreviousCheckLog;
@property (nonatomic, retain) NSString* strUnfitnessValue;
@property (nonatomic, retain) NSString* strErrValue;

@property (nonatomic, retain) NSString* strSpecValue;
@property (nonatomic, retain) NSString* strStatusValue;

@property (nonatomic, retain) NSString* strFitnessResult;

@end
