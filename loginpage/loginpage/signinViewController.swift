//
//  signinViewController.swift
//  loginpage
//
//  Created by 임현규 on 2020/11/02.
//

import UIKit

class signinViewController: ViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwcheckTextField: UITextField!
    @IBOutlet var colForTF: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Btn.layer.cornerRadius = 10
        delegate()
    }
    
    @IBAction func createBtn(_ sender: UIButton) {
        newUser()
    }
    var namecheck = "^[A-Za-z]{4,}$"
    var idcheck = "^[a-z0-9]{5,}$"
    // 영문 소문자 + 숫자 총 8자리 이상
    var pwcheck = "^[A-Za-z0-9]{8,}$"
    
    func delegate() {
        for i in colForTF {
            i.delegate = self
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2.0
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 텍스트 필드 비었는지 검사
        if textField.text!.isEmpty {
        textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            // 안비었을때 유효성 검사
            if textField == idTextField {
                if !(idTextField.text!.hasCharacters(idcheck)) {
                    return textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                }
            } else if textField == pwTextField {
                if !(pwTextField.text!.hasCharacters(pwcheck)) {
                    return textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                }
            } else if textField == pwcheckTextField {
                if !(pwTextField.text!.hasCharacters(pwcheck)) {
                    return textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                }
            } else if textField == nameText {
                if !(nameText.text!.hasCharacters(idcheck)) {
                    return textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                }
            }
            textField.layer.borderWidth = 0
        }
    }
    
    // 이미 있는 id 인지 검사합니다.
    func checkUser() -> Bool {
        // 입력이 없을때 false를 리턴합니다
        guard let id: String = idTextField.text else { return false }
        for user in users {
            if user.id == id {
                let fail = UIAlertController(title: "id가 중복되었습니다", message: nil, preferredStyle: .alert)
                fail.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(fail, animated: false)
                    return false
            }
        }
        let succed = UIAlertController(title: "Well Come 😍", message: nil, preferredStyle: .alert)
        succed.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(succed, animated: false)
       
        return true
    }
    
    func newUser() {
        guard let pw = pwTextField.text else {return}
        guard let checkpw = pwcheckTextField.text else {return}
        if pw == checkpw {
            guard let id = idTextField.text else {return}
            guard let name = nameText.text else {return}
                if checkUser() {
                    let newUser = User(num: "\(users.count)", id: "\(id)", name: "\(name)", password: "\(pw)")
                    saveUsers(newUser)
                    users.append(newUser)
                    print(users)
            }
        }
    }
    
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
