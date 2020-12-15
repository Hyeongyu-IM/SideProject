//
//  wheatherModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

struct APIresponse: Codable {
    let respon: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let current: [CurrentWeatherInfo]
    let hourly: [HourlyWeatherInfo]
    let daily: [DailyWeatherInfo]
}

struct CurrentWeatherInfo: Codable {
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let visibility: Double
    let wind_deg: Int
    let uvi: Double
    let wind_speed: Double
    let feels_like: Double
    let rain: [HourlyRain]?
    let weather: [TitleWeatherInfo]
}

struct DailyWeatherInfo: Codable {
    let dt: Int
    let temp: [DailyTemp]
    let weather: [TitleWeatherInfo]
}

struct HourlyWeatherInfo: Codable {
    let dt: Int
    let temp: Double
    let weather: [TitleWeatherInfo]
}

struct TitleWeatherInfo: Codable {
    let description: String
    let icon: String
}

struct DailyTemp: Codable {
    let max: Double
    let min: Double
}

struct HourlyRain: Codable {
    let hourlyRain: Double
    
    enum CodingKeys: String, CodingKey {
    case hourlyRain = "1h"
        }
}


//struct WeatherbitData: Codable {
//    struct DetailInfo: Codable {
//        let minimumTemp: Double
//        let maximumTemp: Double
//        let weatherIcon: String
//        let averageTemp: Double
//        let week: Date
//        let sunrise: Date
//        let sunset: Date
//        let explanation: String
//        let snowingPercent: Int
//        let humidity: Int
//        let wind: Int
//        let rainyPercent: Int
//        let atmosphericPressure: Int
//        let lineOfSight: Int
//        let UVIndex: Int
//    }
//}
