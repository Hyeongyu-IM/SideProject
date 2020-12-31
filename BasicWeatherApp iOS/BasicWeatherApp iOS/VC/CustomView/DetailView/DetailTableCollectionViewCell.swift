//
//  DetailTableCollectionViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class DetailTableCollectionViewCell: UICollectionViewCell {
    
    static let registerID: String = "\(DetailTableCollectionViewCell.self)"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.binderSetting()
    }
    
    let nameLabelBinder = Binder(" ")
    let valueLabelBinder = Binder(" ")
    
    func binderSetting() {
        nameLabelBinder.bind { [weak self] text in
            self?.nameLabel.text = text
        }
        valueLabelBinder.bind { [weak self] text in
            self?.valueLabel.text = text
        }
    }
    
    func detailData(_ name: String,_ value: String) {
        nameLabelBinder.value = name
        valueLabelBinder.value = value
    }
}

