//
//  weatherCellDataMaker.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/31.
//

import UIKit

class WeatherCellDataMaker {
    private let data: WeatherInfo
    private let maxItemCount = 20
    private var utcTimeConvertor = DateConverter()
    private let fileManager = ImageFileManager()
    
    init(data: WeatherInfo) {
        self.data = data
    }
    
    //MARK: - HourlyCollectionCell Data Config
    func getHourDataCell() -> [HourCell]{
        let sunsetCell = HourCell(dt: data.current.sunset,
                                  time: utcTimeConvertor.dtToTime(data.current.sunset),
                                  icon: UIImage(systemName: "sunset.fill")! ,
                                  Ctemp: "일몰")
        let sunriseCell = HourCell(dt: data.current.sunrise,
                                   time: utcTimeConvertor.dtToTime(data.current.sunrise),
                                   icon: UIImage(systemName: "sunrise.fill")!,
                                   Ctemp: "일출")
        let currentCell = HourCell(dt: data.current.dt,
                                   time: "지금",
                                   icon: fileManager.loadImage(data.daily[0].weather[0].icon),
                                   Ctemp: "\(temperature: Temperature(kelvin: data.current.temp).text)")
        
        var hourCells: [HourCell] = data.hourly.map {
            HourCell(dt: $0.dt ,
                     time: utcTimeConvertor.dtToTime($0.dt),
                     icon: fileManager.loadImage($0.weather[0].icon),
                     Ctemp: "\(temperature: Temperature(kelvin: $0.temp).text)")
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
    func getWeekendDataCell() -> [WeekendCell] {
        let weekendCells = data.daily.map {
            WeekendCell(weekend: utcTimeConvertor.dtToWeekend($0.dt),
                             icon: fileManager.loadImage($0.weather.first!.icon),
                             minCTemp: "\(temperature: Temperature(kelvin: $0.temp.min).text)",
                             maxCTemp: "\(temperature: Temperature(kelvin: $0.temp.max).text)",
                             percent: "")
        }
       
        return weekendCells
    }
    
    //MARK: - DetailData Config
    func getdetailDataCell() -> DetailCell {
        let detailCell: DetailCell = DetailCell(sunrise: utcTimeConvertor.dtToTime(data.current.sunrise),
                                                sunset: utcTimeConvertor.dtToTime(data.current.sunset),
                                                snow: String(data.current.snow?.lastHour ?? 0),
                                                humidity: "\(humidity: data.current.humidity)",
                                                wind: "\(wind: data.current.wind_speed)",
                                                feelsLike: String(data.current.feels_like),
                                                rain: String(data.current.rain?.lastHour ?? 0),
                                                pressure:"\(pressure: data.current.pressure)",
                                                visibility: String(data.current.visibility),
                                                uvi: String(data.current.uvi))
        return detailCell
    }
    
    //MARK: - HeaderCell DataConfig
    func getheaderDataCell() -> HeaderCell {
        let headerCell: HeaderCell = HeaderCell(state: data.timezone,
                                                description: data.current.weather.first!.description,
                                                currentTemp: "\(temperature: Temperature(kelvin: data.current.temp).text)",
                                                minTemp: "\(temperature: Temperature(kelvin: data.daily[0].temp.min).text)" ,
                                                maxTemp: "\(temperature: Temperature(kelvin: data.daily[0].temp.max).text)")
        return headerCell
    }
    
    //MARK: - WeatherListTableCell DataConfig
    func getWeatherListDataCell() -> WeatherListViewCell {
        let weatherListCell = WeatherListViewCell(dt: utcTimeConvertor.curretTime(data.current.dt),
                                                  state: data.timezone,
                                                  currentTempC: "\(temperature: Temperature(kelvin: data.current.temp).text)")
        return weatherListCell
    }
}
