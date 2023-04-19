//
//  DataCollectionExtension.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit

extension Array {
    
    @discardableResult
    public func chunked(from: Int = 0, size: Int) -> [Element] {
        var ret = [Element]()
        if from >= self.count{
            return ret
        }
        let to = from + size
        for i in from..<to{
            if let obj = self.objectAtIndex(i){
                ret.append(obj)
            }else{
                return ret
            }
        }
        return ret
    }
    
    @discardableResult
    public func objectAtIndex(_ index:Int) -> Element?{
        if index < 0 || index >= self.count {
            return nil
        }
        return self[index]
    }
    
    @discardableResult
    public func at(_ index:Int) -> Element?{
        return self.objectAtIndex(index)
    }
    
    
    @discardableResult
    public func indexOfObject(_ object: Element?) -> Int?{
        guard let object = object else{
            return nil
        }
        return self.firstIndex(where: { (item) -> Bool in
            if let a = object as? NSObject,
                let b = item as? NSObject {
                return a == b
            }
            
            return false
        })
    }
    
    
    @discardableResult
    public mutating func safeRemoveObject(_ object:Element?) -> Bool {
        if object == nil {
            return false
        }
        return self.removeObject(object!)
    }
    
    @discardableResult
    public mutating func safeRemoveClass<T>(_ classType:T.Type) -> [Element] {
        var remove:[Element] = []
        for item in self{
            if item is T{
                remove.append(item)
            }
        }
        self.removeObjects(remove)
        return remove
    }
    
    
    
    @discardableResult
    public mutating func removeObject(_ object:Element) -> Bool {
        var result = false
        if let index = self.indexOfObject(object){
            self.remove(at: index)
            result = true
        }
        return result
    }
    
    @discardableResult
    public mutating func removeObjects(_ objects:[Element]) -> Bool  {
        var result = false
        
        for item in objects{
            self.removeObject(item)
            result = true
        }
        return result
    }

    public mutating func safeAppend(_ object:Element?){
        if object != nil {
            self.append(object!)
        }
    }
    
    public mutating func safeSet(_ object: Element?, index: Int){
        guard let obj = object else{
            return
        }
        if index < 0 {
            return
        }
        
        if index >= self.count{
            return
        }
        self[index] = obj
    }
    
    public mutating func safeAppend(sequence:[Element]?){
        if sequence != nil {
            self.append(contentsOf: sequence!)
        }
    }
    
    public func count(query: (Element) -> Bool) -> Int{
        var count  = 0
        
        for item in self{
            if query(item){
                count += 1
            }
        }
        return count
    }
    
    public func search(query: (Element) -> Bool) -> [Element]?{
        let arrs = self.compactMap { (item) -> Element? in
            if query(item){
                return item
            }
            return nil
        }
        return arrs
    }
}
 
