//
//  weatherViewModel.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

public class WeatherViewModel {
    
    let coreDataManager = CoreDataManager()
    
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
    
    private static let defaultAddress = "현재위치"
    private let geocoder = LocationGeocoder()
    
    
}

