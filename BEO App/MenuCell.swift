//
//  MenuCell.swift
//  BEO App
//
//  Created by Katie Hobble on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import Parse

class MenuCell : UITableViewCell {
    
    @IBOutlet weak var appetizerLabel: UILabel!
    @IBOutlet weak var entreLabel: UILabel!
    @IBOutlet weak var dessertLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var tableView : UITableView?
    
    var loaded : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLabels(event: BEO) {
        if !loaded {
            event.menu.fetchIfNeededInBackgroundWithBlock {
                (obj: PFObject?, error: NSError?) -> Void in
                let app = obj!["appetizer"] as? String
                self.appetizerLabel.text = app
                self.entreLabel.text = obj!["entre"] as? String
                self.dessertLabel.text = obj!["dessert"] as? String
                self.noteLabel.text = event.notes
                self.loaded = true
                self.tableView?.reloadData()
            }
        }
    }
}