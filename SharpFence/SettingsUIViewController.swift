//
//  SettingsUIViewController.swift
//  SharpFence
//
//  Created by bharghava on 1/15/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit
import CoreData

class SettingsUIViewController: UIViewController {

    let reuseIdentifier = "settingsCell"
    var boundaries: [LocationModel] = []
   //var originalBoundaries: [LocationModel] = []
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.settingsTableView.dataSource = self
       self.settingsTableView.delegate = self
       self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = DataWrapper.locationModels() {
          boundaries = data
            
         }
        self.settingsTableView.reloadData()
        
    }

    @IBOutlet weak var settingsTableView: UITableView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsUIViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    // Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.boundaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! SettingsTableViewCell
        
        if let latitude = boundaries[indexPath.row].latitude, let longitude = boundaries[indexPath.row].longitude, let radius = boundaries[indexPath.row].radius {
            cell.latitudeTextField.text = String(describing: latitude )
            cell.longitudeTextField.text = String(describing: longitude )
            cell.radiusTextField.text = String(describing: radius )
        }
        
      

        return cell
    }
    
    //Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! SettingsTableViewCell
        
         
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // neeed to call DB to delete it
            CoreDataWrapper.deleteGeoFence(id: self.boundaries[indexPath.row].identifier ?? "")
            self.boundaries.remove(at: indexPath.row)
            self.settingsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
 }




