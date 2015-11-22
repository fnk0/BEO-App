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
    var users = [PFUser]()
    
    var beo: BEO? {
        didSet {
            // Query for tasks on a BEO
            // Update the [Task] array
            // Refresh the tableView
            headerView.beo = beo
            fetchTasks(beo)
        }
    }
    
    func fetchTasks(beo: BEO?) {
        let query = Task.query()
        self.groupedTasks = [PFUser : [Task]]()
        self.users = [PFUser]()
        
        if let b = beo {
            query?.whereKey("beo", equalTo: b)
        }
        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
//                print("Successfully retrieved \(objects!.count) beos.")
                if let objects = objects as? [Task] {
                    self.tasks = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    var tasks: [Task] = [Task]() {
        didSet {
            headerView.tasks = tasks
            
            for t in tasks {
                let employee = t["employee"] as! PFUser
                if var tu = groupedTasks[employee] {
                    tu.append(t)
                    groupedTasks[employee] = tu
                } else {
                    var ts = [Task]()
                    users.append(employee)
                    ts.append(t)
                    groupedTasks[employee] = ts
                }
            }
            //print("GTasks: \(groupedTasks)")
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: Const.ManagerTasksTableCell, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Const.ManagerTasksTableCell)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.tableHeaderView = self.headerView
        self.tableView.reloadData()
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let u = self.users[indexPath.row]
        if let ts = self.groupedTasks[u] {
            return CGFloat((ts.count * 35) + 10)
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ManagerTasksTableCell", forIndexPath: indexPath) as! ManagerTasksTableCell
        
        let u = self.users[indexPath.row]
        if let task = self.groupedTasks[u] {
            if task.count > 0 {
                let u = self.users[indexPath.row]
                if let t = self.groupedTasks[u] {
                    if t.count > 0 {
                        let emp = t[0].employee
                        emp.fetchIfNeededInBackgroundWithBlock {
                            (user: PFObject?, error: NSError?) -> Void in
                            if let name = user!["name"] as? String {
                                if let ln = user!["lastName"] as? String {
//                                    print("\(name) \(ln.char(0)).")
                                    cell.nameLabel.text = "\(name) \(ln.char(0))."
                                }
                            }
                        }
                        cell.tasks = t
                    }
                }
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let btn = UITableViewRowAction(style: UITableViewRowActionStyle.Normal,
            title: "Call",
            handler: { (rowAction, indexPath) in
                // Call the user
                let u = self.users[indexPath.row]
                // This would work if we had a real device
                if let phone = u["phone"] {
                    UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(phone)")!)
                }
                
            })
        btn.backgroundColor = UIColor(netHex: 0x36CA43)
        
        return [btn]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

