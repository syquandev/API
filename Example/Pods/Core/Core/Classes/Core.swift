import UIKit

public class Core: NSObject {
    public static var feedHeaderExpand = true
    public static var appDidLoad: Bool = false
    public static var mediaSize: [String: CGSize] = [:]
    
    public static var shared = Core()
    public static func getBundle() -> Bundle{
        
        let frameworkBundle = Bundle(for: Core.self)
        let path = frameworkBundle.resourceURL?.appendingPathComponent("Core.bundle")
        let resourcesBundle = Bundle(url: path!)
        return resourcesBundle ?? Bundle.main
        
    }
    
    public static func resourcesPath(name: String, type: String) -> String? {
        let bundle = Core.getBundle()
        let pathForResourceString = bundle.path(forResource: name, ofType: type)
        return pathForResourceString
    }
}

extension String {
    public var lcz: String {
        return self.localized//localized(using: nil, in: _getBundle())
    }
}
