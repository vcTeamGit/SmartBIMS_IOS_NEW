//
//  TakeOverChangeBloodLevelInfoTableViewController.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/08/23.
//

import UIKit

class TakeOverChangeBloodLevelInfoTableViewController: UIViewController {

    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Properteis
    var bloodLevel: Int?
    var m_SBUserInfoVO: SBUserInfoVO?
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIsDataTransfereed()
    }
    
    // MARK: - Setup
    func checkIsDataTransfereed() {
        guard let bloodLevel = bloodLevel,
              let m_SBUserInfoVO = m_SBUserInfoVO else {
            showOkButtonAlert(str: "자료를 불러오는데 실패하였습니다.",
                              delegate: self) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            
            return
        }
        print("checkIsDataTransfereed()")
        print(bloodLevel)
        print(m_SBUserInfoVO.szBimsCarcode ?? -1)
    }
}
