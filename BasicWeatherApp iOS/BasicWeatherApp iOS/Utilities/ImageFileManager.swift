//
//  ImageFileManager.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/23.
//

import UIKit
import Alamofire

class ImageFileManager {
    let fileManager = FileManager.default
    
    let iconsName: [String] = ["01d", "02d", "03d", "04d", "09d", "10d", "11d", "13d", "50d", "01n", "02n", "03n", "04n", "09n", "10n", "11n", "13n", "50n" ]
    
    func saveImage(_ image: UIImage,_ name: String) {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent((url as NSString).lastPathComponent)
        
        if !fileManager.fileExists(atPath: filePath.path) {
            fileManager.createFile(atPath: filePath.path,
                                   contents: image.pngData(),
                                   attributes: nil)
        }
    }
    
    static func loadImage(_ name: String) -> UIImage {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        let fileManager = FileManager.default
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return UIImage() }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent((url as NSString).lastPathComponent)
        
        if fileManager.fileExists(atPath: filePath.path) {
            guard let imageData = try? Data(contentsOf: filePath) else {
                return UIImage()
            }
            guard let image = UIImage(data: imageData) else {
                return UIImage()
            }
            print(#function, "성공적으로 이미지를 불러왔습니다")
            return image
        }
        return UIImage()
    }
    
    func checkingImagefile(_ name: String) -> Bool {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return false }
        
        var filePath = URL(fileURLWithPath: path)
        
        filePath.appendPathComponent((url as NSString).lastPathComponent)
        return fileManager.fileExists(atPath: filePath.path)
    }
    
    func storageImageChecking(_ weatherInfo: WeatherInfo) {
        if checkingImagefile(weatherInfo.daily.first?.weather.first?.icon ?? "") {
            print("아이콘이 이미 존재합니다 \(String(describing: weatherInfo.daily.first?.weather.first?.icon))")
        } else {
//                saveAllWeatherIcon(iconsName)
            print("이미지를 다운로드 합니다, \(checkingImagefile(weatherInfo.daily.first?.weather.first?.icon ?? "")) ,\(String(describing: weatherInfo.daily.first?.weather.first?.icon))")
        }
    
    
        func downloadWeatherIcon(_ name: String, completion: @escaping (UIImage?, String, Error?) -> Void) {
            let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
            var image: UIImage = UIImage()
        
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON {
                (json) in
                switch json.result {
                case .success(let response):
                    if let response = response as? UIImage {
                        image = response
                        completion(image, name, nil)
                    }
                case .failure(let error):
                    print(ServiceError.impossibleToGetImageData)
                    completion(nil, name, error)
                }
            }
        }
    
    func saveAllWeatherIcon(_ iconNameList: [String]) {
        iconNameList.forEach {
            downloadWeatherIcon($0) { (image, name, error) in
                guard let image = image else { return }
                self.saveImage(image, name)
                }
            }
        }
    }
}
