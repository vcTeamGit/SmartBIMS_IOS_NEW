//
//  SBBloodnoInfoVO.m
//  Smart BIMS
//
//  Created by  on 11. 8. 8..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBBloodnoInfoVO.h"

@implementation SBBloodnoInfoVO

@synthesize bloodno;

@synthesize jumin1;
@synthesize jumin2;
@synthesize registeryn;
@synthesize marrmstyn;
@synthesize sideeffectsyn;
// 2022.09.22 ADD HMWOO 지정헌혈 여부 확인 추가
@synthesize assignyn;
@synthesize name;
@synthesize bloodcnt;
@synthesize gbmal;
@synthesize gbmal_color;
@synthesize sex;
@synthesize weight;
@synthesize height;
@synthesize bldproccode;
@synthesize bldprocinterface;
@synthesize bldprocname;
@synthesize bldprocNames;
@synthesize bagqty;
@synthesize bldabocode;
@synthesize aboname;
@synthesize sub;
@synthesize abs;
@synthesize hct_result;
@synthesize pccnt;
@synthesize abobarcode;
@synthesize malbarcode;
@synthesize bloodtype;

@synthesize isOnBSD;

@synthesize m_selectedBldProc1;
@synthesize m_selectedBldProc2;
@synthesize m_selectedBldProc3;

@synthesize m_bagInterface;

@synthesize m_barcodeBldBagCode;


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
    [bloodno release];
    [jumin1 release];
    [jumin2 release];
    [registeryn release];
    [marrmstyn release];
    [sideeffectsyn release];
    // 2022.09.22 ADD HMWOO 지정헌혈 여부 확인 추가
    [assignyn release];
    [name release];
    [gbmal release];
    [gbmal_color release];
    [sex release];
    [weight release];
    [height release];
    [bldproccode release];
    [bldprocinterface release];
    [bldprocname release];
    [bldprocNames release];
    [bagqty release];
    [bldabocode release];
    [aboname release];
    [sub release];
    [abs release];
    [hct_result release];
    [pccnt release];
    [abobarcode release];
    [malbarcode release];
    [bloodtype release];
    
    [m_selectedBldProc1 release];
    [m_selectedBldProc2 release];
    [m_selectedBldProc3 release];
    
    [m_bagInterface release];
    
    [m_barcodeBldBagCode release];
    
    [super dealloc];
}

@end
