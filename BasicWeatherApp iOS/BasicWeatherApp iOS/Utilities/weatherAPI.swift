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
    
    // 새로운 요청이 들어오면 기존 것을 취소하고 현재의 것을 실행합니다.
    private var request: DataRequest? {
        didSet {
            oldValue?.cancel()
        }
    }

    
    func getWeatherInfo(_ latitude: Double,_ longitude: Double) -> [WeatherInfo] {
        let apiKey = "f8ad3cf3aa1e0f2df6433c805e65ca58"
        let url = "api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)lang=kr&exclude=minutely&appid=\(apiKey)"
        var weatherInfo = [WeatherInfo]()
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
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
                        
                        // DATA를 [APIresponse] 타입으로 디코딩
                        let jsonResponse = try JSONDecoder().decode(APIresponse.self, from: jsonData)
                        
                        //dataSource에 변환한 값을 대입
                        weatherInfo = [jsonResponse.respon]
                    } catch( let error) {
                        print(error.localizedDescription)
                    }
                //실패
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        return weatherInfo
    }
    
}
