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
    
    static func getWeatherInfo(_ latitude: Double, longitude: Double) {
        let apiKey = "f8ad3cf3aa1e0f2df6433c805e65ca58"
        let url = "api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)lang=kr&exclude=minutely&appid=\(apiKey)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print(json)
        }
    }
}
