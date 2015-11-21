//
//  TimePeriod.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation

struct TimePeriod {
    
    var start : Int
    var end : Int
    var period: String
    
    init(s: Int, e: Int, p: String) {
        self.start = s
        self.end = e
        self.period = p
    }
}