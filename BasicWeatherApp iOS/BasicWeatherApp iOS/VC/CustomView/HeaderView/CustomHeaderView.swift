//
//  CustomHeaderView.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/27.
//

import UIKit

class CustomHeaderView: UIView {

    @IBOutlet weak var cityNameCenterY: NSLayoutConstraint!
    @IBOutlet weak var tempStackView: UIStackView!
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    let weatherViewModel = WeatherViewModel()
    
    static func instance() -> CustomHeaderView {
        return Bundle(for: CustomHeaderView.self).loadNibNamed(String(describing: CustomHeaderView.self), owner: nil, options: nil)![0] as! CustomHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        binderSetting()
    }
    
    func binderSetting() {
        stateBinder.bind { [weak self] stateName in
            self?.stateLabel.text = stateName
        }
        descriptionBinder.bind { [weak self] description in
            self?.descriptionLabel.text = description
        }
        currentTempBinder.bind { [weak self] currentTemp in
            self?.currentTempLabel.text = currentTemp
        }
        minTempBinder.bind { [weak self] minTemp in
            self?.minTempLabel.text = minTemp
        }
        maxTempBinder.bind { [weak self] maxTemp in
            self?.maxTempLabel.text = maxTemp
        }
    }
    
    let stateBinder = Binder(" ")
    let descriptionBinder = Binder(" ")
    let currentTempBinder = Binder(" ")
    let minTempBinder = Binder(" ")
    let maxTempBinder = Binder(" ")
    
    func configData(_ data: [DetailCell],_ index: Int) {
        self.stateBinder.value = data[index].location
        self.descriptionBinder.value = data[index].discription
        self.currentTempBinder.value = data[index].currentTemp
        self.minTempBinder.value = data[index].minTemp
        self.maxTempBinder.value = data[index].maxTemp
    }
    
    
}

