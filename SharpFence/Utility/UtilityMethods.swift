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
    
    static func getCurrentDateString() -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy  hh:mm:ss a"
        return dateFormatter.string(from: Date())
    }
    
    static func getTimeString(date: Date) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        return dateFormatter.string(from: date)
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

