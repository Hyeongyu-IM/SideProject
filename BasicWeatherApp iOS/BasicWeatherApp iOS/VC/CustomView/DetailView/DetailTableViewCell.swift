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
        configData()
    }
    
    func configData() {
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
            cell.detailData("일출", dataTarget.sunrise)
        case 2:
            cell.detailData("일몰", dataTarget.sunset)
        case 3:
            cell.detailData("눈 올 확률", "\(dataTarget.snow ?? "")")
        case 4:
            cell.detailData("습도", "\(dataTarget.humidity)")
        case 5:
            cell.detailData("바람", "\(dataTarget.wind)")
        case 6:
            cell.detailData("체감", "\(dataTarget.feelsLike)")
        case 7:
            cell.detailData("강수량", "\(dataTarget.rain ?? "")")
        case 8:
            cell.detailData("기압", "\(dataTarget.pressure)")
        case 9:
            cell.detailData("가시거리", "\(dataTarget.visibility)")
        case 10:
            cell.detailData("자외선지수", "\(dataTarget.uvi)")
        default: break
            }
        return cell
    }
    
    
}
