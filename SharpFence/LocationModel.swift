//
//  LocationModel.swift
//  SharpFence
//
//  Created by Sebin on 16-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    
    var identifier: String?
    var latitude: Double?
    var longitude: Double?
    var radius: Double?
    
    init(dbModel: TBL_GF_CONFIG) {
        identifier = dbModel.geoFenceId
        latitude = dbModel.centerLatitude
        longitude = dbModel.centerLongitude
        radius = dbModel.radius
    }
}
