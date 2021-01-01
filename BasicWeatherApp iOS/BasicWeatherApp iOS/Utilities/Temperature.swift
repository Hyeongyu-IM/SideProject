//
//  TemperatureUnit.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/31.
//

import Foundation

class Temperature {
    
    let celciusTempValue: Int
    
    init(celcius: Double) {
        let toInt = Int(celcius)
        self.celciusTempValue = toInt
    }
    
    var text: String {
        return TemperatureUnit.shared.boolValue ? "\(celciusTempValue)" : "\(toFahrenhit)"
    }
    
    var toFahrenhit: Int {
        let convertedValue = (celciusTempValue * 9/5) + 32
        return convertedValue
    }
}
