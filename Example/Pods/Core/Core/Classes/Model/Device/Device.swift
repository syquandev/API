//
//  Device.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import ObjectMapper
import Core

public class Device: BaseModel{
    public static let shared = Device()
    public var deviceID: String = ""
    public var appVersion: String = "0.0.0"
    public var appBuildNumber: Int = 1
    public var devServer: ServerType?
    public var userAgent: String?
    public var language: String?
    
    public var deviceName: String = UIDevice.current.name
    public var deviceModel: String = UIDevice.modelName
    public var deviceType: String = UIDevice.modelName
    
    public override func customInit() {
        if deviceType.contains("iPad"){
            deviceType = "Tablet"
        }else if deviceType.contains("iPhone"){
            deviceType = "Phone"
        }else{
            deviceType = "Other"
        }
    }
    
    public static func isIpad() -> Bool{
        return shared.deviceType.contains("iPad")
    }
    
    public override func mapping(map: Map) {
        
    }
    
    public func getUserAgent() -> String{
        if self.userAgent  == nil {
            let model = deviceModel
            let version = UIDevice.current.systemVersion
            let device = self.deviceID
            self.userAgent = "\(model)/\(version)/\(device)"
        }
        return self.userAgent!
    }
}
