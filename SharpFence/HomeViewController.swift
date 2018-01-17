//
//  ViewController.swift
//  SharpFence
//
//  Created by bharghava on 1/12/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    
    let reuseIdentifier = "routeSummary"
    let routeDetailsSegueIdentifier = "routeDetails"
    var valueToPass: RouteDetails?
    var valueToPassLabel: String?
    var tripEvents :[NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.routeSummaryTableView.dataSource = self
        self.routeSummaryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TBL_TRIP_EVENT")
        do {
            tripEvents = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
    }
    

    @IBAction func flushData(_ sender: Any) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "TBL_TRIP_EVENT")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
    @IBAction func emailData(_ sender: Any) {
    }

}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    
    
    // Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   tripEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.routeSummaryTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! RouteSummaryTableViewCell
        
       let tripEvent = tripEvents[indexPath.row]
      if let eventId =  tripEvent.value(forKeyPath: "eventId"), let eventType = tripEvent.value(forKeyPath: "eventType"), let timeStamp = tripEvent.value(forKeyPath: "timeStamp") {
        cell.tilteLabel.text = String(describing: eventId) + " " + String(describing: eventType)
        cell.timeStampLabel.text = String(describing: timeStamp)
        
        }
        
        
        
        return cell
    }
    
    //Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath) as! RouteSummaryTableViewCell
        
        self.valueToPassLabel = currentCell.tilteLabel.text
        let tripEvent = tripEvents[indexPath.row]
        
        if let geoId =  tripEvent.value(forKeyPath: "geoFenceId"), let time = tripEvent.value(forKeyPath: "timeStamp"), let latititude = tripEvent.value(forKeyPath: "eventLat"), let longitude = tripEvent.value(forKeyPath: "eventLong"), let distance = tripEvent.value(forKeyPath: "distance")  {
            self.valueToPass = RouteDetails(
                gfID: String(describing: geoId),
                time:  String(describing: time),
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

