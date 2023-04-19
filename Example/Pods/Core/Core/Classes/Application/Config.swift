//
//  Config.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import ObjectMapper

public enum ServerType: String {
    case test = "Test"
    case live = "Live"
    case staging = "Staging"
    public class Transform: EnumTransform<ServerType> {}
}

public protocol ConfigInterface{
    func setServer(_ type: ServerType)
    func remoteConfig()
}

open class Config: NSObject{
    public static var webURL = ""
    public static var apiURL = ""
    public static var gatewayURL = ""
    public static var uploadURL = ""
    
    public static var basicClientAuth = ""
    
    public static let sessionFolderName = "Session"
    public static let uploadFolderName = "Upload"
    
    public static let mailValidateRegex  = "[a-zA-Z0-9._%\\-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+"
    public static let phoneValidateRegex = "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?([0-9][0-9\\- \\.]+[0-9])"
    public static let nameSpecialCharacterRegex = "[0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:]|[\\[\\]]"
    
    public static var server = ServerType.live
    public static var shared: ConfigInterface = Config()
    public static func setServer(_ type: ServerType){
        shared.setServer(type)
    }
}

extension Config: ConfigInterface{
    public func setServer(_ type: ServerType) {
        Config.mode(type)
    }
    
    public func remoteConfig() {
        
    }
    
    public static func mode(_ type: ServerType) {
        
        Config.baseConfig(type)
        switch Config.server {
        case .live:
            Config.configLive()
            
        case .staging:
            Config.configStaging()
            
        default:
            Config.configTest()
        }
    }
    
    public static func baseConfig(_ type: ServerType){
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String{
            Device.shared.appVersion = appVersion
        }
        if let appBuildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as? String{
            Device.shared.appBuildNumber = Int(appBuildNumber) ?? 1
        }
        
        Config.server = type
    }
    
    public static func configStaging(){
        
    }
    
    public static func configLive(){
        
    }
    
    public static func configTest(){
        Config.gatewayURL = "https://gomhangquangtung.com/api"
    }
}
