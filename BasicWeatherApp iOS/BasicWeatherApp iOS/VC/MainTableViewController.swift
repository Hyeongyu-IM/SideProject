//
//  MainTableViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/26.
//

import UIKit

class MainTableViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
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
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: HourlyTableViewCell.registerID)
        mainTableView.register(UINib(nibName: "WeekendTableViewCell", bundle: nil), forCellReuseIdentifier: WeekendTableViewCell.registerID)
        mainTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: DetailTableViewCell.registerID)
        
        
    }
}

extension MainTableViewController: UITableViewDelegate {
    
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("section \(section)")
        switch section {
        case 0:
            return 1
        case 1:
            return weatherViewModel.weekendCells.count
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default: break
        }
        print(#function, "섹션결과값이 없습니다")
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("IndexPath.section \(indexPath.section)")
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.registerID, for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekendTableViewCell.registerID, for: indexPath) as? WeekendTableViewCell else { return UITableViewCell() }
            let target = weatherViewModel.weekendCells[MainTableViewController.controllerIndex]
            cell.updateUIData(weekendData: target, indexPath.row)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "longdescriptioncell", for: indexPath)
            cell.textLabel?.text = "오늘: 날씨가 화창하고 오후에 비가올수 있습니다. 모두 장난이니까 믿지 마세요"
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.registerID, for: indexPath) as? DetailTableViewCell else { break }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "linkcell", for: indexPath)
            cell.textLabel?.text = "자료가 없습니다"
            return cell
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView.instance()
        headerView.updateUIData(headerData: weatherViewModel.headerDatas, MainTableViewController.controllerIndex)
        print(weatherViewModel.headerDatas[MainTableViewController.controllerIndex])
        print(weatherViewModel.headerDatas)
        print("uiUpdate 메서드가 호출되었습니다")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
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
