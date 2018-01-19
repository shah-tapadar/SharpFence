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
    
//    func saveMonitoredRegionsAndStatus(objectModel: StateObjectModel) {
//        for state in objectModel.objectStateAray{
//            addStateToDB(state: state)
//        }
//    }
    
    static func addStateToDB(state: StateModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let tripEvent = TBL_TRIP_EVENT.init(entity: TBL_TRIP_EVENT.entity(), insertInto: managedContext)
        tripEvent.eventLat = state.latitude ?? 0.0
        tripEvent.eventLong = state.longitude ?? 0.0
        tripEvent.eventType = state.state?.rawValue
        tripEvent.geoFenceId = state.regionId ?? ""
        tripEvent.timeStamp =  state.time
    }
    
    func fetchSavedLocation() -> [TBL_AL_CONFIG]?{
        let fetchRequest: NSFetchRequest<TBL_AL_CONFIG> = TBL_AL_CONFIG.fetchRequest()
        do {
            return try  fetchRequest.execute()

        } catch  {
            return nil
        }
    }
}
