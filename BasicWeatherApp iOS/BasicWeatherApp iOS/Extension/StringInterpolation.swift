//
//  StringInterpolation.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/31.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(temperature value: Double) {
        appendInterpolation("\(value)\(UnitSymbol.forTemperature)")
    }
    
    mutating func appendInterpolation(pressure value: Double) {
        appendInterpolation("\(value) \(UnitSymbol.forPressure)")
    }
    
    mutating func appendInterpolation(wind value: Double) {
        appendInterpolation("\(value) \(UnitSymbol.forWindDegree)")
    }
    
    mutating func appendInterpolation(humidity value: Int) {
        appendInterpolation("\(value) \(UnitSymbol.forHumidity)")
    }
}
