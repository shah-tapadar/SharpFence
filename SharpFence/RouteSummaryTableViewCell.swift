//
//  RouteSummaryTableViewCell.swift
//  SharpFence
//
//  Created by bharghava on 1/15/18.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import UIKit

class RouteSummaryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tilteLabel: UILabel!
    
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
