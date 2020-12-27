//
//  MainPageViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/20.
//

import UIKit
import CoreLocation

class MainPageViewController: UIPageViewController {
    
    let weatherViewModel = WeatherViewModel()
    var locationManager: CLLocationManager!
    
    lazy var currentLocation = Location(name: "", latitude: 0.0, longitude: 0.0)
    
    lazy var vcArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        print(WeatherAPI.shared.getWeatherInfo(37,126.96))
//        currentLocationName(126.96, 37)
//        CoreDataManager.shared.saveLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
//        weatherViewModel.convertCoreData()
        prepareViewControllers()
//        getCurrentLocationAndName()
        setupViewControllers()
    }
    
    
    
    func configViewControllers() {
       
        
    }
    
    // 저장된 weatherInfo수만큼 뷰를 생성합니다.
    func prepareViewControllers() {
        let viewIndex = weatherViewModel.weatherDataList.count
        var result = [UIViewController]()
        for i in 0..<viewIndex {
            result.append( MainTableViewController.instance() ?? UIViewController() )
            MainTableViewController.controllerIndex = i
        }
        vcArray = result
    }
    
    // 첫화면을 설정합니다.
    private func setupViewControllers() {
        guard let firstVC = vcArray.first else { return }
        setViewControllers([firstVC],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}

// 페이지 뷰의 페이지를 설정합니다.
extension MainPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        vcArray.count
    }
    
    // 페이지 뷰가 전환될때
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print(pendingViewControllers)
//        if pendingViewControllers[0] == vcArray[0] {
//            bottomView.alpha = 0.0
//            bottomView.isHidden = false
//            UIView.animate(withDuration: 0.3, animations: { [weak self] in
//                self!.bottomView.alpha = 1.0
//            })
//        } else {
//            UIView.animate(withDuration: 0.3,
//                                   animations: { [weak self] in
//                                    self?.bottomView.alpha = 0.0
//                    }) { [weak self] _ in
//                        self?.bottomView.isHidden = true
//                    }
//        }
        
    }
}


extension MainPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {

        guard let index = vcArray.firstIndex(of: viewController) else { return nil }

        let prevViewControllerIndex = index - 1

        guard prevViewControllerIndex >= 0 else {
            return nil
        }

        guard vcArray.count > prevViewControllerIndex else { 
            return nil
        }

        return vcArray[prevViewControllerIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = vcArray.firstIndex(of: viewController) else { return nil }

        let nextViewControllerIndex = index + 1

        guard nextViewControllerIndex < vcArray.count else {
            return nil
        }

        guard vcArray.count > nextViewControllerIndex else {
            return nil
        }

        return vcArray[nextViewControllerIndex]
    }
}

extension MainPageViewController: CLLocationManagerDelegate {
    
    
    func getCurrentLocationAndName() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        let cityName = currentLocationName(Double(coor?.longitude ?? 0.0), Double(coor?.latitude ?? 0.0))
        let location = Location(name: cityName, latitude: Double(coor?.latitude ?? 0.0), longitude: Double(coor?.longitude ?? 0.0))
        CoreDataManager.shared.saveLocation(latitude: Double(coor?.latitude ?? 0.0), longitude: Double(coor?.longitude ?? 0.0))
        
        currentLocation = location
    }
    
    func currentLocationName(_ longitude: Double,_ latitude:Double) -> String {
        let findLocation = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        var cityname = ""
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let name: String = address.last?.locality {
                    cityname = name
                }
            }
        }
        return cityname
    }
}
