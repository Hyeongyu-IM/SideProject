//
//  ViewController.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class TableViewController: UIViewController {
    
    let bountyViewModel = TableViewModel()
    @IBOutlet weak var bountyList: UITableView!
    
    @IBOutlet weak var toggleBtnClicked: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toggleBtn(_ sender: UISwitch) {
        bountyList.setEditing(sender.isOn, animated: true)
    }
    

}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyViewModel.numberOfbountylist
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let bountyInfo = bountyViewModel.sortedList[indexPath.row]
        cell.update(info: bountyInfo)
        return cell
    }
    
    // 구현하지 않으면 자동으로 true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("클릭되었습니다 \(indexPath.row)")
    }
}
