//
//  AppImage.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation

public enum AppImage: String{
    case back_dark
    case back_light
    
    case close_dark
    case close_light
    
    case left_dark
    case left_light
    
    public var image: UIImage{
        get{
            let ret = UIImage(named: self.rawValue, in: Core.getBundle(), compatibleWith: nil) ?? UIImage()
            return ret
        }
    }
}

public extension UIImage{
    
    static func named(_ named: String?) -> UIImage?{
        guard let named = named else{
            return nil
        }
        if let img = UIImage(named: named){
            return img
        }
        
        return AppImage.init(rawValue: named)?.image
    }
}

public extension UIImageView{
    @objc var rsImage: String? {
        get {
            return nil
        }
        set {
            if let val = newValue,
                let img = AppImage(rawValue: val){
                self.image = img.image
            }
        }
    }
    //@IBInspectable
    @objc var rsPathIB: String? {
        get {
            return nil
        }
        set {
            if let val = newValue,
                let img = AppImage(rawValue: val){
                self.image = img.image
            }
        }
    }
}

public extension UIButton{
    
    @objc var rsImage: String? {
        get {
            return nil
        }
        set {
            if let val = newValue,
                let img = AppImage(rawValue: val){
                self.setImage(img.image, for: [])
            }
        }
    }
    //@IBInspectable
    @objc var rsPathIB: String? {
        get {
            return nil
        }
        set {
            if let val = newValue,
                let img = AppImage(rawValue: val){
                self.setImage(img.image, for: [])
            }
        }
    }
    
    //@IBInspectable
    @objc var rsSelectedPathIB: String? {
        get {
            return nil
        }
        set {
            if let val = newValue,
                let img = AppImage(rawValue: val){
                self.setImage(img.image, for: UIControl.State.selected)
            }
        }
    }
    
    //@IBInspectable
    @objc var rsDisablePathIB: String? {
        get {
            return nil
        }
        set {
            if let val = newValue,
                let img = AppImage(rawValue: val){
                self.setImage(img.image, for: UIControl.State.disabled)
            }
        }
    }
}
