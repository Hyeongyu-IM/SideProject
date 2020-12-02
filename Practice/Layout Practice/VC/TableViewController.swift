//
//  ViewController.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class TableViewController: UIViewController {
    
    let bountyViewModel = TableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    
}
