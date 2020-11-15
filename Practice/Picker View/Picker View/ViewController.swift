//
//  ViewController.swift
//  Picker View
//
//  Created by 임현규 on 2020/11/15.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
   
    @IBOutlet weak var pickerView: UIPickerView!
    
    let pickerData = ["Xcode", "Postman", "SourceTree", "Zeplin", "Android Studio", "SublimeText"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        middle()
        // Do any additional setup after loading the view.
    }
    // 픽커뷰의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // 돌아가는 픽커의 row개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // 픽커 row의 데이터
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // 픽커의 처음에서 시작하는 것이아니라 가운데서 있도록
    func middle() {
        let middle = pickerData.count / 2
        pickerView.selectRow(middle, inComponent: 0, animated: true)
    }
}

