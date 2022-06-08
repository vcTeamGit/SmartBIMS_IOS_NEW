/**
 * 프로젝트 내 URL을 개발 및 검수 용으로
 * 호출할 수 있도록 대응 (Swift 에서 호출하는 URL)
 *
 * @author HMWOO
 * @version 1.0
 */

#import "SBServerURLContent.h"

@implementation SBServerURLContent

NSString const *BLOOD_SERVER = @"mbims.bloodinfo.net:59999/mbims";

#define DEV 0
#define PROD 1

// 개발 DB 접근 시 TARGET을 DEV로 설정
// 상용 DB 접근 시 TARGET을 PROD로 설정
// DEV : 개발, PROD : 상용
#define TARGET DEV

#if TARGET==DEV
    NSString const *SERVER_TARGET = @"/testservice";
    NSString const *URL_MANAGE_TAKEOVER_BLOOD = @"http://mbims.bloodinfo.net:59999/mbims/testservice/Swift_SBTakeOverBloodRegister3.jsp";
    NSString const *URL_GET_TAKEOVER_BLOOD_INFO = @"http://mbims.bloodinfo.net:59999/mbims/testservice/Swift_SBTakeOverChangeBloodLevelInfo.jsp";
#else
    NSString const *SERVER_TARGET = @"/appservice";
    NSString const *URL_MANAGE_TAKEOVER_BLOOD = @"http://mbims.bloodinfo.net:59999/mbims/appservice/Swift_SBTakeOverBloodRegister3.jsp";
    NSString const *URL_GET_TAKEOVER_BLOOD_INFO = @"http://mbims.bloodinfo.net:59999/mbims/appservice/Swift_SBTakeOverChangeBloodLevelInfo.jsp";
#endif

@end
