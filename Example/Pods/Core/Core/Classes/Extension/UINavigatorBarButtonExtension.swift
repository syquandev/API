//
//  UINavigatorBarButtonExtension.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import UIKit
extension UIViewController{
    
    @objc
    public func dismissViewControllerSelector(){
        dismissViewController(completion: nil)
    }
    
    @objc
    public func popOrDismissControllerSelector(){
        popOrDismissController(completion: nil)
    }
    
        
    public func popOrDismissController(completion: (() -> Void)?){
        if let nav = self.navigationController ?? (self as? UINavigationController) {
            let count = nav.viewControllers.count
            if count <= 1 {
                dismissViewController(completion: completion)
            }
            else{
                
            }
        }else{
            dismissViewController(completion: completion)
        }
        
    }
    
    public func dismissViewController(completion: (() -> Void)?){
        self.dismiss(animated: true, completion: completion)
    }
    
    public func addLeftButton(title:String, action:Selector){
        let button = UIBarButtonItem.init(title: title, style: .plain, target: self, action: action);
        self.navigationItem.leftBarButtonItem = button
    }
    
    public func addBackButtonWithImage(_ image: UIImage){
       
        self.addLeftButton(image: image, action: #selector(popOrDismissControllerSelector))
    }
    
    public func addDefaultNavBackButton(closeIcon: Bool = false){
        var icon = ""
        if closeIcon{
            icon = "icon_close"
            if m_isLightNavigation(){
                icon = "close_light"
            }
            
        }else{
            icon = "left_dark"
            if m_isLightNavigation(){
                icon = "left_light"
            }
        }
        
        
        self.addLeftButton(image: UIImage (name: icon, bundle: Core.getBundle()), action: #selector(popOrDismissControllerSelector))
    }
    
    private func m_isLightNavigation() -> Bool{
        guard let vc = self as? UIViewController else{
            return false
        }
        return false
    }
    
    public func addDissmissButton(){
        var icon = ""
        if m_isLightNavigation(){
            icon = ""
        }
        self.addLeftButton(image: UIImage (named: icon), action: #selector(dismissViewControllerSelector))
    }
    
    
    public func addLeftButton(awesome:String, action:Selector){
        
        let button = UIBarButtonItem.init(title: awesome, style: .plain, target: self, action: action);
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        button.setTitleTextAttributes(attribute, for: .normal)
        button.setTitleTextAttributes(attribute, for: .highlighted)
        button.setTitleTextAttributes(attribute, for: .disabled)
        self.navigationItem.leftBarButtonItem = button
    }
    
    public func addLeftButton(image:UIImage?, action:Selector){
        let orgImage = image?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem.init(image: orgImage, style: .plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = button
    }
    
    
    public func addRightButton(title:String, action:Selector){
        let button = UIBarButtonItem.init(title: title, style: .plain, target: self, action: action);
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        button.setTitleTextAttributes(attribute, for: .normal)
        button.setTitleTextAttributes(attribute, for: .highlighted)
        button.setTitleTextAttributes(attribute, for: .disabled)
        self.navigationItem.rightBarButtonItem = button
    }
    
    public func addRightButton(awesome:String, action:Selector){
        let button = UIBarButtonItem.init(title: awesome, style: .plain, target: self, action: action);
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        button.setTitleTextAttributes(attribute, for: .normal)
        button.setTitleTextAttributes(attribute, for: .highlighted)
        button.setTitleTextAttributes(attribute, for: .disabled)
        self.navigationItem.rightBarButtonItem = button
    }
    
    
    public func addRightButton(image:UIImage, action:Selector){
        let orgImage = image.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem.init(image: orgImage, style: .plain, target: self, action: action)
        self.navigationItem.rightBarButtonItem = button
    }
    
    
}


