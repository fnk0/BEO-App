//
//  MyEventsTableCell.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/11/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class ManagerEventListTableCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var cleanLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var dustpanIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}