//
//  API.swift
//  Alamofire
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import ObjectMapper
import Core

public protocol APIFunctionInterface: class{
    func loginComplete()
    func languageChanged()
    func currencyChanged()
}

public enum APIMethod: String{
    case GET
    case POST
    case DELETE
    case PUT
    
    public func getBaseMethod() -> Network.Method{
        return Network.Method(rawValue: self.rawValue) ?? .GET
    }
}

public enum APITypeContent: String{
    case JSON
    case XForm
    
    public func getBaseMethod() -> Network.ContentType{
        return Network.ContentType(rawValue: self.rawValue) ?? .JSON
    }
}

public enum APIRequest{
    case Elastic
    case Core
    case Gateway
}

open class API: NSObject, APIFunctionInterface{
    public static let shared = API()
    
    public func loginComplete() {
        
    }
    
    public func languageChanged() {
        
    }
    
    public func currencyChanged() {
        
    }
}

open class APIBase: BaseModel{
    open var api: String {""}
    open var fullApi: String? {nil}
    open var method: APIMethod {.GET}
    open var requestType: APIRequest {.Elastic}
    open var after: String?
    open var timeout: Float {360}
    open var accessToken: Bool {true}
    open var auth: Bool {true}
    open var basic: Bool {false}
    open var uic: Bool {false}
//    open var enableUUID: Bool {true}
    open var autoLogout: Bool {true}
    open var needLogin: Bool {false}
    open var rawResponse: Bool {false}
    open var contentType: APITypeContent {.JSON}
    
//    MARK: UPLOAD
    open var dataUploadType: NetworkModel.DataUpload.Worker {.Multipart}
    open func getDataUpload() -> [NetworkModel.DataUpload]?{
        return nil
    }
    
    override open func mapping(map: Map) {
        if map.mappingType == .toJSON{
            params(map: map)
        }
    }
    
    open func params(map: Map){
        id <- map["id"]
        after <- map["a"]
    }

    open func getRequest() -> BaseRequest{
        switch self.requestType {
        case .Gateway:
            let rq = PrivateGatewayRequest(param: self)
            rq.hostName = Config.gatewayURL
            rq.requestTimeout = timeout
            rq.method = method.getBaseMethod()
            rq.needAccessToken = accessToken
            rq.checkUser = auth
            rq.autoLogout = autoLogout
            rq.needLogin = needLogin
            rq.dataUploads = getDataUpload()
            rq.dataUploadType = dataUploadType
            rq.needUClientID = false
            rq.basic = true
            rq.uic = true
            rq.contentType = contentType.getBaseMethod()
            rq.rawResponse = rawResponse
            return rq
            
        case .Core:
            let rq = PrivateCoreRequest(param: self)
            rq.requestTimeout = timeout
            rq.method = method.getBaseMethod()
            rq.needAccessToken = accessToken
            rq.checkUser = auth
            rq.autoLogout = autoLogout
            rq.dataUploads = getDataUpload()
            rq.dataUploadType = dataUploadType
            rq.rawResponse = rawResponse
            return rq
            
        case .Elastic:
            let rq = PrivateElasticRequest(param: self)
            rq.requestTimeout = timeout
            rq.autoLogout = autoLogout
            rq.method = method.getBaseMethod()
            rq.checkUser = auth
            rq.rawResponse = rawResponse
            return rq
        }
    }
    
    open func getParamData() -> [String : Any]{
        return self.toJSON()
    }
    
    open func getHeaderData() -> [String : String]{
        return [:]
    }
    
    public static func getUCI() -> String?{
//        if let uid = Session.current.getUserID(),
//           let aes = try? AES(key: Config.uicAesKey.bytes, blockMode: ECB(), padding: .pkcs7){
//            let arr = Array(uid.utf8)
//            if let ciphertext = try? aes.encrypt(arr),
//               let pureText = ciphertext.toBase64(){
//                return pureText
//            }
//        }
        return nil
    }
}

class PrivateCoreRequest: AuthRequest {
    public var paramData: APIBase
    
    public init(param: APIBase) {
        self.paramData = param
        super.init()
        self.moduleName = paramData.api
        self.fullURL = paramData.fullApi
    }
    override public func parameters() -> [String : Any] {
        var params = super.parameters()
        params.add(paramData.getParamData())
        return params
    }
    
    override func headers() -> [String : String] {
        var params = super.headers()
        params.add(paramData.getHeaderData())
        return params
    }
}

class PrivateGatewayRequest: AuthRequest {
    public var paramData: APIBase
    
    public init(param: APIBase) {
        self.paramData = param
        super.init()
        self.moduleName = paramData.api
        self.fullURL = paramData.fullApi
    }
    override public func parameters() -> [String : Any] {
        var params = super.parameters()
        params.add(paramData.getParamData())
        return params
    }
    
    override func headers() -> [String : String] {
        var params = super.headers()
        params.add(paramData.getHeaderData())
        params.safeAdd(key: "uuid", value: Device.shared.deviceID)
        if basic{
            params.safeAdd(key: "Authorization", value: "Basic "+Config.basicClientAuth.base64())
        }
        if uic, let uciCrypt = APIBase.getUCI(){
            params.safeAdd(key: "uci", value: uciCrypt)
        }
        return params
    }
}

class PrivateElasticRequest: ElasticRequest {
    public var paramData: APIBase
    
    public init(param: APIBase) {
        self.paramData = param
        super.init()
        self.moduleName = paramData.api
        self.fullURL = paramData.fullApi
    }
    override public func parameters() -> [String : Any] {
        var params = super.parameters()
        params.add(paramData.getParamData())
        return params
    }
    
    override func headers() -> [String : String] {
        var params = super.headers()
        params.add(paramData.getHeaderData())
        return params
    }
}
