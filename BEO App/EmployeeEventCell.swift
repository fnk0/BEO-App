//
//  EmployeeEventCell.swift
//  BEO App
//
//  Created by JESPERSEN BENJAMIN J on 11/5/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit

class EmployeeEventCell: UITableViewCell {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var completionTimeLabel: UILabel!
    @IBOutlet weak var cleanTimeLabel: UILabel!
    @IBOutlet weak var infoIconImage: UIImageView!
    @IBOutlet weak var clockIconImage: UIImageView!
    @IBOutlet weak var broomIconImage: UIImageView!
    
    var tasks = [ "No tasks" ]
    var taskLabels = [UILabel]()
    var taskImageViews = [UIImageView]()
    
    let taskLabelHeight = 20
    let taskLabelWidth = 100
    let taskLabelCenterX = 100
    let taskLabelCenterY = 60
    let taskLabelSpacing = 4
    let defaultCellHeight = 60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for index in 0..<tasks.count
        {
            let label = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabelWidth), CGFloat(taskLabelHeight)))
            label.center.x = CGFloat(taskLabelCenterX)
            label.center.y = CGFloat(taskLabelCenterY + (taskLabelHeight * index) + taskLabelSpacing)
            label.textAlignment = NSTextAlignment.Left
            label.font = UIFont.systemFontOfSize(12)
            label.text = tasks[index]
            label.userInteractionEnabled = true
            self.addSubview(label)
            taskLabels.append(label)
            
            let tapRecognizer = UITapGestureRecognizer()
            tapRecognizer.addTarget(self, action: "tap")
            label.addGestureRecognizer(tapRecognizer)
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let colorGray = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        // Save the context before drawing
        CGContextSaveGState(context)
        
        // Set fill and stroke colors for drawing the dividers
        CGContextSetFillColorWithColor(context, colorGray.CGColor)
        CGContextSetStrokeColorWithColor(context, colorGray.CGColor)
        
        // Create an array of points representing the first divider
        let divider1Points = [
            CGPoint(x:0, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2 + 1),
            CGPoint(x:0, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2 + 1)
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
            CGPoint(x:0, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2 - 1),
            CGPoint(x:0, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2 - 1)
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
        
        /*
        // Create an array of points representing the third divider
        let divider3Points = [
            CGPoint(x:0, y:self.bounds.size.height),
            CGPoint(x:self.bounds.size.width, y:self.bounds.size.height),
            CGPoint(x:self.bounds.size.width, y:self.bounds.size.height - 10),
            CGPoint(x:0, y:self.bounds.size.height - 10)
        ]
        
        // Create an empty path for divider 3
        let divider3Path = CGPathCreateMutable()
        
        // Draw the path for divider 3
        for point in divider3Points
        {
            if point == divider3Points[0]
            {
                CGPathMoveToPoint(divider3Path, nil, point.x, point.y)
            }
            else
            {
                CGPathAddLineToPoint(divider3Path, nil, point.x, point.y)
            }
        }
        
        // Close the path for divider 3
        CGPathCloseSubpath(divider3Path)
        
        // Add the path for divider 3 to the context
        CGContextAddPath(context, divider3Path)
        
        // Fill the path for divider 3
        CGContextFillPath(context)
        */
        
        // Restore the saved context
        CGContextRestoreGState(context)
        
    }
    
    
    func tap()
    {
        print("Tapped")
    }
    
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("employeeTaskCell", forIndexPath: indexPath) as! EmployeeTaskCell
        
        if let taskNameLabel = cell.taskNamaLabel
        {
            taskNameLabel.text = tasks[indexPath.row]
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 20
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 20
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    */
    
}
