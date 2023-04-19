//
//  MultipartFormDataExtension.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import UIKit
import Alamofire

extension MultipartFormData {
    //    public func append(_ name: String, value: String){
    //        self.append(value.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName : name)
    //    }
    public func append(_ name: String, value: Any){
        self.append("\(value)".data(using: .utf8)!, withName : name)
    }
    public func append(_ params: [String: Any]){
        params.forEach { (key, value) in
            self.append(key, value: value)
        }
    }
    
}
