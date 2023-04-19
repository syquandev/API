//
//  UIViewAutoLayout.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit

extension UIView{
    
    public func addSubViewAndBoundMaskPin(_ view: UIView){
        self.addSubview(view);
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    public func addSubViewAndPinEdge(_ view: UIView){
        self.addSubview(view);
        view.pinEdgesToSuperView()
    }
    
    public func pinEdgesToSuperView(){
        guard let superview = self.superview else{
            return;
        }
        
        self.pinTrailingToView(superview, constant: 0);
        self.pinLeadingToView(superview, constant: 0);
        self.pinTopToView(superview, constant: 0);
        self.pinBottomToView(superview, constant: 0);
    }
    
    @discardableResult
    public func pinTrailingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinWidthFixedTo(constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        
        self.addConstraint(layout)
        return layout
    }
    
    @discardableResult
    public func pinHeightFixedTo(constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        
        self.addConstraint(layout)
        return layout
    }
    
    @discardableResult
    public func pinLeadingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinLeftToRightView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinRightToLeftView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinTopToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinTopToLayoutGuide(_ guide: UILayoutGuide, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: guide.topAnchor, attribute: .top, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinTopToBottomView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinBottomToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinBottomToTopView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: constant)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinCenterYToView(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: 0)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
    
    @discardableResult
    public func pinCenterXToView(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false;
        let layout = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: 0)
        
        if let superview = self.superview {
            superview.addConstraint(layout);
        }
        return layout
    }
}

