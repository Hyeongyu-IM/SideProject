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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.backgroundColor = .clear
        registerCell()
    }
    
    private var detailData: DetailCell?
    
    func registerCell() {
        collectionView.register(UINib(nibName: "DetailTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DetailTableCollectionViewCell.registerID)
    }
    
    func passDetailDatas( detailData: DetailCell) {
        self.detailData = detailData
    }
}

extension DetailTableViewCell: UICollectionViewDelegate {
    
}

extension DetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTableCollectionViewCell.registerID, for: indexPath) as? DetailTableCollectionViewCell,
              let detailData = detailData else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 1:
            cell.setDetailData("일출", detailData.sunrise)
            return cell
            
        case 2:
            cell.setDetailData("일몰", detailData.sunset)
            return cell
            
        case 3:
            cell.setDetailData("눈 올 확률", detailData.snow ?? "")
            return cell
            
        case 4:
            cell.setDetailData("습도", detailData.humidity)
            return cell
            
        case 5:
            cell.setDetailData("바람", detailData.wind)
            return cell
            
        case 6:
            cell.setDetailData("체감", detailData.feelsLike)
            return cell
            
        case 7:
            cell.setDetailData("강수량", detailData.rain ?? "")
            return cell
            
        case 8:
            cell.setDetailData("기압", detailData.pressure)
            return cell
            
        case 9:
            cell.setDetailData("가시거리", detailData.visibility)
            return cell
            
        case 10:
            cell.setDetailData("자외선지수", detailData.uvi)
            return cell
            
        default:
            print("셀이 생성되지 못했습니다")
            break
            }
        return cell
    }
}
