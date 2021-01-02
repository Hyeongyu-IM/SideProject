//
//  CoreDataManager.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/12.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private let modelName: String = "DataLocation"
    private let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    private let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataLocation")
    
    
    // 저장된 데이터 받아오기
    func getLocationList() -> [Location] {
           var models = [Location]()

            do {
                if let result: [DataLocation] = try context?.fetch(fetchRequest) as? [DataLocation] {
                  models = result.map { Location(name: $0.stateName ?? "" , latitude: $0.latitude, longitude: $0.longitude) }
                   }
               } catch let error as NSError {
                   print("Could not fetch: \(error), \(error.userInfo)")
               }
            print("models 입니다 \(models)")
        return models
        }

    // saveLocation
    func saveLocation(latitude: Double, longitude: Double) -> Bool {
        let object = NSEntityDescription.insertNewObject(forEntityName: modelName, into: context!)
        object.setValue(latitude, forKey: "latitude")
        object.setValue(longitude, forKey: "longitude")
        object.setValue([latitude, longitude], forKey: "location")
        
        do{
            try context?.save()
            print("데이터 저장성공")
            return true
        } catch {
            context?.rollback()
            print("데이터 저장실패")
            return false
            }
        print("데이터 저장실패")
        return false
        }
    
    // deleteLocation 셀 지울때 메서드 호출 ( latitude 매개변수 )
    func deleteLocation(latitude: Double, onSuccess: @escaping ((Bool) -> Void)) -> Bool {
        let deleteRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(latitude: latitude)
       
        do {
            if let results: [DataLocation] = try context?.fetch(deleteRequest) as? [DataLocation] {
            if results.count != 0 {
                         context?.delete(results[0])
                       }
                   }
               } catch let error as NSError {
                   print("Could not fatch: \(error), \(error.userInfo)")
                   onSuccess(false)
               }
        do {
                try context?.save()
                return true
            } catch {
                context?.rollback()
                return false
                }
            print("코어데이터 삭제 성공")
           }
    
    // 현재위치 업데이트 앱 시작시 메서드 호출
    func updateCurrentLocation(_ latitude: Double, _ longitude: Double) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: modelName)
        do {
            let data: [DataLocation] = try (context?.fetch(fetchRequest) as? [DataLocation])!
            let objectUpdate = data[0]
            objectUpdate.setValue(latitude, forKey: "latitude")
            objectUpdate.setValue(longitude, forKey: "longitude")
            objectUpdate.setValue([latitude, longitude], forKey: "location")
            do {
                try context?.save()
            } catch {
                print("update Error \(error)")
            }
        } catch {
            print(error)
        }
        print("코어데이터 현재위치 업데이트 성공")
    }
    
    
    func deleteAllData() {
        let fetrequest = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetrequest)
        
        do {
            try context?.execute(batchDeleteRequest)
            print("데이터 모두 삭제")
        } catch {
            print(error)
        }
    }
}
   

extension CoreDataManager {
    fileprivate func filteredRequest(latitude: Double) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "latitude = %@", NSNumber(value: latitude))
        return fetchRequest
    }
}
