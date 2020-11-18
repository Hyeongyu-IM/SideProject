//
//  ValidationCheck.swift
//  loginpage
//
//  Created by 임현규 on 2020/11/18.
//

import UIKit

class ValidationCheck {
    static func emailTest(_ email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    static func nameTest(_ name: String) -> Bool {
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z]{4,}")
        return nameTest.evaluate(with: name)
    }
        
    static func passwordTest(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    // 핸드폰번호 체크
//    var isValidPhone: Bool {
//          let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
//          let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
//          return testPhone.evaluate(with: self)
//       }
        
}

extension String {
    func hasCharacters(_ pattern: String) -> Bool{
            do{
                let regex = try NSRegularExpression(pattern: "\(pattern)", options: .caseInsensitive)
                if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
                    return true
                }
            }catch{
                print(error.localizedDescription)
                return false
            }
            return false
        }
}
