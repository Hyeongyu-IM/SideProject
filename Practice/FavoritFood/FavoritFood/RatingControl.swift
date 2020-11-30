//
//  RatingControl.swift
//  FavoritFood
//
//  Created by 임현규 on 2020/11/30.
//

import UIKit

class RatingControl: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
     
    private func setupButtons() {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        addArrangedSubview(button)
    }
     
    

}
