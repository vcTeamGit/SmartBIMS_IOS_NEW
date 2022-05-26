/**
 * 프로젝트 내 수거자 등록시 혈액 인계 정보를
 * 호출할 수 있도록 대응
 *
 * @author HMWOO
 * @version 1.0
 */

#import "SBTakeOverInfoVO.h"

@implementation SBTakeOverInfoVO

@synthesize bloodcnt;
@synthesize bloodcnt2;
@synthesize bloodsamplecnt;
@synthesize etcsamplecnt;
@synthesize icepackcnt;
@synthesize coolantcnt;
@synthesize bloodboxcnt;
@synthesize hrgsamplecnt2;
@synthesize hrgsamplecnt;
@synthesize assignedcnt;
@synthesize marsamplecnt;
@synthesize spcsamplecnt2;
@synthesize spcsamplecnt;
@synthesize gbmal1cnt;
@synthesize gbmal2cnt;
@synthesize takername;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [bloodcnt release];
    [bloodcnt2 release];
    [bloodsamplecnt release];
    [etcsamplecnt release];
    [icepackcnt release];
    [coolantcnt release];
    [bloodboxcnt release];
    [hrgsamplecnt release];
    [hrgsamplecnt2 release];
    [assignedcnt release];
    [marsamplecnt release];
    [spcsamplecnt release];
    [spcsamplecnt2 release];
    [gbmal1cnt release];
    [gbmal2cnt release];
    
    [super dealloc];
}

@end


