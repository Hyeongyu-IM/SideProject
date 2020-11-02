//
//  userModel.swift
//  loginpage
//
//  Created by 임현규 on 2020/11/01.
//

import Foundation
import Firebase

struct User: Codable {
    // user ID, Password, Name
    
    let num: String
    let id: String
    let name: String
    var password: String
    
    // Computed Property
    var toDictionary: [String: Any] {
        let user: [String: Any] = ["num": num, "id": id, "name": name, "password": password]
        return user
    }
    
    static var num: Int = 0
}
