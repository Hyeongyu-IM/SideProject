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
    
    private var hourDatas = [HourCell]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        registerCell()
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "HourlyTableCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: HourlyTableCollectionViewCell.registerID)
    }
    
    func passHourDatas(hourData: [HourCell]) {
        hourDatas = hourData
        collectionView.reloadData()
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate {
    
}

extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("MainTableViewController.controllerIndex \(MainTableViewController.controllerIndex) 콜렉션뷰에서 테스트")
        return hourDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyTableCollectionViewCell.registerID, for: indexPath) as? HourlyTableCollectionViewCell else { return UICollectionViewCell()}
        cell.setHourData(hourDatas[indexPath.row])
        return cell
    }
}

extension HourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 140)
    }
}
