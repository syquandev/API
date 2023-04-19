//
//  Localize.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
//import Network

let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"
let LCLCurrentLanguageName = "LCLCurrentLanguageName"

/// Default language. English. If English is unavailable defaults to base localization.
let LCLDefaultLanguage = "en"

/// Base bundle as fallback.
let LCLBaseBundle = "Base"

/// Name for language change notification
public let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"

// MARK: Localization Syntax

/**
Swift 1.x friendly localization syntax, replaces NSLocalizedString
- Parameter string: Key to be localized.
- Returns: The localized string.
*/
public func Localized(_ string: String) -> String {
    return string.localized
}

/**
 Swift 1.x friendly localization syntax with format arguments, replaces String(format:NSLocalizedString)
 - Parameter string: Key to be localized.
 - Returns: The formatted localized string with arguments.
 */
public func Localized(_ string: String, arguments: CVarArg...) -> String {
    return String(format: string.localized, arguments: arguments)
}

/**
 Swift 1.x friendly plural localization syntax with a format argument
 
 - parameter string:   String to be formatted
 - parameter argument: Argument to determine pluralisation
 
 - returns: Pluralized localized string.
 */
public func LocalizedPlural(_ string: String, argument: CVarArg) -> String {
    return string.localizedPlural(argument)
}


public extension String {
    
    func atLeast(_ value: Int, unit: String = "character") -> String{
        let lc = self.localized
        var u = unit
        if value > 1 {
            u = unit + "_s"
        }
        return "\(lc) \("at_lest".localized) \(value) \(u.localized)"
    }
    
    func noMoreThan(value: Int, unit: String = "character") -> String {
        let lc = self.localized
        var  u = unit
        if value > 1 {
            u = unit + "_s"
        }
        return "\(lc) \("no_more_than".localized) \(value) \(u.localized)"
    }
    /**
     Swift 2 friendly localization syntax, replaces NSLocalizedString
     - Returns: The localized string.
     */
    var localized: String {
        return localized(using: nil, in: .main)
    }
    

    
//    func localized() -> String {
//        return localized(using: nil, in: .main)
//    }

    /**
     Swift 2 friendly localization syntax with format arguments, replaces String(format:NSLocalizedString)
     - Returns: The formatted localized string with arguments.
     */
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
    
    /**
     Swift 2 friendly plural localization syntax with a format argument
     
     - parameter argument: Argument to determine pluralisation
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(_ argument: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized as NSString, argument) as String
    }
    
    func plural(_ value: Int) -> String {
        if value > 1{
            let pl = self + "_s"
            return pl.localized
        }
        return self.localized
    }
    
    func pluralFormat(_ arguments: CVarArg...) -> String {
        let count = arguments.count
        
        var text = [CVarArg]()
        
        let coup = count/2
        
        for i in 0..<coup{
            let index = i*2
            if let n = arguments.at(index) as? Int,
                let s = arguments.at(index+1) as? String{
                
                var lowscape = s.lowercased()
                if Localize.currentLanguage() != "vi"{
                    if n > 1 {
                        lowscape = lowscape + "_s"
                    }
                }
                
                var local = lowscape.localized
                if lowscape.first != s.first{
//                    local = local.capitalizingFirstLetter()
                }
                
                text.append("\(n)")
                text.append(local)
            }
        }
        
        let result = String(format: self.localized, arguments: text)
        return result
    }
}



// MARK: Language Setting Functions

open class Localize: NSObject {

    open class func getCurrenLocale() -> Locale{
        let locale = Locale(identifier: currentLanguage())
        return locale
    }
    
    /**
     List available languages
     - Returns: Array of available languages.
     */
    open class func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.index(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    /**
     Current language
     - Returns: The current language. String.
     */
    open class func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }
    
//    open class func getSavedLanguage() -> LanguageModel {
//
//        let language = LanguageModel()
//
//
//        if let currentCode = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String, let currentName = UserDefaults.standard.object(forKey: LCLCurrentLanguageName) as? String
//        {
//            language.code = currentCode
//            language.name = currentName
//        }
//        else
//        {
//            language.code = self.defaultLanguage()
////            language.name = "English"
//        }
//        return language
//    }
    
    /**
     Change the current language
     - Parameter language: Desired language.
     */
    open class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if (selectedLanguage != currentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
        }
//        Device.shared.language = Localize.currentLanguage()
    }
    
    open class func setCurrentLanguageCode(_ language: String, name: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
//        if (selectedLanguage != currentLanguage()){
            UserDefaults.standard.set(language, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.set(name, forKey: LCLCurrentLanguageName)
            
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
//        }
        
//        Device.shared.language = language
//        Device.shared.languageName = name
    }
    
    /**
     Default language
     - Returns: The app's default language. String.
     */
    open class func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
    /**
     Resets the current language to the default
     */
    open class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    /**
     Get the current language's display name for a language.
     - Parameter language: Desired language.
     - Returns: The localized string.
     */
    open class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}

