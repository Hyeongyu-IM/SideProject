//
//  TableViewModel.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class TableViewModel {
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    var sortedList: [BountyInfo] {
        return bountyInfoList.sorted{ $0.bounty > $1.bounty }
    }
    
    var numberOfbountylist: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}


// TableView Model
struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
