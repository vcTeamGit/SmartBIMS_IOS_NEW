//
//  TakeOverBloodRegisterModel.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/29.
//

import Foundation

struct TakeRegisterTableViewCellData: Decodable {
    var orgcode: String
    var carcode: String
    var orgname: String
    var carname: String
    
    var takeoverdate: String
    var takeoverseq: String
    var bloodno: String
    var bldprocbarcode: String
    var bldprocnamesh: String
    
    var labelno: String
    var isassigned: String
    var rhnemergency: String
    var enterdate: String
    var enteridno: String
    
    var issaved: String
    var malchk: String
    var gubun: String
    
    enum CodingKeys: String, CodingKey {
        case orgcode
        case carcode
        case orgname
        case carname
        
        case takeoverdate
        case takeoverseq
        case bloodno
        case bldprocbarcode
        case bldprocnamesh
        
        case labelno
        case isassigned
        case rhnemergency
        case enterdate
        case enteridno
        
        case issaved
        case malchk
        case gubun
    }
}

struct TakeoverBloodInsertResult: Decodable {
    var isNotExist: String
    var isEnd: String
    var isExistInTakeOver: String
    var isMal: String
    // 2022.06.03 HMWOO DEL 제제바 코드 자동 등록 대응 기존 로직 제거
    // var isMulti: String
    var isTerminated: String
    var result: String
}
