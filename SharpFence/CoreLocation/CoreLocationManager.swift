//
//  CoreLocationManager.swift
//  SharpFence
//
//  Created by Sebin on 16-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationManager: NSObject {
    let clLocationManagerObject = CLLocationManager()
   // var stateObject: AbstractObjectState?
    var selectedAccuracyLevel: CLLocationAccuracy?
    var locations: [LocationModel]?
    var monitoredRegions: [CLCircularRegion]?
    var delegate:ReloadHomeView?
    
    
    func setupLocationManager(locationAccuracy: CLLocationAccuracy?) {
        clLocationManagerObject.delegate = self
       // self.stateObject = stateObject
        selectedAccuracyLevel = locationAccuracy
        if CLLocationManager.locationServicesEnabled() {
            //handles different cases of app's location services status
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                clLocationManagerObject.requestAlwaysAuthorization()
            case .authorizedAlways:
                startMonitoring()
                break
            case .denied,.restricted:
                break
            default:
                break
            }
        } else {
            //executes when device location services is disabled
        }
    }
    
    func startMonitoring() {
        locationList()
        trackUserLocation()
        startTrackingGeofencedRegion()
    }
    
    func stopLocationMonitoring() {
        stopTrackinguserLocation()
        stopTrackingGeofencedRegion()
    }
    
    private func locationList(){
        //Fetch all locations from DB. All the locations should be mapped to Location model
       locations = DataWrapper.locationModels()
      // locations = DataWrapper().tempLocationModels()
    }
    
    private func trackUserLocation()  {
        clLocationManagerObject.desiredAccuracy = selectedAccuracyLevel ?? kCLLocationAccuracyBest
        clLocationManagerObject.allowsBackgroundLocationUpdates = true
        clLocationManagerObject.startUpdatingLocation()
    }
    
    private func stopTrackinguserLocation(){
        clLocationManagerObject.stopUpdatingLocation()
    }
    
    //This method will create circular area, using longitude, latitude and radius, that needs to be monitored
    private func createCircularRegion(location: LocationModel) ->  CLCircularRegion?{
        if let latitude = location.latitude, let longitude = location.longitude,
            let radius = location.radius, let identifier = location.identifier {
            let geoCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let circularRegion = CLCircularRegion(center: geoCoordinate, radius: radius,
                                                  identifier: identifier)
            return circularRegion
        }
        return nil
    }
    
    private func startTrackingGeofencedRegion() {
        guard let _locations = locations else {
            return
        }
        monitoredRegions = [CLCircularRegion]()
        for location in _locations{
            if let _region = createCircularRegion(location: location){
                clLocationManagerObject.startMonitoring(for: _region)
                monitoredRegions?.append(_region)
            }
        }
    }
    
    private func stopTrackingGeofencedRegion(){
        guard let _monitoredRegions = monitoredRegions else {
            return
        }
        for region in _monitoredRegions {
            clLocationManagerObject.stopMonitoring(for: region)
        }
    }
}

extension CoreLocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        
        let deviceEvent = DeviceEventModel.init(event: .deviceOnMove)
        let locationModel = LocationModel.init()
        locationModel.latitude = manager.location?.coordinate.latitude
        locationModel.longitude = manager.location?.coordinate.longitude
        locationModel.identifier = region.identifier
        let distance = self.measureDistance(locationModel: locationModel)
        let fenceEvent = FenceEventModel.init(location: locationModel, event: fenceEventType.entry, distance: distance, timeStamp: UtilityMethods.getCurrentDateString())
        
        ObjectStateWrapper.sharedObjectStateWrapper.changeState(fenceEvent: fenceEvent, deviceEvent: deviceEvent)
        
        self.delegate?.reLoadHomeView()
        }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion){
        
        let deviceEvent = DeviceEventModel.init(event: .deviceOnMove)
        let locationModel = LocationModel.init()
        locationModel.latitude = manager.location?.coordinate.latitude
        locationModel.longitude = manager.location?.coordinate.longitude
        locationModel.identifier = region.identifier
        let distance = self.measureDistance(locationModel: locationModel)
        
        let fenceEvent = FenceEventModel.init(location: locationModel, event: fenceEventType.exit, distance: distance, timeStamp: UtilityMethods.getCurrentDateString())
        
        ObjectStateWrapper.sharedObjectStateWrapper.changeState(fenceEvent: fenceEvent, deviceEvent: deviceEvent)
          self.delegate?.reLoadHomeView()
}
    
    private func measureDistance(locationModel :LocationModel) -> CLLocationDistance?{
        
        let gfModel = CoreDataWrapper.getGFByID(identifier: locationModel.identifier ?? "")
        
        if let lat = locationModel.latitude, let long = locationModel.longitude, let centerLat =  gfModel?.latitude, let centerLong = gfModel?.longitude {
          let eventLocation = CLLocation(latitude: lat , longitude: long)
          let centerLocation  = CLLocation( latitude: centerLat , longitude: centerLong)
          let distance =  centerLocation.distance(from: eventLocation)
            return distance
        }
        
    return nil
    
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            break
        case .authorizedAlways:
            startMonitoring()
            break
        case .denied,.restricted:
            break
        default:
            break
        }
    }

}
