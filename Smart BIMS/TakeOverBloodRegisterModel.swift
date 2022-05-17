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
    var isMulti: String
    var isTerminated: String
    // 2022.05.16 ADD HMWOO 지정 헌혈 및 일반 헌혈 구분 값 추가
    var isAssigned: String
    
    var result: String
}
