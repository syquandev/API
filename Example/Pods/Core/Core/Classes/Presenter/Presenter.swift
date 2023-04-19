//
//  Presenter.swift
//  Pods
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit

public class Presenter: NSObject{
    
    public static var window: UIWindow?
    //Settings Appdelegate
//    Presenter.window = self.window
    
    static func processLastNotification(){
//        if !Config.shared.appDidLoad || Session.current.notification == nil {
//            return;
//        }
    }
    public static func stopMediaPlay(){
//        App.media.stopLastVideo()
    }
    
    public static func setRootViewController(_ viewController:UIViewController?){
        guard let viewController = viewController else {
            return;
        }
        stopMediaPlay()
        if let navigationController = getRootNavigationController() {
            if navigationController.presentedViewController != nil {
                navigationController.viewControllers = [viewController]
                navigationController.dismiss(animated: true) {
                }
            }else{
                print("Count \(navigationController.viewControllers.count)")
                if navigationController.viewControllers.count > 0 {
                    var child = Array.init(navigationController.viewControllers);
                    child.insert(viewController, at: 0);
                    navigationController.viewControllers = child;
                    navigationController.popToRootViewController(animated: true)
                }else{
                    navigationController.viewControllers = [viewController]
                }
                
            }
        }else{
            if let windows = self.window  {
                stopMediaPlay()
                windows.rootViewController = viewController
            }
        }
    }
    
    public static func popViewController(){
        stopMediaPlay()
        let nav = self.getVeryTopNavigationController()
        nav?.popViewController(animated: true)
    }
    
    public static func popOrDismissController(completion: (() -> Void)? = nil){
        guard let top = getVeryTopViewController() else{
            return
        }
        
        Presenter.stopMediaPlay()
        if let nav = top as? UINavigationController{
            nav.viewControllers.last?.popOrDismissController(completion: completion)
        }else{
            top.popOrDismissController(completion: completion)
        }
    }
    
    public static func dismissViewController(completion: (() -> Void)? = nil){
        guard let top = getVeryTopViewController() else{
            return
        }
        
        Presenter.stopMediaPlay()
        top.dismiss(animated: true, completion: completion)
    }
    
    public static func popRootViewController(){
        stopMediaPlay()
        let nav = self.getVeryTopNavigationController()
        nav?.popToRootViewController(animated: true)
    }
    
    
    @discardableResult
    public static func pushViewController(_ viewController: UIViewController?, animated: Bool) -> Bool{
        if viewController == nil || viewController is UINavigationController {
            return false
        }
        stopMediaPlay()
        if let nav = self.getVeryTopNavigationController(){
            nav.pushViewController(viewController!, animated: animated)
            return true
        }
        
        return false
        
    }
    
    public static func getVeryTopNavigationController() -> UINavigationController? {
        var nav: UINavigationController?
        let top = getVeryTopViewController()
        if top is UINavigationController {
            nav = top as? UINavigationController
        }else{
            nav = top?.navigationController
        }
        return nav
    }
    
    @discardableResult
    public static func presentViewController(_ viewController: UIViewController?, animated: Bool, addNav: Bool = false, styled: Bool = false, completion: (() -> Swift.Void)? = nil) -> UIViewController?{
        guard let viewController = viewController else{
            return nil
        }
        stopMediaPlay()
        if let topController = self.getVeryTopViewController(){
            var vc = viewController
            if addNav{
                if viewController is UINavigationController{
                    
                }else{
                    vc = CustomNavigationController(rootViewController: viewController)
                }
            }
            if !styled{
                if #available(iOS 13.0, *) {
                    vc.modalPresentationStyle = .fullScreen
                }
            }
            topController.present(vc, animated: animated, completion: completion)
            return topController
        }
        
        return nil
    }
    public static func presentPopupController(_ viewController: UIViewController?, animated: Bool, completion: (() -> Swift.Void)? = nil){
        viewController?.modalPresentationStyle = .overCurrentContext;
        self.presentViewController(viewController, animated: animated, styled: true, completion: completion);
    }
    
    
    public static func getRootNavigationController() -> UINavigationController? {
        let navigationController = self.getRootController() as? UINavigationController
        return navigationController
    }
    
    public static func getRootController() -> UIViewController? {
        guard let windows = self.window else {
            return nil
        }
        let rootController = windows.rootViewController
        return rootController
    }
    
    public static func getVeryTopViewController() -> UIViewController? {
        var topController = self.getRootController()
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    public static func getVeryTopLastViewController() -> UIViewController? {
        var topvc = Presenter.getVeryTopViewController()
        if let nav = topvc as? UINavigationController{
            topvc = nav.viewControllers.last
        }
        return topvc
    }
    
    public static func pushOrPresentedController(_ viewController: UIViewController?, animated: Bool = true){
        guard let viewController = viewController else{
            return
        }
        stopMediaPlay()
        if !self.pushViewController(viewController, animated: animated){
            var nav: UINavigationController!
            if let n = viewController as? UINavigationController{
                nav = n
            }else{
                nav = CustomNavigationController(rootViewController: viewController)
            }

            if #available(iOS 13.0, *) {
                nav.modalPresentationStyle = .fullScreen
            }

            self.presentViewController(nav, animated: animated)
        }
    }
    
    public static func presentedController(_ viewController: UIViewController?){
        guard let viewController = viewController else{
            return
        }
        var nav: UINavigationController!
        if let n = viewController as? UINavigationController{
            nav = n
        }else{
            nav = CustomNavigationController(rootViewController: viewController)
        }

        if #available(iOS 13.0, *) {
            nav.modalPresentationStyle = .fullScreen
        }

        self.presentViewController(nav, animated: true)
    }
    
    /* HoaLD present popup*/
    public static func presentPopupViewController(_ viewController: UIViewController?, completion: (() -> Swift.Void)? = nil){
        viewController?.modalPresentationStyle = .overFullScreen
        viewController?.modalTransitionStyle = .crossDissolve
        self.presentViewController(viewController, animated: true, styled: true, completion: completion);
    }
}
