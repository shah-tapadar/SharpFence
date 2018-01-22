//
//  ObjectStateWrapper.swift
//  SharpFence
//
//  Created by Sebin on 17-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import CoreLocation

class ObjectStateWrapper: NSObject {

    private var currentState: AbstractObjectState?
    private static var wrapper: ObjectStateWrapper?
    
    
    private override init(){
        currentState = WhiteObjectState()
        }

    static let sharedObjectStateWrapper = ObjectStateWrapper()

 
    func setState(state: AbstractObjectState) {
        currentState = state
    }

    func changeState(fenceEvent:FenceEventModel, deviceEvent:DeviceEventModel ) {
        currentState?.processChangeState(wrapper: self, fenceEvent: fenceEvent, deviceEvent: deviceEvent)
    }
    
    // To be reviewed
    func callDBToAddState(fenceEvent:FenceEventModel, state:objectState?){
        
        var location:CLLocationCoordinate2D?
        
        if let lat = fenceEvent.latitude, let long = fenceEvent.longitude {
            location = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        } else {
            location = CLLocationCoordinate2D.init()
        }
        CoreDataWrapper.addStateToDB(state: StateModel.init(state: state, time: DateFormatter().string(from: Date()), regionId:fenceEvent.identifier, coordinate:location))
    }
}
