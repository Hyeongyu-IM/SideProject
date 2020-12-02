//
//  TableViewCell.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var bountyImg: UIImageView!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var bountyName: UILabel!
    
    func update(info: BountyInfo) {
        bountyImg.image = info.image
        bountyName.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}
