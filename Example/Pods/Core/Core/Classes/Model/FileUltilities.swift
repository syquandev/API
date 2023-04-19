//
//  FileUltilities.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit

public class FileUltilities: NSObject {
    
    @discardableResult
    public static func loadResouces(bundle: Bundle?, name: String, type:String) -> Data?{
        let bdl:Bundle = bundle ?? Bundle.main
        if let filepath = bdl.path(forResource: name, ofType: type) {
            if let contents = try? Data(contentsOf: URL(fileURLWithPath: filepath)){
                return contents
            }
        }
        return nil
    }

    @discardableResult
    public static func documentFile(name:String) -> URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false) else{
            return nil
        }
        
        let fileURL = documentDirectory.appendingPathComponent(name)
        return fileURL
    }
    
    
    @discardableResult
    public static func temporaryFile(name: String) -> URL? {
        return self.documentFile(name: name, folder: "temporary")
    }
    
    @discardableResult
    public static func documentFile(name:String, folder: String?) -> URL? {
        guard let folder = folder else {
            return self.documentFile(name: name)
        }
        let fileManager = FileManager.default
        if let folderPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folder){
            
            if !fileManager.fileExists(atPath: folderPath.path){
                do{
                    try fileManager.createDirectory(atPath: folderPath.path, withIntermediateDirectories: true, attributes: nil)
                } catch{
                    return nil
                }
            }
            return folderPath.appendingPathComponent(name)
        }
        return nil
    }

    @discardableResult
    public static func saveFile(name:String, string:String, folder: String? = nil) -> Bool{
        if let data = string.data(using: .utf8) {
            return self.saveFile(name: name, data: data, folder: folder)
        }
        return false
    }
    
    @discardableResult
    public static func saveFile(name:String, data:Data, folder: String? = nil) -> Bool{
        guard let url =  FileUltilities.documentFile(name: name, folder: folder) else {
            return false
        }
        do {
            try data.write(to: url)
//            Log.console("Save \(url.absoluteURL)")
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    public static func removeFile(name:String, folder: String? = nil) -> Bool{
        
        guard let url =  FileUltilities.documentFile(name: name, folder: folder) else {
            return false
        }
        
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: url.path)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    public static func loadFile(name:String, folder: String? = nil) -> Data?{
        guard let url =  FileUltilities.documentFile(name: name, folder: folder) else {
            return nil
        }
        let data = try? Data(contentsOf: url)
//        Log.console("Load \(url.absoluteURL)")
        return data
    }
    
    public static func loadURL(_ url: URL) -> Data?{
        return try? Data(contentsOf: url)
    }
    
    public static func removeURL(_ url: URL){
        try? FileManager.default.removeItem(at: url)
    }
    
    @discardableResult
    public static func removeFolder(_ folder: String) -> Bool{
        let fileManager = FileManager.default
        if let folderPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folder){
            
            if fileManager.fileExists(atPath: folderPath.path){
                do{
                    try fileManager.removeItem(atPath: folderPath.path)
                    return true
                } catch{
                    return false
                }
            }
        }
        
        return false
    }
    
    public static func saveModels(_ models: [BaseModel], file: String, folder: String? = nil){
        if let data = models.jsonData(){
            self.saveFile(name: file, data: data, folder: folder)
        }
    }
    
    public static func getFileSize(_ filePath: URL?) -> Int{
        guard let path = filePath?.path else{
            return 0
        }
        var fileSize : UInt64 = 0
        
        do {
            //return [FileAttributeKey : Any]
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            fileSize = attr[FileAttributeKey.size] as! UInt64
            
            //if you convert to NSDictionary, you can get file size old way as well.
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
        } catch {
            print("Error: \(error)")
        }
        
        return Int(fileSize)
    }
    
    public static func saveImage(_ image: UIImage?, folder: String? = nil) -> URL?{
        guard let image = image else{
            return nil
        }
        guard let data = image.jpegData(compressionQuality: 0.5) else{
            return nil
        }
        let name =  UUID().uuidString + ".jpg"
        if self.saveFile(name: name, data: data, folder: folder){
            return FileUltilities.documentFile(name: name, folder: folder)
        }
        return nil
    }
}
