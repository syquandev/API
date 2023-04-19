//
//  UserModel.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import ObjectMapper
import Core

public class UserModel: BaseModel{
    public var name: String?
    public var email: String?
    
    public override func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
    }
}
