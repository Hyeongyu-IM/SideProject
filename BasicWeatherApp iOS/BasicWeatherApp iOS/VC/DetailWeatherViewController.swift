//
//  detailWeatherViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
  
    @IBOutlet weak var hederViewHeightConst: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension DetailWeatherViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}
