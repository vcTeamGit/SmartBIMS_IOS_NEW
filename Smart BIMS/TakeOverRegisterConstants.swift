//
//  TakeOverRegisterConstants.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/29.
//

import Foundation

// MARK: - BloodRegisterURLInfo
struct BloodRegisterURLInfo {
    
    static let baseURL = "http://mbims.bloodinfo.net:59999/mbims/appservice/Swift_SBTakeOverBloodRegister3.jsp"
    
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
    
    static let baseURL = "http://mbims.bloodinfo.net:59999/mbims/appservice/Swift_SBTakeOverChangeBloodLevelInfo.jsp"
    
    // MARK: Request Into
    static let initialRequest = "initialRequest"
    static let changeBloodLevelInfo = "changeBloodLevelInfo"
}

// MARK: - TakeOverChangeLevelInfoSegueInfo
struct TakeOverChangeLevelInfoSegueInfo {
    static let fixBloodLevelSegueIdentifier = "fixBloodLevelSegueIdentifier"
    static let changeInfoLogSegueIdentifier = "changeInfoLogSegueIdentifier"
}
