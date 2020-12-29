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
        
    }
    
    
    let weekendBinder: Binder = Binder(" ")
    let weatherIconBinder: Binder<UIImage?> = Binder(nil)
    let hourlyTempBinder: Binder = Binder(" ")

    
    func binderSetting() {
        self.weekendBinder.value { [weak self] weekendTime in
            
        }
        self.weatherIconBinder.value { [weak self] weatherIcon in
            
        }
        self.hourlyTempBinder.value { [weak self] hourTemp in
            
        }
    }
    
    func hourData(_ hourData: HourCell) {
        weekendLabel.text = hourData.time
        weatherIcon.image = hourData.icon
        hourlyTemp.text = hourData.Ctemp
    }
}
