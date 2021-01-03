//
//  searchViewController.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import UIKit

class LocationListViewController: UIViewController {
    static let identifier: String = "\(LocationListViewController.self)"
    private let coreDatas = CoreDataManager()
    var locations = [Location]()
    
    weak var delegate: LocationListViewDelegate?
    
    @IBOutlet weak var weatherListView: UITableView!
    @IBOutlet weak var tempToggleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherListView.delegate = self
        self.weatherListView.dataSource = self
        self.tempToggleBtn.isSelected = !TemperatureUnit.shared.boolValue
    }
    
    @IBAction func addLocationBtnTouched(_ sender: Any) {
        let subStoryBoard = UIStoryboard(name: "Mainsub", bundle: nil)
        guard let searchViewController = subStoryBoard.instantiateViewController(identifier: SearchViewController.identifier) as? SearchViewController else {
            print(CreationError.toSearchViewController)
            return
        }
        searchViewController.delegate = self
        self.present(searchViewController, animated: true, completion: nil)
    }
    
    @IBAction func tempChangeBtnTouched(_ sender: UIButton) {
        TemperatureUnit.shared.setUnit(with: sender.isSelected)
    }
    
    
    
}

extension LocationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let cellType = LocationListCellType(rowIndex: indexPath.row) else {
            return false
        }
        return cellType.canEditRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewTableViewCell.registerID , for: indexPath)
        guard let cellType = LocationListCellType(rowIndex: indexPath.row) else {
            return cell
        }
        cell.textLabel?.text = cellType.defaultText ?? self.locations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDatas.deleteLocation(stateName: self.locations[indexPath.row].name!)
            self.locations.remove(at: indexPath.row)
            }
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.delegate?.userDeleteLocation(at: indexPath.row)
        }
    }

extension LocationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.userDidSelectLocation(at: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LocationListViewController: SearchViewDelegate {
    func userSelected(newLocation: Location) {
        self.locations.append(newLocation)
        coreDatas.saveLocation(newLocation)
//        let savingList = Array(locations[1..<locations.count])
        self.delegate?.userAdd(newLocation: newLocation)
        self.weatherListView.reloadData()
    }
}
