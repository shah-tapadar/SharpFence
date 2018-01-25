//
//  CoreDataWrapper.swift
//  SharpFence
//
//  Created by Sebin on 18-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class CoreDataWrapper {
    
 
    
    private static func context() -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    static func addFenceEventToDB(stateObject: AbstractObjectState, event: FenceEventModel) {
        let managedContext = CoreDataWrapper.context()
        let tripEvent = TBL_TRIP_EVENT.init(entity: TBL_TRIP_EVENT.entity(), insertInto: managedContext)
        tripEvent.eventLat = event.latitude ?? 0.0
        tripEvent.eventLong = event.longitude ?? 0.0
        tripEvent.eventType =  event.event?.rawValue
        tripEvent.geoFenceId =  event.identifier
        tripEvent.timeStamp =  event.timeStamp ?? ""
        tripEvent.distance = event.distance ?? 0.0
        tripEvent.eventId = "GF" + " " + "\(arc4random_uniform(100))"
        do {
            try managedContext?.save()
        } catch {
            print("Failed saving")
        }
        
    }

    
    
    static func fetchSavedLocation() -> [TBL_GF_CONFIG]?{
        let managedContext = CoreDataWrapper.context()
        let fetchRequest: NSFetchRequest<TBL_GF_CONFIG> = TBL_GF_CONFIG.fetchRequest()
        do {
            return try  managedContext?.fetch(fetchRequest)

        } catch  {
            return nil
        }
    }
    
    static func fetchConfigAccuracy() -> [TBL_AL_CONFIG]?{
        let managedContext = CoreDataWrapper.context()
        let fetchRequest: NSFetchRequest<TBL_AL_CONFIG> = TBL_AL_CONFIG.fetchRequest()
        do {
            return try  managedContext?.fetch(fetchRequest)
            
        } catch  {
            return nil
        }
    }
    
    static func getConfigAccuracy() -> AccuracyDataModel?{
        var accuracy = AccuracyDataModel()
        var dataArray = self.fetchConfigAccuracy()
        
        guard dataArray?.count != 0 else {
            return accuracy
        }
        
        accuracy.disFilter =  dataArray?[0].disFilter
        accuracy.headFilter =  dataArray?[0].headFilter
        accuracy.level =  dataArray?[0].level
                 
 
        switch accuracy.level ?? ""{
        case "LEVEL 1":
            accuracy.accuracy =  kCLLocationAccuracyBestForNavigation
            break
            
        case "LEVEL 2":
            accuracy.accuracy =  kCLLocationAccuracyBest
            break
            
        case "LEVEL 3":
            accuracy.accuracy =  kCLLocationAccuracyNearestTenMeters
            break
            
        default:
            accuracy.accuracy =  kCLLocationAccuracyBest
            break
        
        }
        
        
        return accuracy
        
    }
    
    static func saveAccuracyToDB(dataModel :AccuracyDataModel) {
    
            let managedContext = CoreDataWrapper.context()
            let request = NSFetchRequest<TBL_AL_CONFIG>(entityName: "TBL_AL_CONFIG")
        var entity:TBL_AL_CONFIG?
        
        
        do {
             let searchResults = try managedContext?.fetch(request)
            
            if searchResults?.count == 0 {
             entity = TBL_AL_CONFIG.init(entity: TBL_AL_CONFIG.entity(), insertInto: managedContext)
            } else {
                entity = searchResults?[0]
            }
            
            entity?.disFilter = dataModel.disFilter ?? 0.0
            entity?.headFilter = dataModel.headFilter ?? 0.0
            entity?.level = dataModel.level ?? ""
            try  managedContext?.save()
            
        } catch {
            print("Failed saving")
        }

          
    }
    
    static func flushData(table: String ){
        let managedContext = CoreDataWrapper.context()
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: table)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext?.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    static func deleteGeoFence(id: String){
        let managedContext = CoreDataWrapper.context()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TBL_GF_CONFIG")
        let predicate = NSPredicate(format: "geoFenceId = %@", id)
        fetchRequest.predicate = predicate
        
        
        do {
            if let object = try managedContext?.fetch(fetchRequest)[0] {
                // if there is exception or there is no value
                  managedContext?.delete(object)
            }
           
        } catch let error as NSError {
            debugPrint(error)
        }

    }
    
    static func fetchAllTripEvents() -> [TBL_TRIP_EVENT]?{
        let managedContext = CoreDataWrapper.context()
        let fetchRequest: NSFetchRequest<TBL_TRIP_EVENT> = TBL_TRIP_EVENT.fetchRequest()
        do {
            return try  managedContext?.fetch(fetchRequest)
            
        } catch  {
            return nil
        }
    }
    
    static func saveGFToDB(dataModel : LocationModel){
        
    let managedContext = CoreDataWrapper.context()
    let entity =  TBL_GF_CONFIG.init(entity: TBL_GF_CONFIG.entity(), insertInto: managedContext)
     entity.centerLatitude = dataModel.latitude ?? 0.0
    entity.centerLongitude = dataModel.longitude  ?? 0.0
    entity.radius = dataModel.radius ?? 0.0
    entity.status = dataModel.status ?? false
    entity.geoFenceId = dataModel.identifier ?? "0"
        
        do {
                    try managedContext?.save()
                   // boundaries.append(boundary)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }

    }
    
    
}
