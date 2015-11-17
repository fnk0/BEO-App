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
    var employee = PFUser()
    
    // Boolean to indicate whether parse retrieval failed
    var readFailed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nibs for custom tableView cell and section header
        var nib = UINib(nibName: "EmployeeEventCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "employeeEventCell")
        
        nib = UINib(nibName: "EmployeeEventSectionHeader", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "employeeEventSectionHeader")
        
        // Retrieve the events corresponding to the current employee from the database
        getEventsFromDatabase()
        
        /*
        // ========== START - FOR TESTING ONLY - REMOVE BEFORE PRESENTATION ==========
        // Initialize parse database
        
        var initEvents = [PFObject]()
        var initTasks = [PFObject]()
        
        for _ in 0..<3
        {
            initEvents.append(PFObject(className: "EmployeeEvent"))
        }
        for _ in 0..<9
        {
            initTasks.append(PFObject(className: "EmployeeTask"))
        }
        
        initEvents[0].setObject("Swanson Breakfast", forKey: "name")
        initEvents[1].setObject("Swanson Lunch", forKey: "name")
        initEvents[2].setObject("Swanson Dinner", forKey: "name")
        
        initTasks[0].setObject("Buffet food put out", forKey: "desc")
        initTasks[1].setObject("Table cloth/silverware placement", forKey: "desc")
        initTasks[2].setObject("Greet people at the doors", forKey: "desc")
        initTasks[3].setObject("Chair and table set-up", forKey: "desc")
        initTasks[4].setObject("Table cloth/silverware placement", forKey: "desc")
        initTasks[5].setObject("Buffet food take-down", forKey: "desc")
        initTasks[6].setObject("Make sure lights are correct", forKey: "desc")
        initTasks[7].setObject("Table cloth/silverware placement", forKey: "desc")
        initTasks[8].setObject("Buffet food take-down", forKey: "desc")
        
        let task0 = PFObject(className: "EmployeeTask")
        let task1 = PFObject(className: "EmployeeTask")
        let task2 = PFObject(className: "EmployeeTask")
        task0.setObject("Buffet food put out", forKey: "desc")
        task1.setObject("Table cloth/silverware placement", forKey: "desc")
        task2.setObject("Greet people at the doors", forKey: "desc")
        
        initEvents[1].setObject([task0, task1, task2], forKey: "tasks")
        //initEvents[1].setObject([initTasks[3], initTasks[4], initTasks[5]], forKey: "tasks")
        //initEvents[2].setObject([initTasks[6], initTasks[7], initTasks[8]], forKey: "tasks")
        
        for event in initEvents
        {
            do
            {
                try event.save()
            }
            catch
            {
                print("Database initialization failed")
            }
        }
        // ========== END - FOR TESTING ONLY - REMOVE BEFORE PRESENTATION ============
        */
        /*
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
        */

    }
    
    
    func getEventsFromDatabase()
    {
        // Create a Parse query to retrieve all tasks corresponding to the current employee
        let query = Task.query()
        query?.whereKey("employee", equalTo: employee)
        
        // Execute the query
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) events.")
                
                if let objects = objects as? [Task] {
                    self.tasks = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        // Remove duplicates from the task list
        tasks = Array(Set(tasks))
        
        // Get all the events corresponding to the tasks retrieved
        for task in tasks
        {
            eventsRaw.append(task.beo)
        }
        
        // Sort the events into sections by date
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
    
    
    func getTasksFromDatabase(forEvent forEvent: BEO) -> [Task]
    {
        var tasksToReturn = [Task]()
        let query = Task.query()
        query?.whereKey("beo", equalTo: forEvent)
        
        // Execute the query
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) events.")
                
                if let objects = objects as? [Task] {
                    tasksToReturn = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        return tasksToReturn
    }
    
    
    func saveEventsToDatabase()
    {
        for event in eventsRaw
        {
            do
            {
                try event.save()
            }
            catch
            {
                print("Error: Failed to save event to the database.")
            }
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
        //cell.tasks = [events[indexPath.section][indexPath.row].valueForKey("tasks") as! PFObject]
        cell.tasks = getTasksFromDatabase(forEvent: events[indexPath.section][indexPath.row])
        cell.updateAppearance(printDebug: true)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeEventCell") as! EmployeeEventCell
        
        // Set tasks array in the cell. Even though this has nothing to do with height, it needs to be done
        // before the cell is drawn, so this function is a good place to do it.
        //cell.tasks = [events[indexPath.section][indexPath.row].valueForKey("tasks") as! PFObject]
        cell.tasks = getTasksFromDatabase(forEvent: events[indexPath.section][indexPath.row])
        
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
