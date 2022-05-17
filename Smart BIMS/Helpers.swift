//
//  Helpers.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/07/02.
//

import UIKit

// 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
class LoadingIndicator {
    
    static var isLoading = false
    
    static func showLoading() {
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }

            let loadingIndicatorView: UIActivityIndicatorView
            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                if #available(iOS 13.0, *) {
                    loadingIndicatorView = UIActivityIndicatorView(style: .large)
                } else {
                    loadingIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
                }
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = .gray
                window.addSubview(loadingIndicatorView)
            }

            loadingIndicatorView.startAnimating()
        }
    }

    static func hideLoading() {
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
        }
    }
}

func showOkButtonAlert(str: String, delegate: UIViewController, _ action: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: "알림",
                                  message: str,
                                  preferredStyle: .alert)
    
    let okBtn = UIAlertAction(title: "확인", style: .default, handler: action)
    alert.addAction(okBtn)
    delegate.present(alert, animated: true, completion: nil)
}

func showOkButtonErrorAlert(str: String, delegate: UIViewController, _ action: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: "알림",
                                  message: str,
                                  preferredStyle: .alert)
    
    let okBtn = UIAlertAction(title: "확인", style: .default, handler: action)
    alert.addAction(okBtn)
    delegate.present(alert, animated: true, completion: nil)
    
    SBUtils.playAlertSystemSound(withSoundType: 1)
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
