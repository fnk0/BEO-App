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
    
    var viewController: UIViewController?
    var beo: BEO?
    
    // Storyboard outlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var completionTimeLabel: UILabel!
    @IBOutlet weak var cleanTimeLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var clockIconImage: UIImageView!
    @IBOutlet weak var dustpanIconImage: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    
    // Data arrays
    var tasks = [Task]()
    var taskLabels = [UILabel]()
    var taskCompletionLabels = [UILabel]()
    var taskButtons = [UIButton]()
    var taskClockImages = [UIImageView]()
    var taskCheckboxImages = [UIImageView]()
    
    // Positioning constants for UI elements
    let taskLabel1Height = 20
    let taskLabel1Width = 250
    let taskLabel1CenterX = 170
    let taskLabel1CenterY = 72
    
    let taskLabel2Height = 20
    let taskLabel2Width = 50
    let taskLabel2CenterX = 322
    let taskLabel2CenterY = 72
    
    let checkboxImageHeight = 20
    let checkboxImageWidth = 20
    let checkboxImageCenterX = 25
    let checkboxImageCenterY = 68
    
    let taskImageHeight = 15
    let taskImageWidth = 15
    let taskImageCenterX = 359
    let taskImageCenterY = 72
    
    var taskButtonHeight = 200
    var taskButtonWidth = 200
    var taskButtonCenterX = 200
    var taskButtonCenterY = 200
    
    let defaultCellHeight = 60
    let yPadding = 4
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateAppearance(printDebug: false)
    }
    
    
    func updateAppearance(printDebug printDebug: Bool)
    {
        // Set button size details that depend on other variables (cannot be initialized above before cell is fully instantiated)
        taskButtonHeight = taskLabel1Height + yPadding
        taskButtonWidth = Int(bounds.size.width)
        taskButtonCenterX = Int(center.x)
        taskButtonCenterY = taskLabel1CenterY
        
        if printDebug
        {
            let countToPrint = tasks.count
            print("Length of tasks array = \(countToPrint)")
        }
        
        // Set the separator color
        separatorView.backgroundColor = Colors.LightGrey
        
        // Sort tasks by due date/time
        tasks.sortInPlace { $0.due.compare($1.due) == .OrderedAscending }
        
        // If the UI elements within this cell already exist, delete them. They will be reloaded.
        for index in 0..<taskLabels.count
        {
            taskLabels[index].removeFromSuperview()
            taskCompletionLabels[index].removeFromSuperview()
            taskClockImages[index].removeFromSuperview()
            taskButtons[index].removeFromSuperview()
            taskCheckboxImages[index].removeFromSuperview()
        }
        taskLabels = [UILabel]()
        taskCompletionLabels = [UILabel]()
        taskButtons = [UIButton]()
        taskClockImages = [UIImageView]()
        taskCheckboxImages = [UIImageView]()
        
        for index in 0..<tasks.count
        {
            // Create checkbox image
            let checkboxImage = UIImageView(frame: CGRectMake(0, 0, CGFloat(checkboxImageWidth), CGFloat(checkboxImageHeight)))
            checkboxImage.center.x = CGFloat(checkboxImageCenterX)
            checkboxImage.center.y = CGFloat( checkboxImageCenterY + ((taskLabel1Height + yPadding) * index) )
            if tasks[index].completed
            {
                checkboxImage.image = Const.CheckboxCompleteImage
            }
            else
            {
                checkboxImage.image = Const.CheckboxIncompleteImage
                checkboxImage.transform = CGAffineTransformTranslate(checkboxImage.transform, -2.9, 4)
                checkboxImage.transform = CGAffineTransformScale(checkboxImage.transform, 0.58, 0.58)
            }
            self.addSubview(checkboxImage)
            taskCheckboxImages.append(checkboxImage)
            
            // Create button for task
            let button2 = UIButton(frame: CGRectMake(0, 0, CGFloat(taskButtonWidth), CGFloat(taskButtonHeight)))
            button2.center.x = CGFloat(taskButtonCenterX)
            button2.center.y = CGFloat( taskButtonCenterY + ((taskLabel1Height + yPadding) * index) )
            button2.addTarget(self, action: "checkBoxTap:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button2)
            taskButtons.append(button2)
            
            // Create label for task description
            let label1 = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabel1Width), CGFloat(taskLabel1Height)))
            label1.center.x = CGFloat(taskLabel1CenterX)
            label1.center.y = CGFloat( taskLabel1CenterY + ((taskLabel1Height + yPadding) * index) )
            label1.textAlignment = NSTextAlignment.Left
            label1.font = UIFont.systemFontOfSize(12)
            if tasks[index].completed
            {
                let stringAttributes = [ NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
                    NSStrikethroughColorAttributeName: Colors.DarkBlue ]
                let labelText = NSAttributedString(string: String(tasks[index].desc), attributes: stringAttributes)
                label1.attributedText = labelText
            }
            else
            {
                label1.text = String(tasks[index].desc)
            }
            self.addSubview(label1)
            taskLabels.append(label1)
            
            // Create image for time icon
            let image = UIImageView(frame: CGRectMake(0, 0, CGFloat(taskImageWidth), CGFloat(taskImageHeight)))
            image.center.x = CGFloat(taskImageCenterX)
            image.center.y = CGFloat( taskLabel1CenterY + ((taskLabel1Height + yPadding) * index) )
            if tasks[index].completed
            {
                image.image = Const.GrayTimeImage
            }
            else
            {
                image.image = Const.RedTimeImage
            }
            self.addSubview(image)
            taskClockImages.append(image)
            
            // Create label for time remaining
            let label2 = UILabel(frame: CGRectMake(0, 0, CGFloat(taskLabel2Width), CGFloat(taskLabel2Height)))
            label2.center.x = CGFloat(taskLabel2CenterX)
            label2.center.y = CGFloat( taskLabel2CenterY + ((taskLabel2Height + yPadding) * index) )
            label2.textAlignment = NSTextAlignment.Right
            label2.font = UIFont.systemFontOfSize(8)
            label2.text = getTimeRemaining(tasks[index].due).lowercaseString
            if tasks[index].completed
            {
                label2.textColor = Colors.DarkGrey
            }
            else
            {
                label2.textColor = Colors.Red
            }
            self.addSubview(label2)
            taskCompletionLabels.append(label2)
        }
        
        // Set colors for non-repetetive UI elements
        eventNameLabel.textColor = Colors.DarkBlue
        eventTimeLabel.textColor = Colors.Gold
        checkTasks()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func getTimeRemaining(due: NSDate) -> String {
        let date = NSDate()
        let dueHourStr = due.getHour()
        let dueMinuteStr = due.getMinute()
        let dueDayStr = due.getDay()
        let currentHourStr = date.getHour()
        let currentMinuteStr = date.getMinute()
        let currentDayStr = date.getDay()
        
        let dueDay = Int(dueDayStr)!
        let currentDay = Int(currentDayStr)!
        
        let dueHour = Int(dueHourStr)!
        let currentHour = Int(currentHourStr)!
        
        let dueMinute = Int(dueMinuteStr)! + dueHour * 60
        let currentMinute = Int(currentMinuteStr)! + currentHour * 60
        
        let remainingDays = dueDay - currentDay
        var remainingMinutes = dueMinute - currentMinute
        var remainingHours = 0
        
        while remainingMinutes >= 60 {
            remainingHours += 1
            remainingMinutes -= 60
        }
        
        var returnStr = ""
        
        if remainingDays > 0 {
            returnStr += "\(remainingDays)d "
        }
        
        if remainingHours > 0 {
            returnStr += "\(remainingHours)h "
        }
        
        if remainingMinutes > 0 {
            returnStr += "\(remainingMinutes)m"
        }
        
        
        if remainingMinutes <= 0 && remainingHours <= 0 && remainingDays <= 0 {
            return "0m"
        }
        
        return returnStr
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
            CGPoint(x:0, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2 + 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2 + 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2 + 3),
            CGPoint(x:0, y:self.clockIconImage.center.y + self.clockIconImage.bounds.height / 2 + 3)
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
            CGPoint(x:0, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2 - 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2 - 2),
            CGPoint(x:self.bounds.size.width, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2 - 3),
            CGPoint(x:0, y:self.clockIconImage.center.y - self.clockIconImage.bounds.height / 2 - 3)
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
        
        // Find the data array index corresponding to the tapped button
        for index in 0..<taskButtons.count
        {
            if taskButtons[index] == sender
            {
                buttonIndex = index
                break
            }
        }
        
        // Make sure index was found before proceeding
        if !(buttonIndex == -1)
        {
            // Update the appearance of the task's row to indicate it's completion status
            if !tasks[buttonIndex].completed
            {
                taskCheckboxImages[buttonIndex].image = Const.CheckboxCompleteImage
                taskCompletionLabels[buttonIndex].textColor = Colors.DarkGrey
                taskClockImages[buttonIndex].image = Const.GrayTimeImage
                tasks[buttonIndex].completed = true
                taskCheckboxImages[buttonIndex].transform = CGAffineTransformScale(taskCheckboxImages[buttonIndex].transform, 1/0.58, 1/0.58)
                taskCheckboxImages[buttonIndex].transform = CGAffineTransformTranslate(taskCheckboxImages[buttonIndex].transform, 2.9, -4)
                
                let stringAttributes = [ NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
                    NSStrikethroughColorAttributeName: Colors.DarkBlue ]
                let labelText = NSAttributedString(string: String(tasks[buttonIndex].desc), attributes: stringAttributes)
                taskLabels[buttonIndex].attributedText = labelText
            }
            else
            {
                taskCheckboxImages[buttonIndex].image = Const.CheckboxIncompleteImage
                taskCompletionLabels[buttonIndex].textColor = Colors.Red
                taskClockImages[buttonIndex].image = Const.RedTimeImage
                tasks[buttonIndex].completed = false
                taskCheckboxImages[buttonIndex].transform = CGAffineTransformTranslate(taskCheckboxImages[buttonIndex].transform, -2.9, 4)
                taskCheckboxImages[buttonIndex].transform = CGAffineTransformScale(taskCheckboxImages[buttonIndex].transform, 0.58, 0.58)
                taskLabels[buttonIndex].text = tasks[buttonIndex].desc
            }
            
            // Save the completion status of the task
            tasks[buttonIndex].saveInBackground()
        }
        
        checkTasks()
    }
    
    func checkTasks() {
        if allTasksCompleted()
        {
            // Set color of UI elements to gray
            completionTimeLabel.textColor = Colors.DarkGrey
            cleanTimeLabel.textColor = Colors.DarkGrey
            clockIconImage.image = Const.GrayClockImage
            dustpanIconImage.image = Const.GrayDustpanImage
        }
        else
        {
            // Set color of UI elements to red
            completionTimeLabel.textColor = Colors.Red
            cleanTimeLabel.textColor = Colors.Red
            clockIconImage.image = Const.RedClockImage
            dustpanIconImage.image = Const.RedDustpanImage
        }
        
    }
    
    func allTasksCompleted() -> Bool
    {
        for task in tasks
        {
            if task.completed == false
            {
                return false
            }
        }
        return true
    }
    
    
    // TO-DO: SEGUE TO THE INFO PAGE HERE
    @IBAction func infoButtonTap(sender: AnyObject)
    {
        if let b = beo {
            self.viewController?.performSegueWithIdentifier(Segue.ShowInfo, sender: b)
        }
    }
    
}
