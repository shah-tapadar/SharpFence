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
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = DataWrapper.locationModels() {
          boundaries = data
//            originalBoundaries = data  //.map{$0.identifier ?? ""}
        }
        
    }

    @IBOutlet weak var settingsTableView: UITableView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
         CoreDataWrapper.flushData(table: "TBL_GF_CONFIG")
        
        
        for index in 0..<boundaries.count {
            let indexPath = IndexPath(row: index, section: 0)
            
            if let cell = settingsTableView.cellForRow(at: indexPath) as! SettingsTableViewCell? {
                boundaries[index].latitude = Double(cell.latitudeTextField.text!) ?? 0.0
                boundaries[index].longitude = Double(cell.longitudeTextField.text!) ?? 0.0
                boundaries[index].radius = Double(cell.radiusTextField.text!) ?? 0.0
                boundaries[index].status = true
                // Using Time Stamp as unique ID
                boundaries[index].identifier = UtilityMethods.getCurrentDateString()
                CoreDataWrapper.saveGFToDB(dataModel: boundaries[index])
            }
        }
        
    }
    
    
    
    
    @IBAction func addNew(_ sender: Any) {
        settingsTableView.beginUpdates()
        settingsTableView.insertRows(at: [IndexPath(row: boundaries.count, section: 0)], with: .automatic)
         self.boundaries.append(LocationModel.init())
        settingsTableView.endUpdates()
       
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
        
      cell.latitudeTextField.text = String(describing: boundaries[indexPath.row].latitude)
      cell.longitudeTextField.text = String(describing: boundaries[indexPath.row].longitude)
      cell.radiusTextField.text = String(describing: boundaries[indexPath.row].radius)

        return cell
    }
    
    //Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! SettingsTableViewCell
        
         
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.boundaries.remove(at: indexPath.row)
            // neeed to call DB to delete it
            
            self.settingsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
 }




