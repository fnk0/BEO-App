//
//  LocationCell.swift
//  BEO App
//
//  Created by Katie Hobble on 11/17/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class LocationCell : UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var expectingLabel: UILabel!
    @IBOutlet weak var rsvpLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabels(event: BEO){
        dateLabel.text = event.date.formatDate()
        timeLabel.text = event.timePeriod
//        placeLabel.text = event.location
        expectingLabel.text = "\(event.expecting)"
        rsvpLabel.text = "\(event.rsvp)"
    }
    
    
}
