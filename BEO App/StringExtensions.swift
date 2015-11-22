//
//  StringExtensions.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 10/4/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation

extension String {
    
    func length() -> Int {
        return self.characters.count
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    func stringByAppendingPathComponent(filename: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(filename)
    }
    
    func containsNumber() -> Bool {
        let numberTest = NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*")
        return numberTest.evaluateWithObject(self)
    }
    
    func char(index: Int) -> Character {
        return self[advance(self.startIndex, index)]
    }
    
    func isValidPassword() -> Bool {
        if self.length() >= 6 {
            if self.containsNumber() {
                return true
            }
        }
        return false
    }
    
    func getTimePeriod() -> TimePeriod {
        var x = self.stringByReplacingOccurrencesOfString("\\D", withString: " ", options: .RegularExpressionSearch, range: self.startIndex..<self.endIndex)
        x = x.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        var final = x.componentsSeparatedByString(" ")
        final = final.filter({ $0 != "" })
        
        var stringWithoutDigit = (self.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet()) as NSArray).componentsJoinedByString("")
        
        stringWithoutDigit = stringWithoutDigit.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        if stringWithoutDigit.characters.count == 4 {
            stringWithoutDigit = stringWithoutDigit.substringFromIndex(advance(self.startIndex, 2))
        }
        
        let y = Int(final[0])!
        let z = Int(final[1])!
        return TimePeriod(s: y, e: z, p: stringWithoutDigit)
    }

}

