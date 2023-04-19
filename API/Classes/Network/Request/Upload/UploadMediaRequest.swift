//
//  UploadMediaRequest.swift
//  Network
//
//  Created by HU-IOS-DT-QUAN on 07/04/2023.
//

import Foundation
import Core

public class UploadMediaRequest: UploadRequest {
    public init(data: Data) {
        super.init()
        self.type = "video/mp4"
        self.name = "ios_mobile_video.mp4"
        self.byteData = data
        self.dataSize = self.byteData?.count ?? 0
    }
    
    public init(url: URL){
        super.init()
        self.type = "video/mp4"
        self.name = "ios_mobile_video.mp4"
        self.fileURL = url
        self.dataSize = FileUltilities.getFileSize(url)
    }
    
    public init(image: UIImage) {
        super.init()
        self.type = "image/jpeg"
        self.name = "ios_mobile_image.jpg"
        self.byteData = image.jpegData(compressionQuality: 0.5)
        self.dataSize = self.byteData?.count ?? 0
    }
    public init(image: URL) {
        super.init()
        self.type = "image/jpeg"
        self.name = "ios_mobile_image.jpg"
        self.fileURL = image
    }
}
