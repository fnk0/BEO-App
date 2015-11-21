//
//  MyEventsTableCell.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/11/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class ManagerEventListTableCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var cleanLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var dustpanIcon: UIImageView!
    
    var vc : UIViewController?
    
    var beo : BEO? {
        didSet {
            if let beo = beo {
                titleLabel.text = beo.title
                timeLabel.text = beo.timePeriod
                
                let completeTime = beo.timePeriod.getTimePeriod()
                
                completeLabel.text = setCompleteTime(completeTime.start, amOrPm: completeTime.period)
                cleanLabel.text = setCleanTime(completeTime.end, amOrPm: completeTime.period)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCompleteTime(hour: Int, var amOrPm: String) -> String {
        let numberOfMinutesBeforeCompleteTime = 15
        var totalSeconds = 0
        var newHour = 0
        var newMinute = 0
        if amOrPm == "am" {
            totalSeconds = (hour * 3600) - (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600
        } else if amOrPm == "pm" {
            totalSeconds = (hour * 3600) + (12 * 3600) - (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600 - 12
            if newHour == 0 {
                newHour = 12
                amOrPm = "am"
            }
        }
        
        newMinute = totalSeconds % 3600 / 60
        return ("Complete by \(newHour):\(newMinute)\(amOrPm)")
    }
    
    func setCleanTime(hour: Int, var amOrPm: String) -> String {
        let numberOfMinutesBeforeCompleteTime = 30
        var totalSeconds = 0
        var newHour = 0
        var newMinute = 0
        if amOrPm == "am" {
            totalSeconds = (hour * 3600) + (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600
            if newHour > 12 {
                newHour = newHour - 12
                amOrPm = "pm"
            }
        } else if amOrPm == "pm" {
            totalSeconds = (hour * 3600) + (12 * 3600) + (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600 - 12
        }
        
        newMinute = totalSeconds % 3600 / 60
        return ("Clean by \(newHour):\(newMinute)\(amOrPm)")
    }
    
    @IBAction func openInfo(sender: UIButton) {
        if let v = vc {
            v.parentViewController!.performSegueWithIdentifier(Segue.TaskSegue, sender: nil)
        }
    }
    
}