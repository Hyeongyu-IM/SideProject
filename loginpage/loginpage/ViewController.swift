//
//  ViewController.swift
//  loginpage
//
//  Created by 임현규 on 2020/10/31.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var idLB: UITextField!
    @IBOutlet weak var psLB: UITextField!
    @IBOutlet weak var signinLB: UIButton!
    @IBOutlet weak var loginLB: UIButton!
    
    // ---> 파이어베이스 데이터베이스 연결
    let db = Database.database().reference()
    
    // ---> 저장할 데이터의 모델을 가져옵니다
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBasicUsers()
        fetchCustomers()
//      loginLB.layer.cornerRadius = 10
    }
    
    // 사용자의 입력이 없으면 테두리가 빨갛게 됩니다
    
    
    // --- 로그인 버튼을 누를시 유저 데이터가 맞는지 확인합니다.
    func hasUser() -> Bool {
        // 입력이 없을때 false를 리턴합니다
        guard let pass: String = psLB.text else { return false }
        guard let id: String = idLB.text else { return false }
        for user in users {
            if user.id == id {
                if user.password == pass {
                    return true
                }
            }
        }
        return false
    }
    
    
    // ---> 회원가입 버튼 클릭시 화면전환을 위해 segue를 사용합니다
    @IBAction func signinBtn(_ sender: Any) {
        performSegue(withIdentifier: "signin", sender: nil)
    }
    
    // --> 버튼누르고 판별에 따른 로그인 알림 출력
    @IBAction func loginBtn(_ sender: Any) {
        if hasUser() {
            let succed = UIAlertController(title: "로그인 하셨습니다", message: nil, preferredStyle: .alert)
            succed.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(succed, animated: false)
        } else {
            let fail = UIAlertController(title: "로그인에 실패하셨습니다", message: nil, preferredStyle: .alert)
            fail.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(fail, animated: false)
        }
    }
    
    @IBAction func exitBtn(_ sender: Any) {
        
    }
    
}

// ---> 기본적인 유저정보를 파이어베이스에 저장합니다.
extension ViewController {
    func saveBasicUsers() {
        let user1 = User(num: "\(User.num)", id: "limku220", name: "Hyeongyu_IM", password: "1234")
        User.num += 1
        let user2 = User(num: "\(User.num)", id: "kei960311", name: "Soomin_KIM", password: "1234")
        User.num += 1
        
        db.child("users").child(user1.num).setValue(user1.toDictionary)
        db.child("users").child(user2.num).setValue(user2.toDictionary)
    }
    func saveUsers(_ user: User) {
        let user: User = user
        db.child("users").child(user.num).setValue(user.toDictionary)
    }
}

// ---> 로그인확인을 위한 유저정보를 가져옵니다.
extension ViewController {
    func fetchCustomers() {
        db.child("users").observeSingleEvent(of:.value) { snapshot in
            // 받아온 데이터 디코딩
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                print("data입니다 \(data)")
                let decoder = JSONDecoder()
                //디코딩 시작
                let users: [User] = try decoder.decode([User].self, from: data)
                print("users입니다 \(users)")
                //모델 데이터 설정
                self.users = users
                
            } catch let error {
                print("error ---->\(error.localizedDescription)")
            }
        }
    }
}
