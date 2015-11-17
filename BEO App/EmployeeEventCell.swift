//
//  EmployeeEventCell.swift
//  BEO App
//
//  Created by JESPERSEN BENJAMIN J on 11/5/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import UIKit
import Parse

class EmployeeEventCell: UITableViewCell {
    
    // Storyboard outlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var completionTimeLabel: UILabel!
    @IBOutlet weak var cleanTimeLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var clockIconImage: UIImageView!
    @IBOutlet weak var broomIconImage: UIImageView!
    
    // Data arrays
    /*
    var tasks = [ "Task 1",
                  "Task 2",
                  "Task 3",
                  "Task 4",
                  "Task 5" ]
    */
    var tasks = [PFObject]()
    var taskLabels = [UILabel]()
    var taskCompletionLabels = [UILabel]()
    var taskButtons = [UIButton]()
    var taskImages = [UIImageView]()
    
    // Positioning constants for UI elements
    let taskLabel1Height = 20
    let taskLabel1Width = 250
    let taskLabel1CenterX = 170
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
    let taskImageCenterX = 362
    let taskImageCenterY = 60
    let taskImageSpacing = 4
    
    let defaultCellHeight = 60
    
    // Color constants
    let redColor = UIColor(red: 177/255, green: 40/255, blue: 40/255, alpha: 1.0)
    let lightGrayColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1.0)
    let darkGrayColor = UIColor(red: 165/255, green: 167/255, blue: 170/255, alpha: 1.0)
    let goldColor = UIColor(red: 163/255, green: 145/255, blue: 101/255, alpha: 1.0)
    let blueColor = UIColor(red: 0/255, green: 53/255, blue: 110/255, alpha: 1.0)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateAppearance(printDebug: false)
    }
    
    
    func updateAppearance(printDebug printDebug: Bool)
    {
        if printDebug
        {
            let countToPrint = tasks.count
            print("Length of tasks array = \(countToPrint)")
        }
        
        for index in 0..<tasks.count
        {
            // Create button for checkbox
            let button = UIButton(frame: CGRectMake(0, 0, CGFloat(taskButtonWidth), CGFloat(taskButtonHeight)))
            button.center.x = CGFloat(taskButtonCenterX)
            button.center.y = CGFloat(taskButtonCenterY + (taskLabel1Height * index) + taskButtonSpacing)
            button.backgroundColor = lightGrayColor
            button.addTarget(self, action: "checkBoxTap:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
            taskButtons.append(button)
            
            // Create label for task description
            let label1 = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabel1Width), CGFloat(taskLabel1Height)))
            label1.center.x = CGFloat(taskLabel1CenterX)
            label1.center.y = CGFloat(taskLabel1CenterY + (taskLabel1Height * index) + taskLabel1Spacing)
            label1.textAlignment = NSTextAlignment.Left
            label1.font = UIFont.systemFontOfSize(12)
            do
            {
                try tasks[0].fetchIfNeeded()
            }
            catch
            {
                print("Database read failed.");
            }
            label1.text = String(tasks[index].valueForKey("desc")!)
            self.addSubview(label1)
            taskLabels.append(label1)
            
            // Create image for clock icon
            let image = UIImageView(frame: CGRectMake(0, 0, CGFloat(taskImageWidth), CGFloat(taskImageHeight)))
            image.center.x = CGFloat(taskImageCenterX)
            image.center.y = CGFloat(taskImageCenterY + (taskLabel1Height * index) + taskImageSpacing)
            image.backgroundColor = redColor
            self.addSubview(image)
            taskImages.append(image)
            
            // Create label for time remaining
            let label2 = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabel2Width), CGFloat(taskLabel2Height)))
            label2.center.x = CGFloat(taskLabel2CenterX)
            label2.center.y = CGFloat(taskLabel2CenterY + (taskLabel2Height * index) + taskLabel2Spacing)
            label2.textAlignment = NSTextAlignment.Right
            label2.font = UIFont.systemFontOfSize(8)
            label2.text = "12h 30m"
            label2.textColor = redColor
            self.addSubview(label2)
            taskCompletionLabels.append(label2)
        }
        
        eventNameLabel.textColor = blueColor
        eventTimeLabel.textColor = goldColor
        completionTimeLabel.textColor = redColor
        cleanTimeLabel.textColor = redColor
        clockIconImage.backgroundColor = redColor
        broomIconImage.backgroundColor = redColor
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
            if sender.backgroundColor == lightGrayColor
            {
                sender.backgroundColor = UIColor.blackColor()
                taskCompletionLabels[buttonIndex].textColor = lightGrayColor
                taskImages[buttonIndex].backgroundColor = lightGrayColor
                
            }
            else
            {
                sender.backgroundColor = lightGrayColor
                taskCompletionLabels[buttonIndex].textColor = redColor
                taskImages[buttonIndex].backgroundColor = redColor
            }
        }
    }
    
    
    @IBAction func infoButtonTap(sender: AnyObject)
    {
        print("Info button tapped")
    }
    
}
