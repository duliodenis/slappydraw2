//
//  DrawingView.swift
//  Slappy Draw
//
//  Created by Dulio Denis on 9/2/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    var currentTouch: UITouch?
    var currentPath: [CGPoint]?
    
    // MARK: Draw functions
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let path = currentPath else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(1.5)
        context.beginPath()
        context.setStrokeColor(UIColor.black.cgColor)
        guard let firstPoint = path.first else { return }
        context.move(to: firstPoint)
        
        if path.count > 1 {
            for point in 1...path.count - 1 {
                let currentPoint = path[point]
                context.addLine(to: currentPoint)
            }
            context.drawPath(using: CGPathDrawingMode.stroke)
            print("-- did draw line in context")
        }
    }

    // MARK: Touch functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentPath == nil {
            currentTouch = UITouch()
            currentTouch = touches.first
            guard let currentPoint = currentTouch?.location(in: self) else { return }
            currentPath = [CGPoint]()
            currentPath?.append(currentPoint)
            
            print("Started a new path with point \(currentPoint)")
        }
        
        setNeedsDisplay()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentPath != nil {
            for touch in touches {
                if currentTouch == touch {
                    guard let currentPoint = currentTouch?.location(in: self) else { return }
                    currentPath?.append(currentPoint)
                    
                    print("> Appended a new path with point \(currentPoint)")
                }
            }
        }
        
        setNeedsDisplay()
        super.touchesMoved(touches, with: event)
        // print("Moving in draw area")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentTouch = nil
        currentPath = nil
        print("* TOUCH CANCELLED")
        
        setNeedsDisplay()
        super.touchesCancelled(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentPath != nil {
            for touch in touches {
                if currentTouch == touch {
                    guard let currentPoint = currentTouch?.location(in: self) else { return }
                    currentPath?.append(currentPoint)
                    
                    print("End path with point \(currentPoint)")
                }
            }
        }
        
        currentTouch = nil
        currentPath = nil
        
        setNeedsDisplay()
        super.touchesEnded(touches, with: event)
    }

}
