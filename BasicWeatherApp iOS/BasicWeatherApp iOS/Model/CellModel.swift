//
//  CellModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/17.
//

import UIKit

struct WeekendCell {
    let weekend: String
    let icon: UIImage
    let minCTemp: String
    let maxCTemp: String
    let minFTemp: String
    let maxFTemp: String
}

struct HourCell {
    let dt: Int
    let time: String
    let icon: UIImage
    let Ctemp: String
    let Ftemp: String
    let NowOrSunSetAndRise: String?
}

struct DetailCell {
    let location: String
    let discription: String
    let currentTemp: String
    let minTemp: String
    let maxTemp: String
    let minFTemp: String
    let maxFTemp: String
    let detailDiscription: String
    let sunset: String
    let sunrise: String
    let snow: Double?
    let rain: Double?
    let wind: Int
    let feelsLike: Int
    let pressure: Int
    let visibility: Double
    let uvi: Int
    let humidity: Int
}

//struct SunsetCell {
//    let time: String
//    let icon: UIImage
//    let sunset = "일몰"
//}
//
//struct SunriseCell {
//    let time: String
//    let icon: UIImage
//    let sunrise = "일출"
//}
