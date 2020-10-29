//
//  ViewController.swift
//  Calculater
//
//  Created by 임현규 on 2020/10/27.
//

import UIKit

//class ViewController: UIViewController {
//
//    @IBOutlet var Btns: [UIButton]!
//    @IBOutlet weak var displayText: UILabel!
//    @IBOutlet weak var historyText: UILabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        displayText.text = "0"
//        historyText.text = ""
//        for btn in Btns {
//            btn.layer.cornerRadius = 25
//        }
//}
//
//    var displayLabel: String = ""
//    var opersign: String? = nil
//    var firstNum: Int? = nil
//    var numberbox: String = ""
//    var secondNum: Int = 0
//
//
//
//    @IBAction func cancelBtn(_ sender: UIButton) {
//        displayText.text = "0"
//        historyText.text = ""
//        displayLabel = ""
//        firstNum = nil
//        secondNum = 0
//        opersign = nil
//        numberbox = ""
//    }
//
//    @IBAction func backspaceBtn(_ sender: UIButton) {
//        if numberbox.count >= 0 {
//            numberbox.popLast()
//            displayText.text = numberbox
//            historyText.text?.popLast()
//        } else {
//
//        }
//    }
//
//    @IBAction func operatorBtn(_ sender: UIButton) {
//        if numberbox.isEmpty {
//
//        } else {
//        if opersign == nil {
//            operSign(sign: sender.currentTitle!)
//        }else {
//            if sender.currentTitle! == "=" {
//                secondNum = Int(numberbox)!
//                operSign(sign: sender.currentTitle!)
//            } else {
//                numberbox = displayText.text!
//                operSign(sign: sender.currentTitle!)
//                }
//            }
//        }
//    }
//
//
//    @IBAction func numBtn(_ sender: UIButton) {
//        historyText.text! += (sender.currentTitle)!
//        displayLabel += (sender.currentTitle)!
//        numberbox += (sender.currentTitle)!
//        displayText.text = numberbox
//    }
//
//    private func operSign(sign: String) -> () {
//        switch sign {
//        case "+":
//            historyText.text! += "+"
//            opersign = "+"
//            firstNum = Int(numberbox)!
//            numberbox = ""
//        case "-":
//            historyText.text! += "-"
//            opersign = "-"
//            firstNum = Int(numberbox)!
//            numberbox = ""
//        case "x":
//            historyText.text! += "x"
//            opersign = "x"
//            firstNum = Int(numberbox)!
//            numberbox = ""
//        case "/":
//            historyText.text! += "/"
//            opersign = "/"
//            firstNum = Int(numberbox)!
//            numberbox = ""
//        case "%":
//            historyText.text! += "%"
//            opersign = "%"
//            firstNum = Int(numberbox)!
//            displayText.text = String(firstNum! / 100)
//            numberbox = ""
//        case "=":
//            if opersign == nil {
//
//            } else {
//                if opersign == "+" {
//                    displayText.text = String(firstNum! + secondNum)
//                } else if opersign == "-" {
//                    displayText.text = String(firstNum! - secondNum)
//                } else if opersign == "x" {
//                    displayText.text = String(firstNum! * secondNum)
//                } else if opersign == "/" {
//                    displayText.text = String(firstNum! / secondNum)
//                }
//            }
//        default:
//            displayText.text = String(firstNum!)
//        }
//    }
//}

class UpgradeCalculatorViewControler: UIViewController {

    //MARK: - UI Property
    @IBOutlet weak var displayLB: UILabel!
    @IBOutlet weak var historyLB: UILabel!
    
    
    //UI 둥글게하기위해 버튼 컬렉션
    @IBOutlet var Btns: [UIButton]!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            for btn in Btns {
                btn.layer.cornerRadius = 25
            }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for i in Btns {
            i.startAnimatingPressActions()
        }
    }

    //MARK: - IBAction
    //숫자 입력
    var isTyping: Bool = false
    @IBAction func digit(_ sender: UIButton) {
        let currentDigit = sender.currentTitle!
        historyLB!.text! += sender.currentTitle!
        if isTyping {
            let textCurrentlyInDisplay = displayLB!.text!
            displayLB!.text = textCurrentlyInDisplay + currentDigit
        }else {
            displayLB!.text = currentDigit
            isTyping = true
        }
    }
    
    // 리셋
    @IBAction func resetHandler(_ sender: UIButton) {
        displayValue = 0.0
        historyLB.text = ""
        isTyping = false
        calModel.setNumber(displayNum: displayValue)
    }
    
    // 전시된 값을 get 하거나 set하는 displayValue
    var displayValue: Double {
        get {
            return Double(displayLB.text!)!
        }
        set {
            displayLB.text! = String(newValue)
            historyLB!.text! += displayLB.text!
        }
    }
    
    // operation
    var calModel = CalculatorModel()
    
    @IBAction func operation(_ sender: UIButton) {
        historyLB!.text! += sender.currentTitle!
        if isTyping { // check
            calModel.setNumber(displayNum: displayValue)
            isTyping = false
        }
        
        guard let symbol = sender.currentTitle else { return }
        calModel.perfomrOperation(mathSymbol: symbol)

        if calModel.returnValue != nil {
            displayValue = calModel.returnValue!
        }
    }
    
    

}

//<-- 계산기의 모델입니다. 연산기호의 타입을 정의합니다.
class CalculatorModel {
    // 연산타입정의 : 단일, 이항, 등호
    private enum OperationCase {
    case unary((Double) -> Double)
    case binary((Double, Double) -> Double)
    case equal
    }
    
    // 연산기호를 위한 타입 딕셔너리 입니다.
    private var operDic: [String:OperationCase] = [
            "+": .binary({(num1, num2) -> Double in return num1 + num2}),
            "-": .binary({(num1, num2) -> Double in return num1 - num2}),
            "*": .binary({(num1, num2) -> Double in return num1 * num2}),
            "/": .binary({(num1, num2) -> Double in return num1 / num2}),
            "%": .unary ({(num1: Double) -> Double in return num1 / 100}),
            "=": .equal
        ]

// 연산을 기다리는 숫자를 담을 변수를 옵셔널로 선언해줍니다.
var firstNum: Double?

// 연산기호가 입력되면 담긴 숫자를 디스플레이 시켜줍니다
func setNumber(displayNum: Double) {
    firstNum = displayNum
}

// 이항 연산을 위한 WaititngBinary의 인스턴스
private var waitingBinary: WaitingBinary?

var operand: Double?
    func perfomrOperation(mathSymbol: String) {
        if let operationCase = operDic[mathSymbol] {
            
            switch operationCase {
            case .unary(let function):
                if firstNum != nil {
                    firstNum = function(firstNum!)
                }
            case .binary(let binaryFunction):
            if firstNum != nil && operand == nil {
                operand = firstNum!
                waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunction)
            }else if firstNum != nil && operand != nil {
                operand! += firstNum!
                waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunction)
            }else if operand != nil && firstNum == nil {
                waitingBinary = WaitingBinary(firstNum: operand!, waitingFunc: binaryFunction)
            }
            firstNum = nil
            case .equal:
                getResult()
                operand = nil
            }
        }
    }

// 바이너리 값 저장하고 있을 스트럭트
   private struct WaitingBinary {
       let firstNum: Double
       let waitingFunc: (Double,Double) -> Double
       func doBinaryOp(with secondNum: Double) -> Double {
           return waitingFunc(firstNum, secondNum)
       }
   }

// 바이너리 연산 값 구하기
 private func getResult() {
     if waitingBinary != nil && firstNum != nil {
         firstNum = waitingBinary!.doBinaryOp(with: firstNum!)
     }
 }
 // 뷰콘트롤러에 넘겨줄 연산 완료된 값
 var returnValue: Double? {
     return firstNum
 }
}
extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }
}
