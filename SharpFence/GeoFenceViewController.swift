//
//  GeoFenceViewController.swift
//  SharpFence
//
//  Created by bharghava on 1/23/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit

class GeoFenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!

    @IBOutlet weak var latitudeTextField: UITextField!
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        let gFModel = LocationModel()
         gFModel.latitude = Double(self.latitudeTextField.text!) ?? 0.0
         gFModel.longitude = Double(self.longitudeTextField.text!) ?? 0.0
         gFModel.radius = Double(self.radiusTextField.text!) ?? 0.0
         gFModel.status = true
        // Using Time Stamp as unique ID - Replaced with Random number 
        gFModel.identifier = "GF" + "\(arc4random_uniform(10))" + "\(arc4random_uniform(10))" + "\(arc4random_uniform(10))"
        CoreDataWrapper.saveGFToDB(dataModel: gFModel )
        self.dismiss(animated: true, completion: nil)
    }
    
}
