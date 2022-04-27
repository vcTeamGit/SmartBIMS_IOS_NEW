//
//  TakeOverBloodRegisterTableViewCell.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/06/30.
//

import UIKit

class TakeOverBloodRegisterTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet var rowNumCntLabel: UILabel!
    @IBOutlet var bloodNoLabel: UILabel!
    @IBOutlet var bloodTypeLabel: UILabel!
    @IBOutlet var gubunLabel: UILabel!
    @IBOutlet var bldProcNameLabel: UILabel!
    @IBOutlet var gbMalLabel: UILabel!
    
    // MARK: - Properties
    var cellData: TakeRegisterTableViewCellData? {
        didSet {
            generateCell()
        }
    }
    
    var rowNum: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helpers
    func generateCell() {
        var bloodType: BloodType?
        if cellData?.isassigned == "Y" {
            bloodType = .direct
        } else if cellData?.rhnemergency == "Y" {
            bloodType = .rh_minus
        } else {
            bloodType = .normal
        }
        
        bloodNoLabel.text = cellData?.labelno
        gubunLabel.text = cellData?.gubun
        bldProcNameLabel.text = cellData?.bldprocnamesh
        
        bloodTypeLabel.text = bloodType?.description
        bloodTypeLabel.textColor = bloodType?.color
        
        if cellData?.malchk == "Y" {
            gbMalLabel.backgroundColor = .yellow
            gbMalLabel.textColor = .red
            gbMalLabel.text = "제한"
        } else {
            gbMalLabel.text = ""
        }
        
        rowNumCntLabel.text = rowNum?.description
    }
}
