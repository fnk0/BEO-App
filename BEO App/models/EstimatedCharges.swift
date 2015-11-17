//
//  EstimatedCharges.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/11/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import Parse

class EstimatedCharges : PFObject, PFSubclassing {

    @NSManaged var food: Double
    @NSManaged var beverage: Double
    @NSManaged var audioVisual: Double
    @NSManaged var room: Double
    @NSManaged var staff: Double
    @NSManaged var miscellaneous: Double
    
    static func parseClassName() -> String {
        return "EstimatedCharges"
    }
}