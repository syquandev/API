//
//  AIGestureHandler.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//

import Foundation
import UIKit

public class AIGestureHandler: NSObject {
    private var _delta:CGPoint = CGPoint(x: 0, y: 0) ;
    private var _velocity:CGPoint = CGPoint(x: 0, y: 0);
    private var _prevPoint:CGPoint = CGPoint(x: 0, y: 0);
    
    
    public var delta: CGPoint {
        return _delta
    }
    
    public var velocity:CGPoint{
        return _velocity
    }
    public var isGoUp:Bool{
        return _velocity.y < 0
    }
    
    public var isGoLeft:Bool{
        return _velocity.x < 0;
    }
    
    public func update(gesture: UIPanGestureRecognizer){
        
        let currentPoint = gesture.translation(in: gesture.view)
        switch gesture.state {
        case .began:
            _delta = CGPoint(x: 0, y: 0)
            _prevPoint = currentPoint
            
        case .changed:
            _velocity = gesture.velocity(in: gesture.view)
            _delta = CGPoint(x: currentPoint.x - _prevPoint.x, y: currentPoint.y - _prevPoint.y)
        default:
            break
            
        }
        _prevPoint = currentPoint
    }
    
}
