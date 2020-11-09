//
//  ViewController.swift
//  ConfigureDelegate
//
//  Created by 임현규 on 2020/11/09.
//

import UIKit

protocol ComposeDelegate {
    func composer(_ vc: UIViewController, didInput value: String?)
    func composerDidCancel(_ vc: UIViewController)
}

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ComposeViewController {
            vc.delegate = self
        }
    }

    @IBOutlet weak var hello: UILabel!
    
    @IBAction func sendingSegue(_ sender: Any) {
        performSegue(withIdentifier: "plus", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class ComposeViewController: UIViewController {

    var delegate: ComposeDelegate?
    
    @IBOutlet weak var text: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.composerDidCancel(self)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        delegate?.composer(self, didInput: text.text)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController: ComposeDelegate {
    func composer(_ vc: UIViewController, didInput value: String?) {
        hello.text = value
    }
    
    func composerDidCancel(_ vc: UIViewController) {
        hello.text = "Cancel"
    }
    
    
}

extension ComposeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.composer(self, didInput: text.text)
        dismiss(animated: true, completion: nil)
        resignFirstResponder()
        return true
    }
    
}
