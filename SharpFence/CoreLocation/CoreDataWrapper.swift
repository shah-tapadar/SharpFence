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
    
//    static func saveMonitoredRegionsAndStatus(objectModel: AbstractObjectState) {
//        for state in objectModel.objectStateAray{
//            addStateToDB(state: state)
//        }
//    }
    
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
        tripEvent.eventType =  String(describing: event.event)
        tripEvent.geoFenceId =  event.identifier
        tripEvent.timeStamp =  event.timeStamp
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
