//
//  Task.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/3/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import Parse

class Task : PFObject, PFSubclassing {
    
    @NSManaged var employee: PFUser
    @NSManaged var due: NSDate
    @NSManaged var completed: Bool
 
    static func parseClassName() -> String {
        return "Task"
    }
}