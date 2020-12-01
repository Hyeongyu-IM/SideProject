//
//  ViewController.swift
//  Practice tableView
//
//  Created by 임현규 on 2020/11/29.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = PhotosSettingSection.generateData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    

}

extension ViewController: UITableViewDataSource{
    @objc func switchValueChanged(_ sender: UISwitch) {
        print(sender.isOn, sender.tag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.count
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel[section].items.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let target = viewModel[indexPath.section].items[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: target.type.rawValue, for: indexPath)
    
    switch target.type {
    case .checkmark:
        cell.textLabel?.text = target.title
        cell.accessoryType = target.on ? .checkmark : .none
    case .detailTitle:
        cell.textLabel?.text = target.title
        cell.detailTextLabel?.text = target.subTitle
        cell.imageView?.image = UIImage(named: target.imageName!)
    case .switch:
        cell.textLabel?.text = target.title
        if let switchView = cell.accessoryView as? UISwitch {
            switchView.isOn = target.on
            switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            switchView.tag = indexPath.section
        }
    default:
        break
    }
    return cell
}
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel[section].header
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel[section].footer
    }
}

extension ViewController: UITableViewDelegate{
    
    
    
}
