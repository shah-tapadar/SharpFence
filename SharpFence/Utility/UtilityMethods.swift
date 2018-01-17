//
//  UtilityMethods.swift
//  SharpFence
//
//  Created by Sebin on 16-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation
import UIKit

class UtilityMethods {
    
    static func showAlert(controller: UIViewController)  {
        let alertController = UIAlertController(title: "iOScreator", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
