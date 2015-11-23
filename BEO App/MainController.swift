//
//  ViewController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 10/3/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit
import Parse

class MainController: UIViewController {
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var managerListContainer: UIView!
    @IBOutlet weak var pageTitle: UINavigationItem!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var isManager : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isManager = defaults.valueForKey(Const.IS_MANAGER) as? Bool {
            self.isManager = isManager
            
            if self.isManager {
                self.pageTitle.title = "EVENTS"
            }
        }
        
        showHideListController(false)
    }
    
    func showHideListController(isCalendar: Bool) {
        managerListContainer.hidden = !isManager || isCalendar
        listContainer.hidden = isManager || isCalendar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TODO => Refactor this
    @IBAction func showListController(sender: UIButton) {
        showHideListController(false)
        sender.tintColor = Colors.DarkBlue
        calendarButton.tintColor = Colors.LightGrey

    }
    @IBAction func showCalendarController(sender: UIButton) {
        showHideListController(true)
        sender.tintColor = Colors.DarkBlue
        listButton.tintColor = Colors.LightGrey
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segue.TaskSegue {
            if let vc = segue.destinationViewController as? ManagerTasksController {
                if let beo = sender as? BEO {
                    vc.beo = beo
                }
            }
        }  else if segue.identifier == "ShowInfo" {
            if let vc = segue.destinationViewController as? InfoTableViewController {
                if let beo = sender as? BEO {
                    vc.event = beo
                }
            }
        }
    }
    
}

