
//  Created by Quan on 08/02/2023.

import UIKit
import Core

public class APISystem: NSObject {
    public static var feedHeaderExpand = true
    public static var appDidLoad: Bool = false
    public static var mediaSize: [String: CGSize] = [:]
    
    public static var shared = APISystem()
    public static func getBundle() -> Bundle{
        
        let frameworkBundle = Bundle(for: APISystem.self)
        let path = frameworkBundle.resourceURL?.appendingPathComponent("API.bundle")
        let resourcesBundle = Bundle(url: path!)
        return resourcesBundle ?? Bundle.main
        
    }
    
    public static func resourcesPath(name: String, type: String) -> String? {
        let bundle = APISystem.getBundle()
        let pathForResourceString = bundle.path(forResource: name, ofType: type)
        return pathForResourceString
    }
}

extension String {
    public var lcz: String {
        return self.localized//localized(using: nil, in: _getBundle())
    }
}
