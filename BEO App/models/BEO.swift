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

    // This is what is part of a BEO but we really don't care about this..
    // Since we don't show this stuff on the UI
    @NSManaged var beoNumber: Int
    @NSManaged var accountName: String
    @NSManaged var postAs: String
    @NSManaged var methodOfPayment: String
    @NSManaged var estimatedCharges: EstimatedCharges
    
    // This is mainly the part we care about
    @NSManaged var manager: PFUser
    @NSManaged var expecting: String
    @NSManaged var rsvp: String
    @NSManaged var date: NSDate
    @NSManaged var due: NSDate
    @NSManaged var clean: NSDate
    
    // We forgot about the menu...
    @NSManaged var menu: Menu
    
    // Format 6-8am 5:30-8:30pm
    @NSManaged var timePeriod: String
    @NSManaged var title: String

    // Once HR gives us more info we can set up a location enum also
    @NSManaged var location: String
    
    // The value for this is retrieved from the enum DinnerStyle
    @NSManaged var dinnerStyle: String
        
    // The value for this is retrieved from the enum Beverage
    @NSManaged var beverage: String
    
    @NSManaged var notes: String

    //TODO: move this to a class constants file
    static func parseClassName() -> String {
        return "BEO"
    }
    
}