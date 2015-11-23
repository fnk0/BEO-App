//
//  ManagerEventHeader.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/20/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ManagerEventHeader : UIView {
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.view = xibSetup("ManagerEventHeader")
        self.addSubview(self.view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view = xibSetup("ManagerEventHeader")
        self.addSubview(self.view)
    }
}

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