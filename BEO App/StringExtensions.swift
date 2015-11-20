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
    
    func isValidPassword() -> Bool {
        if self.length() >= 6 {
            if self.containsNumber() {
                return true
            }
        }
        return false
    }
}

