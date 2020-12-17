//
//  weatherViewModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

public class WeatherViewModel {
    
    let locationGeocoder = LocationGeocoder()
    
    //MARK: - Format Setting
    
    private func dtToWeekend(_ dt: Int) -> String {
        let dt = TimeInterval(dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
          dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(for: dt) ?? ""
    }
    
    private func dtToTime(_ dt: Int) -> String {
        let dt = TimeInterval(dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h"
          dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(for: dt) ?? ""
    }
    
    private let tempFormatter: NumberFormatter = {
      let tempFormatter = NumberFormatter()
      tempFormatter.numberStyle = .none
      return tempFormatter
    }()
    
    private func celsiusToFahrenhit(_ temp: String) -> NSNumber {
        let celsius = Int(temp)!
        let F = (celsius * 9/5) + 32
        
        return NSNumber(value: F)
    }
    

    
    //MARK: - CoreDataLoad and API Call
    
    let coreDataManager = CoreDataManager()
    var coreData: [DataLocation] = {
        CoreDataManager.shared.locationList
    }()
    var weatherDataList = [[WeatherInfo]]()
    
    func convertCoreData() {
        if coreData.count != 0 {
           weatherDataList = coreData.compactMap {
                WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude)
            }
        } else { print("코어데이터에 데이터가 없습니다") }
    }

    //MARK: - TableViewData, CollectionView Data( 시간별, 요일별, 현재날씨 뷰에 따른 데이터 공급 )
    func hourData(_ data: WeatherInfo ) -> [[HourCell]]{
        let hourCells = data.hourly.map {
                [HourCell(time: dtToTime($0.dt) ,
                                    icon: UIImage(named: "\($0.weather[0].icon)")!,
                                    Ctemp: tempFormatter.string(from: $0.temp as NSNumber)!,
                                    Ftemp: "\(celsiusToFahrenhit(tempFormatter.string(from: $0.temp as NSNumber)!))" )]
        }
        let sunsetCell: SunsetCell = SunsetCell(time: dtToTime(data.current.sunset), icon: UIImage(named: "sunrise.fill")! )
        let sunriseCell = SunriseCell(time: dtToTime(data.current.sunrise), icon: UIImage(named: "sunset.fill")!)
        hourCells.append(sunsetCell)
        
        return hourCells
    }
    
    func weekendData(_ data: WeatherInfo) -> [[WeekendCell]] {
        let weekendCells = data.daily.map {
            [WeekendCell(weekend: dtToWeekend($0.dt),
                             icon: UIImage(named: "\($0.weather[0].icon)")!,
                             minCTemp: tempFormatter.string(from: $0.temp[0].min as NSNumber)!,
                             maxCTemp: tempFormatter.string(from: $0.temp[0].max as NSNumber)!,
                             minFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: $0.temp[0].min as NSNumber)!))" ,
                             maxFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: $0.temp[0].min as NSNumber)!))") ]
        }
        return weekendCells
    }
    
    func detailData(_ data: WeatherInfo) -> [DetailCell] {
        let state = String(locationGeocoder.GeoCoordiToCityName(latitude: data.latitude, longitude: data.longitude))
        let detailCell: [DetailCell] = [ DetailCell(location: state,
                                                    discription: data.current.weather.description,
                                                    currentTemp: tempFormatter.string(from: data.current.temp as NSNumber) ?? "",
                                                    minTemp: tempFormatter.string(from: data.daily[0].temp[0].min as NSNumber) ?? "",
                                                    maxTemp: tempFormatter.string(from: data.daily[0].temp[0].max as NSNumber) ?? "",
                                                    minFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: data.daily[0].temp[0].min as NSNumber)!))",
                                                    maxFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: data.daily[0].temp[0].max as NSNumber)!))",
                                                    detailDiscription: data.current.weather.description,
                                                    sunset: dtToTime(data.current.sunset) ,
                                                    sunrise: dtToTime(data.current.sunrise),
                                                    snow: data.current.snow ,
                                                    rain: data.current.rain ,
                                                    wind: Int(data.current.wind_speed),
                                                    feelsLike: Int(data.current.feels_like),
                                                    pressure: data.current.pressure,
                                                    visibility: data.current.visibility,
                                                    uvi: Int(data.current.uvi),
                                                    humidity: data.current.humidity) ]
        return detailCell
    }
    
    
    
    // 코어데이터에 있는 객체를 받아와서 API 호출후 배열로 변환
//    lazy var loadCoreData: Binder<[[WeatherInfo]]> = Binder(CoreDataManager.shared.locationList.compactMap { WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude)})
//
//    func bindConfig() {
//        loadCoreData.bind { data in
//            self.weatherDataList = data
//        }
//    }
    
    
    
    

    
    
    
}

// 코어데이터에 저장되어있는 객체를 로드합니다
//    lazy var loadCoreData: [DataLocation] = CoreDataManager.shared.locationList
//
//    lazy var weatherDataList: [[WeatherInfo]] = {
//
//            loadCoreData.compactMap { WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude) }
//    }()
//


//    var epocTime = TimeInterval(1608186525)
//    let myDate = NSDate(timeIntervalSince1970: epocTime)
