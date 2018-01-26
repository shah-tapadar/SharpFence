//
//  AbstractObjectModel.swift
//  SharpFence
//
//  Created by Sebin on 17-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import CoreLocation


protocol AbstractObjectState {
	
     
    var identifier:String {get set}
    
	
    func processChangeState(wrapper:ObjectStateWrapper,fenceEvent:FenceEventModel, deviceEvent:DeviceEventModel)


}
