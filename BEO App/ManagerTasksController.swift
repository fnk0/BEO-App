//
//  ManagerTasksController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import Parse



class ManagerTasksController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var headerView: ManagerTasksHeader = ManagerTasksHeader(frame: CGRect(x: 0, y: 0, width: 375, height: 130))
    @IBOutlet weak var tableView: UITableView!
    
    var groupedTasks = [PFUser : [Task]]()
    var tasksRaw = [PFObject]()
    var users = [PFUser]()
    
    var beo: BEO? {
        didSet {
            
            // Query for tasks on a BEO
            // Update the [Task] array
            // Refresh the tableView
            headerView.beo = beo
        }
    }
    
    var tasks : [Task]? {
        didSet {
           // print("TASKS: \(self.tasks)\n\n")
            headerView.tasks = self.tasks
        
            for t in tasks! {
               // print(t)
                let employee = t["employee"] as! PFUser
                //print(employee)
                if users.contains(employee) {
                    //Do nothing
                } else {
                    users.append(employee)
                }
                if var tu = groupedTasks[employee] {
                    tu.append(t)
                    groupedTasks[employee] = tu
                } else {
                    var ts = [Task]()
                    ts.append(t)
                    groupedTasks[employee] = ts
                }
            }
             //print("GTasks: \(groupedTasks)")
        }
    }
    
    override func viewDidLoad() {
        self.tableView.tableHeaderView = self.headerView
        self.tableView.reloadData()
        
        let nib = UINib(nibName: Const.ManagerTasksTableCell, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Const.ManagerTasksTableCell)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Create a Parse query for EmployeeEvents
        let query = Task.query()
        
        // Retrieve the list of BEO Tasks from the database
        do
        {
            try self.tasksRaw = query!.findObjects()
        }
        catch
        {
            print("Database read failed")
        }
        
        self.tasks = self.tasksRaw as? [Task]
        


    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedTasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ManagerTasksTableCell", forIndexPath: indexPath) as! ManagerTasksTableCell
        
        
        let u = self.users[indexPath.row]
        print("USER: \(u)")
        if let task = self.groupedTasks[u] {
            if task.count > 0 {
                let emp = task[indexPath.section].employee
                emp.fetchIfNeededInBackgroundWithBlock {
                    (user: PFObject?, error: NSError?) -> Void in
                    if let name = user!["name"] as? String {
                        if let ln = user!["lastName"] as? String {
                            print("\(name) \(ln.char(0)).")
                            UITableViewCell.nameLabel.text = "\(name) \(ln.char(0))."
                        }
                    }
                    for t in self.tasks! {
                        print(t.desc)
                    }
                    //print(emp["desc"] as? String)
                //UITableViewCell.taskLabel.text = task[indexPath.section]["desc"] as? String
                }
                print("TASK: \(task)")
                print(task[0]["desc"])
                //UITableViewCell.taskLabel.text = task[indexPath.row]["desc"] as? String
            }
        }
    

        
        return UITableViewCell
    }
}
