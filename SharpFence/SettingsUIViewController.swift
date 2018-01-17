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
    //var boundaries: [NSManagedObject] = []
    var numberOfRows:Int =  3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.settingsTableView.dataSource = self
       self.settingsTableView.delegate = self
       self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
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
           }
    
    
    
//    func saveData(latitude: Double, longitude:Double, radius: Double){
//    
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Boundary", in: managedContext)!
//        let boundary = NSManagedObject(entity: entity, insertInto: managedContext)
//        boundary.setValue(latitude, forKeyPath: "latitude")
//        boundary.setValue(longitude, forKeyPath: "longitude")
//        boundary.setValue(radius, forKeyPath: "radius")
//        do {
//            try managedContext.save()
//            boundaries.append(boundary)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//}
    
    @IBAction func addNew(_ sender: Any) {
        settingsTableView.beginUpdates()
       
        settingsTableView.insertRows(at: [IndexPath(row: numberOfRows, section: 0)], with: .automatic)
         self.numberOfRows = self.numberOfRows + 1
        settingsTableView.endUpdates()
    }
    
    
    
}

extension SettingsUIViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    // Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows
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
            print("Deleted")
            
            self.numberOfRows = numberOfRows - 1
            self.settingsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
 }




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

