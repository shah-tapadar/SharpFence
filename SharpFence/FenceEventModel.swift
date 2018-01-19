//
//  FenceEventModel.swift
//  SharpFence
//
//  Created by Sebin on 16-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation

enum fenceEventType {
    case entry
    case exit
}

class FenceEventModel {
    
    init(location: LocationModel, event:fenceEventType?, distance: Double?){
        self.identifier = location.identifier
        self.latitude = location.latitude
        self.longitude = location.longitude
        self.event = event
        self.distance = distance
        }
    
    var event: fenceEventType?
    var identifier: String?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
	
 
	
    func isEventExit() -> Bool{
        
    return   self.event == fenceEventType.exit ? true : false
    
    }
    
	
    func isEventEntry() -> Bool{
        
      return   self.event == fenceEventType.entry ? true : false
    }
    
}

