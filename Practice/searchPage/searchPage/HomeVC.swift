//
//  ViewController.swift
//  searchPage
//
//  Created by 임현규 on 2020/11/13.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController {
    
    @IBOutlet weak var segBtn: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func uiRadius() {
        searchBtn.layer.cornerRadius = 10
    }
    
    @IBAction func segBtnClicked(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        
        switch value {
        case 0:
            searchBar.becomeFirstResponder()
        case 1:
            searchBar.becomeFirstResponder()
        default: break
        }
    }
    
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        if searchBar.text?.count == 0 {
            self.view.makeToast("검색키워드를 입력해주세요", duration: 1.0, position: .center)
        } else {
            if segBtn.selectedSegmentIndex == 0 {
                performSegue(withIdentifier: "toUserVC", sender: nil)
                searchBar.endEditing(true)
            } else {
                performSegue(withIdentifier: "toImageVC", sender: nil)
                searchBar.endEditing(true)
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
            print("HomeVC - keyboardWillShowHandle() called")
            // 키보드 사이즈 가져오기
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                print("keyboardSize.height: \(keyboardSize.height)")
                print("searchBtn.frame.origin.y : \(searchBtn.frame.origin.y)")
                if keyboardSize.height < searchBtn.frame.origin.y {
                    print("키보드가 버튼을 덮었다.")
                    let distance = keyboardSize.height - searchBtn.frame.origin.y
                    print("이만큼 덮었다. distance : \(distance)")
                    self.view.frame.origin.y = distance + searchBtn.frame.height
                }
            }

        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension HomeVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: segBtn) == true {
            return false
        } else if touch.view?.isDescendant(of: searchBar) == true {
            return false
        } else if touch.view?.isDescendant(of: searchBtn) == true {
            return false
        }
        view.endEditing(true)
        return true
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                searchBar.resignFirstResponder()
            })
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let searchBarTextindext = searchBar.text?.appending(text).count ?? 0
        
        if searchBarTextindext <= 12 {
            return true
        } else {
            self.view.makeToast("12자 까지만 입력가능합니다.", duration: 1.0, position: .center)
            return false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userinputString = searchBar.text else { return }
        if userinputString.isEmpty {
            self.view.makeToast("검색키워드를 입력해주세요", duration: 1.0, position: .center)
        } else {
            segBtn.selectedSegmentIndex == 0 ? performSegue(withIdentifier: "toUserVC", sender: nil) :performSegue(withIdentifier: "toImageVC", sender: nil)
            searchBar.resignFirstResponder()
        }
    }
}
