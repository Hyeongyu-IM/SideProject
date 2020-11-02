//
//  signinViewController.swift
//  loginpage
//
//  Created by 임현규 on 2020/11/02.
//

import UIKit

class signinViewController: ViewController {
    
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwcheckTextField: UITextField!
    
    
    var usermodel = UserViewmodel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(usermodel)")
        Btn.layer.cornerRadius = 10
        
    }
    
    @IBAction func createBtn(_ sender: UIButton) {
    }
    
}

extension signinViewController : UITextFieldDelegate{
//    func textFieldDidEndEditing(_ textField: UITextField,_ regex: String) {
//        if textField == idTextField {
//            // 영문 소문자 1자리 이상
//            textFieldCheck(idTextField, "^[a-z]{1,}$")
//        } else if textField == pwTextField {
//            // 영문 소문자 + 숫자 총 6자리 이상
//            textFieldCheck(pwTextField, "^[a-z0-9]{6,}$")
//        }
//    }
//    func textFieldCheck(_ tf: UITextField,_ regex: String) {
//        if !textFieldNullCheck(tf) {
//        } else if (tf.text.map{String($0)}!.contains(regex) {
//            // 컨테이너 뷰 빨간색으로 변경
//            cv.setColor(.ff6E6E)
//            errorLabel.textColor = .ff6E6E
//        } else {
//            cv.setColor(.lightGray)
//            errorLabel.text = " "
//        }
//    }
//    func textFieldNullCheck(_ tf: UITextField) -> Bool {
//        if tf.text == "" {
//            // 컨테이너 뷰 빨간색으로 변경
//            tf.placeholder = "값을 입력해주세요"
//            tf.layer.borderColor = #colorLiteral(red: 1, green: 0.2843161821, blue: 0.2501606941, alpha: 1)
//            return false
//        } else { return true }
//    }
    // 키보드 처리
    @objc func keyboardWillShow(notification: Notification) {
        self.view.frame.origin.y -= 50
    }
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y += 50
    }
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 영역을 클릭하면 블루로 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == idTextField {
            textField.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else {
            if textField.layer.borderColor == #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) {
                textField.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            }
        }
        if textField == pwTextField {
            textField.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else {
            if textField.layer.borderColor == #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) {
                textField.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            }
        }
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//        if idTextField.text.hasCharacter(regex: "^[a-z]{1,}$") &&
//            pwTextField.text.hasCharacter(regex: "^[a-z0-9]{6,}$") {
//            loginButton.isEnabled = true
//            loginButton.backgroundColor = .mainblue
//        } else {
//            loginButton.isEnabled = false
//            loginButton.backgroundColor = .lightGray
//        }
//    }
}

class UserViewmodel {
    var users: [User] = []
    
    func update(model: [User]) {
        users = model
    }
}
