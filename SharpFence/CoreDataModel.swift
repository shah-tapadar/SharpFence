//
//  CoreDataModel.swift
//  SharpFence
//
//  Created by bharghava on 1/20/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation


struct AccuracyDataModel {

    var disFilter: Double?
    var headFilter: Double?
    var level: String?
     

}

struct RouteDetails {
    
    var gfID:String?
    var time: String?
    var latitude: String?
    var longitude: String?
    var distanceFromCenter: String?
    
}

struct GFDetails {
    
    var geoFenceId: String?
    var status: Bool?
    var centerLatitude: Double?
    var centerLongitude: Double?
    var radius: Double?


}
