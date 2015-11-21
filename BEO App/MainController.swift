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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TODO => Refactor this
    @IBAction func showListController(sender: UIButton) {
        listContainer.hidden = false
        sender.tintColor = Colors.DarkBlue
        calendarButton.tintColor = Colors.LightGrey

    }
    @IBAction func showCalendarController(sender: UIButton) {
        listContainer.hidden = true
        sender.tintColor = Colors.DarkBlue
        listButton.tintColor = Colors.LightGrey
    }
    
    
}

