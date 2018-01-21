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
    var boundaries: [GFDetails] = []
    
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.settingsTableView.dataSource = self
       self.settingsTableView.delegate = self
       self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // boundaries = CoreDataWrapper.fetchGF() as! [GFDetails]
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
        
     
//        for index in 0...boundaries.count {
//            let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! SettingsTableViewCell
//            boundaries[index].centerLatitude = Double(cell.latitudeTextField.text ?? "0.0")!
//            boundaries[index].centerLongitude = Double(cell.latitudeTextField.text ?? "0.0")!
//            boundaries[index].radius = Double(cell.radiusTextField.text ?? "0.0")!
//            CoreDataWrapper.saveGFToDB(dataModel: boundaries[index])
//        }
        
    }
    
    
    
    
    @IBAction func addNew(_ sender: Any) {
        settingsTableView.beginUpdates()
       
        settingsTableView.insertRows(at: [IndexPath(row: boundaries.count, section: 0)], with: .automatic)
         self.boundaries.append(GFDetails.init())
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
        return cell
    }
    
    //Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! SettingsTableViewCell
        
         
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.boundaries.remove(at: indexPath.row)
            self.settingsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
 }




