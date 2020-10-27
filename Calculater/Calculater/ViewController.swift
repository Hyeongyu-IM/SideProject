//
//  ViewController.swift
//  Calculater
//
//  Created by 임현규 on 2020/10/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var totalBtn: UIButton!
    @IBOutlet weak var backspaceBtn: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var numberBtn: [UIButton]!
    
    //< --- 텍스트 라벨 "" 문자열 넣기, 변화할때 메인큐가 업데이트
    var number = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.textLabel.text = self.number
            }
        }
    }
    var captureone: Int?
    var doit = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //<-- 버튼 둥글게
        cancelBtn.layer.cornerRadius = 25
        backspaceBtn.layer.cornerRadius = 25
        totalBtn.layer.cornerRadius = 25
        for btn in numberBtn {
            btn.layer.cornerRadius = 25
            
        //<-- 버튼 눌렸을때 이벤트 처리
            for textbtn in numberBtn {
                textbtn.addTarget(self, action: #selector(onBtnClicked(sender:)), for: .touchUpInside)
            }
            cancelBtn.addTarget(self, action: #selector(cancelBtnClicked(sender:)), for: .touchUpInside)
            backspaceBtn.addTarget(self, action: #selector(backspaceBtnClicked(sender:)), for: .touchUpInside)
            totalBtn.addTarget(self, action: #selector(totalBtnClicked(sender:)), for: .touchUpInside)
        }
    }
    
    @objc fileprivate func onBtnClicked(sender: UIButton) {
        guard let inputNumber = sender.titleLabel?.text else { return }
        switch inputNumber {
        case "+", "-", "X", "/":
            print("입력된 값은 \(inputNumber)")
            doit.append(inputNumber)
            if captureone == nil {
                guard captureone == nil else { return }
                captureone = Int(number)
                number.removeAll()
            } else {
                print("captureone이 있네요 ㅎㅎ")
//                var capturetwo = 0
//                capturetwo = Int(number)!
//                number.removeAll()
//                number.append(String(captureone ?? 0 + capturetwo))
            }
        case "%":
            captureone = Int(number)
            doit.append("%")
            totalBtnClicked(sender: totalBtn)
        default:
            print("현재버튼은 \(inputNumber)입니다")
            number.append(inputNumber)
        }
    }
    @objc fileprivate func cancelBtnClicked(sender: UIButton) {
        number.removeAll()
        captureone = nil
        doit.removeAll()
    }
    
    @objc fileprivate func backspaceBtnClicked(sender: UIButton) {
        number.popLast()
    }
    
    @objc fileprivate func totalBtnClicked(sender: UIButton) {
        switch doit {
        case "+":
            let capturetwo = Int(number)!
            number = String((captureone ?? 0) + capturetwo )
        case "-":
            let capturetwo = Int(number)!
            number = String((captureone ?? 0) - capturetwo )
        case "X":
            let capturetwo = Int(number)!
            number = String((captureone ?? 0) * capturetwo )
        case "/":
            let capturetwo = Int(number)!
            number = String((captureone ?? 0) / capturetwo )
        case "%":
            number = String((captureone ?? 0) / 100 )
        default:
            return
        }
    }
    
    
}

