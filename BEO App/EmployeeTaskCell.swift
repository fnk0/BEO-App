//
//  EmployeeTaskCell.swift
//  BEO App
//
//  Created by JESPERSEN BENJAMIN J on 11/5/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit

class EmployeeTaskCell: UITableViewCell {

    @IBOutlet weak var taskNamaLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var checkboxImage: UIImageView!
    @IBOutlet weak var clockIconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
