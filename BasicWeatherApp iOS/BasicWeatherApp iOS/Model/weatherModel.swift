//
//  wheatherModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

struct WeatherbitData: Codable {
    
    let weatherInfo: [WeatherInfo]
    
    struct WeatherInfo: Codable { 
        let location: String
        let currentTime: Date
        let currentWeather: String
        
        let detailWeatherInfo: DetailInfo
    }
    
    struct DetailInfo: Codable {
        let minimumTemp: Double
        let maximumTemp: Double
        let weatherIcon: String
        let averageTemp: Double
        let week: Date
        let sunrise: Date
        let sunset: Date
        let explanation: String
        let snowingPercent: Int
        let humidity: Int
        let wind: Int
        let rainyPercent: Int
        let atmosphericPressure: Int
        let lineOfSight: Int
        let UVIndex: Int
    }


    
}


