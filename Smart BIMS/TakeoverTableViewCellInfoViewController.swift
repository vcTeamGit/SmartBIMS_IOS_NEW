//
//  TakeoverTableViewCellInfoViewController.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/30.
//

import UIKit

class TakeoverTableViewCellInfoViewController: UIViewController {

    // MARK: - IBOutlets
    
    // Label
    @IBOutlet var orgNameLabel: UILabel!
    @IBOutlet var carNameLabel: UILabel!
    @IBOutlet var takeOverDateLabel: UILabel!
    @IBOutlet var takeOverLevelLabel: UILabel!
    @IBOutlet var bloodNoLabel: UILabel!
    @IBOutlet var bldProcNameLabel: UILabel!
    @IBOutlet var isAssignLabel: UILabel!
    @IBOutlet var enterIDLabel: UILabel!
    @IBOutlet var isMalLabel: UILabel!
    @IBOutlet var bagNameLabel: UILabel!
    
    // Button
    @IBOutlet var changeButton: UIButton!
    
    // etc
    @IBOutlet var bloodTypeSegmentedControl: UISegmentedControl!
    
    // MARK: - Properteis
    weak var delegate: TakeoverBloodRegisterViewController?
    var currentID: String?
    var returnStr = ""
    
    // MARK: - IBActions
    @IBAction func backGroundTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let allCase = BloodType.allCases
        selectedBloodType = allCase[sender.selectedSegmentIndex]
        
        if selectedBloodType == currentBloodType {
            changeButton.isHidden = true
        } else {
            changeButton.isHidden = false
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "혈액 종류 변경",
                                      message: String(format: "다음 혈액의 혈액종류를 변경하시겠습니까?\n%@\n\n변경 전: %@\n변경 후: %@", takeoverBloodData!.labelno, currentBloodType!.description, selectedBloodType!.description),
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            guard let bloodData = self?.takeoverBloodData,
                  let changeType = self?.selectedBloodType,
                  let bloodDate = self?.takeOverDateLabel.text,
                  let currentID = self?.currentID,
                  let bldproccode = self?.takeoverBloodData?.bldprocbarcode else {
                showOkButtonAlert(str: "오류가 발생하여 혈액종류 변경을 실패하였습니다.",
                                  delegate: self!) { _ in
                    self?.dismiss(animated: true, completion: nil)
                }
                return
            }
            
            let (isAssigned, isRh) = BloodType.getBloodTypeInfoByTuple(data: changeType)
            let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo.changeBloodType,
                                                      "orgcode": bloodData.orgcode,
                                                      "carcode": bloodData.carcode,
                                                      "takeoverdate": bloodDate,
                                                      "takeoverseq" : bloodData.takeoverseq,
                                                      "bloodno": bloodData.bloodno,
                                                      "isassigned": isAssigned,
                                                      "isrh": isRh,
                                                      "deleteid": currentID,
                                                      "bldproccode": bldproccode])
            TakeOverRegisterAPI
                .shared
                .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                            selector: #selector(self!.changeBloodType),
                                            parameter: parameter,
                                            delegate: self!)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func removeBloodButtonTapped(_ sender: UIButton) {
        guard let takeoverBloodData = takeoverBloodData else { return }
        let alert = UIAlertController(title: "혈액 삭제",
                                      message: String(format: "다음 혈액을 삭제하시겠습니까?\n%@\n\n차수정보: %@\n%@",
                                                      takeoverBloodData.labelno,
                                                      takeoverBloodData.takeoverseq,
                                                      takeoverBloodData.gubun),
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            guard let bloodData = self?.takeoverBloodData,
                  let bloodDate = self?.takeOverDateLabel.text,
                  let currentID = self?.currentID else {
                showOkButtonAlert(str: "오류가 발생하여 해당 혈액 삭제를 실패하였습니다.", delegate: self!) { _ in
                    self?.dismiss(animated: true, completion: nil)
                }
                return
            }
            
            let parameter = NSDictionary(dictionary: ["reqId": BloodRegisterURLInfo.deleteBloodno,
                                                      "orgcode": bloodData.orgcode,
                                                      "carcode": bloodData.carcode,
                                                      "takeoverdate": bloodDate,
                                                      "takeoverseq" : bloodData.takeoverseq,
                                                      "bloodno": bloodData.bloodno,
                                                      "deleteid": currentID])
            
            guard self != nil else { return }
            
            TakeOverRegisterAPI
                .shared
                .getDataFromURLWithSelector(url: BloodRegisterURLInfo.baseURL,
                                            selector: #selector(self?.deleteBloodNo),
                                            parameter: parameter,
                                            delegate: self!)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Properties
    var takeoverBloodData: TakeRegisterTableViewCellData?
    var currentBloodType: BloodType?
    var selectedBloodType: BloodType?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard takeoverBloodData != nil else {
            let alert = UIAlertController(title: "오류",
                                          message: "해당 행의 데이터를 불러오는데 실패하였습니다.",
                                          preferredStyle: .alert)
            let btn = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(btn)
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        setCellDataInfo()
        setBloodTypeSegmentation()
    }
}

// MARK: - Setup
extension TakeoverTableViewCellInfoViewController {
    func setCellDataInfo() {
        self.orgNameLabel.text = takeoverBloodData?.orgname
        self.carNameLabel.text = takeoverBloodData?.carname
        
        let data = takeoverBloodData?.takeoverdate
        let dataStr = data!.prefix(10)
        self.takeOverDateLabel.text = String(dataStr)
        
        self.takeOverLevelLabel.text = takeoverBloodData?.takeoverseq
        self.bloodNoLabel.text = takeoverBloodData?.labelno
        
        self.bldProcNameLabel.text = takeoverBloodData?.bldprocnamesh
        
        let isAssigned = takeoverBloodData?.isassigned
        let isRhMinus = takeoverBloodData?.rhnemergency
        
        if isAssigned == "Y" {
            currentBloodType = .direct
        } else if isRhMinus == "Y" {
            currentBloodType = .rh_minus
        } else {
            currentBloodType = .normal
        }
        
        self.isAssignLabel.text = currentBloodType?.description
        self.isAssignLabel.textColor = currentBloodType?.color
        
        self.enterIDLabel.text = takeoverBloodData?.enteridno
        
        let isMal = takeoverBloodData?.malchk
        self.isMalLabel.text = isMal
        
        if isMal == "Y" {
            self.isMalLabel.textColor = .red
            self.isMalLabel.backgroundColor = .yellow
        }
        
        self.bagNameLabel.text = takeoverBloodData?.gubun
    }
    
    func setBloodTypeSegmentation() {
        let allCase = BloodType.allCases
        
        for i in 0..<allCase.count {
            bloodTypeSegmentedControl.setTitle(allCase[i].description, forSegmentAt: i)
            
            if currentBloodType == allCase[i]{
                bloodTypeSegmentedControl.selectedSegmentIndex = i
            }
        }
        
        changeButton.isHidden = true
    }
}

// MARK: - API
extension TakeoverTableViewCellInfoViewController {
    @objc
    func changeBloodType(result: Any) {
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        
        guard let result = json["result"] as? String, result != "" else {
            print("Error: ", json)
            return
        }
        
        if result == "Y" {
            returnStr = "혈액종류 변경이 완료되었습니다."
        } else {
            returnStr = "오류가 발생하여 혈액종류 변경을 실패하였습니다."
        }
        
        showOkButtonAlert(str: self.returnStr, delegate: self) { [unowned self] _ in
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.setInitialInfo()
            }
        }
    }
    
    @objc
    func deleteBloodNo(result: Any) {
        let json = TakeOverRegisterAPI.shared.getDictionaryFromResult(result)
        
        guard let result = json["result"] as? String, result != "" else {
            print("Error: ", json)
            return
        }
        
        if result == "Y" {
            returnStr = "해당 혈액 삭제가 완료되었습니다."
        } else {
            returnStr = "오류가 발생하여 해당혈액 삭제를 실패하였습니다."
        }
        
        showOkButtonAlert(str: self.returnStr, delegate: self) { [unowned self] _ in
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.setInitialInfo()
            }
        }
    }
}
