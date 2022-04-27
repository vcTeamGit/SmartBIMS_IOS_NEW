//
//  SBUserInfoVO.m
//  Smart BIMS
//
//  Created by  on 11. 8. 5..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "SBUserInfoVO.h"

@implementation SBUserInfoVO

@synthesize szBimsId;
@synthesize szBimsName;
@synthesize szBimsPwd;
@synthesize szBimsPgLimt;
@synthesize szBimsOrgcode;

@synthesize szBimsOrgname;
@synthesize szBimsDeptcode;
@synthesize szBimsDeptname;
@synthesize szBimsSitecode;
@synthesize szBimsSitename;

@synthesize szBimsCarcode;
@synthesize szBimsCarname;
@synthesize szBimsDeptorders;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithSBUserInfo:(SBUserInfoVO*)userInfo
{
    self = [super init];
    
    if(self){
        self.szBimsId = userInfo.szBimsId;
        self.szBimsName = userInfo.szBimsName;
        self.szBimsPwd = userInfo.szBimsPwd;
        self.szBimsPgLimt = userInfo.szBimsPgLimt;
        self.szBimsOrgcode = userInfo.szBimsOrgcode;
        
        self.szBimsOrgname = userInfo.szBimsOrgname;
        self.szBimsDeptcode = userInfo.szBimsDeptcode;
        self.szBimsDeptname = userInfo.szBimsDeptname;
        self.szBimsSitecode = userInfo.szBimsSitecode;
        self.szBimsSitename = userInfo.szBimsSitename;
        
        self.szBimsCarcode = userInfo.szBimsCarcode;
        self.szBimsCarname = userInfo.szBimsCarname;
        self.szBimsDeptorders = userInfo.szBimsDeptorders;
    }
    
    return self;
}

- (void)dealloc
{    
    [szBimsId release];
    [szBimsName release];
    [szBimsPwd release];
    [szBimsPgLimt release];
    [szBimsOrgcode release];
    [szBimsOrgname release];
    [szBimsDeptcode release];
    [szBimsDeptname release];
    [szBimsSitecode release];
    [szBimsSitename release];
    [szBimsCarcode release];
    [szBimsCarname release];
    [szBimsDeptorders release];
    
    [super dealloc];
}

@end
