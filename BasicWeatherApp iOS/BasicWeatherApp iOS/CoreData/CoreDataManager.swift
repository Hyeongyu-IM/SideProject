//
//  CoreDataManager.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/12.
//

import UIKit
import CoreData

class CoreDataManager {
    
    let modelName: String = "DataLocation"
    
    lazy var locationList: [NSManagedObject] = {
        return self.fetch()
    }()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataLocation")
    
    // 저장된 데이터 받아오기
    func fetch() -> [NSManagedObject] {
        guard let result = try! context?.fetch(fetchRequest) else { return [NSManagedObject()] }
        return result
    }
    
    // saveLocation
    func save(latitude: Double, longitude: Double) -> Bool {
        let object = NSEntityDescription.insertNewObject(forEntityName: modelName, into: context!)
        object.setValue(latitude, forKey: "latitude")
        object.setValue(longitude, forKey: "longitude")
        object.setValue([latitude, longitude], forKey: "location")
        
        do{
            try context?.save()
            self.locationList.insert(object, at: locationList.count)
            return true
        } catch {
            context?.rollback()
            return false
            }
        }
    
    // deleteLocation
    func delete(object: NSManagedObject) -> Bool {
        context?.delete(object)
        
        do {
            try context?.save()
            return true
        } catch {
            context?.rollback()
            return false
        }
      }
    
    // update
    func update(object: NSManagedObject, latitude: Double, longitude: Double) -> Bool {
        object.setValue(latitude, forKey: "latitude")
        object.setValue(longitude, forKey: "longitude")
        object.setValue([latitude, longitude], forKey: "location")
        
        do {
            try context?.save()
            return true
        } catch {
            context?.rollback()
            return false
        }
     }
    }
