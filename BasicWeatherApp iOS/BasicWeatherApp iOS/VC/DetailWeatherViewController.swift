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
    
    let headerViewMaxHeight: CGFloat = 240
    let headerViewMinHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.height
}

extension DetailWeatherViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newheaderViewHeight: CGFloat = hederViewHeightConst.constant - y
        print(newheaderViewHeight)

        if newheaderViewHeight > headerViewMaxHeight {
            print("#1")
            hederViewHeightConst.constant = headerViewMaxHeight
        } else if newheaderViewHeight < headerViewMinHeight {
            print("#2")
            hederViewHeightConst.constant = headerViewMinHeight
        } else {
            print("#3")
            hederViewHeightConst.constant = newheaderViewHeight
            scrollView.contentOffset.y = 0
        }
        print("결과입니다 \(hederViewHeightConst.constant)")
    }
}
