//
//  TakeoverBloodRegisterViewController.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/23.
//

import UIKit

private let tempOrgcode  = "A00"
private let tempCarcode  = "00"
private let tempSiteCode = "혈액관리본부"
private let tempSiteName = ""

private let bloodNoMaxLength = 12
private let bldCodeMaxLength = 5

class TakeoverBloodRegisterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var bloodTypeSegmentation: UISegmentedControl!
    @IBOutlet var bloodTypeView: UIView!
    @IBOutlet var bloodTypeView2: UIView!
    @IBOutlet var bloodTypeView3: UIView!
    @IBOutlet var bloodTypeTitle: UILabel!
    @IBOutlet var currentBloodLocationInfo: UILabel!
    
    // Blood Info
    @IBOutlet var numOfTotalBloodInfo: UILabel!
    @IBOutlet var numOf320T: UILabel!
    @IBOutlet var numOf400T: UILabel!
    @IBOutlet var numOf320D: UILabel!
    @IBOutlet var numOf400D: UILabel!
    @IBOutlet var numOf400Q: UILabel!
    @IBOutlet var numOfPLA: UILabel!
    @IBOutlet var numOfAPLT: UILabel!
    @IBOutlet var numOfPLTM_PLM: UILabel!
    @IBOutlet var maxBloodLevel: UIButton!
    
    // TextField
    @IBOutlet var bloodBarcodeTextField: UITextField!
    @IBOutlet var bldProccodeBarcodeTextField: UITextField!
    
    // TableView
    @IBOutlet var tableView: UITableView!
    
    // BloodType Count
    @IBOutlet var numOfDirectBlood: UILabel!
    @IBOutlet var numOfRhBlood: UILabel!
    
    // MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bloodButtonTapped(_ sender: Any) {
        guard let bloodNum = bloodNum, bloodNum == 0 else {
            showOkButtonErrorAlert(str: "저장 된 혈액이 없을 경우에만 차수를 넘어갈 수 있습니다.",
                              delegate: self)
            return
        }
        performSegue(withIdentifier: TakeOverRegisterSegueInfo.changeBloodLevelSegueIdentifier,
                     sender: nil)
    }
    @IBAction func bloodTypeSegmentChanged(_ sender: UISegmentedControl) {
        let allCase = BloodType.allCases
        let currentValue = allCase[sender.selectedSegmentIndex]
        currentBloodType = currentValue
    }
    
    @IBAction func addBloodButtonTapped(_ sender: UIBarButtonItem) {
        bloodBarcodeTextField.text = ""
        bldProccodeBarcodeTextField.text = ""
        
        bloodBarcodeTextField.becomeFirstResponder()
    }
    
    @IBAction func sortBloodNoButtonTapped(_ sender: Any) {
        guard takeoverData != nil else { return }
        takeoverData!.sort { $0.bloodno < $1.bloodno }
    }
    
    @IBAction func sortBldBagButtonTapped(_ sender: Any) {
        guard takeoverData != nil else { return }
        takeoverData!.sort { $0.bldprocbarcode < $1.bldprocbarcode }
    }
    
    @IBAction func sortBloodTypeButtonTapped(_ sender: Any) {
        guard takeoverData != nil else { return }
        takeoverData!.sort { BloodType.getBloodType(data: $0).rawValue < BloodType.getBloodType(data: $1).rawValue }
    }
    
    @IBAction func removeAllDataTapped(_ sender: Any) {
        let alert = UIAlertController(title: "주의",
                                      message: "현재 차수에 저장된 모든 혈액을 삭제합니다.",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .destructive) { [self] _ in
            guard let m_SBUserInfoVO = self.m_SBUserInfoVO else { return }
            
            if self.takeoverData?.count == 0 {
                showOkButtonErrorAlert(str: "삭제할 혈액이 존재하지 않습니다", delegate: self)
                return
            }
            
            let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo.removeAllData,
                                                      "orgcode": m_SBUserInfoVO.szBimsOrgcode!,
                                                      "carcode": m_SBUserInfoVO.szBimsCarcode!,
                                                      "takeoverdate": getCurrentDate(),
                                                      "takeoverseq": self.maxBloodLevel.titleLabel!.text!,
                                                      "deleteid": m_SBUserInfoVO.szBimsId!])
            
            // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
            LoadingIndicator.showLoading()
            
            TakeOverRegisterAPI
                .shared
                .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                            selector: #selector(self.removeAllData),
                                            parameter: parameter,
                                            delegate: self)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        showOkButtonAlert(str: "새로고침이 완료되었습니다.", delegate: self)
        self.setInitialInfo()
    }
    
    // MARK: - Properties
    
    @objc
    var m_SBUserInfoVO: SBUserInfoVO?
    
    var currentBloodType: BloodType? {
        didSet {
            self.bloodTypeView.backgroundColor = self.currentBloodType?.color
            self.bloodTypeView2.backgroundColor = self.currentBloodType?.color
            self.bloodTypeView3.backgroundColor = self.currentBloodType?.color
            self.bloodTypeTitle.text = self.currentBloodType?.description
        }
    }
    
    var takeoverData: [TakeRegisterTableViewCellData]? {
        didSet {
            tableView.reloadData()
            setBloodTypeCnt()
        }
    }

    var bloodNum: Int?
    var dpGroup = DispatchGroup()
    var insertResult: TakeoverBloodInsertResult?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup
        setBloodTypeSegmentation()
        setInitialInfo()
        setBasicInfo()
        setTakeOverTableView()
        setKeyboardSetting()
        
        self.becomeBarcodeTextFieldFirstResponder()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TakeOverRegisterSegueInfo.cellInfoSegueIdentifier {
            let destVC = segue.destination as! TakeoverTableViewCellInfoViewController
            destVC.takeoverBloodData = sender as? TakeRegisterTableViewCellData
            destVC.currentID = m_SBUserInfoVO?.szBimsId
            destVC.delegate = self
        } else if segue.identifier == TakeOverRegisterSegueInfo.changeBloodLevelSegueIdentifier {
            let destVC = segue.destination as! ChangeBloodLevelViewController
            destVC.currentBloodLevel = Int(maxBloodLevel.titleLabel!.text!)
            destVC.m_SBUserInfoVO = self.m_SBUserInfoVO
            destVC.delegate = self
        }
    }
}

// MARK: - Helpers
extension TakeoverBloodRegisterViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func becomeBarcodeTextFieldFirstResponder() {
        bloodBarcodeTextField.text = ""
        bldProccodeBarcodeTextField.text = ""
        
        view.endEditing(false)
        bloodBarcodeTextField.becomeFirstResponder()
    }
}

// MARK: - Setup Functions
extension TakeoverBloodRegisterViewController {

    func setBloodTypeSegmentation() {
        let allCase = BloodType.allCases
        
        for i in 0..<allCase.count {
            bloodTypeSegmentation.setTitle(allCase[i].description, forSegmentAt: i)
        }
    }
    
    func setBasicInfo() {
        if let sitename = m_SBUserInfoVO?.szBimsSitename, sitename != "" {
            currentBloodLocationInfo.text = sitename
        } else {
            currentBloodLocationInfo.text = "No Info"
        }
    }

    func setKeyboardSetting() {
        bloodBarcodeTextField.delegate = self
        bldProccodeBarcodeTextField.delegate = self
    }
    
    func setInitialInfo() {
        guard let m_SBUserInfoVO = m_SBUserInfoVO else { return }
        
        if m_SBUserInfoVO.szBimsId == "R2020045" {
            m_SBUserInfoVO.szBimsOrgcode  = tempOrgcode
            m_SBUserInfoVO.szBimsCarcode  = tempCarcode
            m_SBUserInfoVO.szBimsSitecode = tempSiteCode
            m_SBUserInfoVO.szBimsSitename = tempSiteName
        }
        
        bloodTypeSegmentation.selectedSegmentIndex = 1
        currentBloodType = .normal
        let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo.initialRequest,
                                                  "orgcode": m_SBUserInfoVO.szBimsOrgcode!,
                                                  "carcode": m_SBUserInfoVO.szBimsCarcode ?? "-1",
                                                  "userid" : m_SBUserInfoVO.szBimsId!])
        
        // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
        LoadingIndicator.showLoading()
        
        TakeOverRegisterAPI
            .shared
            .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                        selector: #selector(getInitaialData),
                                        parameter: parameter,
                                        delegate: self)
    }
    
    func setTakeOverTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TakeOverRegisterTableViewInfo.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: TakeOverRegisterTableViewInfo.reuseIdentifier)
    }
    
    func setBloodTypeCnt() {
        guard let takeoverData = takeoverData else { return }
        
        numOfDirectBlood.text =
            String(takeoverData.filter{$0.isassigned == "Y"}.count)
        numOfRhBlood.text =
            String(takeoverData.filter{$0.rhnemergency == "Y"}.count)
    }
}

// MARK: API
extension TakeoverBloodRegisterViewController {
    
    @objc
    func getInitaialData(result: Any) {
        
        // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
        LoadingIndicator.hideLoading()
        
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        
        guard let maxLevel = json["nexttakeoverseq"] as? String, maxLevel != "" else {
            print("Error: ", json)
            // 2022.05.17 ADD HMWOO 오류 발생 메시지 발생 메시지 추가
            showOkButtonErrorAlert(str: "초기 데이터 조회를 실패하였습니다. 오류가 지속될 경우 담당자에게 문의 부탁 드립니다.",
                              delegate: self)
            return
        }

        maxBloodLevel.setTitle(maxLevel, for: .normal)
        
        numOf320T.text = json["numOf320T"] as? String
        numOf400T.text = json["numOf400T"] as? String
        numOf320D.text = json["numOf320D"] as? String
        numOf400D.text = json["numOf400D"] as? String
        numOf400Q.text = json["numOf400Q"] as? String
        
        numOfPLA.text = json["numOfPL-A"] as? String
        numOfAPLT.text = json["numOfA-PLT"] as? String
        
        numOfPLTM_PLM.text = String(format: "%@ / %@",
                                    json["numOfAPLT-M"] as! String,
                                    json["numOfPLA-M"] as! String)
        
        numOfTotalBloodInfo.text = String(format: "%@  /  %@",
                                          json["numOfBlood"] as! String,
                                          json["numOfBloodBag"] as! String)
        
        let bldcnt = json["numOfBlood"] as! String
        bloodNum = Int(bldcnt)
        
        if Int(bldcnt) ?? 0 < 1 {
            takeoverData = []
            tableView.reloadData()
            return
        }
        
        let dataArr = json["result"] as? [NSDictionary]
        
        if let data = try? JSONSerialization.data(withJSONObject: dataArr!,
                                                  options: .prettyPrinted) {
            takeoverData = try? JSONDecoder().decode([TakeRegisterTableViewCellData].self,
                                                     from: data)
        }
    }
    
    @objc
    func removeAllData(result: Any) {
        
        LoadingIndicator.hideLoading()
        
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        var resultMsg = "혈액 삭제에 실패하였습니다."
        
        guard let result = json["result"] as? String else {
            print("Error: ", json)
            showOkButtonErrorAlert(str: resultMsg, delegate: self)
            return
        }
        
        if result == "Y" {
            resultMsg = "현재 차수의 모든 혈액이 삭제되었습니다."
        }
        setInitialInfo()
        showOkButtonAlert(str: resultMsg, delegate: self)
    }
    
    func checkIsValidAndSaveBloodNo(bloodNo: String) {
        guard let m_SBUserInfoVO = m_SBUserInfoVO,
              let bloodType = currentBloodType,
              let bloodLevel = maxBloodLevel.titleLabel?.text else {
            dpGroup.leave()
            return
        }
        
        let (isAssigned, isRh) = BloodType.getBloodTypeInfoByTuple(data: bloodType)
        insertResult = nil
        
        let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo.checkIsValidAndSaveBloodNo,
                                                  "orgcode": m_SBUserInfoVO.szBimsOrgcode!,
                                                  "carcode": m_SBUserInfoVO.szBimsCarcode!,
                                                  "takeoverdate": getCurrentDate(),
                                                  "takeoverseq": bloodLevel,
                                                  "bloodno": bloodNo,
                                                  "isassigned": isAssigned,
                                                  "isrh": isRh,
                                                  "userid" : m_SBUserInfoVO.szBimsId!])
        
        // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
        LoadingIndicator.showLoading()
        
        TakeOverRegisterAPI
            .shared
            .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                        selector: #selector(checkIsValidAndSaveBloodNoSelector),
                                        parameter: parameter,
                                        delegate: self)
    }
    
    @objc
    func checkIsValidAndSaveBloodNoSelector(result: Any) {
        
        // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
        LoadingIndicator.hideLoading()
        
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)

        guard let data = try? JSONSerialization.data(withJSONObject: json,
                                                     options: .prettyPrinted) else {
            // 2022.05.17 ADD HMWOO 오류 발생 메시지 발생 메시지 추가
            showOkButtonErrorAlert(str: "혈액 번호 조회를 실패하였습니다.",
                              delegate: self)
            dpGroup.leave()
            return
        }
        
        insertResult = try? JSONDecoder().decode(TakeoverBloodInsertResult.self,
                                                 from: data)

        if insertResult?.isNotExist == "Y" {
            showOkButtonErrorAlert(str: "존재하지 않는 혈액번호 입니다.",
                              delegate: self)
        } else if insertResult?.isTerminated == "Y" {
            showOkButtonErrorAlert(str: "현재 차수가 종료되었습니다. 새로고침 버튼을 눌러주세요.",
                              delegate: self)
        } else if insertResult?.isEnd == "N" {
            showOkButtonErrorAlert(str: "종료시간 미입력 혈액입니다.",
                              delegate: self)
        } else if insertResult?.isExistInTakeOver == "Y" {
            showOkButtonErrorAlert(str: "다른 차수 혹은 이미 저장된 혈액입니다. 혈액번호를 확인 바랍니다.",
                              delegate: self)
        } else if insertResult?.isMulti == "N" {
            // 2022.05.09 DEL HMWOO 인계혈액 저장 시 저장되었다는 알림이 업무 효율성에 방해되어 제거
            // showOkButtonAlert(str: "정상적으로 저장이 완료되었습니다.", delegate: self)
            self.setInitialInfo()
            becomeBarcodeTextFieldFirstResponder()
        }
        
        dpGroup.leave()
    }
    
    func checkIsValidAndSaveMultiBloodNoWithBldProcCode(bloodNo: String, bldProcCode: String) {
        
        guard let m_SBUserInfoVO = m_SBUserInfoVO,
              let bloodType = currentBloodType,
              let bloodLevel = maxBloodLevel.titleLabel?.text else {
                  dpGroup.leave()
                  return
              }
        
        print("BLDPROCCODE: \(bldProcCode)")
        
        let changedBloodNo = removeBloodNoCheckBitAndReturnNewBloodNo(bloodNo: bloodNo)
        let (isAssigned, isRh) = BloodType.getBloodTypeInfoByTuple(data: bloodType)
        
        let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo
                                                            .checkIsValidAndSaveMultiBloodNoWithBldProcCode,
                                                  "orgcode": m_SBUserInfoVO.szBimsOrgcode!,
                                                  "carcode": m_SBUserInfoVO.szBimsCarcode!,
                                                  "takeoverdate": getCurrentDate(),
                                                  "takeoverseq": bloodLevel,
                                                  "bloodno": changedBloodNo,
                                                  "isassigned": isAssigned,
                                                  "isrh": isRh,
                                                  "bldproccode": bldProcCode,
                                                  "userid" : m_SBUserInfoVO.szBimsId!])
                
        // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
        LoadingIndicator.showLoading()
        
        TakeOverRegisterAPI
            .shared
            .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                        selector: #selector(checkIsValidAndSaveMultiBloodNoWithBldProcCodeSelector),
                                        parameter: parameter,
                                        delegate: self)
    }
    
    @objc
    func checkIsValidAndSaveMultiBloodNoWithBldProcCodeSelector(result: Any) {
        
        // 2022.05.16 ADD HMWOO 로딩 인디케이터 추가
        LoadingIndicator.hideLoading()
        
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        var returnStr = ""
        
        guard let isNotExist = json["isNotExist"] as? String, isNotExist != "" else {
            print("Error: ", json)
            // 2022.05.17 ADD HMWOO 오류 발생 메시지 발생 메시지 추가
            returnStr = "해당 혈액 등록에 실패하였습니다. 오류가 지속될 경우 담당자에게 문의 부탁 드립니다."
            showOkButtonErrorAlert(str: returnStr, delegate: self) { [weak self] _ in
                self?.becomeBarcodeTextFieldFirstResponder()
            }
            dpGroup.leave()
            return
        }
        
        guard let result = json["result"] as? String, result != "" else {
            print("Error: ", json)
            // 2022.05.17 ADD HMWOO 오류 발생 메시지 발생 메시지 추가
            returnStr = "해당 혈액 등록에 실패하였습니다. 오류가 지속될 경우 담당자에게 문의 부탁 드립니다."
            showOkButtonErrorAlert(str: returnStr, delegate: self) { [weak self] _ in
                self?.becomeBarcodeTextFieldFirstResponder()
            }
            dpGroup.leave()
            return
        }
        
        if isNotExist == "Y" {
            returnStr = "제제바코드가 유효하지 않습니다. 다시 스캔하여 주시기 바랍니다."
        } else {
            if result == "Y" {
                // 2022.05.09 DEL HMWOO 인계혈액 저장 시 저장되었다는 알림이 업무 효율성에 방해되어 제거
                //returnStr = "입력하신 혈액 저장이 완료되었습니다."
                self.setInitialInfo()
                
            } else if result == "E"{
                returnStr = "이미 저장된 혈액 제제 바코드 입니다."
            } else if result == "W"{
                returnStr = "제제 바코드가 혈액번호와 맞는지 확인 바랍니다."
            } else {
                returnStr = "해당 혈액 등록에 실패하였습니다. 오류가 지속될 경우 담당자에게 문의 부탁 드립니다."
            }
        }
        
        // 2022.05.09 DEL HMWOO 인계혈액 저장 시 저장되었다는 알림이 업무 효율성에 방해되어 제거
        if isNotExist == "Y" || result != "Y"
        {
            showOkButtonErrorAlert(str: returnStr, delegate: self) { [weak self] _ in
                self?.becomeBarcodeTextFieldFirstResponder()
            }
        }
        
        dpGroup.leave()
    }
}

// MARK: - UITextField
extension TakeoverBloodRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bloodBarcodeTextField {
            guard let bloodNo = bloodBarcodeTextField.text, bloodNo.count == bloodNoMaxLength else {
                showOkButtonErrorAlert(str: "잘못된 혈액번호 입니다.", delegate: self)
                bloodBarcodeTextField.text = ""
                return true
            }

            dpGroup.enter()
            checkIsValidAndSaveBloodNo(bloodNo: removeBloodNoCheckBitAndReturnNewBloodNo(bloodNo: bloodNo))
            dpGroup.notify(queue: .main) { [weak self] in
                self?.bloodBarcodeTextField.resignFirstResponder()
                guard let result = self?.insertResult else {
                    self?.bloodBarcodeTextField.text = ""
                    showOkButtonErrorAlert(str: "오류가 발생하였습니다. 오류가 지속시 담당자에게 연락 부탁드립니다.",
                                      delegate: self!)
                    return
                }
                
                if result.isMulti == "Y" {
                    self?.bloodBarcodeTextField.resignFirstResponder()
                    self?.bldProccodeBarcodeTextField.becomeFirstResponder()
                } else {
                    self?.bloodBarcodeTextField.text = ""
                    self?.insertResult = nil
                    return
                }
            }
        } else if textField == bldProccodeBarcodeTextField {
            guard let bldProccode = bldProccodeBarcodeTextField.text,
                  bldProccode.count == bldCodeMaxLength else {
                showOkButtonErrorAlert(str: "잘못된 제제바코드 입니다. 다시 스캔하여 주시기 바랍니다.",
                                  delegate: self)
                bldProccodeBarcodeTextField.text = ""
                bldProccodeBarcodeTextField.becomeFirstResponder()
                return true
            }
            
            guard let bloodNo = bloodBarcodeTextField.text,
                    bloodNo.count == bloodNoMaxLength else {
                showOkButtonErrorAlert(str: "잘못된 혈액번호 입니다. 혈액번호부터 다시 스캔하여 주시기 바랍니다.",
                                  delegate: self)
                bloodBarcodeTextField.text = ""
                bldProccodeBarcodeTextField.text = ""
                bldProccodeBarcodeTextField.resignFirstResponder()
                return true
            }
            
            dpGroup.enter()
            checkIsValidAndSaveMultiBloodNoWithBldProcCode(bloodNo: bloodNo,
                                                           bldProcCode: bldProccode)
            dpGroup.notify(queue: .main) { [weak self] in
                self?.bloodBarcodeTextField.text = ""
                self?.bldProccodeBarcodeTextField.text = ""
                self?.bldProccodeBarcodeTextField.resignFirstResponder()
            }
        }

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == bloodBarcodeTextField {
            guard let text = textField.text else { return true }
            let maxLength = bloodNoMaxLength
            let newLength = text.count + (string.count - range.length)
            return newLength <= maxLength
        } else if textField == bldProccodeBarcodeTextField {
            guard let text = textField.text else { return true }
            let maxLength = bldCodeMaxLength
            let newLength = text.count + (string.count - range.length)
            return newLength <= maxLength
        }
        
        return false
    }
}

// MARK: - UITableViewDataSource/Delegate
extension TakeoverBloodRegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return takeoverData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TakeOverRegisterTableViewInfo.reuseIdentifier) as! TakeOverBloodRegisterTableViewCell
        
        cell.rowNum = indexPath.row + 1
        cell.cellData = takeoverData?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRow = tableView.indexPathForSelectedRow else { return }
        guard let selectedData = takeoverData?[selectedRow.row] else { return }

        performSegue(withIdentifier: TakeOverRegisterSegueInfo.cellInfoSegueIdentifier,
                     sender: selectedData)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
