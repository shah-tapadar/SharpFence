//
//  DataWrapper.swift
//  SharpFence
//
//  Created by Sebin on 19-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation

class DataWrapper {
    static func locationModels() -> [LocationModel]? {
        guard let dbLocations = CoreDataWrapper.fetchSavedLocation() else {
            return nil
        }
        var locationArray = [LocationModel]()
        for dbLocation in dbLocations {
            let location = LocationModel(dbModel: dbLocation)
            locationArray.append(location)
        }
        return locationArray
    }
    
    func tempLocationModels() -> [LocationModel] {
        var locationModelArray = [LocationModel]()
        
        let location1 = LocationModel()
        location1.identifier = "location1testfence"
        location1.latitude = 39.687382
        location1.longitude = -104.726521
        location1.radius = 100
        locationModelArray.append(location1)
        
        let location2 = LocationModel()
        location2.identifier = "location2testfence"
        location2.latitude = 9.996158
        location2.longitude = 76.352945
        location2.radius = 100
        locationModelArray.append(location2)
        
        let location3 = LocationModel()
        location3.identifier = "location3testfence"
        location3.latitude = 39.556296
        location3.longitude = -104.822191
        location3.radius = 100
        locationModelArray.append(location3)
        
        return locationModelArray
    }
}
