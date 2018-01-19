//
//  WhiteObjectState.swift
//  SharpFence
//
//  Created by Sebin on 17-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import CoreLocation

class WhiteObjectState:  AbstractObjectState{
    
    
    var identifier: String {
        get {
            //code to execute
            return  self.identifier
        }
        set(newValue) {
            //code to execute
            self.identifier = newValue
        }
    }

    
  
	func processChangeState(wrapper:ObjectStateWrapper,fenceEvent:FenceEventModel, deviceEvent:DeviceEventModel){
        if(fenceEvent.isEventEntry()){
			processEntry(wrapper: wrapper,fenceEvent: fenceEvent)
		}else if (fenceEvent.isEventExit()){
			processExit(wrapper: wrapper, fenceEvent:fenceEvent, deviceEvent: deviceEvent)
		}
	}

    private func processExit(wrapper:ObjectStateWrapper,fenceEvent:FenceEventModel, deviceEvent: DeviceEventModel ){
        let skippedState = GreenObjectState()
		skippedState.processChangeState(wrapper: wrapper, fenceEvent: fenceEvent, deviceEvent: deviceEvent)
		//DB UTIL
        //Save ExEvent
         ObjectStateWrapper.sharedObjectStateWrapper.callDBToAddState(fenceEvent: fenceEvent, state: .white)
        
        ObjectStateWrapper.sharedObjectStateWrapper.callDBToAddState(fenceEvent: fenceEvent, state: .white)
        
        
		
        wrapper.setState(state: WhiteObjectState())
	}
	
    private func processEntry(wrapper:ObjectStateWrapper,fenceEvent:FenceEventModel ){
		//DB UTIL
		//Save Entry Event
		wrapper.setState(state: GreenObjectState())

	}
    

}
