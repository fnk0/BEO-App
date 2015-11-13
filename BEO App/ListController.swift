//
//  ListController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/3/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ListController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = [String]()
    var events = [ [PFObject] ]()
    var eventsRaw = [PFObject]()
    
    // Boolean to indicate whether parse retrieval failed
    var readFailed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nibs for custom tableView cell and section header
        var nib = UINib(nibName: "EmployeeEventCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "employeeEventCell")
        
        nib = UINib(nibName: "EmployeeEventSectionHeader", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "employeeEventSectionHeader")
        
        // Create a Parse query for EmployeeEvents
        let query = PFQuery(className: "EmployeeEvent")
        
        // Retrieve the list of EmployeeEvents from the database
        do
        {
            try self.eventsRaw = query.findObjects()
        }
        catch
        {
            readFailed = true
            print("Database read failed")
        }
        
        var eventIndex = 0
        var sectionIndex = 0
        
        while eventIndex < eventsRaw.count
        {
            let sectionName = String(eventsRaw[eventIndex].valueForKey("date")!)
            sections.append(sectionName)
            events.append([eventsRaw[eventIndex]])
            ++eventIndex
            
            while (eventIndex < eventsRaw.count) && (String(eventsRaw[eventIndex].valueForKey("date")!) == sectionName)
            {
                events[sectionIndex].append(eventsRaw[eventIndex])
                ++eventIndex
            }
            ++sectionIndex
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeEventCell", forIndexPath: indexPath) as! EmployeeEventCell
        
        cell.eventNameLabel.text = String(events[indexPath.section][indexPath.row].valueForKey("name")!)
        let startTime = String(events[indexPath.section][indexPath.row].valueForKey("startTime")!)
        let endTime = String(events[indexPath.section][indexPath.row].valueForKey("endTime")!)
        cell.eventTimeLabel.text = "\(startTime)-\(endTime)"
        
        // Update the cell so the tasks will be drawn
        cell.tasks = [ events[indexPath.section][indexPath.row].valueForKey("tasks") as! PFObject ]
        cell.updateAppearance(printDebug: true)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeEventCell") as! EmployeeEventCell
        
        // Set tasks array in the cell. Even though this has nothing to do with height, it needs to be done
        // before the cell is drawn, so this function is a good place to do it.
        cell.tasks = [ events[indexPath.section][indexPath.row].valueForKey("tasks") as! PFObject ]
        
        return CGFloat( cell.defaultCellHeight + ( cell.taskLabel1Height * cell.tasks.count ) - cell.taskLabel1Spacing )
        //return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeEventSectionHeader") as! EmployeeEventSectionHeader
        
        if let dateLabel = cell.dateLabel
        {
            dateLabel.text = sections[section]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
