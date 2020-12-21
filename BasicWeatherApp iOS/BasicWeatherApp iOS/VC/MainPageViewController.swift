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
    var vcArray = [UIViewController]()
    var locationManager: CLLocationManager!
    var currentLocation: Location = Location(name: "서울", latitude: 37, longitude: 126.96)
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .init(
                            x: 0,
                            y: UIScreen.main.bounds.height - 50,
                            width: UIScreen.main.bounds.width,
                            height: 50))
        view.backgroundColor = .black
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
//        getCurrentLocation()
//        currentLocationName(126.96, 37)
        CoreDataManager.shared.saveLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        weatherViewModel.convertCoreData()
        prepareViewControllers()
        setupViewControllers()
        view.addSubview(bottomView)
       
    }
    
    
    
    func configViewControllers() {
       
        
    }
    
    
    func prepareViewControllers() {
        let viewIndex = weatherViewModel.weatherDataList.count
        var result = [UIViewController]()
        for _ in 0..<viewIndex {
            result.append( DetailWeatherViewController.instance() ?? UIViewController() )
        }
        vcArray = result
    }
    
    private func setupViewControllers() {
        guard let firstVC = vcArray.first else { return }
        setViewControllers([firstVC],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}

extension MainPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        vcArray.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print(pendingViewControllers)
        if pendingViewControllers[0] == vcArray[0] {
            bottomView.alpha = 0.0
            bottomView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self!.bottomView.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.3,
                                   animations: { [weak self] in
                                    self?.bottomView.alpha = 0.0
                    }) { [weak self] _ in
                        self?.bottomView.isHidden = true
                    }
        }
        
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
    
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        currentLocation.longitude = coor?.longitude ?? 0
        currentLocation.latitude = coor?.latitude ?? 0
    }
    
    func currentLocationName(_ longitude: CLLocationDegrees,_ latitude:CLLocationDegrees) {
        let findLocation = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let name: String = address.last?.locality {
//                    self.currentLocation.name = name
                    CoreDataManager.shared.saveLocation(latitude: latitude, longitude: longitude)
                }
            }
        }
    }
}
