#import "SBServerURLContent.h"

@implementation SBServerURLContent

NSString const *BLOOD_SERVER = @"mbims.bloodinfo.net:59999/mbims";

#define DEV 0
#define PROD 1

// 개발 DB 접근 시 TARGET을 DEV로 설정
// 상용 DB 접근 시 TARGET을 PROD로 설정
// DEV : 개발, PROD : 상용
#define TARGET DEV

#if TARGET==PROD
    NSString const *SERVER_TARGET = @"/testservice";
#else
    NSString const *SERVER_TARGET = @"/appservice";
#endif

@end
