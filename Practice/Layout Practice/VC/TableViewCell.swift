//
//  TableViewCell.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
