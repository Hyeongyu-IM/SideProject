//
//  WeekendTableViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    static let registerID: String = "\(HourlyTableViewCell.self)"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HourlyTableCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: HourlyTableCollectionViewCell.registerID)
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate {
    
}

extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("MainTableViewController.controllerIndex \(MainTableViewController.controllerIndex) 콜렉션뷰에서 테스트")
        return weatherViewModel.hourCells[MainTableViewController.controllerIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyTableCollectionViewCell.registerID, for: indexPath) as? HourlyTableCollectionViewCell else { return UICollectionViewCell()}
        cell.hourData(weatherViewModel.hourCells[MainTableViewController.controllerIndex][indexPath.row])
        return cell
    }
    
    
}
