//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by LAURA LUCRECIA SANCHEZ PADILLA on 19/10/15.
//  Copyright © 2015 LAURA LUCRECIA SANCHEZ PADILLA. All rights reserved.
//

import UIKit

extension UIColor{
    class func randomColor() -> UIColor{
        let red = CGFloat(Double((arc4random() % 256))/255)
        let green = CGFloat(Double((arc4random() % 256))/255)
        let blue = CGFloat(Double((arc4random() % 256))/255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
    }
}

enum Shape: UInt{
    case Line = 0, Rect, Ellipse, Image
}

enum DrawingColor: UInt{
    case Red = 0, Blue, Yellow, Green, Random
}

class QuartzFunView: UIView {
    
    var shape = Shape.Line
    var currentColor = UIColor.redColor()
    var useRandomColor = false
    
    private let image = UIImage(named: "iphone")!
    private var firstTouchLocation : CGPoint = CGPointZero
    private var lastTouchLocation : CGPoint = CGPointZero
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        firstTouchLocation = (touches.first?.locationInView(self))!
        lastTouchLocation = firstTouchLocation
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouchLocation = (touches.first?.locationInView(self))!
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouchLocation = (touches.first?.locationInView(self))!
        setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
        
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
        let currentRect = CGRectMake(firstTouchLocation.x, firstTouchLocation.y, lastTouchLocation.x - firstTouchLocation.x, lastTouchLocation.y - firstTouchLocation.y)
        switch shape{
        
        case .Line:
            CGContextMoveToPoint(context, firstTouchLocation.x, firstTouchLocation.y)
            CGContextAddLineToPoint(context, lastTouchLocation.x, lastTouchLocation.y)
            CGContextStrokePath(context)
        case .Rect:
            CGContextAddRect(context, currentRect)
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            
        case .Ellipse:
            CGContextAddEllipseInRect(context, currentRect)
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            
        case .Image:
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            
            let drawPoint = CGPointMake(lastTouchLocation.x - horizontalOffset, lastTouchLocation.y - verticalOffset)
            image.drawAtPoint(drawPoint)
            
            
            
        }
    }
    

}
