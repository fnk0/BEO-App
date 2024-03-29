//
//  MyEventsTableViewController.swift
//  BEO App
//
//  Created by JESPERSEN BENJAMIN J on 10/22/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit

class MyEventsTableViewController: UITableViewController {
    
    // Section headers
    var sections = [ "MON. OCT 5",
        "TUE. OCT 6",
        "WED. OCT 7",
        "THU. OCT 8",
        "FRI. OCT 9",
        "SAT. OCT 10",
        "SUN. OCT 11"]
    
    // Array of events
    var events = [ [ (name: "Dummy event #1", startTime: "8:00am", endTime: "10:00pm") ],
        [ (name: "Dummy event #2", startTime: "7:15am", endTime: "8:00pm"),
            (name: "Dummy event #3", startTime: "3:00pm", endTime: "6:00pm") ],
        [ (name: "Dummy event #4", startTime: "12:00pm", endTime: "1:30pm") ],
        [ (name: "Dummy event #5", startTime: "3:00pm", endTime: "4:30pm"),
            (name: "Dummy event #6", startTime: "9:00am", endTime: "11:00pm") ],
        [ (name: "Dummy event #7", startTime: "6:00pm", endTime: "10:00pm"),
            (name: "Dummy event #8", startTime: "8:30am", endTime: "10:30am") ],
        [ (name: "Dummy event #9", startTime: "10:00am", endTime: "1:00pm") ],
        [ (name: "Dummy event #10", startTime: "2:00pm", endTime: "3:15pm"),
            (name: "Dummy event #11", startTime: "10:00am", endTime: "10:30am"),
            (name: "Dummy event #12", startTime: "7:00am", endTime: "9:00am") ] ]
    
    @IBAction func homeButtonHandler(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // Display a cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Get the appropriate cell from indexPath and reuse identifier
        let cell = tableView.dequeueReusableCellWithIdentifier("homeTableCell", forIndexPath: indexPath)
        
        let name = events[indexPath.section][indexPath.row].name
        let startTime = events[indexPath.section][indexPath.row].startTime
        let endTime = events[indexPath.section][indexPath.row].endTime
        
        // Set cell's title text
        cell.textLabel?.text = "\(startTime) - \(endTime) | \(name)"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
