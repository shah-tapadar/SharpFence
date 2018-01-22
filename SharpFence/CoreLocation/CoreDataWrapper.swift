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

class CoreDataWrapper {
    
    static func saveMonitoredRegionsAndStatus(objectModel: StateObjectModel) {
        for state in objectModel.objectStateAray{
            addStateToDB(state: state)
        }
    }
    
    private static func context() -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    static func addStateToDB(state: StateModel) {
        let managedContext = CoreDataWrapper.context()
        let tripEvent = TBL_TRIP_EVENT.init(entity: TBL_TRIP_EVENT.entity(), insertInto: managedContext)
        tripEvent.eventLat = state.latitude ?? 0.0
        tripEvent.eventLong = state.longitude ?? 0.0
        tripEvent.eventType = state.state?.rawValue
        tripEvent.geoFenceId = state.regionId ?? ""
        tripEvent.timeStamp =  state.time
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
    
    static func saveAccuracyToDB(dataModel :AccuracyDataModel) {
    
            let managedContext = CoreDataWrapper.context()
            let entity = TBL_AL_CONFIG.init(entity: TBL_AL_CONFIG.entity(), insertInto: managedContext)
              entity.disFilter = dataModel.disFilter ?? 0.0
              entity.headFilter = dataModel.headFilter ?? 0.0
              entity.level = dataModel.level ?? ""
        
        do {
            try managedContext?.save()
        } catch {
            print("Failed saving")
        }

          
    }
    
    static func flushData(){
        let managedContext = CoreDataWrapper.context()
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "TBL_TRIP_EVENT")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext?.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
//    static func fetchTripEvents() -> [NSManagedObject]{
//        
//         var data :[NSManagedObject] = []
//        
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return data
//        }
//       
//        
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//        let fetchRequest =
//            NSFetchRequest<NSManagedObject>(entityName: "TBL_TRIP_EVENT")
//        do {
//            data = try managedContext.fetch(fetchRequest)
//            return data
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//             return data
//            
//        }
//    
//    }
    
    static func fetchAllTripEvents() -> [TBL_TRIP_EVENT]?{
        let managedContext = CoreDataWrapper.context()
        let fetchRequest: NSFetchRequest<TBL_TRIP_EVENT> = TBL_TRIP_EVENT.fetchRequest()
        do {
            return try  managedContext?.fetch(fetchRequest)
            
        } catch  {
            return nil
        }
    }
    
    static func saveGFToDB(dataModel : TBL_GF_CONFIG){
    let managedContext = CoreDataWrapper.context()
    let entity =  TBL_GF_CONFIG.init(entity: TBL_GF_CONFIG.entity(), insertInto: managedContext)
     entity.centerLatitude = dataModel.centerLatitude 
    entity.centerLongitude = dataModel.centerLongitude 
    entity.radius = dataModel.radius 
    entity.status = dataModel.status
    entity.geoFenceId = dataModel.geoFenceId ?? ""
        
        do {
                    try managedContext?.save()
                   // boundaries.append(boundary)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }

    }
    
    static func fetchGF() -> [NSManagedObject]{
        var data :[NSManagedObject] = []
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return data
        }
        
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TBL_GF_CONFIG")
        do {
            data = try managedContext.fetch(fetchRequest)
            return data
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return data
            
        }

    
    }

}
