//
//  MenuCell.swift
//  BEO App
//
//  Created by Katie Hobble on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class MenuCell : UITableViewCell {
    
    @IBOutlet weak var appetizerLabel: UILabel!
    @IBOutlet weak var entreLabel: UILabel!
    @IBOutlet weak var dessertLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLabels(event: BEO) {
        appetizerLabel.text = event.menu.appetizer
        entreLabel.text = event.menu.entre
        dessertLabel.text = event.menu.dessert
        noteLabel.text = event.notes
    }
}