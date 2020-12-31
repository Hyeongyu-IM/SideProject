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
        
    }
    
    var toFahrenhit: Int {
        let convertedValue = (celciusTempValue * 9/5) + 32
        return convertedValue
    }
    
//    private func tempFormatter: NumberFormatter = {
//      let tempFormatter = NumberFormatter()
//      tempFormatter.numberStyle = .none
//      return tempFormatter
//    }()
//
//    private func celsiusToFahrenhit(_ temp: String) -> NSNumber {
//        let celsius = Int(temp)!
//        let F = (celsius * 9/5) + 32
//        return NSNumber(value: F)
//    }
}
