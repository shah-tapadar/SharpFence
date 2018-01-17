//
//  StateObjectModel.swift
//  SharpFence
//
//  Created by Sebin on 17-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation

enum objectState {
    case white
    case blue
    case green
    case red
}

class StateObjectModel: NSObject {
    var currentState: objectState
    var currentRegionId: String?
    var objectIdentifier: String?
    var objectStateAray = [StateModel]()
    
    override init() {
        currentState = .white
        super.init()
    }
}
