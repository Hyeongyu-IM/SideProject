//
//  WeekendTableViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class WeekendTableViewCell: UITableViewCell {
    
    static let registerID: String = "\(WeekendTableViewCell.self)"

    @IBOutlet weak var weekendLabel: UILabel!
    @IBOutlet weak var weekendIcon: UIImageView!
    @IBOutlet weak var weekendPercent: UILabel!
    @IBOutlet weak var weekendMaxTempLabel: UILabel!
    @IBOutlet weak var weekendMinTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func binderSetting() {
        weekendBinder.bind { [weak self] weekend in
            self?.weekendLabel.text = weekend
        }
        weekendImageBinder.bind { [weak self] image in
            self?.weekendIcon.image = image
        }
        weekendpercentBinder.bind { [weak self] percent in
            self?.weekendPercent.text = percent
        }
        weekendMaxTempBinder.bind { [weak self] maxTemp in
            self?.weekendMaxTempLabel.text = maxTemp
        }
        weekendMinTempBinder.bind { [weak self] minTemp in
            self?.weekendMinTempLabel.text = minTemp
        }
    }
    
    let weekendBinder = Binder(" ")
    let weekendImageBinder: Binder<UIImage?> = Binder(nil)
    let weekendpercentBinder = Binder(" ")
    let weekendMaxTempBinder = Binder(" ")
    let weekendMinTempBinder = Binder(" ")
    
    func fetchData(_ data: [WeekendCell],_ index: Int ) {
        self.weekendBinder.value = data[index].weekend
        self.weekendImageBinder.value = data[index].icon
        self.weekendpercentBinder.value = data[index].minFTemp
        self.weekendMaxTempBinder.value = data[index].maxCTemp
        self.weekendMinTempBinder.value = data[index].minCTemp
    }
}
