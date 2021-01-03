//
//  MainTableViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/26.
//

import UIKit

class MainTableViewController: UIViewController {
    static let identifier: String = "\(MainTableViewController.self)"
    var location: Location!
    var index = 0
    
    @IBOutlet weak var mainTableView: UITableView!
    
    static func instance() -> MainTableViewController? {
        return UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
            identifier: "MainTableViewController") as? MainTableViewController
    }
    
    var viewModel: WeatherViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.location.bind { [weak self] _ in
                self!.mainTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load at index \(self.index)")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        registerCells()
        getWeatherData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let temperatureUnit = TemperatureUnit.shared.unit
//        if viewModel?.temperatureUnit.value != temperatureUnit {
//            viewModel?.temperatureUnit.value = temperatureUnit
//        }
//    }
    
    func registerCells() {
        mainTableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: HourlyTableViewCell.registerID)
        mainTableView.register(UINib(nibName: "WeekendTableViewCell", bundle: nil), forCellReuseIdentifier: WeekendTableViewCell.registerID)
        mainTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: DetailTableViewCell.registerID)
    }
    
    func getWeatherData() {
        print("get weather")
        guard let location = self.location else {
            print(LocationError.noLocationConfigured.localizedDescription)
            return
        }
        self.viewModel = WeatherViewModel(location: location)
        self.viewModel?.retrieveWeatherInfo()
    }
}

extension MainTableViewController: UITableViewDelegate {
    
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return WeatherTableViewSection.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("section \(section)")
        guard let section = WeatherTableViewSection(sectionIndex: section) else { return 0 }
        switch section {
        case .hour:
            return 1
        case .weekend:
            return viewModel?.weekendTableViewCell.count ?? 0
        case .description:
            return viewModel?.weatherDescription?.count ?? 0
        case .detail:
            return 1
        case .link:
            return 1
        }
        print(#function, "섹션결과값이 없습니다")
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = WeatherTableViewSection(sectionIndex: indexPath.section) else { return UITableViewCell() }
//        print("IndexPath.section \(indexPath.section)")
        switch section {
        case  .hour:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.registerID, for: indexPath) as? HourlyTableViewCell,
                  let hourdatas = viewModel?.hourlyTableViewCell else { return UITableViewCell() }
            cell.passHourDatas(hourData: hourdatas)
            return cell
            
        case .weekend:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekendTableViewCell.registerID, for: indexPath) as? WeekendTableViewCell,
                let weekendDatas = viewModel?.weekendTableViewCell else { return UITableViewCell() }
            cell.setWeekendData(weekendData: weekendDatas[indexPath.row])
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "longdescriptioncell", for: indexPath)
            cell.textLabel?.text = viewModel?.weatherDescription ?? ""
            return cell
            
        case .detail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.registerID, for: indexPath) as? DetailTableViewCell,
                let detailDatas = viewModel?.detailTableViewCell  else { break }
            cell.passDetailDatas(detailData: detailDatas)
            return cell
            
        case .link:
            let cell = tableView.dequeueReusableCell(withIdentifier: "linkcell", for: indexPath)
            cell.textLabel?.text = "자료가 없습니다"
            return cell
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerData = viewModel?.customHeaderViewData else { return UIView() }
        let headerView = CustomHeaderView.instance()
        headerView.setHeaderData(headerData)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(400)
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
