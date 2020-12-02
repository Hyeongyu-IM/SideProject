//
//  SettingViewCell.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class SettingViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let v = UISwitch(frame: .zero)
        accessoryView = v
    }

    

}
