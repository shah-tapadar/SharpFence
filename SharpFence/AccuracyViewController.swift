//
//  AccuracyViewController.swift
//  SharpFence
//
//  Created by bharghava on 1/17/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit
import CoreData

class AccuracyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var list = ["LEVEL 1", "LEVEL 2", "LEVEL 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropDown.delegate = self
        self.dropDown.isHidden = true
        self.hideKeyboardWhenTappedAround()
        self.accuracyLevel.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var accuracyLevel: UITextField!
    @IBOutlet weak var distanceFilter: UITextField!
    
    @IBOutlet weak var headingFilter: UITextField!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.accuracyLevel.text = self.list[row]
        self.dropDown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.accuracyLevel {
            textField.endEditing(true)
            self.dropDown.isHidden = false
        }
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
       // self.save()
    }
    
//    func save() {
//        
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//        
//        let entity =
//            NSEntityDescription.entity(forEntityName: "TBL_AL_CONFIG",
//                                       in: managedContext)!
//        
//        let aLConfig = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//        
//        aLConfig.setValue(self.accuracyLevel.text, forKeyPath: "level")
//        aLConfig.setValue(self.distanceFilter.text, forKeyPath: "disFilter")
//        aLConfig.setValue(self.headingFilter.text, forKeyPath: "headFilter")
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
    
    
    
}
