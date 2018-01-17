//
//  StateModel.swift
//  SharpFence
//
//  Created by Sebin on 17-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
enum objectState {
    case entry
    case exit
}
class StateModel: NSObject {
    var state: objectState?
    var time: Date?
    var geofenceId: String?
}
