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
    
    var viewController: UIViewController?
    
    var beo : BEO? {
        didSet {
            if let beo = beo {
                self.title.text = beo.title
                self.timePeriod.text = beo.timePeriod
                
                completeLabel.text = "Complete by \(beo.due.formatTime().lowercaseString)"
                cleanByLabel.text = "Clean by \(beo.clean.formatTime().lowercaseString)"
                
                let now = NSDate()
                
                if beo.due.isGreaterThanDate(now) && beo.clean.isGreaterThanDate(now) {
                    self.completeLabel.textColor = Colors.Red
                    clockIcon.image = Const.RedClockImage
                    let end = self.beo?.clean
                    if now.isGreaterThanDate(end!) {
                        cleanByLabel.textColor = Colors.Red
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
        self.view = xibSetup("ManagerTasksHeader")
        self.addSubview(self.view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view = xibSetup("ManagerTasksHeader")
        self.addSubview(self.view)
    }
    
    @IBAction func info(sender: AnyObject) {
        if let b = self.beo {
            self.viewController?.performSegueWithIdentifier(Segue.ShowInfo, sender: b)
        }
    }
    
}