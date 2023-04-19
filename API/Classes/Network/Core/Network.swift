//
//  Network.swift
//  Network
//
//  Created by Quan on 07/02/2023.
//

import Foundation
import RxSwift
import Alamofire
import Core

extension DataRequest: NetworkRequest{
    public func cancelRequest() {
        self.cancel()
    }
}

public class Network: NSObject{
    public static let ARRAY_PARAMETER = "network_custom_array_parameter"
    
    public static weak var delegate: NetworkDelegate?
    public static var shared = Network()
    private let reachability = ReachabilityX()
    
    public var isReachable = BehaviorSubject<Bool>(value: false)
    public var networkErrorShowed = false
    
    public static var conection = ReachabilityX.Connection.none
    public static var enableLog = true
    
    func initReachability(){
        reachability?.whenReachable = { [weak self] reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            Network.conection = reachability.connection
            Network.shared.networkErrorShowed = false
            self?.isReachable.onNext(true)
//            App.shared.networkReachable()
        }
        reachability?.whenUnreachable = { [weak self] _ in
            print("Not reachable")
            self?.isReachable.onNext(false)
//            App.shared.networkUnreachable()
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    public func getReachable() -> Bool{
        let conection = reachability?.connection ?? ReachabilityX.Connection.none
        return conection != ReachabilityX.Connection.none
    }
    
    public static func isNetworkError(_ show:Bool = true) -> Bool{
        
        if !Network.shared.getReachable(){
            if show{
                HUDBuilder.showAlert(message: "Network error")
            }
            return true
        }
        
        return false
    }
    
    @discardableResult
    public func request(_ requestData: BaseRequest, elementRootBaseHandler: ((ResponseStatus, BaseModel?)-> Void)?) -> NetworkRequest?{
        return request(requestData) { (status, data) in
            if data != nil {
                if let root = ElementRootModel<BaseModel>.create(dictionary: data!) {
                    elementRootBaseHandler?(status, root.elements?.first)
                    return
                }
            }
            elementRootBaseHandler?(status, nil)
        }
    }
    
    @discardableResult
    public func request(_ requestData: BaseRequest, completionHandler: @escaping NetworkResponseHandler) -> NetworkRequest?  {
        
#if DEBUG
        if Network.enableLog{
            print("##################### >>>>> Init: \(requestData.url()?.absoluteString ?? "")");
        }
#else
#endif
        
//        if requestData.checkUser && Session.current.isAPIInvalid(){
//            Router.auth.tryRefreshToken {[weak self] code in
//                if code == ResponseCode.success{
//                    self?._request(requestData, completionHandler: completionHandler)
//                }else{
//#if DEBUG
//                    if Network.enableLog{
//                        print("##################### >>>>> Session isInvalid");
//                    }
//
//#else
//#endif
////                    if code == ResponseCode.tokenInvalid{
////                        self?.requestFinished(requestData, status: ResponseStatus(code: ResponseCode.unauthorized), data: nil, completionHandler: completionHandler)
////
////                    }else{
//                        self?.requestFinished(requestData, status: ResponseStatus(code: code), data: nil, completionHandler: completionHandler)
//
////                    }
//                }
//            }
//            return nil
//        }
        
        return _request(requestData, completionHandler: completionHandler)
    }
    
    static func getBaseRawHeader() -> [String: String]{
        let headers = ["api_app_key": "",
                "user-agent": Device.shared.getUserAgent(),
                "devicename": Device.shared.deviceName,
                "version": "4",
                "DEVICE": "\(Device.shared.deviceType)/\(Device.shared.deviceModel)/\(Device.shared.deviceID)",
                "SYSTEM": "iOS/\(UIDevice.current.systemVersion)",
                "APP": "\(Device.shared.appVersion)/\(Device.shared.appBuildNumber)",
                "NETWORK": "\(Device.shared.deviceID)"]
//        if let ip = Device.shared.ipAddress{
//            headers["ipaddress"] = ip
//        }
        return headers
    }
    
    static func getRawHeader(_ requestData: BaseRequest) -> [String: String]{
        var header = getBaseRawHeader()
        
        if requestData.contentType == .XForm{
            header["Content-Type"] = "application/x-www-form-urlencoded"
        }else{
            header["Content-Type"] = "application/json"
            header["Accept"] = "application/json"
        }
        if let lang = Device.shared.language{
            header["lang"] = lang
        }
        header.add(requestData.headers())
        
        return header
    }
    
    func getParametersEncode(parameters: [String: Any]) -> String{
        var urlData = "";
        var count = 0;
        for (key, value) in parameters{
            if count > 0 {
                urlData.append("&")
            }
            urlData.append(key)
            urlData.append("=")
            let stringValue = "\(value)"
            let encode = stringValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? stringValue
            urlData.append(encode)
            count += 1;
            
        }
        return urlData
    }
    
    @discardableResult
    private func _request(_ requestData: BaseRequest, completionHandler: @escaping NetworkResponseHandler) -> NetworkRequest?  {
        let parameters = requestData.parameters()
        guard let url = requestData.url() else {
            DispatchQueue.main.async { [weak self] in
                self?.requestFinished(requestData, status: ResponseStatus(code: -13), data: nil, completionHandler: completionHandler)
            }
            return nil;
        }
        
        
        if requestData.dataUploads?.count ?? 0 > 0 {
            return uploadMultipart(requestData, completionHandler: completionHandler)
        }
        let rawHeader =  Network.getRawHeader(requestData)
        
#if DEBUG
        if Network.enableLog{
            print("##################### >>>>> Request: \(url.absoluteString)");
            print("##################### >>>>> Parameter: \(parameters.toJSONString() ?? "")");
            print("HEADER ==========")
            rawHeader.forEach({ key, value in
                print("\(key):\(value)")
            })
            print("=================")
        }
#else
#endif
        var request = URLRequest(url: url)
        request.httpMethod = requestData.method.rawValue
        let timeout = TimeInterval(requestData.requestTimeout)
        request.timeoutInterval = timeout
        rawHeader.forEach { (key, val) in
            request.setValue(val, forHTTPHeaderField: key)
        }
        if(parameters.count > 0 && requestData.method != .GET){
            if requestData.urlencoded || requestData.contentType == .XForm{
                let urlData = getParametersEncode(parameters: parameters)
                request.httpBody = urlData.data(using: String.Encoding.utf8);
                
            }else{
                do {
                    if let custom_array = parameters[Network.ARRAY_PARAMETER] as? [[String: Any]]{
                        var itemJsons = [String]()
                        custom_array.forEach { (item) in
                            if let itemJson = item.toJSONString(){
                                itemJsons.append(itemJson)
                            }
                        }
                        let ret = "[\(itemJsons.joined(separator: ","))]"
                        request.httpBody = ret.data(using: .utf8)
                        
                    }else{
                        let jsonBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                        request.httpBody = jsonBody
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        //End
        let rq = AF.request(request)
        rq.responseData {[weak self] (result) in
            var status = ResponseStatus.errorReponse()
            var jsonRet: [String: Any]?
            if let error = result.error{
                let code = error.responseCode ?? error.getErrorCode()
                status = ResponseStatus(code: code)
            }else
            if let data = result.data{
                if var json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    var statusCode = result.response?.statusCode ?? result.error?.getErrorCode()
                    var message: String?
                    var internalMessage: String?
                    var intVal: Int?
                    
                    if let code = json?["statusCode"] as? Int{
                        statusCode = code
                        if let msg =  json?["message"] as? String{
                            message = msg
                        }
                    }
                    
                    if let status = json?["status"] as? [String: Any]{
                        if let code = status["code"] as? Int{
                            statusCode = code
                        }
                        if let message = status["error"] as? String{
                            internalMessage = message
                        }
                        
                        if let message = status["errors"] as? String{
                            internalMessage = message
                        }
                    }
                    
                    if let eml = json?["elements"] as? [[String: Any]]{
                        if let f = eml.first{
                            if let val = f["value"] as? Int{
                                intVal = val
                            }
                        }
                    }
                    
                    status = ResponseStatus(code: statusCode)
                    
                    if let msg = message{
                        status.message = msg
                    }
                    
                    if let msg = internalMessage{
                        status.message = msg
                    }
                    
                    status.intVal = intVal
                    
                    if json == nil {
                        if let arrjson = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]{
                            json = ["data": arrjson ?? []]
                        }
                    }
                    jsonRet = json
                }else if requestData.rawResponse{
                    jsonRet = ["data": data]
                }
            }
            self?.requestFinished(requestData, status: status, data: jsonRet, completionHandler: completionHandler)
        }
        return rq
    }
    
    public func uploadMultipart(_ requestData: BaseRequest, completionHandler: @escaping NetworkResponseHandler) -> NetworkRequest? {
        
        let apiURL = requestData.apiURL()
        let rawHeader =  Network.getRawHeader(requestData)
        
        if Network.enableLog{
            print("HEADER ==========")
            rawHeader.forEach({ key, value in
                print("\(key):\(value)")
            })
            print("=================")
        }
        
        AF.upload(
            multipartFormData: { multipartFormData in
                requestData.dataUploads?.forEach({ (item) in
                    let name = item.name ?? "file"
                    let fileName = item.fileName ?? name
                    let type = item.type
                    
                    if let urlString = item.url,
                       let url = URL(string: urlString){
                        multipartFormData.append(url, withName: name, fileName: fileName , mimeType: type)
                    } else if let image = item.image,
                              let data = image.jpegData(compressionQuality: 0.5){
                        multipartFormData.append(data, withName: name, fileName: "\(fileName).jpg" , mimeType: "image/jpeg")
                    } else if let data = item.data{
                        multipartFormData.append(data, withName: name, fileName: fileName , mimeType: type)
                    }
                })
                multipartFormData.append(requestData.parameters())
            },
            to: apiURL,
            usingThreshold:UInt64.init(),
            method: methodFromBase(requestData.method),
            headers: HTTPHeaders(rawHeader))
            .responseData {[weak self] (result) in
                var status = ResponseStatus.successReponse()
                var jsonRet: [String: Any]?
                if let error = result.error,
                   let code = error.responseCode{
                    status = ResponseStatus(code: code)
                }else
                if let data = result.data, let json = try?  JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    jsonRet = json
                }
                self?.requestFinished(requestData, status: status, data: jsonRet, completionHandler: completionHandler)
            }
        return nil
    }
    
    
    func requestFinished(_ requestData: BaseRequest, status: ResponseStatus, data: [String: Any]?, completionHandler: @escaping NetworkResponseHandler){
        requestData.lastedCode = status.code
#if DEBUG
        if Network.enableLog{
            
            var stringParse = "(empty)"
            if requestData.rawResponse && data is [String:Data]{
                stringParse = "\(String(describing: data))"
            }else{
                stringParse = data?.toJSONString() ?? "(empty)"
            }
            print("\(status.code) ##################### <<<<< ResponseStatus: \(requestData.url()?.absoluteString ?? "")\n\(stringParse)\n#####################END")
        }
#else
#endif
        DispatchQueue.main.async {
            if [ResponseCode.unauthorized, 4012, 4126].contains(status.code){
                if requestData.checkUser && requestData.autoLogout{
                    Network.delegate?.serviceAPIUnauthorized(requestData, completionHandler: completionHandler)
                    return
                }else{
                    completionHandler(status, data)
                    return
                }
            }
            if status.code == ResponseCode.userUnactive{
                Network.delegate?.serviceAPIUserUnactive()
                completionHandler(status, data)
                return
            }
            if status.isError{
                Network.delegate?.serviceAPIError(status, requestData: requestData)
            }
            completionHandler(status, data)
        }
    }
    
    public func methodFromBase(_ input: Network.Method) -> HTTPMethod{
        return HTTPMethod(rawValue: input.rawValue)
    }
    
    //MARK - Uploader
    
    public func uploadFile(_ requestData: UploadRequest, completionHandler: @escaping NetworkResponseHandler, process: ((Int64, Int64) -> Void)? = nil) -> NetworkRequest? {
        
        let uploader = NetworkUploader(request: requestData)
        uploader.process = process
        if uploader.prepare(){
            uploader.handler = completionHandler
            uploader.resume()
            return uploader
        }
        return nil
    }
    
    @discardableResult
    public func uploadImage(_ image: UIImage, handler: @escaping ((ResponseStatus, UploadMediaResult?) -> Void)) -> NetworkRequest?{

        if let url = FileUltilities.saveImage(image){
            return self.uploadImage(url, handler: handler)
        }
        return nil
    }
    
    @discardableResult
    public func uploadImage(_ url: URL, handler: @escaping ((ResponseStatus, UploadMediaResult?) -> Void), process: ((Int64, Int64) -> Void)? = nil) -> NetworkRequest?{
        
        let request = UploadMediaRequest(image: url)
        
        return uploadFile(request, completionHandler: { (status, result) in
            if let result = result {
                FileUltilities.removeURL(url)
                let info = UploadMediaResult.create(dictionary: result)
                info?.updatePath()
                handler(status, info)
                return
            }
            handler(status, nil)
        }, process: process)
    }
    
    @discardableResult
    public func uploadVideoLimit(_ url: URL, handler: @escaping ((ResponseStatus, UploadMediaResult?) -> Void), process: ((Int64, Int64) -> Void)? = nil) -> NetworkRequest? {
        let request = UploadMediaRequest(url: url)
        
        return uploadFile(request, completionHandler: { (status, result) in
            FileUltilities.removeURL(url)
            if let result = result {
                let info = UploadMediaResult.create(dictionary: result)
                info?.updatePath()
                handler(status, info)
                return
            }
            handler(status, nil)
        }, process: process)
    }
    
//    @discardableResult
//    public func uploadMedia(_ media: MediaFeedModel, handler:  @escaping ((ResponseStatus, UploadMediaResult?) -> Void)) -> NetworkRequest?{
//        let requestHolder = NetworkRequestHolder()
//        if let image = media.image {
//            requestHolder.request = self.uploadImage(image, handler: handler)
//            return requestHolder
//        }
//
//        if let export = media.export{
//            export.exportData { (url, string) in
//                if let url = url {
//                    requestHolder.request = self.uploadVideoLimit(url, handler: handler)
//                }
//            }
//            return requestHolder
//        }
//
//        return nil
//    }
}
