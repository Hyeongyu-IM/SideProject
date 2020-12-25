//
//  weatherAPI.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/13.
//

import UIKit
import Alamofire

// Corelocation에 저장된 데이터를 map으로 당겨와서 하나씩 API실행후에 받아온 정보로 테이블뷰에 실행.
// 가져올 요소 - { list:[{ main:{ temp, tempmin, tempmax, humidity,
class WeatherAPI {
    
    static let shared: WeatherAPI = WeatherAPI()
    lazy var iconsName: [String] = ["01d", "02d", "03d", "04d", "09d", "10d", "11d", "13d", "50d", "01n", "02n", "03n", "04n", "09n", "10n", "11n", "13n", "50n" ]
    // 새로운 요청이 들어오면 기존 것을 취소하고 현재의 것을 실행합니다.
    private var request: DataRequest? {
        didSet {
            oldValue?.cancel()
        }
    }

    
    func getWeatherInfo(_ latitude: Double,_ longitude: Double) -> [WeatherInfo] {
        let apiKey = "f8ad3cf3aa1e0f2df6433c805e65ca58"
        let url = "https://api.openweathermap.org/data/2.5/onecall"
        let parameters:[String:String] = [
            "lang": "kr",
            "exclude": "minutely",
            "lon": "\(longitude)",
            "lat": "\(latitude)",
            "appid": apiKey
        ]
        var weatherInfo = [WeatherInfo]()
        
        AF.request(url,
                   method: .get,
                   parameters:  parameters,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("데이터가 요청되었습니다 \(json)")
                switch json.result {
                 //성공
                case .success(let response):
                    do {
                        // 반환값을 DATA로 변환
                        let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                        print("Data변환")
                        // DATA를 [APIresponse] 타입으로 디코딩
                        let jsonResponse = try JSONDecoder().decode(WeatherInfo.self, from: jsonData)
                        print("jsonResponse \(jsonResponse)")
                        
                        //dataSource에 변환한 값을 대입
                       weatherInfo = [jsonResponse]
                    } catch( let error) {
                        print(" data를 담지못했습니다\(error.localizedDescription)")
                    }
                //실패
                case .failure(let error):
                    print("\(error.localizedDescription) 데이터를 요청했지만 받지 못했습니다.  ")
                }
        }
            if ImageFileManager.shared.checkingImage(weatherInfo[0].current.weather[0].icon) {
                print("아이콘이 이미 존재합니다")
            } else {
                saveAllWeatherIcon(iconsName)
            }
        return weatherInfo
    }
    
    func downloadWeatherIcon(_ name: String) {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        var image: UIImage = UIImage()
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON {
            (json) in
            switch json.result {
            case .success(let response):
                if let response = response as? UIImage {
                    image = response
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("이미지를 성공적으로 다운로드했습니다.")
        ImageFileManager.shared.saveImage(image, name)
        return
    }
    
    func saveAllWeatherIcon(_ iconNameList: [String]) {
        iconNameList.forEach {
            downloadWeatherIcon($0)
        }
    }
}
