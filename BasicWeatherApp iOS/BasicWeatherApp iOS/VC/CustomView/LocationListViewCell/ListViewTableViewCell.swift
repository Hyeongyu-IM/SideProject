//
//  ListViewTableViewCell.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2021/01/03.
//

import UIKit

class ListViewTableViewCell: UITableViewCell {
    static let registerID: String = "\(ListViewTableViewCell.self)"

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setWeatherData(from weatherItem: WeatherListViewCell) {
        self.timeLabel.text = weatherItem.dt
        self.stateNameLabel.text = weatherItem.state
        self.currentTempLabel.text = weatherItem.currentTempC
    }
    
}
