//
//  SingleTask.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/21/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class SingleTask : UIView {
    
    @IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var task : Task? {
        didSet {
            if let t = task {
                
                if t.completed {
                    checkbox.image = Const.CheckboxCompleteImage
                    let attributes = [
                        NSFontAttributeName: UIFont(name: "Avenir Book", size: 16.0)!,
                        NSForegroundColorAttributeName: UIColor.blackColor(),
                        NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)
                    ]
                    let myTitle = NSAttributedString(string: t.desc, attributes: attributes)
                    title.attributedText = myTitle
                } else {
                    title.text = t.desc
                }
            }
        }
    }
    
    var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.view = xibSetup("SingleTask")
        self.addSubview(self.view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view = xibSetup("SingleTask")
        self.addSubview(self.view)
    }
    
}