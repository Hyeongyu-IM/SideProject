//
//  MainTableViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/26.
//

import UIKit

class MainTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var controllerIndex = 0
    let weatherViewModel = WeatherViewModel()
    
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
        tableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: HourlyTableViewCell.registerID)
        tableView.register(UINib(nibName: "WeekendTableViewCell", bundle: nil), forCellReuseIdentifier: WeekendTableViewCell.registerID)
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: DetailTableViewCell.registerID)
        
        
        let headerView = Bundle.main.loadNibNamed("CustomHeaderView", owner: nil, options: nil)?.first as! CustomHeaderView
        tableView.tableHeaderView = headerView
    }
}

extension MainTableViewController: UITableViewDelegate {
    
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:  return 1
        case 2:  return 7
        case 3:  return 1
        case 4:  return 1
        case 5:  return 1
        default: break
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.registerID, for: indexPath) as? HourlyTableViewCell else { break }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekendTableViewCell.registerID, for: indexPath) as? WeekendTableViewCell else { break }
            let target = weatherViewModel.weekendCells[MainTableViewController.controllerIndex]
            cell.configData(target[indexPath.row])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "longdescriptioncell", for: indexPath)
            cell.textLabel?.text = "오늘: 날씨가 화창하고 오후에 비가올수 있습니다. 모두 장난이니까 믿지 마세요"
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.registerID, for: indexPath) as? DetailTableViewCell else { break }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "linkcell", for: indexPath)
            cell.textLabel?.text = "자료가 없습니다"
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView.instance()
        headerView.configData()
        return headerView
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
