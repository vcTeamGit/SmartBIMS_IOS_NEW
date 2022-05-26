/**
 * 프로젝트 내 수거자 등록시 혈액 인계 정보를
 * 호출할 수 있도록 대응
 *
 * @author HMWOO
 * @version 1.0
 */

#import <Foundation/Foundation.h>

@interface SBTakeOverInfoVO : NSObject
{
    NSString* bloodcnt;         // 혈액 갯수
    NSString* bloodcnt2;        // 혈액백 갯수
    NSString* bloodsamplecnt;   // 헌혈검체 갯수
    NSString* etcsamplecnt;     // 기타검체 갯수
    NSString* icepackcnt;       // 아이스팩 갯수
    NSString* coolantcnt;       // PCM냉매제 갯수
    NSString* bloodboxcnt;      // 혈액박스 갯수
    NSString* hrgsamplecnt2;    // 안전성의뢰 건수
    NSString* hrgsamplecnt;     // 안전성의뢰 갯수
    NSString* assignedcnt;      // 지정헌혈 갯수
    NSString* marsamplecnt;     // 조혈모세포 갯수
    NSString* spcsamplecnt2;    // 특검 건수
    NSString* spcsamplecnt;     // 특검 갯수
    NSString* gbmal1cnt;          // 말라리아 갯수(전혈)
    NSString* gbmal2cnt;          // 말라리아 갯수(혈장)
    NSString* takername;        // 수거자 명
}

@property (nonatomic, retain) NSString* bloodcnt;
@property (nonatomic, retain) NSString* bloodcnt2;
@property (nonatomic, retain) NSString* bloodsamplecnt;
@property (nonatomic, retain) NSString* etcsamplecnt;
@property (nonatomic, retain) NSString* icepackcnt;
@property (nonatomic, retain) NSString* coolantcnt;
@property (nonatomic, retain) NSString* bloodboxcnt;
@property (nonatomic, retain) NSString* hrgsamplecnt2;
@property (nonatomic, retain) NSString* hrgsamplecnt;
@property (nonatomic, retain) NSString* assignedcnt;
@property (nonatomic, retain) NSString* marsamplecnt;
@property (nonatomic, retain) NSString* spcsamplecnt2;
@property (nonatomic, retain) NSString* spcsamplecnt;
@property (nonatomic, retain) NSString* gbmal1cnt;
@property (nonatomic, retain) NSString* gbmal2cnt;
@property (nonatomic, retain) NSString* takername;

@end

