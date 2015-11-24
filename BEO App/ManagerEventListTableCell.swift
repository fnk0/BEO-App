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
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var dustpanIcon: UIImageView!
        
    var vc : UIViewController?
    
    var beo : BEO? {
        didSet {
            if let beo = beo {
                titleLabel.text = beo.title
                timeLabel.text = beo.timePeriod
                completeLabel.text = "Complete by \(beo.due.formatTime().lowercaseString)"
                cleanLabel.text = "Clean by \(beo.clean.formatTime().lowercaseString)"
                
                let now = NSDate()
                
                if beo.due.isGreaterThanDate(now) && beo.clean.isGreaterThanDate(now) {
                    self.completeLabel.textColor = Colors.Red
                    clockIcon.image = Const.RedClockImage
                    let end = beo.clean
                    if now.isGreaterThanDate(beo.due) && now.isLessThanDate(end) {
                        cleanLabel.textColor = Colors.Red
                        dustpanIcon.image = Const.RedDustpanImage
                    }
                }
                completeLabel.sizeToFit()
                cleanLabel.sizeToFit()
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func openInfo(sender: UIButton) {
        if let v = vc {
            v.parentViewController!.performSegueWithIdentifier(Segue.TaskSegue, sender: beo)
        }
    }
    
}