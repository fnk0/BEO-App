//
//  UIViewExtensions.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/22/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let v = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return v
    }
    
    func xibSetup(nibName: String) -> UIView {
        let view = self.loadViewFromNib(nibName)
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        return view
    }
}