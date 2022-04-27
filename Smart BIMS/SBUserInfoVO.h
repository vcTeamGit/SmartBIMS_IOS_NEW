//
//  SBUserInfoVO.h
//  Smart BIMS
//
//  Created by  on 11. 8. 5..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBUserInfoVO : NSObject
{
    NSString* szBimsId;
    NSString* szBimsName;
    NSString* szBimsPwd;
    NSString* szBimsPgLimit;
    NSString* szBimsOrgcode;
    NSString* szBimsOrgname;
    NSString* szBimsDeptcode;
    NSString* szBimsDeptName;
    NSString* szBimsSitecode;
    NSString* szBimsSitename;
    NSString* szBimsCarcode;
    NSString* szBimsCarname;
    NSString* szBimsDeptorders;
}

@property (nonatomic, retain) NSString* szBimsId;
@property (nonatomic, retain) NSString* szBimsName;
@property (nonatomic, retain) NSString* szBimsPwd;
@property (nonatomic, retain) NSString* szBimsPgLimt;
@property (nonatomic, retain) NSString* szBimsOrgcode;
@property (nonatomic, retain) NSString* szBimsOrgname;
@property (nonatomic, retain) NSString* szBimsDeptcode;
@property (nonatomic, retain) NSString* szBimsDeptname;
@property (nonatomic, retain) NSString* szBimsSitecode;
@property (nonatomic, retain) NSString* szBimsSitename;
@property (nonatomic, retain) NSString* szBimsCarcode;
@property (nonatomic, retain) NSString* szBimsCarname;
@property (nonatomic, retain) NSString* szBimsDeptorders;

- (id)initWithSBUserInfo:(SBUserInfoVO*)userInfo;

@end
