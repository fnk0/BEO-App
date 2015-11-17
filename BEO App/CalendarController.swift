//
//  CalendarController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/3/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar
import Parse

class CalendarController : UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate,
UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var beosTableView: UITableView!
    
    var beos: [BEO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = Appearance()
        appearance.dayLabelWeekdayHighlightedBackgroundColor = Colors.Red
        appearance.dayLabelPresentWeekdaySelectedBackgroundColor = Colors.Red
        appearance.dayLabelPresentWeekdayHighlightedTextColor = Colors.DarkBlue
        appearance.dayLabelWeekdaySelectedBackgroundColor = Colors.Red
        appearance.dayLabelPresentWeekdayTextColor = Colors.DarkBlue
        
        calendarView.appearance = appearance
        
        let date = CVDate(date: NSDate())
        let dateStr = date.globalDescription.uppercaseString
        calendarLabel.text = dateStr.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
    }
    
    func updateBEOList(date: CVDate) -> Void {
        let query = BEO.query()
        query?.whereKey(Const.DATE, equalTo: date.convertedDate()!)
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) beos.")
                
                if let objects = objects as? [BEO] {
                    self.beos = objects
                    self.beosTableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : MyEventsCalendarTableCell = tableView.dequeueReusableCellWithIdentifier(Const.MyEventsCalendarTableCell) as! MyEventsCalendarTableCell
        let beo = self.beos[indexPath.row]
        
        cell.titleLabel.text = beo.title
        cell.timeLabel.text = beo.timePeriod
        
        return cell
    }
    
    func presentedDateUpdated(date: Date) {
        let dateStr = date.globalDescription.uppercaseString
        calendarLabel.text = dateStr.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        updateBEOList(date)
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return WeekdaySymbolType.VeryShort
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    func presentationMode() -> CalendarMode {
        return CalendarMode.MonthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.Sunday
    }
    
    @IBAction func calendarLeft(sender: AnyObject) {
        self.calendarView.loadPreviousView()
    }
    
    
    @IBAction func calendarRight(sender: UIButton) {
        self.calendarView.loadNextView()
    }
    
}