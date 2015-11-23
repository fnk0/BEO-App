//
//  TimeUtil.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/22/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation

class TimeUtil {
    
    static func setCompleteTime(hour: Int, var amOrPm: String) -> String {
        let numberOfMinutesBeforeCompleteTime = 15
        var totalSeconds = 0
        var newHour = 0
        var newMinute = 0
        if amOrPm == "am" {
            totalSeconds = (hour * 3600) - (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600
        } else if amOrPm == "pm" {
            totalSeconds = (hour * 3600) + (12 * 3600) - (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600 - 12
            if newHour == 0 {
                newHour = 12
                amOrPm = "am"
            }
        }
        
        newMinute = totalSeconds % 3600 / 60
        return ("Complete by \(newHour):\(newMinute)\(amOrPm)")
    }
    
    static func setCleanTime(hour: Int, var amOrPm: String) -> String {
        let numberOfMinutesBeforeCompleteTime = 30
        var totalSeconds = 0
        var newHour = 0
        var newMinute = 0
        if amOrPm == "am" {
            totalSeconds = (hour * 3600) + (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600
            if newHour > 12 {
                newHour = newHour - 12
                amOrPm = "pm"
            }
        } else if amOrPm == "pm" {
            totalSeconds = (hour * 3600) + (12 * 3600) + (numberOfMinutesBeforeCompleteTime * 60)
            newHour = totalSeconds / 3600 - 12
        }
        
        newMinute = totalSeconds % 3600 / 60
        return ("Clean by \(newHour):\(newMinute)\(amOrPm)")
    }

    
}