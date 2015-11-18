//
//  Food.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/11/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Parse
import Foundation

enum Food : String {
    case Breakfast = "Breakfast"
    case Lunch = "Lunch"
    case Dinner = "Dinner"
}

class Menu : PFObject, PFSubclassing {
    
    @NSManaged var appetizer: String
    @NSManaged var entre: String
    @NSManaged var dessert: String
    
    // The value for this is retrieved from the enum Food
    @NSManaged var typeOfFood: String
    
    static func parseClassName() -> String {
        return "Menu"
    }
}