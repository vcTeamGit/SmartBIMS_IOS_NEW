//
//  TakeOverChangeBloodLevelConfirmViewController.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/08/17.
//

import UIKit

class TakeOverChangeBloodLevelConfirmViewController: UIViewController {
    
    // MARK: - Properties
    var m_SBUserInfoVO: SBUserInfoVO?
    var bloodLevelInfoData: TakeOverLevelInfoData?
    var bloodLevelFixInfoData: TakeOverLevelInfoData?
    var saveData = TakeOverLevelInfoData()
    weak var delegate: TakeOverChangeBloodLevelInfoViewController?
    var bloodLevel = -1
    
    let dpGroup = DispatchGroup()
    var returnStr = ""
    
    // MARK: - IBOutlets
    @IBOutlet var bloodCntLabel: UILabel!
    @IBOutlet var spcSampleCntLabel: UILabel!
    @IBOutlet var enrSampleCntLabel: UILabel!
    @IBOutlet var etcSampleCntLabel: UILabel!
    @IBOutlet var hrgSampleCntLabel: UILabel!
    
    @IBOutlet var hbvSampleCntLabel: UILabel!
    @IBOutlet var marSampleCntLabel: UILabel!
    @IBOutlet var rhnSampleCntLabel: UILabel!
    @IBOutlet var paperCntLabel: UILabel!
    @IBOutlet var epaperCntLabel: UILabel!
    
    @IBOutlet var unfitPaperCntLabel: UILabel!
    @IBOutlet var eunfitPaperCntLabel: UILabel!
    @IBOutlet var iceCntLabel: UILabel!
    @IBOutlet var coolentCntLabel: UILabel!
    @IBOutlet var bloodBoxCntLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func okButtonTapped(_ sender: Any) {
        
        guard let m_SBUserInfoVO = self.m_SBUserInfoVO else { return }
        
        let alert = UIAlertController(title: "혈액인계정보 수정",
                                      message: "해당차수 혈액인계정보를 수정하시겠습니까?\n수정 시간과 현재 사용자 ID가 저장됩니다.",
                                      preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "확인",
                                     style: .destructive) { [self] _ in
            
            self.dpGroup.enter()
            self.changeBloodLevelInfo(m_SBUserInfoVO)
            self.dpGroup.notify(queue: .main, execute: {
                showOkButtonAlert(str: self.returnStr,
                                  delegate: self.delegate!) { [self] _ in
                                    self.delegate?.delegateVC?.setPages()
                                    self.delegate?.dismiss(animated: true)
                }
            })

            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelButton = UIAlertAction(title: "취소",
                                         style: .cancel,
                                         handler: nil)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitiialValue()
    }
    
    // MARK: - Setup
    func setupInitiialValue() {
        guard let originData = self.bloodLevelInfoData,
              let fixData = self.bloodLevelFixInfoData,
              self.m_SBUserInfoVO != nil,
              self.bloodLevel > 0 else {
            showOkButtonAlert(str: "자료를 불러오는데 실패하였습니다. 다시 시도하여주시기 바랍니다.",
                              delegate: self) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        // 수정 불가 값
        self.bloodCntLabel.text = originData.bloodsamplecnt
        self.paperCntLabel.text = originData.papercnt
        self.epaperCntLabel.text = originData.epapercnt
        
        // 수정 값
        if fixData.spcsamplecnt2 != "" || fixData.spcsamplecnt != "" {
            self.spcSampleCntLabel.text = String(format: "%d건 %d개",
                                                 fixData.spcsamplecnt2.toInt(),
                                                 fixData.spcsamplecnt.toInt())
            self.spcSampleCntLabel.textColor = .red
            self.spcSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.spcsamplecnt2 = fixData.spcsamplecnt2
            saveData.spcsamplecnt = fixData.spcsamplecnt
        } else {
            self.spcSampleCntLabel.text = String(format: "%d건 %d개",
                                                 originData.spcsamplecnt2.toInt(),
                                                 originData.spcsamplecnt.toInt())
            saveData.spcsamplecnt2 = originData.spcsamplecnt2
            saveData.spcsamplecnt = originData.spcsamplecnt
        }
        
        if fixData.enrsamplecnt != "" {
            self.enrSampleCntLabel.text = fixData.enrsamplecnt
            self.enrSampleCntLabel.textColor = .red
            self.enrSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.enrsamplecnt = fixData.enrsamplecnt
        } else {
            self.enrSampleCntLabel.text = originData.enrsamplecnt
            saveData.enrsamplecnt = originData.enrsamplecnt
        }

        if fixData.etcsamplecnt != "" {
            self.etcSampleCntLabel.text = fixData.etcsamplecnt
            self.etcSampleCntLabel.textColor = .red
            self.etcSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.etcsamplecnt = fixData.etcsamplecnt
        } else {
            self.etcSampleCntLabel.text = originData.etcsamplecnt
            saveData.etcsamplecnt = originData.etcsamplecnt
        }
        
        if fixData.hrgsamplecnt2 != "" || fixData.hrgsamplecnt != "" {
            self.hrgSampleCntLabel.text = String(format: "%d건 %d개",
                                                 fixData.hrgsamplecnt2.toInt(),
                                                 fixData.hrgsamplecnt.toInt())
            self.hrgSampleCntLabel.textColor = .red
            self.hrgSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.hrgsamplecnt2 = fixData.hrgsamplecnt2
            saveData.hrgsamplecnt = fixData.hrgsamplecnt
        } else {
            self.hrgSampleCntLabel.text = String(format: "%d건 %d개",
                                                 originData.hrgsamplecnt2.toInt(),
                                                 originData.hrgsamplecnt.toInt())
            saveData.hrgsamplecnt2 = originData.hrgsamplecnt2
            saveData.hrgsamplecnt = originData.hrgsamplecnt
        }
        
        if fixData.hbvsamplecnt != "" {
            self.hbvSampleCntLabel.text = fixData.hbvsamplecnt
            self.hbvSampleCntLabel.textColor = .red
            self.hbvSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.hbvsamplecnt = fixData.hbvsamplecnt
        } else {
            self.hbvSampleCntLabel.text = originData.hbvsamplecnt
            saveData.hbvsamplecnt = originData.hbvsamplecnt
        }
        
        if fixData.marsamplecnt != "" {
            self.marSampleCntLabel.text = fixData.marsamplecnt
            self.marSampleCntLabel.textColor = .red
            self.marSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.marsamplecnt = fixData.marsamplecnt
        } else {
            self.marSampleCntLabel.text = originData.marsamplecnt
            saveData.marsamplecnt = originData.marsamplecnt
        }
        
        if fixData.rhnsamplecnt != "" {
            self.rhnSampleCntLabel.text = fixData.rhnsamplecnt
            self.rhnSampleCntLabel.textColor = .red
            self.rhnSampleCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.rhnsamplecnt = fixData.rhnsamplecnt
        } else {
            self.rhnSampleCntLabel.text = originData.rhnsamplecnt
            saveData.rhnsamplecnt = originData.rhnsamplecnt
        }
        
        if fixData.unfitpapercnt != "" {
            self.unfitPaperCntLabel.text = fixData.unfitpapercnt
            self.unfitPaperCntLabel.textColor = .red
            self.unfitPaperCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.unfitpapercnt = fixData.unfitpapercnt
        } else {
            self.unfitPaperCntLabel.text = originData.unfitpapercnt
            saveData.unfitpapercnt = originData.unfitpapercnt
        }
        
        if fixData.eunfitpapercnt != "" {
            self.eunfitPaperCntLabel.text = fixData.eunfitpapercnt
            self.eunfitPaperCntLabel.textColor = .red
            self.eunfitPaperCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.eunfitpapercnt = fixData.eunfitpapercnt
        } else {
            self.eunfitPaperCntLabel.text = originData.eunfitpapercnt
            saveData.eunfitpapercnt = originData.eunfitpapercnt
        }
        
        if fixData.icepackcnt != "" {
            self.iceCntLabel.text = fixData.icepackcnt
            self.iceCntLabel.textColor = .red
            self.iceCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.icepackcnt = fixData.icepackcnt
        } else {
            self.iceCntLabel.text = originData.icepackcnt
            saveData.icepackcnt = originData.icepackcnt
        }
        
        if fixData.coolantcnt != "" {
            self.coolentCntLabel.text = fixData.coolantcnt
            self.coolentCntLabel.textColor = .red
            self.coolentCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.coolantcnt = fixData.coolantcnt
        } else {
            self.coolentCntLabel.text = originData.coolantcnt
            saveData.coolantcnt = originData.coolantcnt
        }
        
        if fixData.bloodboxcnt != "" {
            self.bloodBoxCntLabel.text = fixData.bloodboxcnt
            self.bloodBoxCntLabel.textColor = .red
            self.bloodBoxCntLabel.font = .boldSystemFont(ofSize: 17)
            saveData.bloodboxcnt = fixData.bloodboxcnt
        } else {
            self.bloodBoxCntLabel.text = originData.bloodboxcnt
            saveData.bloodboxcnt = originData.bloodboxcnt
        }
    }
}

// MARK: - API
extension TakeOverChangeBloodLevelConfirmViewController {
    func changeBloodLevelInfo(_ userInfo: SBUserInfoVO ) {
        let parameter =
            NSDictionary(dictionary: ["reqId": TakeOverChangeLevelInfoURL.changeBloodLevelInfo,
                                      "orgcode": userInfo.szBimsOrgcode!,
                                      "carcode": userInfo.szBimsCarcode!,
                                      "sitecode": userInfo.szBimsSitecode!,
                                      "useridno": userInfo.szBimsId!,
                                      "takeoverseq": bloodLevel,
                                      
                                      "spcsamplecnt2": saveData.spcsamplecnt2,
                                      "spcsamplecnt": saveData.spcsamplecnt,
                                      "enrsamplecnt": saveData.enrsamplecnt,
                                      "etcsamplecnt": saveData.etcsamplecnt,
                                      "hrgsamplecnt2": saveData.hrgsamplecnt2,
                                      
                                      "hrgsamplecnt": saveData.hrgsamplecnt,
                                      "hbvsamplecnt": saveData.hbvsamplecnt,
                                      "marsamplecnt": saveData.marsamplecnt,
                                      "rhnsamplecnt": saveData.rhnsamplecnt,
                                      "unfitpapercnt": saveData.unfitpapercnt,
                                      
                                      "eunfitpapercnt": saveData.eunfitpapercnt,
                                      "icepackcnt": saveData.icepackcnt,
                                      "coolantcnt": saveData.coolantcnt,
                                      "bloodboxcnt": saveData.bloodboxcnt])
        
        TakeOverRegisterAPI
            .shared
            .getDataFromURLWithSelector(url: TakeOverChangeLevelInfoURL.baseURL,
                                        selector: #selector(changeBloodLevelInfoSelector),
                                        parameter: parameter,
                                        delegate: self)
    }
    
    @objc
    func changeBloodLevelInfoSelector(result: Any) {
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        guard let result = json["result"] as? String, result != "" else {
            returnStr = "오류가 발생하여 차수정보 변경을 실패하였습니다."
            dpGroup.leave()
            return
        }
        
        if result == "Y" {
            returnStr = "해당 차수 정보 변경이 완료되었습니다."
        } else {
            returnStr = "오류가 발생하여 차수정보 변경을 실패하였습니다."
        }
        
        dpGroup.leave()
    }
}
