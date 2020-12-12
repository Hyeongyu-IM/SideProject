//
//  Geocoder.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/12.
//

import Foundation
import CoreLocation

// 주소를 위도와 경도 이름으로 변환
class LocationGeocoder {
  private lazy var geocoder = CLGeocoder()
  
  func geocode(addressString: String, callback: @escaping ([Location]) -> ()) {
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
      var locations: [Location] = []
      if let error = error {
        print("Geocoding error: (\(error))")
      } else {
        if let placemarks = placemarks {
          locations = placemarks.compactMap { (placemark) -> Location? in
            guard
              let name = placemark.locality,
              let location = placemark.location
              else {
                return nil
            }
            let region = placemark.administrativeArea ?? ""
            let fullName = "\(name), \(region)"
            return Location(
              name: fullName,
              latitude: location.coordinate.latitude,
              longitude: location.coordinate.longitude)
          }
        }
      }
      callback(locations)
    }
  }
}
