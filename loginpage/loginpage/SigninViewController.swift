//
//  signinViewController.swift
//  loginpage
//
//  Created by 임현규 on 2020/11/02.
//

import UIKit
import Firebase

class SigninViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwcheckTextField: UITextField!
    @IBOutlet var colForTF: [UITextField]!
    @IBOutlet var tapRecog: UITapGestureRecognizer!
    
    let db = Database.database().reference()
    
    var emptyCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    @IBAction func createBtn(_ sender: UIButton) {
        newUser()
    }
//    var namecheck = "^[A-Za-z]{4,}$"
//    var idcheck = "^[a-z0-9]{5,}$"
//    // 영문 소문자 + 숫자 총 8자리 이상
//    var pwcheck = "^[A-Za-z0-9]{8,}$"
    @objc func keyboardwillShowHandle(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if keyboardSize.height < Btn.frame.origin.y {
            let distance = keyboardSize.height - Btn.frame.origin.y
            self.view.frame.origin.y = distance - distance / 2
        }
    }
    
    @objc func keyboardwillHideHandel(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func config() {
        for i in colForTF {
            i.delegate = self
        }
        Btn.layer.cornerRadius = 10
        self.view.addGestureRecognizer(tapRecog)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillHideHandel), name: UIResponder.keyboardWillHideNotification, object: nil)
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
            return emptyCheck = false
        } else {
            // 안비었을때 유효성 검사
            if textField == emailTextField {
                if !ValidationCheck.emailTest(emailTextField.text!) {
                    textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                   return emptyCheck = false
                }
            } else if textField == pwTextField {
                if !ValidationCheck.passwordTest(pwTextField.text!) {
                    textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                   return emptyCheck = false
                }
            } else if textField == pwcheckTextField {
                if !(pwTextField.text! == pwcheckTextField.text!)  {
                    textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                   return emptyCheck = false
                }
            } else if textField == nameText {
                if !ValidationCheck.nameTest(nameText.text!) {
                    textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                   return emptyCheck = false
                }
            }
            textField.layer.borderWidth = 0
            return emptyCheck = true
        }
    }
    
    // 이미 있는 id 인지 검사합니다.
//    func checkTextField() -> Bool {
        // 입력이 없을때 false를 리턴합니다
//        guard let id: String = emailTextField.text else { return false }
//        for user in users {
//            if user.id == id {
//                let fail = UIAlertController(title: "id가 중복되었습니다", message: nil, preferredStyle: .alert)
//                fail.addAction(UIAlertAction(title: "OK", style: .cancel))
//                self.present(fail, animated: false)
//                    return false
//            }
//        }
//        let succed = UIAlertController(title: "Well Come 😍", message: nil, preferredStyle: .alert)
//        succed.addAction(UIAlertAction(title: "OK", style: .cancel))
//        self.present(succed, animated: false)
//
//        return true
//    }
    
    func newUser() {
        if !emptyCheck {
            let fail = UIAlertController(title: "맞지않는 입력이 있습니다", message: nil, preferredStyle: .alert)
                fail.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(fail, animated: false)
        } else {
            // 모든 입력값이 제대로 입력됫고 서버에 사용자정보를 올릴차례
            Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!) { (result, err) in
                
                if err != nil {
                    print("Error creating user")
                }
                else {
                    // User was created successfully, now store the first name and last name
                    self.db.child("users").setValue(["name": self.nameText.text!, "email": self.emailTextField.text!, "uid": result!.user.uid ]) { (error, complete) in
                        if error != nil {
                            // Show error message
                            print("Error saving user data")
                        } else {
                            let succed = UIAlertController(title: "Well Come 😍", message: nil, preferredStyle: .alert)
                           succed.addAction(UIAlertAction(title: "OK", style: .cancel))
                           self.present(succed, animated: false)
                        }
                    }
            }
        }
     }
    }
}

extension SigninViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: nameText) == true || touch.view?.isDescendant(of: emailTextField) == true || touch.view?.isDescendant(of: pwTextField) == true || touch.view?.isDescendant(of: pwcheckTextField) == true {
            return false
        } else {
            view.endEditing(true)
            return true
        }
    }
}
