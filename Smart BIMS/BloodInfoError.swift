//
//  BloodInfoError.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/07/12.
//

import Foundation

// TODO: 오류 발생 시 refactoring
enum BloodInfoError: Error, CustomStringConvertible {
    case isNotExistBloodNo(bloodNo: String)
    case notEnd(bloodNo: String)
    case isNotExistBldProcCode(bldProcCode: String)
    
    var description: String {
        switch self {
        case .isNotExistBloodNo(bloodNo: let bloodNo):
            return bloodNo.description
        case .notEnd(bloodNo: let bloodNo):
            return bloodNo.description
        case .isNotExistBldProcCode(bldProcCode: let bldProcCode):
            return bldProcCode.description
        }
    }
}
