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
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Remove default cell separator from the tableView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func viewDidAppear(animated: Bool) {
        // Retrieve the events corresponding to the current employee from the database
        getDataFromDatabase()
    }
    
    
    func getDataFromDatabase() {
        // Create a Parse query to retrieve all tasks corresponding to the current employee
        let query = Task.query()
        query?.whereKey("employee", equalTo: PFUser.currentUser()!)
        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil
            {
                // The find succeeded
//                print("Successfully retrieved \(objects!.count) tasks")
                
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
        
//        let toPrint = eventsRaw
//        print("eventsRaw = \(toPrint)")
        
        var eventIndex = 0
        var sectionIndex = 0
        
        // Create a formatter for displaying the date header
        let eventDateFormatter = NSDateFormatter()
        eventDateFormatter.dateFormat = "EEEE,  MMMM  d,  y"
        
        // Organize the events into the two-dimensional array so that they are grouped into sections by date
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
        
        let beo = events[indexPath.section][indexPath.row]
        
        cell.eventNameLabel.text = beo.title
        cell.eventTimeLabel.text = beo.timePeriod
        
        // Update the cell so the tasks will be drawn
        cell.tasks = [Task]()
        for task in tasks where task.beo == beo
        {
            cell.tasks.append(task)
        }
        
        cell.beo = beo
        cell.viewController = self.parentViewController
        
        cell.updateAppearance(printDebug: false)
        
        // Set up a formatter to use for displaying the time the event is due
        var formattedTime = beo.due.formatTime().lowercaseString
        cell.completionTimeLabel.text = "Complete by \(formattedTime)"
        formattedTime = beo.clean.formatTime().lowercaseString
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
        return 80
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ManagerEventHeader(frame: CGRect(x: 0, y: 0, width: 375, height: 30))
        headerView.arrowImage.hidden = true
        headerView.dateLabel.text = sections[section]
        headerView.dateLabel.sizeToFit()
        return headerView
    }

    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
