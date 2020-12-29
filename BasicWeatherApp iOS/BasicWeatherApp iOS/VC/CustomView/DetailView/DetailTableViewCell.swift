//
//  DetailTableViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/28.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let registerID: String = "\(DetailTableViewCell.self)"
    @IBOutlet weak var collectionView: UICollectionView!
    
    let weatherViewModel = WeatherViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "DetailTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DetailTableCollectionViewCell.registerID)
    }
}

extension DetailTableViewCell: UICollectionViewDelegate {
    
}

extension DetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTableCollectionViewCell.registerID, for: indexPath) as? DetailTableCollectionViewCell else { return UICollectionViewCell() }
        let dataTarget = weatherViewModel.detailCells[MainTableViewController.controllerIndex]
        
        switch indexPath.row {
        case 1:
            cell.configData("일출", dataTarget.sunrise)
        case 2:
            cell.configData("일몰", dataTarget.sunset)
        case 3:
            cell.configData("눈 올 확률", "\(dataTarget.snow ?? 0.0)")
        case 4:
            cell.configData("습도", "\(dataTarget.humidity)")
        case 5:
            cell.configData("바람", "\(dataTarget.wind)")
        case 6:
            cell.configData("체감", "\(dataTarget.feelsLike)")
        case 7:
            cell.configData("강수량", "\(dataTarget.rain ?? 0.0)")
        case 8:
            cell.configData("기압", "\(dataTarget.pressure)")
        case 9:
            cell.configData("가시거리", "\(dataTarget.visibility)")
        case 10:
            cell.configData("자외선지수", "\(dataTarget.uvi)")
        default: break
            }
        return cell
    }
    
    
}
