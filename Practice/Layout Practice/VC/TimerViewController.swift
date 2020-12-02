//
//  TimerViewController.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class TimerViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var timeList: UITableView!
    
    var timer: Timer?
    var time = [String]()
    var comps: DateComponents = DateComponents(minute: 0, second: 0, nanosecond: 0)
    
    
    lazy var formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "mm:ss.SS"
        return f
    }()
    
    func updateTimer(_ timer: Timer) {
        print(#function, Date(), timer)
        timeLabel.text = formatter.string(for: comps)
    }
    
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            guard timer.isValid else {return}
            self.updateTimer(timer)
        })
    }
    
    @IBAction func stop(_ sender: Any) {
        time.insert(timeLabel.text!, at: 0)
        print(time)
        timeList.reloadData()
        timeLabel.text = "00.00.00"
        timer?.invalidate()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if time.count != 0 {
            return time.count
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if time.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
            cell.textLabel?.text = time[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
