//
//  ProgressBarView.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 11/19/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ProgressBarView : UIView {
    
    @IBInspectable var max: Int = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var current: Int = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var bgColor: UIColor = UIColor.blueColor() {
        didSet {
            self.backgroundColor = bgColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var progressColor: UIColor = UIColor.orangeColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    func initialize() {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        CGContextSetFillColorWithColor(context, progressColor.CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.clearColor().CGColor)
        
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:[UIRectCorner.AllCorners], cornerRadii: CGSizeMake(3, 3))
        let maskLayer = CAShapeLayer()
        maskLayer.path = bezierPath.CGPath
        self.layer.mask = maskLayer
        
        let frame = self.frame
        
        let part = frame.width / CGFloat(max)
        let finalX = part * CGFloat(current)
        
        let points = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: finalX, y: 0),
            CGPoint(x: finalX, y: frame.height),
            CGPoint(x: 0, y: frame.height),
            CGPoint(x: 0, y: 0),
        ]
        
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
        
        for p in points {
            CGPathAddLineToPoint(path, nil, p.x, p.y)
        }
        
        CGPathCloseSubpath(path)
        CGContextAddPath(context, path)
        CGContextFillPath(context)
        CGContextAddPath(context, path)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
    
}