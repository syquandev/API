//
//  ElementStatusModel.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import UIKit
import ObjectMapper

public class ElementStatusModel: BaseModel {
    public var success: Bool?
    public var errors: String?
    public var code: Int?
    
    override public func mapping(map: Map) {
        success <- map["success"]
        errors <- map["errors"]
        code <- map["code"]
    }
}
