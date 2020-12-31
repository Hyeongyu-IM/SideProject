//
//  TemperatureUni.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/31.
//

import Foundation

class TemperatureUnit {
    enum Unit {
        case celcius, fahrenheit
        
        init(bool: Bool) {
            self = bool ? .celcius : .fahrenheit
        }
    }
static let shared = TemperatureUnit()
    
    var unit: Unit
    
    init(bool: Bool) {
        self.unit = Unit(bool: bool)
    }



