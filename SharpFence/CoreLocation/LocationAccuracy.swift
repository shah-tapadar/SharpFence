//
//  LocationAccuracy.swift
//  SharpFence
//
//  Created by bharghava on 3/13/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationAccuracyProtocol {
    func trackGPSAccuracy(selectedAccuracy: CLLocationAccuracy?)
    
}

class LocationAccuracy {
    
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    var batteryState: UIDeviceBatteryState {
        return UIDevice.current.batteryState
    }
    
    var configAccuracy: CLLocationAccuracy?
    var delegate:LocationAccuracyProtocol?
    var selectedAccuracy: CLLocationAccuracy?
    
    init(currentAccuracy: CLLocationAccuracy?){
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.configAccuracy = currentAccuracy
        addNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(batteryDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryDidChange), name: .UIDeviceBatteryStateDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePowerMode),
                                               name: .NSProcessInfoPowerStateDidChange,
                                                         object: nil)
        }
    
   

    @objc func didChangePowerMode(_ notification: Notification) {
        if ProcessInfo.processInfo.isLowPowerModeEnabled && (configAccuracy == kCLLocationAccuracyBest || configAccuracy == kCLLocationAccuracyBestForNavigation) {
            // low power mode on
            selectedAccuracy = kCLLocationAccuracyNearestTenMeters
            self.delegate?.trackGPSAccuracy(selectedAccuracy: selectedAccuracy)
        }
    }
    
    func getSelectedAccuracyLevel() -> CLLocationAccuracy {
        return selectedAccuracy ?? (configAccuracy ?? kCLLocationAccuracyBest)
    }
    
    @objc func batteryDidChange(_ notification: Notification) {
        switch batteryState {
        case .unplugged, .unknown:
            if (batteryLevel > 0.2){
                selectedAccuracy = kCLLocationAccuracyBest
                self.delegate?.trackGPSAccuracy(selectedAccuracy: selectedAccuracy)
            } else {
                selectedAccuracy = kCLLocationAccuracyNearestTenMeters
                self.delegate?.trackGPSAccuracy(selectedAccuracy: selectedAccuracy)
            }
        case .charging, .full:
            self.selectedAccuracy = configAccuracy
            self.delegate?.trackGPSAccuracy(selectedAccuracy: selectedAccuracy)
        }
    }
    
    
}
