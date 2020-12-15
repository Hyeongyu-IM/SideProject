//
//  weatherViewModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

public class WeatherViewModel {
    
    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMM d"
      return dateFormatter
    }()
    
    private let tempFormatter: NumberFormatter = {
      let tempFormatter = NumberFormatter()
      tempFormatter.numberStyle = .none
      return tempFormatter
    }()
    
    let coreDataManager = CoreDataManager()
    

    // 코어데이터에 있는 객체를 받아와서 API 호출후 배열로 변환
    lazy var loadCoreData: Binder<[[WeatherInfo]]> = Binder(CoreDataManager.shared.locationList.compactMap { WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude)})
    
    var weatherDataList = [[WeatherInfo]]()
    
    func bindConfig() {
        loadCoreData.bind { data in
            self.weatherDataList = data
        }
    }
    

    
    
    
    

    
    
    
}

// 코어데이터에 저장되어있는 객체를 로드합니다
//    lazy var loadCoreData: [DataLocation] = CoreDataManager.shared.locationList
//
//    lazy var weatherDataList: [[WeatherInfo]] = {
//
//            loadCoreData.compactMap { WeatherAPI.shared.getWeatherInfo($0.latitude, $0.longitude) }
//    }()
//
