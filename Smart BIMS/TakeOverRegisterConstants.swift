//
//  TakeOverRegisterConstants.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/29.
//

import Foundation

// MARK: - BloodRegisterURLInfo
struct BloodRegisterURLInfo {
    
    // 2022.05.09 ADD HMWOO URL을 하나의 파일로 관리하기 위해 기존에 고정적으로 박혀져 있던 URL 변경
    static let baseURL = URL_MANAGE_TAKEOVER_BLOOD
    
    // MARK: Request Into
    static let initialRequest = "takeOverBloodInfoWithSeq"
    static let tableViewCellBloodInfoRequest = "tableViewCellBloodInfoRequest"
    static let raiseTakeOverLevel = "raiseTakeOverLevel"
    static let removeAllData = "removeAllData"
    static let changeBloodType = "changeBloodType"
    static let deleteBloodno = "deleteBloodNo"
    static let checkIsValidAndSaveBloodNo = "checkIsValidAndSaveBloodNo"
    static let checkIsValidAndSaveMultiBloodNoWithBldProcCode = "checkIsValidAndSaveMultiBloodNoWithBldProcCode"
}

// MARK: - TakeOverRegisterTableViewInfo
struct TakeOverRegisterTableViewInfo {
    static let reuseIdentifier = "TakeoverBloodRegisterViewCellReuseIdentifier"
    static let nibName = "TakeOverBloodRegisterTableViewCell"
}

// MARK: - TakeOverRegisterSegueInfo
struct TakeOverRegisterSegueInfo {
    static let cellInfoSegueIdentifier = "TakeoverTableViewCellInfoViewController"
    static let changeBloodLevelSegueIdentifier = "ChangeBloodLevelViewController"
}

// MARK: - BloodRegisterURLInfo
struct TakeOverChangeLevelInfoURL {
    
    // 2022.05.09 ADD HMWOO URL을 하나의 파일로 관리하기 위해 기존에 고정적으로 박혀져 있던 URL 변경
    static let baseURL = URL_GET_TAKEOVER_BLOOD_INFO
    
    // MARK: Request Into
    static let initialRequest = "initialRequest"
    static let changeBloodLevelInfo = "changeBloodLevelInfo"
}

// MARK: - TakeOverChangeLevelInfoSegueInfo
struct TakeOverChangeLevelInfoSegueInfo {
    static let fixBloodLevelSegueIdentifier = "fixBloodLevelSegueIdentifier"
    static let changeInfoLogSegueIdentifier = "changeInfoLogSegueIdentifier"
}
