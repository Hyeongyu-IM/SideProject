//
//  keyboardHandle.swift
//  loginpage
//
//  Created by 임현규 on 2020/11/18.
//

import UIKit

class KeyboardHandler {
    static func addNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillHideHandel), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private  func keyboardwillShowHandle(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if keyboardSize.height < loginLB.frame.origin.y {
            let distance = keyboardSize.height - loginLB.frame.origin.y
            self.view.frame.origin.y = distance
        }
    }
}
