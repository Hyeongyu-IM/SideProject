//
//  Date.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/31.
//

import Foundation

class DateConverter {
    
//MARK: - DateFormat Setting
// 요일표시 포맷
 func dtToWeekend(_ dt: Int) -> String {
    let dt = NSDate(timeIntervalSince1970: Double(dt))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
      dateFormatter.locale = Locale(identifier: "ko-kr")
    return dateFormatter.string(for: dt) ?? ""
    }

// 오전/오후 몇시 표시 포맷
 func dtToTime(_ dt: Int) -> String {
    let dt = NSDate(timeIntervalSince1970: Double(dt))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a h시"
      dateFormatter.locale = Locale(identifier: "ko-kr")
    return dateFormatter.string(for: dt) ?? ""
 }

// 오전/오후 몇시:몇분 포맷
    func curretTime(_ dt: Int) -> String {
    let dt = NSDate(timeIntervalSince1970: Double(dt))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a h:m"
      dateFormatter.locale = Locale(identifier: "ko-kr")
    return dateFormatter.string(for: dt) ?? ""
    }
}
