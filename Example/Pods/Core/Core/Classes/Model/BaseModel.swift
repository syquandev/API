//
//  BaseModel.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import ObjectMapper

public protocol IBaseModel:class, Mappable{
    
}

extension IBaseModel{
    
    public static func create(json: String) -> Self?{
        return self.init(JSONString: json)
    }
    
    public static func create(data: Data) -> Self?{
        guard let string = String(data: data, encoding: .utf8) else{
            return nil
        }
        return self.init(JSONString: string)
    }
    
    public static func createAray(json: String) -> [Self]?{
        return Mapper<Self>().mapArray(JSONString: json)
    }
    
    public static func createAray(data: Data) -> [Self]?{
        if let jsonString = String(data: data, encoding: .utf8){
            return Mapper<Self>().mapArray(JSONString: jsonString)
        }
        return nil
    }
    
    public static func createAray(array: [[String:Any]]) -> [Self]?{
        var result = [Self]()
        array.forEach { (item) in
            if let obj = Self.create(dictionary: item){
                result.append(obj)
            }
        }
        return result
    }
    
    public static func create(dictionary: [String:Any]) -> Self?{
        return self.init(JSON: dictionary)
    }
    
    public func jsonString() -> String? {
        return self.toJSONString()
    }
    public func jsonData() -> Data? {
        if let jsonString = self.jsonString(){
            let data = jsonString.data(using: .utf8)
            return data
        }
        return nil
    }
}

public extension Array where Element:IBaseModel {
    func jsonString() -> String? {
        return Mapper().toJSONString(self)
    }
    func jsonData() -> Data? {
        return Mapper().toJSONString(self)?.data(using: .utf8)
    }
}



public protocol DiffBaseModel: class{
    func getDiffID() -> String
    func isNeedUpdate() -> Bool
}

open class BaseModel: NSObject, IBaseModel, DiffBaseModel {
    //Base
    public var id : String?
    public var diffID: String = ""
    public var cellDiffID: String?
    public var needUpdate = false
    
    public func getHash() -> String{
        return id ?? ""
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        id <- map["id"]
    }
    
    public override init() {
        super.init()
        self.customInit()
    }
    
    open func getID() -> String?{
        return self.id
    }
    
    open func customInit(){
        
    }
    open func getDiffID() -> String{
        return self.id ?? self.diffID
    }
    
    open func isNeedUpdate() -> Bool {
        return self.needUpdate
    }
    
    @discardableResult
    public func saveCache(_ name: String, folder: String? = nil) -> Bool{
        if let jsonData = self.toJSONString(){
            let result = FileUltilities.saveFile(name: name, string: jsonData, folder: folder)
            return result
        }
        return false
    }
    
    public static func loadCache<T: BaseModel>(_ name: String, folder: String? = nil) -> T?{
        
        if let data = FileUltilities.loadFile(name: name, folder: folder){
            return T.create(data: data)
        }
        return nil
    }
    
    open func propertyNames() -> [String] {
        var properties = [String]()
        
        var mirror: Mirror? = Mirror(reflecting: self)
        while mirror != nil {
            
            let keys = mirror?.children.compactMap { $0.label }
            properties.safeAppend(sequence: keys)
            if (keys?.contains("cellDiffID") ?? false){
                break
            }
            mirror = mirror?.superclassMirror
            
        }
        
        return properties
    }
    
    open func clone() -> Self?{
        let json = self.toJSON()
        let obj = Self.create(dictionary: json)
        return obj
    }
}
