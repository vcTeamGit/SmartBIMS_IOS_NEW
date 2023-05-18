//
//  BloodType.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/30.
//

import Foundation

enum BloodType: Int, CaseIterable, CustomStringConvertible {

    // 숫자가 작을수록 정렬 우선순위 최우선
    case direct = 1
    case normal = 3
    case rh_minus = 2
    
    var color: UIColor  {
        switch self {
        case .direct:
//            return UIColor(red: 75/255.0, green: 137/255.0, blue: 220/255.0, alpha: 1)
            return UIColor(red: 46/255.0, green: 108/255.0, blue: 164/255.0, alpha: 1)
        case .normal:
//            return UIColor(red: 0/255.0, green: 183/255.0, blue: 17/255.0, alpha: 1)
            return UIColor(red: 100/255.0, green: 151/255.0, blue: 49/255.0, alpha: 1)
        case .rh_minus:
//            return UIColor(red: 220/255.0, green: 75/255.0, blue: 78/255.0, alpha: 1)
            return UIColor(red: 170/255.0, green: 55/255.0, blue: 49/255.0, alpha: 1)
        }
    }
    
    var description: String {
        switch self {
        case .direct:
            return "지정헌혈"
        case .normal:
            return "일반혈액"
        case .rh_minus:
            return "Rh(-)긴급"
        }
    }
    
    static func getBloodType(data: TakeRegisterTableViewCellData) -> BloodType {
        if data.isassigned == "Y" {
            return .direct
        } else if data.rhnemergency == "Y" {
            return .rh_minus
        } else {
            return .normal
        }
    }

    static func getBloodTypeInfoByTuple(data: BloodType) -> (String, String) {
        switch data {
        case .direct:
            return ("Y", "N")
        case .normal:
            return ("N", "N")
        case .rh_minus:
            return ("N", "Y")
        }
    }
}

