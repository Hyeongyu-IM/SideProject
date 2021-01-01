//
//  WeekendTableCollectionViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class HourlyTableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekendLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var hourlyTemp: UILabel!
    
    static let registerID: String = "\(HourlyTableCollectionViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        binderSetting()
    }
    
    let weekendBinder = Binder(" ")
    let weatherIconBinder: Binder<UIImage?> = Binder(nil)
    let hourlyTempBinder = Binder(" ")
    
    func hourData(_ hourData: HourCell) {
        self.weekendBinder.value = hourData.time
        self.weatherIconBinder.value = hourData.icon
        self.hourlyTempBinder.value = hourData.Ctemp
    }
}
