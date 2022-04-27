//
//  Helpers.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/07/02.
//

import UIKit

func showOkButtonAlert(str: String, delegate: UIViewController, _ action: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: "알림",
                                  message: str,
                                  preferredStyle: .alert)
    
    let okBtn = UIAlertAction(title: "확인", style: .default, handler: action)
    alert.addAction(okBtn)
    delegate.present(alert, animated: true, completion: nil)
}

func getCurrentDate() -> String {
    let formatter = DateFormatter()
    let currentDate = Date()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter.string(from: currentDate)
}

func removeBloodNoCheckBitAndReturnNewBloodNo(bloodNo: String) -> String {
    var tempBloodNo = bloodNo.dropLast(2)
    tempBloodNo += "01"
    return String(tempBloodNo)
}

extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}
