//
//  NSDateExtensions.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation

let uFormatter =  NSDateFormatter()

extension NSDate {
    
    func formatDate() -> String {
        uFormatter.dateFormat = "EEEE, MMM dd, yyyy"
        var stringDate: String = uFormatter.stringFromDate(self)
        stringDate = stringDate.uppercaseString
        return stringDate
    }
    
    func formatTime() -> String {
        uFormatter.dateFormat = "h:mma"
        return uFormatter.stringFromDate(self)
    }
    
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }    
}