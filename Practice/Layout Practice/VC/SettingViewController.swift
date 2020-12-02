//
//  SettingViewController.swift
//  Layout Practice
//
//  Created by 임현규 on 2020/12/02.
//

import UIKit

class SettingViewController: UIViewController {
    
    let SettingViewModel = PhotosSettingSection.generateData()
    
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingViewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingViewModel[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = SettingViewModel[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: target.type.rawValue, for: indexPath)
        cell.textLabel?.text = target.title
        
        switch target.type {
        
        case .checkmark:
            cell.accessoryType = target.on ? .checkmark : .none
        case .detailTitle:
            cell.detailTextLabel?.text = target.subTitle
            cell.imageView?.image = UIImage(named: target.imageName!)
            
        case .switch:
            if let switchView = cell.accessoryView as? UISwitch {
                switchView.isOn = target.on
            }
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingViewModel[section].header
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return SettingViewModel[section].footer
    }
}
    
