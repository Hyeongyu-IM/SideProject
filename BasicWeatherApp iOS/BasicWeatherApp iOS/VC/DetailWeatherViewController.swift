//
//  detailWeatherViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit
import CoreLocation

class DetailWeatherViewController: UIViewController {
    
    let weatherViewModel = WeatherViewModel()
//    var currentLocation: Location!

    static func instance() -> DetailWeatherViewController? {
        return UIStoryboard(
            name: "MainTest",
            bundle: nil).instantiateViewController(
            identifier: "DetailWeatherViewController"
            ) as? DetailWeatherViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getCurrentLocation()
//        currentLocationName(currentLocation.longitude, currentLocation.latitude)
    }
}





// 현재 위치정보를 받아옵니다.
//extension DetailWeatherViewController: CLLocationManagerDelegate {
//    
//    func getCurrentLocation() {
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//        
//        let coor = locationManager.location?.coordinate
//        currentLocation.longitude = coor!.longitude
//        currentLocation.latitude = coor!.latitude
//    }
//    
//    func currentLocationName(_ longitude: CLLocationDegrees,_ latitude:CLLocationDegrees) {
//        let findLocation = CLLocation(latitude: latitude, longitude: longitude)
//        let geocoder = CLGeocoder()
//        let locale = Locale(identifier: "Ko-kr")
//        
//        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (placemarks, error) in
//            if let address: [CLPlacemark] = placemarks {
//                if let name: String = address.last?.locality {
//                    self.currentLocation.name = name
//                    CoreDataManager.shared.updateCurrentLocation(latitude, longitude)
//                }
//            }
//        }
//    }
//}
