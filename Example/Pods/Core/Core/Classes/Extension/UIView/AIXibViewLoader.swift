//
//  AIXibViewLoader.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit

open class AIXibViewLoader: UIView {
    
    public var didLoaded = false
    
    func initNib(){
        guard let view = type(of: self).getViewForOwner(owner: self) else {
            return
        }
        self.addSubViewAndBoundMaskPin(view)
        self.initCustom()
    }
    
    
    class func getViewForOwner(owner: Any?) -> UIView? {
        
//        let class2 = NSStringFromClass(self)
//        let class3 = String(describing: AIXibViewLoader.self)
//        let class4 = String(describing: type(of: self))
        let className = Self.getFileName()
        let bundle = getBundle() //Core.getBundle()!
        guard let subs = bundle.loadNibNamed(className, owner: owner, options: nil) else {
            return nil;
        }
        return subs.objectAtIndex(0) as? UIView
    }
    
    open func initCustom(){
    
    }
    open func viewDidLoad(){
        
    }
    
    open class func getFileName() -> String{
        return String(describing: self)
    }
    
    open class func getBundle() -> Bundle{
        let bundle = Bundle(for: self)
        return bundle
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.initNib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }
    
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if !self.didLoaded {
            self.didLoaded = true
            self.viewDidLoad()
        }
    }

}

