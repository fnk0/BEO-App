//
//  CalendarController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/3/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar
import Parse

class ManagerEventListController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var beosTableView: UITableView!
    
    var sections = [NSDate]()
    var beos: [NSDate: [BEO]] = [NSDate: [BEO]]()
    
    let manager = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Const.ManagerEventListTableCell, bundle: nil)
        self.beosTableView.registerNib(nib, forCellReuseIdentifier: Const.ManagerEventListTableCell)
        self.beosTableView.tableFooterView = UIView(frame: CGRectZero)
        
        let date = NSDate()
        sections.append(date)
        
        // 24 hours * 60 mins * 60 secs
        let ti = 24 * 60 * 60
        
        for i in 1...6 {
            sections.append(date.dateByAddingTimeInterval(NSTimeInterval(i * ti)))
        }

        for s in sections {
            updateBEOList(s)
        }
    }
    
    func updateBEOList(date: NSDate) -> Void {
        let query = BEO.query()
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let start = cal.startOfDayForDate(date)
        let end: NSDate = cal.dateBySettingHour(23, minute: 59, second: 59, ofDate: date, options: NSCalendarOptions())!
        query?.whereKey(Const.DATE, greaterThan: start)
        query?.whereKey(Const.DATE, lessThan: end)
        query?.whereKey("manager", equalTo: self.manager!)
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) beos.")
                
                if let objects = objects as? [BEO] {
                    self.beos[date] = objects
                    self.beosTableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var count = 0
        for s in self.sections {
            if let bs = self.beos[s] {
                if bs.count > 0 {
                    count++
                }
            }
        }
        return count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let d = self.sections[section]
        if let b = self.beos[d] {
            return b.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let b = self.beos[self.sections[section]] {
            if b.count > 0 {
                let headerView = ManagerEventHeader(frame: CGRect(x: 0, y: 0, width: 375, height: 30))
                headerView.dateLabel.text = sections[section].formatDate()
                headerView.dateLabel.sizeToFit()
                headerView.arrowImage.hidden = true
                return headerView
            }
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : ManagerEventListTableCell = tableView.dequeueReusableCellWithIdentifier(Const.ManagerEventListTableCell) as! ManagerEventListTableCell
        let date = self.sections[indexPath.section]
        let beo = self.beos[date]![indexPath.row]
        cell.beo = beo
        cell.vc = self
        return cell
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
    
}