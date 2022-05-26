//
//  SBUtils.m
//  Smart BIMS
//
//  Created by  on 11. 8. 25..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBUtils.h"

@implementation SBUtils

@synthesize beef01SoundFileURLRef;
@synthesize beef01SoundFileObject;
@synthesize beef02SoundFileURLRef;
@synthesize beef02SoundFileObject;
@synthesize inTheDreamSoundFileURLRef;
@synthesize inTheDreamSoundFileObject;
@synthesize misterySoundFileURLRef;
@synthesize misterySoundFileObject;
@synthesize firstDonorSoundFileURLRef;
@synthesize firstDonorSoundFileObject;
@synthesize appearedSoundFileURLRef;
@synthesize appearedSoundFileObject;

NSString *const VenderCodeName[VENDER_COUNT] = {
    [AMICUS] = @"6000",
    [MCS_PLUS] = @"2747",
    [TRIMA] = @"9999"
};

+ (NSString*)formatBloodNo:(NSString*)bloodNo
{
    NSString* strRetVal;
    NSString* strBloodNo = [[NSString alloc] initWithString:bloodNo];
    
    strBloodNo = [strBloodNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    strBloodNo = [strBloodNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSRange range1 = NSMakeRange(0, 2);
    NSRange range2 = NSMakeRange(2, 2);
    NSRange range3 = NSMakeRange(4, 6);
    
    if(strBloodNo.length == 0){
        strRetVal = nil;
    }else if(strBloodNo.length < 12){
        strRetVal = nil;
    }else{
        NSString* strBloodNo1 = [strBloodNo substringWithRange:range1];
        NSString* strBloodNo2 = [strBloodNo substringWithRange:range2];
        NSString* strBloodNo3 = [strBloodNo substringWithRange:range3];
        
        strRetVal = [NSString stringWithFormat:@"%@-%@-%@", strBloodNo1, strBloodNo2, strBloodNo3];
    }
    
    [strBloodNo release];
    
    return strRetVal;
}


// 혈액형정보를 코드값이 아닌 텍스트로 반환.
+ (NSString*)getABOTypeName:(NSString*)ABOTypeCode
{
    NSString* strABOTypeCode = ABOTypeCode;
    
    if([strABOTypeCode isEqualToString:@"51"] || [strABOTypeCode isEqualToString:@"1"]){
        return @"O(+)";
    }else if([strABOTypeCode isEqualToString:@"62"] || [strABOTypeCode isEqualToString:@"2"]){
        return @"A(+)";
    }else if([strABOTypeCode isEqualToString:@"73"] || [strABOTypeCode isEqualToString:@"3"]){
        return @"B(+)";
    }else if([strABOTypeCode isEqualToString:@"84"] || [strABOTypeCode isEqualToString:@"4"]){
        return @"AB(+)";
    }else if([strABOTypeCode isEqualToString:@"95"] || [strABOTypeCode isEqualToString:@"5"]){
        return @"O(-)";
    }else if([strABOTypeCode isEqualToString:@"06"] || [strABOTypeCode isEqualToString:@"6"]){
        return @"A(-)";
    }else if([strABOTypeCode isEqualToString:@"17"] || [strABOTypeCode isEqualToString:@"7"]){
        return @"B(-)";
    }else if([strABOTypeCode isEqualToString:@"28"] || [strABOTypeCode isEqualToString:@"8"]){
        return @"AB(-)";
    }
    
    return nil;
}


// 혈액형정보를 보여주는 라벨의 폰트색을 반환.
+ (UIColor*)getABOTypeRGBValue:(NSString*)ABOTypeCode
{
    NSString* strABOTypeCode = ABOTypeCode;
    UIColor* color;
    
    if([strABOTypeCode isEqualToString:@"51"] || [strABOTypeCode isEqualToString:@"95"]
       || [strABOTypeCode isEqualToString:@"1"] || [strABOTypeCode isEqualToString:@"5"]){
        color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    }else if([strABOTypeCode isEqualToString:@"62"] || [strABOTypeCode isEqualToString:@"06"]
             || [strABOTypeCode isEqualToString:@"2"] || [strABOTypeCode isEqualToString:@"6"]){
        color = [UIColor colorWithRed:0.6 green:0.6 blue:0 alpha:1];
    }else if([strABOTypeCode isEqualToString:@"73"] || [strABOTypeCode isEqualToString:@"17"]
             || [strABOTypeCode isEqualToString:@"3"] || [strABOTypeCode isEqualToString:@"7"]){
        color = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }else if([strABOTypeCode isEqualToString:@"84"] || [strABOTypeCode isEqualToString:@"28"]
             || [strABOTypeCode isEqualToString:@"4"] || [strABOTypeCode isEqualToString:@"8"]){
        color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }else{
        color = nil;
    }
    
    return color;
}


// 혈액형정보를 보여주는 라벨의 배경색을 반환.
+ (UIColor*)getABOTypeBgRGBValue:(NSString*)ABOTypeCode
{
    NSString* strABOTypeCode = ABOTypeCode;
    UIColor* color;
    
    if([strABOTypeCode isEqualToString:@"62"] || [strABOTypeCode isEqualToString:@"06"] 
       || [strABOTypeCode isEqualToString:@"2"] || [strABOTypeCode isEqualToString:@"6"]){
        color = [UIColor colorWithRed:1.6 green:1.6 blue:1 alpha:1];
    }else{
        color = nil;
    }
    
    return color;
}


+ (NSString*)getMalariaStatusName:(NSString*)gbmal
{
    NSString* strMalariaStatus = gbmal;
    
    // 2013.05.30 변경(기존 0: 정상, 1: 위험, 2: 고위험, 3: 잠재)
    if([strMalariaStatus isEqualToString:@"0"]){
        return @"정상";
    }else if([strMalariaStatus isEqualToString:@"1"]){
        return @"제한";
    }else if([strMalariaStatus isEqualToString:@"2"]){
        return @"고위험";
    }else if([strMalariaStatus isEqualToString:@"3"]){
        return @"가능";
    }else{
        return nil;
    }
}


+ (UIColor*)getMalariaStatusColor:(NSString*)gbmal_color
{
    NSString* strMalariaStatusColor = gbmal_color;
    UIColor* color;
    
//    if([strMalariaStatusColor isEqualToString:@"0"]){
//        color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
//    }else if([strMalariaStatusColor isEqualToString:@"1"]){
//        color = [UIColor colorWithRed:1.0 green:1.5 blue:0.0 alpha:1.0];
//    }else if([strMalariaStatusColor isEqualToString:@"2"]){
//        color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
//    }else if([strMalariaStatusColor isEqualToString:@"3"]){
//        color = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
//    }else{
//        color = nil;
//    }
    
    if([strMalariaStatusColor isEqualToString:@"#333333"]){
        color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    }else if([strMalariaStatusColor isEqualToString:@"#FF9900"]){
        color = [UIColor colorWithRed:1.0 green:1.5 blue:0.0 alpha:1.0];
    }else if([strMalariaStatusColor isEqualToString:@"#FF0000"]){
        color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }else if([strMalariaStatusColor isEqualToString:@"#0000FF"]){
        color = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    }else{
        color = [UIColor blackColor];
    }
    
    return color;
}


/**
 * Display 로직에 사용되는 bldProcValue를 매개변수로 받아 실제 DB에 사용될 bldProcValue를 반환한다.
 */
+ (NSString*)getBagInterface:(NSString*)value
{
    NSString* strTempValue = [NSString stringWithString:value];
    
    if([strTempValue isEqualToString:@"1,0"]){
        return @"1";
    }else if([strTempValue isEqualToString:@"2,0"]){
        return @"2";
    }else if([strTempValue isEqualToString:@"3,0"]){
        return @"3";
    }else if([strTempValue isEqualToString:@"4,0"]){
        return @"4";
    }else if([strTempValue isEqualToString:@"1,1"]){
        return @"1";
    }else if([strTempValue isEqualToString:@"1,2"]){
        return @"2";
    }else if([strTempValue isEqualToString:@"1,3"]){
        return @"3";
    }else if([strTempValue isEqualToString:@"1,4"]){
        return @"4";
    }else if([strTempValue isEqualToString:@"1,5"]){
        return @"5";
    }else if([strTempValue isEqualToString:@"1,6"]){
        return @"6";
    }else if([strTempValue isEqualToString:@"1,7"]){
        return @"7";
    }else if([strTempValue isEqualToString:@"1,8"]){
        return @"8";
    }else if([strTempValue isEqualToString:@"2,5"]){
        return @"5";
    }else if([strTempValue isEqualToString:@"2,6"]){
        return @"6";
    }else if([strTempValue isEqualToString:@"2,7"]){
        return @"7";
    }else if([strTempValue isEqualToString:@"2,9"]){
        return @"9";
    }else{
        return @"0";
    }
}


+ (NSString*)getParameterTypeBloodNo:(NSString*)bloodNo
{
    NSMutableString* strBloodNo = [NSMutableString stringWithCapacity:16];
    
    [strBloodNo setString:bloodNo];
    
    NSRange range = NSMakeRange(0, 10);
    [strBloodNo setString:[strBloodNo stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    [strBloodNo setString:[strBloodNo substringWithRange:range]];
    
    return (NSString*)strBloodNo;
}


+ (NSString*)getDateFormatWithString:(NSString*)strDate
{
    NSRange rangeYear = NSMakeRange(0, 4);
    NSRange rangeMonth = NSMakeRange(4, 2);
    NSRange rangeDay = NSMakeRange(6, 2);
    
    return [NSString stringWithFormat:@"%@-%@-%@", [strDate substringWithRange:rangeYear],
            [strDate substringWithRange:rangeMonth],
            [strDate substringWithRange:rangeDay]];
}



#pragma marks -
#pragma AudioSound 
// Respond to a tap on the System Sound button.
- (void)playBeef01AlertSound{
    AudioServicesPlayAlertSound(beef01SoundFileObject);
}

- (void)playBeef02AlertSound
{
    AudioServicesPlayAlertSound(beef02SoundFileObject);
}


- (void)playInTheDreamAlertSound{
    AudioServicesPlayAlertSound(inTheDreamSoundFileObject);
}


- (void)playMisteryAlertSound{
    AudioServicesPlayAlertSound(misterySoundFileObject);
}

- (void)playFirstDonorSound{
    AudioServicesPlayAlertSound(firstDonorSoundFileObject);
}


// Respond to a tap on the Alert Sound button.
- (void)playSystemSound{
    AudioServicesPlaySystemSound(beef02SoundFileObject);
}

- (void)playAppearedSystemSound
{
    AudioServicesPlaySystemSound(appearedSoundFileObject);
}


// Respond to a tap on the Vibrate button. In the Simulator and on devices with no 
//    vibration element, this method does nothing.
+ (void) vibrate{
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}


+ (void)playAlertSystemSoundWithSoundType:(int)nSoundType
{
    SBUtils* SBUtilsForSound = [[SBUtils alloc] init];
    
    if(nSoundType == SOUND_ALERT_0){
        [SBUtilsForSound playBeef01AlertSound];
    }else if(nSoundType == SOUND_ALERT_1){
        [SBUtilsForSound playBeef02AlertSound];
    }else if(nSoundType == SOUND_IS_RECORDED){
        [SBUtilsForSound playBeef02AlertSound];
    }else if(nSoundType == SOUND_IS_INDIVISUAL){
        [SBUtilsForSound playInTheDreamAlertSound];
    }else if(nSoundType == SOUND_IS_HOLDING){
        [SBUtilsForSound playMisteryAlertSound];
    }else if(nSoundType == SOUND_FIRST_DONOR){
        [SBUtilsForSound playFirstDonorSound];
    }else if(nSoundType == SOUND_APPEARED){
        [SBUtilsForSound playAppearedSystemSound];
    }
    
    [SBUtilsForSound release];
}


+ (BOOL)isDigit:(NSString*)str
{
    NSString *ptn = @"^[0-9]*$";
    
    NSRange range = [str rangeOfString:ptn options:NSRegularExpressionSearch];
//    NSRange range1 = [str1 rangeOfString:ptn options:NSRegularExpressionSearch];
    
    if(range.length == 0){
        return NO;
    }else{
        return YES;
    }
}

// 특정일과 오늘 날짜 비교: 날짜 단위로 특정일이 과거면 음수, 특정일이 오늘이면 0, 특정일이 미래면 양수 반환
// param이 NSDate인 경우
+ (NSInteger)compareDateWithToday:(NSDate*)tdate
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *targetDate = [df dateFromString:[df stringFromDate:tdate]];
    NSInteger result = (int)[targetDate timeIntervalSinceNow] / (60*60*24);
    
    return result;
}

// 특정일과 오늘 날짜 비교: 날짜 단위로 특정일이 과거면 음수, 특정일이 오늘이면 0, 특정일이 미래면 양수 반환
+ (NSInteger)compareDateByStringWithToday:(NSString*)tdate
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *targetDate = [df dateFromString:tdate];
    NSInteger result = (int)[targetDate timeIntervalSinceNow] / (60*60*24);
    
    return result;
}





- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beeps_03"
//                                                    withExtension: @"m4a"];
        
        NSURL *beef01Sound   = [[NSBundle mainBundle] URLForResource: @"beef01"
                                                       withExtension: @"mp3"];
        NSURL *beef02Sound   = [[NSBundle mainBundle] URLForResource: @"beef02"
                                                       withExtension: @"mp3"];
        NSURL* inTheDreamSound = [[NSBundle mainBundle] URLForResource:@"in_the_dream"
                                                         withExtension:@"wav"];
        NSURL* misterySound = [[NSBundle mainBundle] URLForResource:@"mistery"
                                                      withExtension:@"wav"];
        NSURL* appearedSound = [[NSBundle mainBundle] URLForResource:@"mistery_appeared"
                                                       withExtension:@"wav"];
        NSURL* firstDonorSound = [[NSBundle mainBundle] URLForResource:@"SFX_02"
                                                       withExtension:@"mp3"];
        
        // Store the URL as a CFURLRef instance
        self.beef01SoundFileURLRef = (CFURLRef)[beef01Sound retain];
        self.beef02SoundFileURLRef = (CFURLRef)[beef02Sound retain];
        self.inTheDreamSoundFileURLRef = (CFURLRef)[inTheDreamSound retain];
        self.misterySoundFileURLRef = (CFURLRef)[misterySound retain];
        self.appearedSoundFileURLRef = (CFURLRef)[appearedSound retain];
        self.firstDonorSoundFileURLRef = (CFURLRef)[firstDonorSound retain];
        
        // Create a system sound object representing the sound file.
        AudioServicesCreateSystemSoundID (beef01SoundFileURLRef, &beef01SoundFileObject);
        AudioServicesCreateSystemSoundID (beef02SoundFileURLRef, &beef02SoundFileObject);
        AudioServicesCreateSystemSoundID(inTheDreamSoundFileURLRef, &inTheDreamSoundFileObject);
        AudioServicesCreateSystemSoundID(misterySoundFileURLRef, &misterySoundFileObject);
        AudioServicesCreateSystemSoundID(appearedSoundFileURLRef, &appearedSoundFileObject);
        AudioServicesCreateSystemSoundID(firstDonorSoundFileURLRef, &firstDonorSoundFileObject);
    }
    
    return self;
}

// 2022.05.13 ADD HMWOO UDI 제조사 별 로트 정보 유효성 검사 추가
+ (BOOL) checkVenderLOT:(NSString *)vcode
{
    if([vcode isEqualToString:VenderCodeName[AMICUS]])
    {
        // 알파벳(2), 숫자(2), 알파벳(1), 숫자(5)
    }
    else if([vcode isEqualToString:VenderCodeName[MCS_PLUS]])
    {
        // 숫자(7)
    }
    else if([vcode isEqualToString:VenderCodeName[TRIMA]])
    {
        // 숫자(10)
    }
    
    return false;
}

// 2022.05.17 ADD HMWOO 로딩 인디케이터 추가
+ (void) showLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIWindow *window = UIApplication.sharedApplication.windows.lastObject;
        
        if(window == nil)
        {
            return;
        }
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        
        if([window.subviews.firstObject isKindOfClass:[UIActivityIndicatorView class]])
        {
            activityIndicator = window.subviews.firstObject;
        }
        else
        {
            activityIndicator = [UIActivityIndicatorView new];
            if (@available(iOS 13.0, *)) {
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
            } else {
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            }
            activityIndicator.frame = window.frame;
            activityIndicator.color = UIColor.grayColor;
            
            [window addSubview:activityIndicator];
        }
        
        [activityIndicator startAnimating];
    });
}

// 2022.05.17 ADD HMWOO 로딩 인디케이터 추가
+ (void) hideLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSArray *array = UIApplication.sharedApplication.windows;
        
        for(int i = 0; i < [array count]; i++)
        {
            UIWindow *window = UIApplication.sharedApplication.windows[i];
            
            if(window == nil)
            {
                return;
            }
            
            for (UIView *v in window.subviews)
            {
                if([v isKindOfClass:[UIActivityIndicatorView class]])
                {
                    [v removeFromSuperview];
                }
            }
        }
    });
}

@end
