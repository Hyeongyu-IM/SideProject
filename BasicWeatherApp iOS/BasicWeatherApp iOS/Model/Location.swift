//
//  Location.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/11.
//

import Foundation
import CoreLocation

struct Location {
  var name: String
    var latitude: Double = 0.0
    var longitude: Double = 0.0
  
  var location: CLLocation {
    return CLLocation(latitude: latitude, longitude: longitude)
  }
}

extension Location: Equatable {
  static func ==(lhs: Location, rhs: Location) -> Bool {
    return lhs.name == rhs.name &&
      lhs.latitude == rhs.latitude &&
      lhs.longitude == rhs.longitude
  }
}
