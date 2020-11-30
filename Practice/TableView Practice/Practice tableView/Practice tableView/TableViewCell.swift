//
//  TableViewCell.swift
//  Practice tableView
//
//  Created by 임현규 on 2020/11/29.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let v = UISwitch(frame: .zero)
        accessoryView = v
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
