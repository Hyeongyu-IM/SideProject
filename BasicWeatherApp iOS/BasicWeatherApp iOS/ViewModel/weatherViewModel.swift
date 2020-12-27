//
//  weatherViewModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

public class WeatherViewModel {
    
    let locationGeocoder = LocationGeocoder()
    
    //MARK: - DateFormat Setting
    // 요일표시 포맷
    private func dtToWeekend(_ dt: Int) -> String {
        let dt = TimeInterval(dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
          dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(for: dt) ?? ""
    }
    
    // 오전/오후 몇시 표시 포맷
    private func dtToTime(_ dt: Int) -> String {
        let dt = TimeInterval(dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h시"
          dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(for: dt) ?? ""
    }
    
    // 오전/오후 몇시:몇분 포맷
    private func curretTime(_ dt: Int) -> String {
        let dt = TimeInterval(dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:m"
          dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(for: dt) ?? ""
    }
    
    //MARK: - TempFormat Setting
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
    
    func convertCoreData() {
        if coreData.count != 0 {
            
           weatherDataList = coreData.compactMap {
                WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude)
           }.flatMap { $0 }
            
            print("weatherDatalist입니다. \(weatherDataList)")
        } else {
            print("코어데이터에 데이터가 없습니다")
        }
    }
    
    var weatherDataList = [WeatherInfo]()
    
    lazy var hourCells = weatherDataList.map { hourDataConfig( $0 ) }
    lazy var detailCells = weatherDataList.map { detailDataConfig( $0 ) }
    lazy var weekendCells = weatherDataList.map { weekendDataConfig( $0 ) }

    //MARK: - HourlyCollectionCell Data Config
    func hourDataConfig(_ data: WeatherInfo ) -> [HourCell]{
        let sunsetCell = HourCell(dt: data.current.sunset ,time: dtToTime(data.current.sunset), icon: UIImage(named: "sunset.fill")!, Ctemp: "", Ftemp: "", NowOrSunSetAndRise: "일출")
        let sunriseCell = HourCell(dt: data.current.sunrise, time: dtToTime(data.current.sunrise), icon: UIImage(named: "sunrise.fill")!, Ctemp: "", Ftemp: "", NowOrSunSetAndRise: "일몰")
        let currentCell = HourCell(dt: data.current.dt, time: curretTime(data.current.dt), icon: UIImage(named: "\(data.daily[0].weather[0].icon)")!, Ctemp: tempFormatter.string(from: data.current.temp as NSNumber) ?? "", Ftemp: "\(celsiusToFahrenhit(tempFormatter.string(from: data.current.temp as NSNumber)!))", NowOrSunSetAndRise: "지금")
        
        var hourCells: [HourCell] = data.hourly.map {
            HourCell(dt: $0.dt ,time: dtToTime($0.dt) ,
                                    icon: UIImage(named: "\($0.weather[0].icon)")!,
                                    Ctemp: tempFormatter.string(from: $0.temp as NSNumber)!,
                                    Ftemp: "\(celsiusToFahrenhit(tempFormatter.string(from: $0.temp as NSNumber)!))",
                                    NowOrSunSetAndRise: nil)
        }
        hourCells.append(sunsetCell)
        hourCells.append(sunriseCell)
        hourCells.sort { $0.dt < $1.dt }
        // 현재시간 5:10분 이면 5시가 들어있기때문에 5시를 삭제합니다.
        hourCells.removeFirst()
        // 현재시간 5:10(지금)을 넣고, 다음셀은 6시 부터 표시.
        hourCells.insert(currentCell, at: 0)
        
        return hourCells
    }
    
    //MARK: - WeekendTableData Config
    func weekendDataConfig(_ data: WeatherInfo) -> [WeekendCell] {
        let weekendCells = data.daily.map {
            WeekendCell(weekend: dtToWeekend($0.dt),
                             icon: UIImage(named: "\($0.weather[0].icon)")!,
                             minCTemp: tempFormatter.string(from: $0.temp.min as NSNumber)!,
                             maxCTemp: tempFormatter.string(from: $0.temp.max as NSNumber)!,
                             minFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: $0.temp.min as NSNumber)!))" ,
                             maxFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: $0.temp.min as NSNumber)!))")
        }
        return weekendCells
    }
    
    //MARK: - DetailData Config
    func detailDataConfig(_ data: WeatherInfo) -> DetailCell {
        let state = String(locationGeocoder.GeoCoordiToCityName(latitude: data.lat, longitude: data.lon))
        let detailCell: DetailCell = DetailCell(dt: curretTime(data.current.dt),
                                                    location: state,
                                                    discription: data.current.weather.description,
                                                    currentTemp: tempFormatter.string(from: data.current.temp as NSNumber) ?? "",
                                                    minTemp: tempFormatter.string(from: data.daily[0].temp.min
                                                                                    as NSNumber) ?? "",
                                                    maxTemp: tempFormatter.string(from: data.daily[0].temp.max as NSNumber) ?? "",
                                                    minFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: data.daily[0].temp.min as NSNumber)!))",
                                                    maxFTemp: "\(celsiusToFahrenhit(tempFormatter.string(from: data.daily[0].temp.max as NSNumber)!))",
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
                                                    humidity: data.current.humidity)
        return detailCell
    }
    
    //MARK: - Data delete, Add
    func hourCellDelete(_ index: Int,_ hourCellList: [[HourCell]]) -> [[HourCell]] {
        var hourCellList = hourCellList
        hourCellList.remove(at: index)
        return hourCellList
    }
    
    func detailCellDelete(_ index: Int,_ detailCellList: [DetailCell]) -> [DetailCell] {
        var detailCellList = detailCellList
        detailCellList.remove(at: index)
        return detailCellList
    }
    
    func weekendCellDelete(_ index: Int,_ weekendCellList: [[WeekendCell]]) -> [[WeekendCell]] {
        var weekenCellList = weekendCellList
        weekenCellList.remove(at: index)
        return weekendCellList
    }
    
    func addLocation(_ latitude: Double,_ longitude: Double) {
        coreDataManager.saveLocation(latitude: latitude, longitude: longitude)
        let newWeatherInfo = WeatherAPI.shared.getWeatherInfo(latitude, longitude)
        hourCells.append(hourDataConfig(newWeatherInfo[0]))
        detailCells.append(detailDataConfig(newWeatherInfo[0]))
        weekendCells.append(weekendDataConfig(newWeatherInfo[0]))
    }
    
    
    //MARK: - Refresh Data
    func refreshData() {
       let newCoreData = coreDataManager.getLocation()
        coreData = newCoreData
        convertCoreData()
        
        hourCells = weatherDataList.map { hourDataConfig( $0 ) }
        detailCells = weatherDataList.map { detailDataConfig( $0 ) }
        weekendCells = weatherDataList.map { weekendDataConfig( $0 ) }
    }
}
    
    // 코어데이터에 있는 객체를 받아와서 API 호출후 배열로 변환
//    lazy var loadCoreData: Binder<[[WeatherInfo]]> = Binder(CoreDataManager.shared.locationList.compactMap { WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude)})
//
//    func bindConfig() {
//        loadCoreData.bind { data in
//            self.weatherDataList = data
//        }
//    }

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
