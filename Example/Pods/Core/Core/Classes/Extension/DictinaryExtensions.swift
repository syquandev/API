//
//  DictinaryExtensions.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//

import UIKit

extension Dictionary {
    public func toData() -> Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        return jsonData
    }
    public func toJSONString() -> String? {
        if let jsonData = self.toData(){
            return String(data: jsonData, encoding: String.Encoding.utf8)
        }
        return nil
    }
    /**
     An extension that add the elements of one dictionary to another
     */
    public mutating func add(_ dictionary: [Key : Value]) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
    public mutating func safeAdd(_ dictionary: [Key : Value]?) {
        guard let dictionary = dictionary else{
            return
        }
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
    public mutating func safeAdd(key: Key?, value: Value?) {
        guard let v = value,
            let k = key else{
                return
        }
        self[k] = v
    }
    public func getValueForKey(_ key: Key?) -> Value?{
        
        guard let k = key else{
                return nil
        }
        return self[k]
    }
}

//extension Array{
//    public func toJSONs() -> [[String: Any]]{
//        var ret = [[String: Any]]()
//        guard let arr = self as? [BaseModel] else{
//            return ret
//        }
//        arr.forEach { (model) in
//            ret.safeAppend(model.toJSON())
//        }
//        return ret
//    }
//}
//
