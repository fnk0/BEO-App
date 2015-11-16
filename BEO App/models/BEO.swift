//
//  BEO.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/3/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import Parse

class BEO : PFObject, PFSubclassing {

    @NSManaged var beoNumber: Int
    @NSManaged var accountName: String
    @NSManaged var postAs: String
    @NSManaged var methodOfPayment: String
    @NSManaged var manager: PFUser
    @NSManaged var expecting: Int
    @NSManaged var rsvp: Int
    @NSManaged var date: NSDate
    
    @NSManaged var estimatedCharges: EstimatedCharges
    
    // Once HR gives us more info we can set up a location enum also
    @NSManaged var location: String
    
    // The value for this is retrieved from the enum DinnerStyle
    @NSManaged var dinnerStyle: String
    
    // The value for this is retrieved from the enum Food
    @NSManaged var typeOfFood: String
    
    // The value for this is retrieved from the enum Beverage
    @NSManaged var beverage: String
    
    //TODO: move this to a class constants file
    static func parseClassName() -> String {
        return "BEO"
    }
    
}