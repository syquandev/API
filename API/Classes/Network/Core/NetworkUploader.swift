//
//  NetworkUploader.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import Alamofire
import TUSKit
import Core

public class GetUploadInfoRequest: AuthRequest{
    let url: String
    
    public init(url: String) {
        self.url = url
        super.init()
        self.fullURL = url
    }
    open override func headers() -> [String : String] {
        var data = [String : String]()
//        if let token = Session.current.accessToken?.base64(){
//            let basic = (Session.current.accessToken?.count ?? 0) < 36 ? "Basic2 " : "Basic "
//            data["Authorization"] = basic + token
//        }
        return data
    }
}


public class NetworkUploader: NSObject, NetworkRequest{
    
//    public static var workers = [NetworkUploader]()
    
    public var session: TUSSession?
    public var uploader: TUSResumableUpload?
    public var request: UploadRequest
    
    public var handler: NetworkResponseHandler?
    public var process: ((Int64, Int64) -> Void)?
    private var _path: URL?
    
    public init(request: UploadRequest) {
        self.request = request
        super.init()
    }
    
    public func prepare() -> Bool{
        var fileURL: URL?
        if let url = request.fileURL{
            fileURL = url
        }else if let data = request.byteData{
            let name = UUID().uuidString
            if FileUltilities.saveFile(name: name, data: data){
                
                fileURL = FileUltilities.documentFile(name: name, folder: Config.uploadFolderName)
            }
        }
        guard let url = fileURL else{
            return false
        }
        _path = url
//        var header = [String: String]()
        return uploadLocalUrl(url)
    }
    
    @discardableResult
    private func uploadLocalUrl(_ url: URL) -> Bool{
        guard let apiURL = request.url() else{
            return false
        }
        var header = Network.getBaseRawHeader()
//        if let token = Session.current.accessToken?.base64(){
//            let basic = (Session.current.accessToken?.count ?? 0) < 36 ? "Basic2 " : "Basic "
//            header["Authorization"] = basic + token
//        }
        let dataStore = TUSFileUploadStore(url: FileUltilities.documentFile(name: "tuskit")) ?? TUSFileUploadStore()
        
        session = TUSSession(endpoint: apiURL, dataStore: dataStore, allowsCellularAccess: true)
        uploader = session?.createUpload(fromFile: url, retry: 3, headers: header, metadata: nil)
        uploader?.resultBlock = {fileURL in
            self.finished(fileURL, error: nil)
        }
        uploader?.progressBlock = {(bytesWritten , bytesTotal) in
            self.processing(bytesWritten: bytesWritten, bytesTotal: bytesTotal)
        }
        uploader?.failureBlock = { error in
            self.finished(nil, error: error)
        }
        uploader?.setChunkSize(1024*1024)
        return true
    }
    
    public func resume(){
//        Router.auth.tryRefreshToken { code in
//            if code == ResponseCode.success{
//                self.uploader?.resume()
//            }
//        }
    }
    
    
    public func cancelRequest(){
        uploader?.cancel()
        releaseRef()
    }
    
    public func releaseRef(){
        uploader?.progressBlock = nil
        uploader?.resultBlock = nil
        uploader?.failureBlock = nil
        handler = nil
        uploader = nil
        session = nil
    }
    
    func resume401(){
        guard let url = self._path else{
            return
        }
//        cancelRequest()
        uploadLocalUrl(url)
        resume()
    }
    
    private func processing(bytesWritten: Int64, bytesTotal: Int64 ){
        process?(bytesWritten, bytesTotal)
//        let percent = bytesWritten*100/bytesTotal
//        print("TUST uploading \(bytesWritten)/\(bytesTotal) | \(percent)")
    }
    
    private func finished(_ url: URL?, error: Error?){
        if let er = error, er.getErrorCode() == ResponseCode.unauthorized{
//            Router.auth.tryRefreshToken{ code in
//                if code == ResponseCode.success{
//                    self.resume401()
//                }else{
//                    self.uploadError(code, error: nil)
//                }
//            }
            return
        }
        
        if let path  = self._path{
            FileUltilities.removeURL(path)
        }
        
        if let url = url?.absoluteString {
            let request = GetUploadInfoRequest(url: url)
            Network.shared.request(request, completionHandler: { (status, datas) in
                self.handler?(status, datas)
                self.releaseRef()
            })
        }else{
            uploadError(ResponseCode.apiError, error: error)
        }
    }
    
    private func uploadError(_ code: Int, error: Error?){
        var status = ResponseStatus(code: code)
        if let error = error{
            status = ResponseStatus(code: error.getErrorCode())
        }
        self.handler?(status, nil)
        self.releaseRef()
    }
}
