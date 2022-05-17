//
//  SBUtils.h
//  Smart BIMS
//
//  Created by  on 11. 8. 25..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioToolbox/AudioToolbox.h"

//#define WIRELINE_AUTO_LOGIN_MODE    1
//#define APNS_TEST_MODE              1

#define kProgramVersionInfo @"1.3.2"    // 실제 사용하는 값은 아니다.

#define kVIEW_HEIGHT    548
#define kVIEW_WIDTH     320
#define kWINDOW_HEIGHT  568
#define kREQUEST_TIMEOUT_TYPE   @"RTO"
#define kREQUEST_TIMEOUT_MSG    @"요청한 시간이 초과되었습니다.\n신호가 약하거나 VPN이 꺼져 있습니다."
#define kNO_RES_RECEIVE_TYPE    @"NRT"
#define kNO_RES_RECEIVE_MSG     @"정상적인 응답을 받지 못하였습니다.\n다시 시도해 주세요."

enum SOUNDTYPE{
    SOUND_ALERT_0 = 0,
    SOUND_ALERT_1 = 1,
    SOUND_IS_RECORDED = 50,
    SOUND_IS_INDIVISUAL = 60,
    SOUND_IS_HOLDING = 61,
    SOUND_FIRST_DONOR = 62,
    SOUND_APPEARED = 90
};

// 2022.05.13 ADD HMWOO 제조사 코드 관리 추가
typedef enum
{
    AMICUS,
    MCS_PLUS,
    TRIMA,
    
    VENDER_COUNT
} VENDERCODE;


@interface SBUtils : NSObject
{
    CFURLRef        beef01SoundFileURLRef;
    SystemSoundID   beef01SoundFileObject;
    CFURLRef        beef02SoundFileURLRef;
    SystemSoundID   beef02SoundFileObject;
    CFURLRef        inTheDreamSoundFileURLRef;
    SystemSoundID   inTheDreamSoundFileObject;
    CFURLRef        misterySoundFileURLRef;
    SystemSoundID   misterySoundFileObject;
    CFURLRef        appearedSoundFileURLRef;
    SystemSoundID   appearedSoundFileObject;
    CFURLRef        firstDonorSoundFileURLRef;
    SystemSoundID   firstDonorSoundFileObject;
}

@property (readwrite)   CFURLRef        beef01SoundFileURLRef;
@property (readonly)    SystemSoundID   beef01SoundFileObject;
@property (readwrite)   CFURLRef        beef02SoundFileURLRef;
@property (readonly)    SystemSoundID   beef02SoundFileObject;
@property (readwrite)   CFURLRef        inTheDreamSoundFileURLRef;
@property (readonly)    SystemSoundID   inTheDreamSoundFileObject;
@property (readwrite)   CFURLRef        misterySoundFileURLRef;
@property (readonly)    SystemSoundID   misterySoundFileObject;
@property (readwrite)   CFURLRef        appearedSoundFileURLRef;
@property (readonly)    SystemSoundID   appearedSoundFileObject;
@property (readwrite)   CFURLRef        firstDonorSoundFileURLRef;
@property (readonly)    SystemSoundID   firstDonorSoundFileObject;

extern NSString *const VenderCodeName[VENDER_COUNT];

- (void)playBeef01AlertSound;
- (void)playBeef02AlertSound;
- (void)playInTheDreamAlertSound;
- (void)playMisteryAlertSound;
- (void)playFirstDonorSound;

- (void)playAppearedSystemSound;

+ (void)vibrate;


+ (NSString*)formatBloodNo:(NSString*)bloodNo;
+ (NSString*)getABOTypeName:(NSString*)ABOTypeCode;
+ (UIColor*)getABOTypeRGBValue:(NSString*)ABOTypeCode;
+ (UIColor*)getABOTypeBgRGBValue:(NSString*)ABOTypeCode;

+ (NSString*)getMalariaStatusName:(NSString*)gbmal;
+ (UIColor*)getMalariaStatusColor:(NSString*)gbmal_color;

+ (NSString*)getBagInterface:(NSString*)value;

+ (NSString*)getParameterTypeBloodNo:(NSString*)bloodNo;

+ (NSString*)getDateFormatWithString:(NSString*)strDate;

+ (void)playAlertSystemSoundWithSoundType:(int)nSoundType;

+ (BOOL)isDigit:(NSString*)str;

// 특정일(tdate)와 오늘 날짜 비교
+ (NSInteger)compareDateWithToday:(NSDate*)tdate;

+ (NSInteger)compareDateByStringWithToday:(NSDate*)tdate;

// 2022.05.13 ADD HMWOO UDI 제조사 별 로트 정보 유효성 검사 추가
+ (BOOL) checkVenderLOT:(NSString *)vcode;

// 2022.05.17 ADD HMWOO 로딩 인디케이터 추가
+ (void) showLoading;

// 2022.05.17 ADD HMWOO 로딩 인디케이터 추가
+ (void) hideLoading;

@end
