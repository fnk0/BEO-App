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
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var clockIconImage: UIImageView!
    @IBOutlet weak var broomIconImage: UIImageView!
    
    var tasks = [ "Task 1",
                  "Task 2",
                  "Task 3",
                  "Task 4",
                  "Task 5" ]
    var taskLabels = [UILabel]()
    var taskButtons = [UIButton]()
    var taskImages = [UIImageView]()
    
    let taskLabel1Height = 20
    let taskLabel1Width = 100
    let taskLabel1CenterX = 100
    let taskLabel1CenterY = 60
    let taskLabel1Spacing = 4
    
    let taskLabel2Height = 20
    let taskLabel2Width = 50
    let taskLabel2CenterX = 325
    let taskLabel2CenterY = 60
    let taskLabel2Spacing = 4
    
    let taskButtonHeight = 20
    let taskButtonWidth = 20
    let taskButtonCenterX = 25
    let taskButtonCenterY = 60
    let taskButtonSpacing = 4
    
    let taskImageHeight = 15
    let taskImageWidth = 15
    var taskImageCenterX = 362
    let taskImageCenterY = 60
    let taskImageSpacing = 4
    
    let defaultCellHeight = 60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for index in 0..<tasks.count
        {
            // Create button for checkbox
            let button = UIButton(frame: CGRectMake(0, 0, CGFloat(taskButtonWidth), CGFloat(taskButtonHeight)))
            button.center.x = CGFloat(taskButtonCenterX)
            button.center.y = CGFloat(taskButtonCenterY + (taskLabel1Height * index) + taskButtonSpacing)
            button.backgroundColor = UIColor.grayColor()
            button.addTarget(self, action: "checkBoxTap:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
            taskButtons.append(button)
            
            // Create label for task description
            let label1 = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabel1Width), CGFloat(taskLabel1Height)))
            label1.center.x = CGFloat(taskLabel1CenterX)
            label1.center.y = CGFloat(taskLabel1CenterY + (taskLabel1Height * index) + taskLabel1Spacing)
            label1.textAlignment = NSTextAlignment.Left
            label1.font = UIFont.systemFontOfSize(12)
            label1.text = tasks[index]
            self.addSubview(label1)
            taskLabels.append(label1)
            
            // Create image for clock icon
            let image = UIImageView(frame: CGRectMake(0, 0, CGFloat(taskImageWidth), CGFloat(taskImageHeight)))
            image.center.x = CGFloat(taskImageCenterX)
            image.center.y = CGFloat(taskImageCenterY + (taskLabel1Height * index) + taskImageSpacing)
            image.backgroundColor = UIColor.grayColor()
            self.addSubview(image)
            taskImages.append(image)
            
            // Create label for time remaining
            let label2 = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabel2Width), CGFloat(taskLabel2Height)))
            label2.center.x = CGFloat(taskLabel2CenterX)
            label2.center.y = CGFloat(taskLabel2CenterY + (taskLabel2Height * index) + taskLabel2Spacing)
            label2.textAlignment = NSTextAlignment.Right
            label2.font = UIFont.systemFontOfSize(8)
            label2.text = "12h 30m"
            self.addSubview(label2)
            taskLabels.append(label2)
        }
        
        clockIconImage.backgroundColor = UIColor.grayColor()
        broomIconImage.backgroundColor = UIColor.grayColor()
        
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
        
        // Restore the saved context
        CGContextRestoreGState(context)
        
    }
    
    
    func checkBoxTap(sender:UIButton!)
    {
        var buttonIndex = -1
        
        for index in 0..<taskButtons.count
        {
            if taskButtons[index] == sender
            {
                buttonIndex = index
                break
            }
        }
        
        if !(buttonIndex == -1)
        {
            print("\(tasks[buttonIndex]) checkbox tapped")
        }
    }
    
    
    @IBAction func infoButtonTap(sender: AnyObject)
    {
        print("Info button tapped")
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
