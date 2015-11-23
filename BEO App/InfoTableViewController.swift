//
//  InfoTableViewController.swift
//  BEO App
//
//  Created by Katie Hobble on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class InfoTableViewController: UITableViewController {
    
    var event : BEO? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nibs for custom tableView cell and section header
        var nib = UINib(nibName: "LocationCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "LocationCell")
        
        nib = UINib(nibName: "MenuCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "MenuCell")
        
        nib = UINib(nibName: "InfoCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "InfoCell")
        
        nib = UINib(nibName: "ImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ImageCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let e = event {
            switch indexPath.section {
            case 0:
                let cellL = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath) as! LocationCell
                cellL.setLabels(e)
                return cellL
            case 1:
                let cellM = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
                cellM.tableView = tableView
                cellM.setLabels(e)
                return cellM
            case 2:
                let cellI = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! InfoCell
                cellI.setLabels(e)
                return cellI
            case 3:
                let cellI = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
                return cellI
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 180
        case 1:
            return 196
        case 2:
            return 48
        case 3:
            return 200
        default:
            return 0
        }
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
