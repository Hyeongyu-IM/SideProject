//
//  DetailTableCollectionViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class DetailTableCollectionViewCell: UICollectionViewCell {
    
    static let registerID: String = "\(DetailTableCollectionViewCell.self)"
    static let height: CGFloat = 90
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func detailData(_ name: String,_ value: String) {
        self.nameLabel.text = name
        self.valueLabel.text = value
    }
}

