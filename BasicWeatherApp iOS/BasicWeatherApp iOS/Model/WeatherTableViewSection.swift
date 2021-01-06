//
//  WeatherTableViewSection.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2021/01/03.
//

import UIKit

enum WeatherTableViewSection: Int {
    static let numberOfSection = 4
    
    case hour = 0
    case weekend = 1
    case description = 2
    case detail = 3
    case link = 4
    
    init?(sectionIndex: Int) {
        guard let section = WeatherTableViewSection(rawValue: sectionIndex) else {
            return nil
        }
        self = section
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .hour:
            return CGFloat(140)
        case .weekend:
            return CGFloat(70)
        case .description:
            return CGFloat(70)
        case .link:
            return CGFloat(70)
        case .detail:
            return CGFloat(350)
        }
    }
}
