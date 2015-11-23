//
//  ManagerTasksHeader.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ManagerTasksHeader : UIView {
    
    var view: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timePeriod: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var cleanByLabel: UILabel!
    @IBOutlet weak var dustpanIcon: UIImageView!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var beo : BEO? {
        didSet {
            if let beo = beo {
                self.title.text = beo.title
                self.timePeriod.text = beo.timePeriod
                let p : TimePeriod = beo.timePeriod.getTimePeriod()
                // I'll add some extra logic here later to change color and stuff
                completeLabel.text = "Complete by \(p.end - Int(1)):45 \(p.period)"
                cleanByLabel.text = "Clean by \(p.end + Int(1)):30 \(p.period)"
                
                let now = NSDate()
                
                if beo.due.isGreaterThanDate(now) {
                    self.completeLabel.textColor = UIColor.redColor()
                    clockIcon.image = Const.RedClockImage
                    let hours = p.end - p.start
                    // Hours * 60 minutes * 60 seconds + (30 minutes * 60 seconds)
                    let interval = hours * 60 * 60 + (30 * 60)
                    let end = self.beo?.date.dateByAddingTimeInterval(Double(interval))
                    if now.isGreaterThanDate(end!) {
                        cleanByLabel.textColor = UIColor.redColor()
                        dustpanIcon.image = Const.RedDustpanImage
                    }
                }
                completeLabel.sizeToFit()
                cleanByLabel.sizeToFit()
            }
        }
    }
    
    var tasks : [Task]? {
        didSet {
            if let tasks = tasks {
                progressBar.max = tasks.count
                
                var completed : Int = 0
                for t in tasks {
                    if t.completed {
                        completed++
                    }
                }
                self.progressBar.current = completed
                self.progressLabel.text = "\(completed)/\(tasks.count)"
                self.progressBar.current = completed
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.view = xibSetup("ManagerTasksHeader")
        self.addSubview(self.view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.view = xibSetup("ManagerTasksHeader")
        self.addSubview(self.view)
    }
    
    @IBAction func edit(sender: AnyObject) {
    }
    
    @IBAction func info(sender: AnyObject) {
    }
    
}