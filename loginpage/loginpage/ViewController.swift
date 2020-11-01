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
    
    let db = Database.database().reference()
    
    // 모델을 가져옵니다
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBasicUsers()
        fetchCustomers()
        signinLB.layer.cornerRadius = 10
        loginLB.layer.cornerRadius = 10
    }
    
    // 로그인 버튼을 누를시 유저가 있는지 확인합니다.
    func hasUser() -> Bool {
        print("입력된 id\(idLB.text) , password \(psLB.text)입니다")
        print("\(users)")
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
    
    
    
    @IBAction func signinBtn(_ sender: UIButton) {
        
    }
    
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

// --- 기본적인 유저정보를 파이어베이스에 저장합니다.
extension ViewController {
    func saveBasicUsers() {
        let user1 = User(id: "limku220", name: "Hyeongyu_IM", password: "1234")
        let user2 = User(id: "kei960311", name: "Soomin_KIM", password: "1234")
        
        db.child("users").child(user1.id).setValue(user1.toDictionary)
        db.child("users").child(user2.id).setValue(user2.toDictionary)
    }
}

// --- 로그인확인을 위한 유저정보를 가져옵니다.
extension ViewController {
    func fetchCustomers() {
        db.child("users").observeSingleEvent(of:.value) { snapshot in
            print("--> \(snapshot.value)")
            
            // 받아온 데이터 디코딩
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                print("data입니다 \(data)")
                let decoder = JSONDecoder()
                //디코딩 시작
                let users: [User] = try decoder.decode([User].self, from: data)
                //모델 데이터 설정
                print("usersdata입니다 \(users)")
                self.users = users
                print("usersdata입니다 \(users)")
                
            } catch let error {
                print("error ---->\(error.localizedDescription)")
            }
        }
    }
}
