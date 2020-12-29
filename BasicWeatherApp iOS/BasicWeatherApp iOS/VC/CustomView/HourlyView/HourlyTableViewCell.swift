//
//  WeekendTableViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    static let registerID: String = "\(HourlyTableViewCell.self)"
    let weatherViewModel = WeatherViewModel()
    var cellCount: Int!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionViewCellCount.bind { [weak self] count in
            self?.cellCount = count
        }
        collectionView.register(UINib(nibName: "HourlyTableCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: HourlyTableCollectionViewCell.registerID)
    }
    
    let collectionViewCellCount: Binder = Binder(10)
    
    func reloadCellCount(_ data: [[HourCell]],_ index: Int) {
        self.collectionViewCellCount.value = data[index].count
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate {
    
}

extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyTableCollectionViewCell.registerID, for: indexPath) as? HourlyTableCollectionViewCell else { return UICollectionViewCell()}
        cell.hourData(weatherViewModel.hourCells[MainTableViewController.controllerIndex][indexPath.row])
        return cell
    }
    
    
}
