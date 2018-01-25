//
//  ViewController.swift
//  SharpFence
//
//  Created by bharghava on 1/12/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

protocol ReloadHomeView {
 func reLoadHomeView()
}

class HomeViewController: UIViewController, ReloadHomeView {

    
    let reuseIdentifier = "routeSummary"
    let routeDetailsSegueIdentifier = "routeDetails"
    var valueToPass: RouteDetails?
    var valueToPassLabel: String?
    var tripEvents :[TBL_TRIP_EVENT]?
    lazy var logManager = LogManager()
    var stateObject:  AbstractObjectState?
    lazy var locationManager = CoreLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.routeSummaryTableView.dataSource = self
        self.routeSummaryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reLoadHomeView() 
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBOutlets
    
    @IBOutlet weak var flushData: UIButton!
    
    @IBOutlet weak var emailData: UIButton!
    
    @IBOutlet weak var routeSummaryTableView: UITableView!
    
   
     //IB ACTIONS
    
    
    @IBAction func startDriving(_ sender: Any) {
        let switchButton = sender as! UISwitch
        if switchButton.isOn {
            locationManager.delegate = self
            locationManager.setupLocationManager(locationAccuracy: CoreDataWrapper.getConfigAccuracy()?.accuracy)
        }else{
            locationManager.stopLocationMonitoring()
             self.routeSummaryTableView.reloadData()
            //CoreDataWrapper.saveMonitoredRegionsAndStatus(objectModel: stateObject!)
        }
    }
    

    @IBAction func flushData(_ sender: Any) {
        CoreDataWrapper.flushData(table: "TBL_TRIP_EVENT")
        self.tripEvents = []
        self.routeSummaryTableView.reloadData()
     }
    
    
    @IBAction func emailData(_ sender: Any) {
        logManager.emailLog(presentMailComposeron: self)
    }

    
    // Protocol
    func reLoadHomeView() {
        tripEvents = []
        tripEvents = CoreDataWrapper.fetchAllTripEvents()
        self.routeSummaryTableView.reloadData()
        
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    
    
    // Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   tripEvents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.routeSummaryTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! RouteSummaryTableViewCell
        
       let tripEvent = tripEvents![indexPath.row]
        
        
        
       
      if let geoId =  tripEvent.geoFenceId, let eventType = tripEvent.eventType, let timeStamp = tripEvent.timeStamp {
        
        if (eventType == "entry") {
         cell.textLabel?.textColor = .green
         cell.textLabel?.text = geoId + "  " + "Entry"
        } else {
           cell.textLabel?.textColor = .red
            cell.textLabel?.text = geoId + "  " + "Exit"
        }
       // cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = timeStamp
        cell.detailTextLabel?.textColor = UIColor.gray
        
        }
        
        
        
        return cell
    }
    
    //Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
       // let currentCell = tableView.cellForRow(at: indexPath) as! RouteSummaryTableViewCell
        
        let tripEvent = tripEvents![indexPath.row]
        
        if let geoId =  tripEvent.value(forKeyPath: "geoFenceId"), let time = tripEvent.timeStamp, let latititude = tripEvent.value(forKeyPath: "eventLat"), let longitude = tripEvent.value(forKeyPath: "eventLong"), let distance = tripEvent.value(forKeyPath: "distance"),let eventId =  tripEvent.eventId, let eventType = tripEvent.eventType  {
            
             eventType == "entry" ? (self.valueToPassLabel = eventId + "  " + "Entry") :  (self.valueToPassLabel = eventId + "  " + "Exit")
            
            self.valueToPass = RouteDetails(
                gfID: String(describing: geoId),
                time: time,
                latitude: String(describing: latititude),
                longitude: String(describing: longitude),
                distanceFromCenter:String(describing: distance)
            )

            
        }
        
        
        performSegue(withIdentifier:routeDetailsSegueIdentifier, sender: self)
    }
    
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == routeDetailsSegueIdentifier) {
                    let viewController = segue.destination as! DetailViewController
            
                        viewController.data = valueToPass
                        viewController.titleText = valueToPassLabel
            
                    }
    }
}

