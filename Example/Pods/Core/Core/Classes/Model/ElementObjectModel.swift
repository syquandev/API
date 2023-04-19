//
//  ElementObjectModel.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import ObjectMapper

open class ElementObjectModel<T: IBaseModel>: BaseModel{
    public var status: ElementStatusModel?
    public var elements: T?
    public var token: String?
    
    override open func mapping(map: Map) {
        status <- map["status"]
        elements <- map["data"]
        token   <- map["token"]
    }
}
