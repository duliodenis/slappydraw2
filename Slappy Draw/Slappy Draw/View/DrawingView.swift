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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentPath == nil {
            currentTouch = UITouch()
            currentTouch = touches.first
            guard let currentPoint = currentTouch?.location(in: self) else { return }
            currentPath = [CGPoint]()
            currentPath?.append(currentPoint)
            
            print("Started a new path with point \(currentPoint)")
        }
        
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
        
        super.touchesMoved(touches, with: event)
        // print("Moving in draw area")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentTouch = nil
        currentPath = nil
        print("* TOUCH CANCELLED")
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
        super.touchesEnded(touches, with: event)
    }

}
