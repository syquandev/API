//
//  CustomNavigationController.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
open class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
//    let animationTransition = PresentPushAnimation()
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.customInit()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.customInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    func customInit(){
//        self.transitioningDelegate = self.animationTransition
//        self.interactivePopGestureRecognizer
        self.delegate = self
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.white
        
//        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: AppFont.bold_19.getFont()]
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 1{
            self.interactivePopGestureRecognizer?.isEnabled = true
        }else{
            
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
}
