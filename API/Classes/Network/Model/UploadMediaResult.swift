//
//  UploadMediaResult.swift
//  Network
//
//  Created by HU-IOS-DT-QUAN on 07/04/2023.
//

import Foundation
import ObjectMapper
import Core

public class UploadMediaResult: BaseModel {
    public var success = false
    public var uuid: String?
    private var file_path: String?
    public var file_type: String?
    public var file_extension: String?
    public var file_size: CGFloat?
    public var dim_width: CGFloat?
    public var dim_height: CGFloat?
    public var file_name: String?
    
    public var thumbPath: String?
    public var fullPath: String?
    
    override public func mapping(map: Map) {
        //        super.mapping(map: map)
        success <- map["success"]
        id <- map["uuid"]
        uuid <- map["uuid"]
        
        file_path <- map["file_url"]
        thumbPath <- map["thumbnail"]
        
        file_type <- map["file_type"]
        file_size <- map["file_size"]
        file_name <- map["file_name"]
        file_extension <- map["file_extension"]
        dim_width <- map["dim_width"]
        dim_height <- map["dim_height"]
    }
    public func getScaleSize(_ width: CGFloat) -> CGSize{
        let dw = self.dim_width ?? 1.0
        let dh = self.dim_height ?? 1.0
        
//        if dw < width {
//            return CGSize(width: dw, height: dh)
//        }
        let ratio = dh/dw
        let nh = width*ratio
        return CGSize(width: width, height: nh)
        
    }
    public func updatePath(){
        
        self.fullPath = self.file_path//Ultilities.getCDNWithPath(self.file_path)
        //            ?.replacingOccurrences(of: ".jpg", with: "_\(Int(dim_width ?? 0))x\(Int(dim_height ?? 0))_high.jpg")
//        self.thumbPath = self.getThumb(Config.media_thumb)
    }
    
    func getThumb(_ width: CGFloat) -> String?{
        let size = self.getScaleSize(width)
        return self.getThumb(size)
    }
    
    func getThumb(_ size: CGSize) -> String? {
        return ""
//        return URLUltilities.getMediaThumbFromOriginalURL(file_path, size: size)
    }
    
//    public func getAvatar() -> String?{
//        return self.getThumb(CGSize(width: Config.media_avatar_thumb, height: Config.media_avatar_thumb))
//    }
//
//    public func getFM200() -> FM200{
//        let obj = FM200()
//
//        obj.uid = Session.current.getUserID()
//        obj.uuid = self.uuid
//        obj.type = self.getMediaType() == .img ? 0 : 1
//        obj.path = self.fullPath
//        obj.size = self.file_size
//        obj.thumb = self.thumbPath
//        obj.userType = "user"
//        obj.width = self.dim_width
//        obj.height = self.dim_height
//
//        return obj
//    }
//
//    public func getMediaType() -> MediaType{
//        let isVideo = URLUltilities.isVideoPath(self.fullPath)
//        return isVideo ? .vid : .img
//    }
//
//    public func getMedia(_ typeMedia: Bool) -> FeedModel.Media? {
//        let media = FeedModel.Media()
//        media.uuid = self.uuid
//        media.path = self.fullPath
//        media.thumb = self.thumbPath
//        media.width = self.dim_width
//        media.height = self.dim_height
//        media.size = self.file_size
//        media.name = self.file_name
//        typeMedia ? (media.type = FeedModel.Media.Typex.media) : (media.type = FeedModel.Media.Typex.video)
//        media.thumbnail?.path = self.thumbPath
//        return media
//    }
}
