//
//  ChangeBloodLevelViewController.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/28.
//

import UIKit

class ChangeBloodLevelViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var currentBloodLevelLabel: UILabel!
    @IBOutlet var nextBloodLevelLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        guard let userInfo = m_SBUserInfoVO,
              let bloodLevel = currentBloodLevel else {
                showOkButtonAlert(str: "오류가 발생하여 해당 차수 종료를 실패하였습니다.", delegate: self) { [weak self] _ in
                    self?.dismiss(animated: true, completion: nil)
            }
            
            return
        }
        dpGroup.enter()
        raiseBloodLevel(userInfo, bloodLevel)
        
        dpGroup.notify(queue: .main) {
            showOkButtonAlert(str: self.returnStr!,
                              delegate: self) { [unowned self] _ in
                self.dismiss(animated: true) { [weak self] in
                    self?.delegate?.setInitialInfo()
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Properties
    var currentBloodLevel: Int?
    var m_SBUserInfoVO : SBUserInfoVO?
    weak var delegate: TakeoverBloodRegisterViewController?
    
    var returnStr: String?
    var dpGroup = DispatchGroup()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBloodLevel()
    }
}

// MARK: - Setup
extension ChangeBloodLevelViewController {
    func setupBloodLevel() {
        guard let level = currentBloodLevel else { return }
        currentBloodLevelLabel.text = level.description
        nextBloodLevelLabel.text = (level + 1).description
    }
}

// MARK: - API
extension ChangeBloodLevelViewController {
    func raiseBloodLevel(_ userInfo: SBUserInfoVO, _ bloodLevel: Int) {
        let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo
                                                            .raiseTakeOverLevel,
                                                  "orgcode": userInfo.szBimsOrgcode!,
                                                  "carcode": userInfo.szBimsCarcode!,
                                                  "sitecode": userInfo.szBimsSitecode!,
                                                  "userIdNo": userInfo.szBimsId!,
                                                  "takeOverSeq": bloodLevel])
        
        TakeOverRegisterAPI
            .shared
            .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                        selector: #selector(raiseBloodLevelSelector),
                                        parameter: parameter,
                                        delegate: self)
    }
    
    @objc
    func raiseBloodLevelSelector(result: Any) {
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        guard let result = json["result"] as? String, result != "" else {
            returnStr = "오류가 발생하여 해당 차수 종료를 실패하였습니다."
            dpGroup.leave()
            return
        }
        
        if result == "Y" {
            returnStr = "해당 차수 종료가 완료되었습니다."
        } else {
            returnStr = "오류가 발생하여 해당 차수 종료를 실패하였습니다."
        }
        
        dpGroup.leave()
    }
}
