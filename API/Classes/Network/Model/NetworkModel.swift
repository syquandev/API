//
//  NetworkModel.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import UIKit

public class NetworkModel: NSObject {
    public class DataUpload: NSObject{
        
        public enum Worker {
            case Multipart
            case TUSKit
        }
        public var name: String?
        public var fileName: String?
        public var image: UIImage?
        public var data: Data?
        public var url: String?
        public var type: String = "image/jpeg"
    }
    
}
