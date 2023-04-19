//
//  UIViewExtension.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit

extension UIView{
    public func backgroundShadow(shadow: CGFloat = 4, radius: CGFloat = 10, border: CGFloat = 1, color: UIColor = UIColor.black){
        layer.cornerRadius = radius
         
        // border
        layer.borderWidth = border
        layer.borderColor = color.withAlphaComponent(0.1).cgColor
         
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = shadow
    }
    
    
    
    //@IBInspectable
    @objc public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    //@IBInspectable
    @objc public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    //@IBInspectable
    @objc public var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    //@IBInspectable
    @objc public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.2
            layer.shadowRadius = shadowRadius
        }
    }
 
    //@IBInspectable
    @objc public var topLineColor: UIColor? {
        get {
            return UIColor.white
        }
        set {
            let line = UIView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 1))
            line.backgroundColor = newValue
            self.addSubview(line)
            line.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
        }
    }
    
    //@IBInspectable
    @objc public var bottomLineColor: UIColor? {
        get {
            return UIColor.white;
        }
        
        set {
            let line = UIView.init(frame: CGRect(x: 0, y: self.bounds.size.height - 1, width: self.bounds.size.width, height: 0.5))
            line.backgroundColor = newValue
            self.addSubview(line)
            line.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        }
    }
    
    
    //@IBInspectable
    @objc public var leftLineColor: UIColor? {
        get {
            return UIColor.white
        }
        set {
            let line = UIView.init(frame: CGRect(x: 0, y: 0, width: 1, height: self.bounds.size.height))
            line.backgroundColor = newValue
            self.addSubview(line)
            line.autoresizingMask = [.flexibleHeight]
        }
    }
    
    //@IBInspectable
    @objc public var rightLineColor: UIColor? {
        get {
            return UIColor.white
        }
        set {
            let line = UIView.init(frame: CGRect(x: self.bounds.size.width - 1, y: 0, width: 1, height: self.bounds.size.height))
            line.backgroundColor = newValue
            self.addSubview(line)
            line.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
        }
    }
    
    public func makeRightLineBorder(width: CGFloat, color: UIColor) {
        let line = UIView.init(frame: CGRect(x: self.bounds.size.width - width, y: 0, width: width, height: self.bounds.size.height))
        line.backgroundColor = color
        self.addSubview(line)
        line.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
    }
    
    public func makeLeftLineBorder(width: CGFloat, color: UIColor) {
        let line = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: self.bounds.size.height))
        line.backgroundColor = color
        self.addSubview(line)
        line.autoresizingMask = [.flexibleHeight]
    }
    
    public func makeBottomLineBorder(width: CGFloat, color: UIColor) {
        let line = UIView.init(frame: CGRect(x: 0, y: self.bounds.size.height - width, width: self.bounds.size.width, height: width))
        line.backgroundColor = color
        self.addSubview(line)
        line.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
    }
    
    public func makeTopLineBorder(width: CGFloat, color: UIColor) {
        let line = UIView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: width))
        line.backgroundColor = color
        self.addSubview(line)
        line.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
    }
    
    public func roundCorners(_ cornerRadius: Double, corner: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
    }
    
    public func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    
    var dashBorder: CAShapeLayer? {
        get {
            return CAShapeLayer()
        }
        set {
            
        }
    }
    public func createDottedLine(width: CGFloat, space: CGFloat, lenghDot: CGFloat, color: CGColor) {
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = width
        dashBorder.strokeColor = UIColor.orange.cgColor
        dashBorder.lineDashPattern = [lenghDot, space] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
    
    
}
