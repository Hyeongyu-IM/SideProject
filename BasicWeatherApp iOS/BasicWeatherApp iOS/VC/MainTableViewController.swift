//
//  MainTableViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/26.
//

import UIKit

class MainTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dummymodel = ["data", "data",  "data",  "data",  "data",  "data",  "data",  "data",  "data"]
    
    static var controllerIndex = 0
    
    static func instance() -> MainTableViewController? {
        return UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
            identifier: "MainTableViewController") as? MainTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = Bundle.main.loadNibNamed("CustomHeaderView", owner: nil, options: nil)?.first as! CustomHeaderView
        tableView.tableHeaderView = headerView
        
      
        
    }
}

extension MainTableViewController: UITableViewDelegate {
    

}

extension MainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dummymodel[indexPath.row]
        
        return cell
    }
    
    
}

extension MainTableViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = Bundle.main.loadNibNamed("CustomHeaderView", owner: nil, options: nil)?.first as? CustomHeaderView else { return }
        let offset = scrollView.contentOffset.y
        
        let changeStartOffset: CGFloat = -180
        let changeSpeed: CGFloat = 100
        headerView.tempStackView.alpha = min(1.0, (offset - changeStartOffset) / changeSpeed)
    }
}

