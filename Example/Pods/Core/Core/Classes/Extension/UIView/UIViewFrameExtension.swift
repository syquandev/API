//
//  UIViewFrameExtension.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//
import UIKit

extension UIView {
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    public func getFrameConvert(_ view:UIView? = nil) -> CGRect?{
        var toView = view
        if toView == nil {
            toView = UIApplication.shared.keyWindow
        }
        let frame = self.superview?.convert(self.frame, to: toView)
        return frame
    }
}
