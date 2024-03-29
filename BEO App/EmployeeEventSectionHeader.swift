//
//  EmployeeEventSectionHeader.swift
//  BEO App
//
//  Created by JESPERSEN BENJAMIN J on 11/9/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit

class EmployeeEventSectionHeader: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    // Color constants
    let redColor = UIColor(red: 177/255, green: 40/255, blue: 40/255, alpha: 1.0)
    let lightGrayColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1.0)
    let darkGrayColor = UIColor(red: 165/255, green: 167/255, blue: 170/255, alpha: 1.0)
    let goldColor = UIColor(red: 163/255, green: 145/255, blue: 101/255, alpha: 1.0)
    let blueColor = UIColor(red: 0/255, green: 53/255, blue: 110/255, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = goldColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        // Save the context before drawing
        CGContextSaveGState(context)
        
        // Set fill and stroke colors for drawing the dividers
        CGContextSetFillColorWithColor(context, blueColor.CGColor)
        CGContextSetStrokeColorWithColor(context, blueColor.CGColor)
        
        // Create an array of points representing the first divider
        let divider1Points = [
            CGPoint(x:0, y:0),
            CGPoint(x:self.bounds.size.width, y:0),
            CGPoint(x:self.bounds.size.width, y:1),
            CGPoint(x:0, y:1)
        ]
        
        // Create an empty path for divider 1
        let divider1Path = CGPathCreateMutable()
        
        // Draw the path for divider 1
        for point in divider1Points
        {
            if point == divider1Points[0]
            {
                CGPathMoveToPoint(divider1Path, nil, point.x, point.y)
            }
            else
            {
                CGPathAddLineToPoint(divider1Path, nil, point.x, point.y)
            }
        }
        
        // Close the path for divider 1
        CGPathCloseSubpath(divider1Path)
        
        // Add the path for divider 1 to the context
        CGContextAddPath(context, divider1Path)
        
        // Fill the path for divider 1
        CGContextFillPath(context)
        
        // Create an array of points representing the second divider
        let divider2Points = [
            CGPoint(x:0, y:self.bounds.size.height),
            CGPoint(x:self.bounds.size.width, y:self.bounds.size.height),
            CGPoint(x:self.bounds.size.width, y:self.bounds.size.height - 1),
            CGPoint(x:0, y:self.bounds.size.height - 1)
        ]
        
        // Create an empty path for divider 2
        let divider2Path = CGPathCreateMutable()
        
        // Draw the path for divider 2
        for point in divider2Points
        {
            if point == divider2Points[0]
            {
                CGPathMoveToPoint(divider2Path, nil, point.x, point.y)
            }
            else
            {
                CGPathAddLineToPoint(divider2Path, nil, point.x, point.y)
            }
        }
        
        // Close the path for divider 2
        CGPathCloseSubpath(divider2Path)
        
        // Add the path for divider 2 to the context
        CGContextAddPath(context, divider2Path)
        
        // Fill the path for divider 2
        CGContextFillPath(context)
        
        // Restore the saved context
        CGContextRestoreGState(context)
    }
}
