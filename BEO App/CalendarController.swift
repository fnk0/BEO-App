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

class CalendarController : UIViewController,
            CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate {
    
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = Appearance()
        appearance.dayLabelWeekdayHighlightedBackgroundColor = Colors.Red
        appearance.dayLabelPresentWeekdaySelectedBackgroundColor = Colors.Red
        appearance.dayLabelPresentWeekdayHighlightedTextColor = Colors.DarkBlue
        appearance.dayLabelWeekdaySelectedBackgroundColor = Colors.Red
        appearance.dayLabelPresentWeekdayTextColor = Colors.DarkBlue
        
        calendarView.appearance = appearance
        
        let dateStr = CVDate(date: NSDate()).globalDescription.uppercaseString
        calendarLabel.text = dateStr.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    override func viewDidLayoutSubviews() {
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    func presentedDateUpdated(date: Date) {
        let dateStr = date.globalDescription.uppercaseString
        calendarLabel.text = dateStr.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
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