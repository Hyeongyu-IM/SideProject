//
//  ViewController.swift
//  loginpage
//
//  Created by 임현규 on 2020/10/31.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKUser
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailLB: UITextField!
    @IBOutlet weak var psLB: UITextField!
    @IBOutlet weak var signinLB: UIButton!
    @IBOutlet weak var loginLB: UIButton!
    @IBOutlet var tapRecog: UITapGestureRecognizer!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    // ---> 파이어베이스 데이터베이스 연결
    let db = Database.database().reference()
    
    // ---> 저장할 데이터의 모델을 가져옵니다
//    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        signInButton.layer.cornerRadius = 10
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
     // 카카오톡 설치 여부 확인
      if (AuthApi.isKakaoTalkLoginAvailable()) {
        // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
        AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                // 예외 처리 (로그인 취소 등)
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
               // do something
                _ = oauthToken
               // 어세스토큰
               let accessToken = oauthToken?.accessToken
            }
        }
      } else {
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            
            //do something
            _ = oauthToken
            self.saveUserToFirebase()
           }
      }
    }
    }
    
    func saveUserToFirebase() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
        //do something
                _ = user
                
                self.db.child("users").setValue(["name": user?.kakaoAccount?.profile?.nickname, "email": user?.kakaoAccount?.email, "uid": user?.id ]) { (error, complete) in
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
    
    func config() {
        self.view.addGestureRecognizer(tapRecog)
        loginLB.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillHideHandel), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardwillShowHandle(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        print(keyboardSize.height)
        print(loginLB.frame.origin.y)
        
        if keyboardSize.height < loginLB.frame.origin.y {
            let distance = keyboardSize.height - loginLB.frame.origin.y
            self.view.frame.origin.y = distance - distance / 2
        }
    }
    
    @objc func keyboardwillHideHandel(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    // ---> 회원가입 버튼 클릭시 화면전환을 위해 segue를 사용합니다
    @IBAction func signinBtn(_ sender: Any) {
        performSegue(withIdentifier: "signin", sender: nil)
    }
    
    // --> 버튼누르고 판별에 따른 로그인 알림 출력
    @IBAction func loginBtn(_ sender: Any) {
        // 혹시 있을 공백을 지워줍니다.
        let email = emailLB.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = psLB.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                let fail = UIAlertController(title: "\(error!.localizedDescription)", message: nil, preferredStyle: .alert)
                            fail.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(fail, animated: false)
            } else {
                let succed = UIAlertController(title: "로그인 하셨습니다", message: nil, preferredStyle: .alert)
                    succed.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(succed, animated: false)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
    }
}

extension LoginViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: emailLB) == true || touch.view?.isDescendant(of: psLB) == true {
            return false
        } else {
            view.endEditing(true)
            return true
        }
    }
}

        
        // 사용자의 입력이 없으면 테두리가 빨갛게 됩니다
        
        
        // --- 로그인 버튼을 누를시 유저 데이터가 맞는지 확인합니다.
    //    func hasUser() -> Bool {
    //        // 입력이 없을때 false를 리턴합니다
    //        guard let pass: String = psLB.text else { return false }
    //        guard let id: String = idLB.text else { return false }
    //        for user in users {
    //            if user.id == id {
    //                if user.password == pass {
    //                    return true
    //                }
    //            }
    //        }
    //        return false
    //    }
        
//        if hasUser() {
//            let succed = UIAlertController(title: "로그인 하셨습니다", message: nil, preferredStyle: .alert)
//            succed.addAction(UIAlertAction(title: "OK", style: .cancel))
//            self.present(succed, animated: false)
//        } else {
//            let fail = UIAlertController(title: "로그인에 실패하셨습니다", message: nil, preferredStyle: .alert)
//            fail.addAction(UIAlertAction(title: "OK", style: .cancel))
//            self.present(fail, animated: false)
//        }
  

// ---> 기본적인 유저정보를 파이어베이스에 저장합니다.
//extension LoginViewController {
//    func saveBasicUsers() {
//        let user1 = User(num: "\(User.num)", id: "limku220", name: "Hyeongyu_IM", password: "1234")
//        User.num += 1
//        let user2 = User(num: "\(User.num)", id: "kei960311", name: "Soomin_KIM", password: "1234")
//        User.num += 1
//
//        db.child("users").child(user1.num).setValue(user1.toDictionary)
//        db.child("users").child(user2.num).setValue(user2.toDictionary)
//    }
//    func saveUsers(_ user: User) {
//        let user: User = user
//        db.child("users").child(user.num).setValue(user.toDictionary)
//    }
//}

// ---> 로그인확인을 위한 유저정보를 가져옵니다.
//extension LoginViewController {
//    func fetchCustomers() {
//        db.child("users").observeSingleEvent(of:.value) { snapshot in
//            // 받아온 데이터 디코딩
//            do {
//                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
//                print("data입니다 \(data)")
//                let decoder = JSONDecoder()
//                //디코딩 시작
//                let users: [User] = try decoder.decode([User].self, from: data)
//                print("users입니다 \(users)")
//                //모델 데이터 설정
//                self.users = users
//
//            } catch let error {
//                print("error ---->\(error.localizedDescription)")
//            }
//        }
//    }
//}
