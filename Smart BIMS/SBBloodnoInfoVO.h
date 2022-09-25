//
//  SBBloodnoInfoVO.h
//  Smart BIMS
//
//  Created by  on 11. 8. 8..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBBloodnoInfoVO : NSObject
{
    NSString* bloodno;
    
    NSString* jumin1;   // 
    NSString* jumin2;
    NSString* registeryn;   // 등록헌혈자여부 (Y/N)
    NSString* marrmstyn;    // 골수기증자여부 (Y/N)
    NSString* sideeffectsyn;    // 헌혈관련증상여부 (Y/N)
    // 2022.09.22 ADD HMWOO 지정헌혈 여부 확인 추가
    NSString* assignyn;     // 지정헌혈여부 (Y/N)
    NSString* name;
    NSString* bloodcnt;
    NSString* gbmal;        // 0:정상, 1:제한, 2:고위험, 3:가능
    NSString* gbmal_color;  // 0:#333333, 1:#ff9900, 2:#ff0000, 3:#0000ff
    NSString* sex;          // 성별 (남/여)
    NSString* weight;
    NSString* height;
    NSString* bldproccode;
    NSString* bldprocinterface;
    NSString* bldprocname;
    NSString* bldprocNames;
    NSString* bagqty;
    NSString* bldabocode;
    NSString* aboname;
    NSString* sub;
    NSString* abs;
    NSString* hct_result;   // 헤마토크릿(%): lab_resultcbc의 HCT
    NSString* pccnt;        // 혈소판 수 (*1000)
    NSString* abobarcode;   // 혈액형 바코드 
    NSString* malbarcode;   // 말라리아바코드
    NSString* bloodtype;    // 헌혈타입(1:전혈, 2:혈장, 3:혈소판, 4:다종성분, 5:없음)
    
    BOOL isOnBSD;
    
    NSString* m_selectedBldProc1;
    NSString* m_selectedBldProc2;
    NSString* m_selectedBldProc3;
    NSString* m_bagInterface;
    
//    NSString* m_selectedBagQty;
    NSString* m_barcodeBldBagCode;
}

@property (nonatomic, retain) NSString* bloodno;

@property (nonatomic, retain) NSString* jumin1;
@property (nonatomic, retain) NSString* jumin2;
@property (nonatomic, retain) NSString* registeryn;
@property (nonatomic, retain) NSString* marrmstyn;
@property (nonatomic, retain) NSString* sideeffectsyn;
// 2022.09.22 ADD HMWOO 지정헌혈 여부 확인 추가
@property (nonatomic, retain) NSString* assignyn;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* bloodcnt;
@property (nonatomic, retain) NSString* gbmal;
@property (nonatomic, retain) NSString* gbmal_color;
@property (nonatomic, retain) NSString* sex;
@property (nonatomic, retain) NSString* weight;
@property (nonatomic, retain) NSString* height;
@property (nonatomic, retain) NSString* bldproccode;
@property (nonatomic, retain) NSString* bldprocinterface;
@property (nonatomic, retain) NSString* bldprocname;
@property (nonatomic, retain) NSString* bldprocNames;
@property (nonatomic, retain) NSString* bagqty;
@property (nonatomic, retain) NSString* bldabocode;
@property (nonatomic, retain) NSString* aboname;
@property (nonatomic, retain) NSString* sub;
@property (nonatomic, retain) NSString* abs;
@property (nonatomic, retain) NSString* hct_result;
@property (nonatomic, retain) NSString* pccnt;
@property (nonatomic, retain) NSString* abobarcode;
@property (nonatomic, retain) NSString* malbarcode;
@property (nonatomic, retain) NSString* bloodtype;

@property (nonatomic, assign) BOOL isOnBSD;

@property (nonatomic, retain) NSString* m_selectedBldProc1;
@property (nonatomic, retain) NSString* m_selectedBldProc2;
@property (nonatomic, retain) NSString* m_selectedBldProc3;
@property (nonatomic, retain) NSString* m_bagInterface;

@property (nonatomic, retain) NSString* m_barcodeBldBagCode;

@end
