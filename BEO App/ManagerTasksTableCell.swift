//
//  ManagerTasksTableCell.swift
//  BEO App
//
//  Created by Tom Fiveash on 11/20/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

class ManagerTasksTableCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tasksView: UIStackView!
    
    var tasks : [Task] = [Task]() {
        didSet {
            for t in tasks {
                let tv = SingleTask(frame: CGRect(x: 0, y: 0, width: 245, height: 30))
                tv.task = t
                tasksView.addArrangedSubview(tv)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}