//
//  TakeOverLevelInfoData.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/08/12.
//

import Foundation

struct TakeOverLevelInfoData: Codable {
    init() {
        self.orgcode = ""
        self.carcode = ""
        self.carname = ""
        self.sitename = ""
        self.spcsamplecnt = ""
        self.spcsamplecnt2 = ""
        self.etcsamplecnt = ""
        self.hrgsamplecnt = ""
        self.hrgsamplecnt2 = ""
        self.enrsamplecnt = ""
        self.hbvsamplecnt = ""
        self.marsamplecnt = ""
        self.rhnsamplecnt = ""
        self.unfitpapercnt = ""
        self.eunfitpapercnt = ""
        self.icepackcnt = ""
        self.coolantcnt = ""
        self.bloodboxcnt = ""
        self.bloodsamplecnt = ""
        self.papercnt = ""
        self.epapercnt = ""
        self.enteridno = ""
        self.takeoverinputidno = ""
        self.getidno = ""
        self.dbcheckid = ""
    }
    
    // MARK: - Basic Info
    var orgcode: String
    //var orgname: String
    var carcode: String
    var carname: String
    var sitename: String
    
    // MARK: - 검체
    /// 특검검체
    var spcsamplecnt: String
    var spcsamplecnt2: String // 건
    
    /// 기타검체
    var etcsamplecnt: String
    
    /// HRG검체
    var hrgsamplecnt: String
    var hrgsamplecnt2: String // 건
    
    /// 등록검체
    var enrsamplecnt: String
    
    /// HBV검체/연구용검체
    var hbvsamplecnt: String
    
    /// 조혈모 세포 검체
    var marsamplecnt: String
    
    /// Rh- 검체
    var rhnsamplecnt: String
    
    // MARK: - 기록카드
    /// 부적격
    var unfitpapercnt: String
    
    /// e-부적격
    var eunfitpapercnt: String
    
    // MARK: - 냉매제
    /// 아이스팩
    var icepackcnt: String
    
    /// 쿨런트
    var coolantcnt: String
    
    /// 혈액박스
    var bloodboxcnt: String
    
    // MARK: - 수정불가
    var bloodsamplecnt: String
    var papercnt: String
    var epapercnt: String
    
    // MARK: - 저장정보
    var enteridno: String
    var takeoverinputidno: String
    var getidno: String
    var dbcheckid: String
    
    
}
