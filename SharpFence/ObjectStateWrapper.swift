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

    static let sharedObjectStateWrapper = ObjectStateWrapper.init()

 
    func setState(state: AbstractObjectState) {
        currentState = state
    }

    func changeState(fenceEvent:FenceEventModel, deviceEvent:DeviceEventModel ) {
        currentState?.processChangeState(wrapper: self, fenceEvent: fenceEvent, deviceEvent: deviceEvent)
    }
    
   
}
