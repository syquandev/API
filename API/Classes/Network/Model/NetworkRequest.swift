//
//  NetworkRequest.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import UIKit

public protocol NetworkRequest: class {
    func cancelRequest()
}

public class NetworkRequestHolder: NSObject, NetworkRequest{
    public var request: NetworkRequest?
    
    public func cancelRequest() {
        request?.cancelRequest()
    }
}
