//
//  String+LocalizedBundleTableName.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation

public class LanguageExtend{
    private static var lang = getLang()
    
    private static func getLang() -> [String: String]{
        guard let path = Bundle.main.path(forResource: "DefaultLcz", ofType: "strings") else{
            return [:]
        }
        if let dics = NSDictionary(contentsOfFile: path) as? [String: String]{
            return dics
        }
        return [:]
    }
    static func lcz(_ input: String) -> String?{
        return ""
    }
}
/// bundle & tableName friendly extension
public extension String {
    
    /**
     Swift 2 friendly localization syntax, replaces NSLocalizedString.
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: The localized string.
     */
    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        var ret = ""
        
//        let test = Localize.currentLanguage()
        
        if let path = bundle.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            ret = bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        else if let path = bundle.path(forResource: LCLBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            ret = bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        if ret != self{
            return ret
        }
        if let r = LanguageExtend.lcz(ret){
            ret = r
        }
//        if let path = bundle.path(forResource: "en", ofType: "lproj"),
//            let bundle = Bundle(path: path) {
//            ret = bundle.localizedString(forKey: self, value: nil, table: tableName)
//        }
        return ret
    }
    
    /**
     Swift 2 friendly localization syntax with format arguments, replaces String(format:NSLocalizedString).
     
     - parameter arguments: arguments values for temlpate (substituted according to the user’s default locale).
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: The formatted localized string with arguments.
     */
    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized(using: tableName, in: bundle), arguments: arguments)
    }
    
    /**
     Swift 2 friendly plural localization syntax with a format argument.
     
     - parameter argument: Argument to determine pluralisation.
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(argument: CVarArg, using tableName: String?, in bundle: Bundle?) -> String {
        return NSString.localizedStringWithFormat(localized(using: tableName, in: bundle) as NSString, argument) as String
    }
    
}
