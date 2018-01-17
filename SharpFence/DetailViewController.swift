//
//  DetailViewController.swift
//  SharpFence
//
//  Created by bharghava on 1/15/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var data:RouteDetails?
    let embedSegueIdentifier = "EmbedSegue"
    var titleText:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = titleText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var embedView: UIView!
    
 
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let embeddedVC = segue.destination as? RouteDetailsTableViewController, segue.identifier == embedSegueIdentifier {
                    embeddedVC.data = self.data
                }
    }
    
}
