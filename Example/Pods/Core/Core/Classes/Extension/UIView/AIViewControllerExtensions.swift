//
//  AIViewControllerExtensions.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit

extension UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    public class func createFromStoryboard<T:UIViewController>(bundle: Bundle) -> T{
        let storyboardIdentifier = self.storyboardIdentifier
        let storyboard:UIStoryboard = UIStoryboard(name: storyboardIdentifier, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
    
    public class func createFromStoryboard<T:UIViewController>(storyboardName: String, bundle: Bundle) -> T{
        let storyboardIdentifier = self.storyboardIdentifier
        let storyboard:UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
    
    public class func createFromStoryboard<T:UIViewController>(_ storyboardName: String, bundle: Bundle) -> T{
        let storyboardIdentifier = self.storyboardIdentifier
        let storyboard:UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
    
    public class func createFromStoryboard<T:UIViewController>(storyboardName: String, bundle: Bundle, storyboardIdentifier: String) -> T{
        let storyboard:UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
    
    public class func createFromStoryboard<T:UIViewController>() -> T{
        let storyboardIdentifier = self.storyboardIdentifier
        let bundle = Bundle(for: self)
        let storyboard:UIStoryboard = UIStoryboard(name: storyboardIdentifier, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
    
    public class func createFromStoryboard<T:UIViewController>(name:String) -> T{
        let storyboardIdentifier = self.storyboardIdentifier
        let bundle = Bundle(for: self)
        let storyboard:UIStoryboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
}
