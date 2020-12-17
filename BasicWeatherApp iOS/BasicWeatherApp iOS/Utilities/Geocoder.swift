//
//  Geocoder.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/12.
//

import Foundation
import CoreLocation

class LocationGeocoder {
  var geocoder = CLGeocoder()
 
    // 도시 이름을 경도와 위도로 변환
  func cityNameToGeoCoordi(_ addressString: String, callback: @escaping ([Location]) -> ()) {
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
        
    // 경도와 위도를 도시이름으로 변환
    func GeoCoordiToCityName(latitude: Double,longitude: Double) -> String {
        let findLocation = CLLocation(latitude: latitude, longitude: longitude)
        var cityName: String = ""
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: Locale(identifier: "Ko-kr")) {
            (placemarks, error) -> Void in
                if let error = error {
                    print("Geocoding error: (\(error))")
                } else {
                    if let address: [CLPlacemark] = placemarks {
                        if let name: String = address.last?.locality {
                            cityName = name
                        }
                    }
                }
            }
        return cityName
    }
}
