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
    var events = [ [BEO] ]()
    var eventsRaw = [BEO]()
    var tasks = [Task]()
    
    // Boolean to indicate whether parse retrieval failed
    var readFailed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nibs for custom tableView cell and section header
        var nib = UINib(nibName: "EmployeeEventCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "employeeEventCell")
        
        nib = UINib(nibName: "EmployeeEventSectionHeader", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "employeeEventSectionHeader")
        
        // Remove default cell separator from the tableView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Retrieve the events corresponding to the current employee from the database
        getDataFromDatabase()
        
    }
    
    
    func getDataFromDatabase()
    {
        // Create a Parse query to retrieve all tasks corresponding to the current employee
        let query = Task.query()
        query?.whereKey("employee", equalTo: PFUser.currentUser()!)
        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil
            {
                // The find succeeded
                print("Successfully retrieved \(objects!.count) tasks")
                
                if let objects = objects as? [Task]
                {
                    self.tasks = objects
                }
                
                self.getEventsFromDatabase()
            }
            else
            {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    func getEventsFromDatabase()
    {
        // Remove duplicates from the task list
        tasks = Array(Set(tasks))
        
        // Get all the events corresponding to the tasks retrieved
        for task in tasks
        {
            let event = task.beo
            
            event.fetchIfNeededInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                
                if let object = object as? BEO
                {
                    self.eventsRaw.append(object)
                    self.organizeEvents()
                }
            }
        }
    }
    
    
    func organizeEvents()
    {
        // Remove duplicates from the event list
        eventsRaw = Array(Set(eventsRaw))
        
        // Initialize data arrays
        sections = [String]()
        events = [ [BEO] ]()
        
        // Sort events by date
        eventsRaw.sortInPlace { $0.date.compare($1.date) == .OrderedAscending }
        
        let toPrint = eventsRaw
        print("eventsRaw = \(toPrint)")
        
        var eventIndex = 0
        var sectionIndex = 0
        
        // Create a formatter for displaying the date header
        let eventDateFormatter = NSDateFormatter()
        eventDateFormatter.dateFormat = "EEEE,  MMMM  d,  y"
        
        // Organize the events into the two-dimensional array so that they are grouped by date
        while eventIndex < eventsRaw.count
        {
            let sectionName = eventDateFormatter.stringFromDate(eventsRaw[eventIndex].date).uppercaseString
            
            sections.append(sectionName)
            events.append([eventsRaw[eventIndex]])
            ++eventIndex
            
            var nextSectionName = ""
            
            if eventIndex < eventsRaw.count
            {
                nextSectionName = eventDateFormatter.stringFromDate(eventsRaw[eventIndex].date).uppercaseString
            }
            
            while (eventIndex < eventsRaw.count) && (nextSectionName == sectionName)
            {
                events[sectionIndex].append(eventsRaw[eventIndex])
                ++eventIndex
                
                if eventIndex < eventsRaw.count
                {
                    nextSectionName = eventDateFormatter.stringFromDate(eventsRaw[eventIndex].date).uppercaseString
                }
            }
            ++sectionIndex
        }
        
        tableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeEventCell", forIndexPath: indexPath) as! EmployeeEventCell
        
        cell.eventNameLabel.text = events[indexPath.section][indexPath.row].title
        cell.eventTimeLabel.text = events[indexPath.section][indexPath.row].timePeriod
        
        // Update the cell so the tasks will be drawn
        cell.tasks = [Task]()
        for task in tasks where task.beo == events[indexPath.section][indexPath.row]
        {
            cell.tasks.append(task)
        }
        
        cell.updateAppearance(printDebug: true)
        
        // Set up a formatter to use for displaying the time the event is due
        let dueTimeFormatter = NSDateFormatter()
        dueTimeFormatter.dateFormat = "h:mma"
        var formattedTime = dueTimeFormatter.stringFromDate(events[indexPath.section][indexPath.row].due).lowercaseString
        cell.completionTimeLabel.text = "Complete by \(formattedTime)"
        formattedTime = dueTimeFormatter.stringFromDate(events[indexPath.section][indexPath.row].clean).lowercaseString
        cell.cleanTimeLabel.text = "Clean by \(formattedTime)"
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeEventCell") as! EmployeeEventCell
        
        // Set tasks array in the cell. Even though this has nothing to do with height, it needs to be done
        // before the cell is drawn, so this function is a good place to do it.
        cell.tasks = [Task]()
        for task in tasks where task.beo == events[indexPath.section][indexPath.row]
        {
            cell.tasks.append(task)
        }
        
        return CGFloat( cell.defaultCellHeight + ((cell.taskLabel1Height + cell.yPadding) * cell.tasks.count) + 10 )
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
