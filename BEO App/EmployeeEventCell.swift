//
//  EmployeeEventCell.swift
//  BEO App
//
//  Created by JESPERSEN BENJAMIN J on 11/5/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit

class EmployeeEventCell: UITableViewCell {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var completionTimeLabel: UILabel!
    @IBOutlet weak var cleanTimeLabel: UILabel!
    @IBOutlet weak var task0DescriptionLabel: UILabel!
    @IBOutlet weak var infoIconImage: UIImageView!
    @IBOutlet weak var clockIconImage: UIImageView!
    @IBOutlet weak var broomIconImage: UIImageView!
    @IBOutlet weak var task0IconImage: UIImageView!
    //@IBOutlet weak var taskTableView: UITableView!
    
    var taskLabels = [UILabel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeTaskCell", forIndexPath: indexPath) as! EmployeeTaskCell
        
        if let taskNameLabel = cell.taskNamaLabel
        {
            taskNameLabel.text = tasks[indexPath.row]
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 20
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 20
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    */
    
}
