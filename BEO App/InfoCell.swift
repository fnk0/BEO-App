//
//  InfoCell.swift
//  BEO App
//
//  Created by Katie Hobble on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var setupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLabels(event: BEO) {
        setupLabel.text = event.dinnerStyle
    }
}