//
//  DeviceEventModel.swift
//  SharpFence
//
//  Created by Sebin on 16-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation

enum deviceEventType {
    case driveButtonOn
    case driveButtonOff
    case deviceOnMove
    case deviceOnStop
    case devicePlugged
    case deviceUnPlugged
	case devicePowerLow
}

class DeviceEventModel {
    var event: deviceEventType?
}
