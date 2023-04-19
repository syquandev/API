//
//  UploadRequest.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import Core

public class UploadRequest: AuthRequest {
    public var dataSize = 0
    public var byteData: Data?
    public var type = ""
    public var name = ""
    public var uuid = Random.stringKey()
    public var fileURL: URL?
    
    override init() {
        super.init()
        self.hostName = Config.uploadURL
        self.bypassAuthResponseStatus = true
        self.method = .POST
    }
    
    override public func parameters() -> [String : Any] {
        
        var params = super.parameters()
        
        let userAgent = Device.shared.userAgent ?? ""
        
        params["filename"] = self.name
        params["type"] = self.type
        params["total_filesize"] = self.dataSize
        params["uuid"] = uuid
        params["user_agent"] = userAgent
        return params
    }
    
    open func getByData() -> Data?{
        return self.byteData
    }
}
