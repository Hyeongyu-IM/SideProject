//
//  ViewController.swift
//  Calculater
//
//  Created by 임현규 on 2020/10/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Btns: [UIButton]!
    @IBOutlet weak var displayText: UILabel!
    @IBOutlet weak var historyText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayText.text = "0"
        historyText.text = ""
        for btn in Btns {
            btn.layer.cornerRadius = 25
        }
}
   
    var displayLabel: String = ""
    var opersign: String? = nil
    var firstNum: Int? = nil
    var numberbox: String = ""
    var secondNum: Int = 0
    
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        displayText.text = "0"
        historyText.text = ""
        displayLabel = ""
        firstNum = nil
        secondNum = 0
        opersign = nil
        numberbox = ""
    }
    
    @IBAction func backspaceBtn(_ sender: UIButton) {
        if numberbox.count >= 0 {
            numberbox.popLast()
            displayText.text = numberbox
            historyText.text?.popLast()
        } else {
            
        }
    }
    
    @IBAction func operatorBtn(_ sender: UIButton) {
        if numberbox.isEmpty {
            
        } else {
        if opersign == nil {
            operSign(sign: sender.currentTitle!)
        }else {
            if sender.currentTitle! == "=" {
                secondNum = Int(numberbox)!
                operSign(sign: sender.currentTitle!)
            } else {
                numberbox = displayText.text!
                operSign(sign: sender.currentTitle!)
                }
            }
        }
    }
    
    
    @IBAction func numBtn(_ sender: UIButton) {
        historyText.text! += (sender.currentTitle)!
        displayLabel += (sender.currentTitle)!
        numberbox += (sender.currentTitle)!
        displayText.text = numberbox
    }
    
    private func operSign(sign: String) -> () {
        switch sign {
        case "+":
            historyText.text! += "+"
            opersign = "+"
            firstNum = Int(numberbox)!
            numberbox = ""
        case "-":
            historyText.text! += "-"
            opersign = "-"
            firstNum = Int(numberbox)!
            numberbox = ""
        case "x":
            historyText.text! += "x"
            opersign = "x"
            firstNum = Int(numberbox)!
            numberbox = ""
        case "/":
            historyText.text! += "/"
            opersign = "/"
            firstNum = Int(numberbox)!
            numberbox = ""
        case "%":
            historyText.text! += "%"
            opersign = "%"
            firstNum = Int(numberbox)!
            displayText.text = String(firstNum! / 100)
            numberbox = ""
        case "=":
            if opersign == nil {
            
            } else {
                if opersign == "+" {
                    displayText.text = String(firstNum! + secondNum)
                } else if opersign == "-" {
                    displayText.text = String(firstNum! - secondNum)
                } else if opersign == "x" {
                    displayText.text = String(firstNum! * secondNum)
                } else if opersign == "/" {
                    displayText.text = String(firstNum! / secondNum)
                }
            }
        default:
            displayText.text = String(firstNum!)
        }
    }
}
