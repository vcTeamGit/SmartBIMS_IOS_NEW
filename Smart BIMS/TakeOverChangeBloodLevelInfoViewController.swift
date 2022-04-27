//
//  TakeOverChangeBloodLevelInfoViewController.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/08/12.
//

import UIKit

private let tempOrgcode  = "001"      // A00
private let tempCarcode  = "50"       // 00
private let tempSiteCode = "41229724"
private let tempSiteName = "혈액관리본부"

class TakeOverChangeBloodLevelInfoViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var bloodCntLabel: UILabel!
    
    @IBOutlet var spcsamplecnt2TextField: UITextField!
    @IBOutlet var spcsamplecntTextField: UITextField!
    
    @IBOutlet var enrsamplecntTextField: UITextField!
    @IBOutlet var etcsamplecntTextField: UITextField!
    
    @IBOutlet var hrgsamplecnt2TextField: UITextField!
    @IBOutlet var hrgsamplecntTextField: UITextField!
    
    @IBOutlet var hbvsamplecntTextField: UITextField!
    @IBOutlet var marsamplecntTextField: UITextField!
    @IBOutlet var rhnsamplecntTextField: UITextField!
    
    @IBOutlet var unfitpapercntTextField: UITextField!
    @IBOutlet var eunfitpapercntTextField: UITextField!
    @IBOutlet var icepackcntTextField: UITextField!
    @IBOutlet var coolantcntTextField: UITextField!
    @IBOutlet var bloodboxcntTextField: UITextField!
    
    @IBOutlet var papercntLabel: UILabel!
    @IBOutlet var epapercntLabel: UILabel!
    
    
    // MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fixButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: TakeOverChangeLevelInfoSegueInfo
                                     .fixBloodLevelSegueIdentifier,
                     sender: nil)
    }
    
    @IBAction func showLogInfoButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: TakeOverChangeLevelInfoSegueInfo
                                     .changeInfoLogSegueIdentifier,
                     sender: nil)
    }
    
    // MARK: - Properties
    @objc
    var m_SBUserInfoVO: SBUserInfoVO?
    
    @objc
    var bloodLevel: Int = -1
    
    var bloodLevelInfoData: TakeOverLevelInfoData?
    var bloodLevelFixInfoData = TakeOverLevelInfoData()
    
    let dpGroup = DispatchGroup()
    
    @objc
    weak var delegateVC: SBTakeOverInfoViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        checkIsValidData()
        setInitialData()
    }
    
    // MARK: - Setup
    func checkIsValidData() {
        guard self.m_SBUserInfoVO != nil,
              self.bloodLevel > 0 else {
            showOkButtonAlert(str: "자료를 불러오는데 실패하였습니다. 다시 시도하여주시기 바랍니다.",
                              delegate: self) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            return
        }
    }
    
    func setInitialData() {
        dpGroup.enter()
        loadTakeOverInfoData()
        dpGroup.notify(queue: .main) { [weak self] in
            self?.setBloodLevelInfo()
        }
    }
    
    func loadTakeOverInfoData() {
        guard let m_SBUserInfoVO = m_SBUserInfoVO,
              bloodLevel > 0 else { return }
        
        if m_SBUserInfoVO.szBimsId == "R2020045" {
            m_SBUserInfoVO.szBimsOrgcode  = tempOrgcode
            m_SBUserInfoVO.szBimsCarcode  = tempCarcode
            m_SBUserInfoVO.szBimsSitecode = tempSiteCode
            m_SBUserInfoVO.szBimsSitename = tempSiteName
        }

        let parameter = NSDictionary(dictionary: ["reqId":
                                                    TakeOverChangeLevelInfoURL.initialRequest,
                                                  "orgcode": m_SBUserInfoVO.szBimsOrgcode!,
                                                  "carcode": m_SBUserInfoVO.szBimsCarcode ?? "-1",
                                                  "takeoverseq": bloodLevel])
        
        TakeOverRegisterAPI
            .shared
            .getDataFromURLWithSelector(url: TakeOverChangeLevelInfoURL.baseURL,
                                        selector: #selector(getInitaialData),
                                        parameter: parameter,
                                        delegate: self)
    }
    
    func setBloodLevelInfo() {
        guard let bloodLevelInfo = self.bloodLevelInfoData else {
            showOkButtonAlert(str: "자료를 불러오는데 실패하였습니다. 다시 시도하여주시기 바랍니다. (code: 2)",
                              delegate: self) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            return
        }

        self.bloodCntLabel.text = bloodLevelInfo.bloodsamplecnt
        self.spcsamplecnt2TextField.placeholder = bloodLevelInfo.spcsamplecnt2
        self.spcsamplecntTextField.placeholder = bloodLevelInfo.spcsamplecnt
        
        self.enrsamplecntTextField.placeholder = bloodLevelInfo.enrsamplecnt
        self.etcsamplecntTextField.placeholder = bloodLevelInfo.etcsamplecnt
        
        self.hrgsamplecnt2TextField.placeholder = bloodLevelInfo.hrgsamplecnt2
        self.hrgsamplecntTextField.placeholder = bloodLevelInfo.hrgsamplecnt
        
        self.hbvsamplecntTextField.placeholder = bloodLevelInfo.hbvsamplecnt
        self.marsamplecntTextField.placeholder = bloodLevelInfo.marsamplecnt
        self.rhnsamplecntTextField.placeholder = bloodLevelInfo.rhnsamplecnt
        
        self.unfitpapercntTextField.placeholder = bloodLevelInfo.unfitpapercnt
        self.eunfitpapercntTextField.placeholder = bloodLevelInfo.eunfitpapercnt
        self.icepackcntTextField.placeholder = bloodLevelInfo.icepackcnt
        self.coolantcntTextField.placeholder = bloodLevelInfo.coolantcnt
        self.bloodboxcntTextField.placeholder = bloodLevelInfo.bloodboxcnt
        
        self.papercntLabel.text = bloodLevelInfo.papercnt
        self.epapercntLabel.text = bloodLevelInfo.epapercnt
    }
    
    // MARK: - API
    @objc
    func getInitaialData(result: Any) {
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        guard let result = json["result"] as? NSDictionary else {
            dpGroup.leave()
            return
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: result,
                                                  options: .prettyPrinted) {
            bloodLevelInfoData = try! JSONDecoder().decode(TakeOverLevelInfoData.self,
                                                           from: data)
        }
        
        dpGroup.leave()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TakeOverChangeLevelInfoSegueInfo.fixBloodLevelSegueIdentifier {
            let destVC = segue.destination as! TakeOverChangeBloodLevelConfirmViewController
            makeFixLevelInfoData()
            destVC.delegate = self
            destVC.bloodLevelInfoData = self.bloodLevelInfoData
            destVC.bloodLevelFixInfoData = self.bloodLevelFixInfoData
            destVC.m_SBUserInfoVO = self.m_SBUserInfoVO
            destVC.bloodLevel = self.bloodLevel
        } else if segue.identifier == TakeOverChangeLevelInfoSegueInfo.changeInfoLogSegueIdentifier {
            let destVC = segue.destination as! TakeOverChangeBloodLevelInfoTableViewController
            
            destVC.bloodLevel = self.bloodLevel
            destVC.m_SBUserInfoVO = self.m_SBUserInfoVO
        }
    }
}

// MARK: - Helpers
extension TakeOverChangeBloodLevelInfoViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func makeFixLevelInfoData() {
        
        if let value = self.spcsamplecnt2TextField.text {
            self.bloodLevelFixInfoData.spcsamplecnt2 = value
        }
        
        if let value = self.spcsamplecntTextField.text {
            self.bloodLevelFixInfoData.spcsamplecnt = value
        }
        
        if let value = self.enrsamplecntTextField.text {
            self.bloodLevelFixInfoData.enrsamplecnt = value
        }
        
        if let value = self.etcsamplecntTextField.text {
            self.bloodLevelFixInfoData.etcsamplecnt = value
        }
        
        if let value = self.hrgsamplecnt2TextField.text {
            self.bloodLevelFixInfoData.hrgsamplecnt2 = value
        }
        
        if let value = self.hrgsamplecntTextField.text {
            self.bloodLevelFixInfoData.hrgsamplecnt = value
        }
        
        if let value = self.hbvsamplecntTextField.text {
            self.bloodLevelFixInfoData.hbvsamplecnt = value
        }
        
        if let value = self.marsamplecntTextField.text {
            self.bloodLevelFixInfoData.marsamplecnt = value
        }
        
        if let value = self.rhnsamplecntTextField.text {
            self.bloodLevelFixInfoData.rhnsamplecnt = value
        }
        
        if let value = self.unfitpapercntTextField.text {
            self.bloodLevelFixInfoData.unfitpapercnt = value
        }
        
        if let value = self.eunfitpapercntTextField.text {
            self.bloodLevelFixInfoData.eunfitpapercnt = value
        }
        
        if let value = self.icepackcntTextField.text {
            self.bloodLevelFixInfoData.icepackcnt = value
        }
        
        if let value = self.coolantcntTextField.text {
            self.bloodLevelFixInfoData.coolantcnt = value
        }
        
        if let value = self.bloodboxcntTextField.text {
            self.bloodLevelFixInfoData.bloodboxcnt = value
        }
    }
}
