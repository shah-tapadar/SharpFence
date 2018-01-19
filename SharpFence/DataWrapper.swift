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
}
