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
    
    var beo: BEO? {
        didSet {
            // Query for tasks on a BEO
            // Update the [Task] array
            // Refresh the tableView
            headerView.beo = beo
        }
    }
    
    var tasks: [Task] = [Task]() {
        didSet {
            headerView.tasks = tasks
        }
    }
    
    override func viewDidLoad() {
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
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
