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
        self.addSubview(self.view)
    }
}