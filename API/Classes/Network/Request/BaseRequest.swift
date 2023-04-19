//
//  BaseRequest.swift
//  Alamofire
//
//  Created by Quan on 08/02/2023.
//

import Foundation

extension Network{
    public enum Method: String{
        case GET
        case POST
        case DELETE
        case PUT
    }
    public enum ContentType: String{
        case JSON
        case XForm
    }
}

open class BaseRequest: NSObject {

    public var dataUploadType: NetworkModel.DataUpload.Worker?
    public var dataUploads: [NetworkModel.DataUpload]?
    
    public var hostName: String = ""
    public var moduleName: String?
    public var apiName: String?
    public var fullURL: String?
    public var method = Network.Method.GET
    public var urlencoded: Bool = false
    public var disableDefaultParameter: Bool = false
    public var requestTimeout: Float = 360
    public var checkUser = true
    public var autoLogout = true
    public var needLogin = false
    public var bypassAuthResponseStatus = false
    public var version = 1
    public var requestms: TimeInterval = 0
    public var needAccessToken = true
    public var needUClientID = true
    public var uic = false
    public var basic = false
    public var contentType = Network.ContentType.JSON
    public var requestCount = 0
    public var lastedCode = 0
    public var token: String?
    public var rawResponse = false
    
    open func apiURL() -> String {
        if let url = fullURL{
            return url;
        }
        var url = "";
        url.append(hostName);
        
        if let module = moduleName {
            url.append("/\(module)")
        }
        if let api = apiName {
            url.append("/\(api)");
        }
        return url
    }
    
    open func url() -> URL?{
//        self.token = Session.current.accessToken
        let urlString = self.apiURL()
        guard var url = URL(string: urlString) else{
            return nil
        }
        if self.method != .GET{
//            if needAccessToken, let access_token = Session.current.accessToken{
//                let parameters = ["access_token": access_token]
//                url.appendQueryParameters(parameters)
//            }
        }else{
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let parameters = self.parameters()

            var cs = CharacterSet.urlQueryAllowed
            cs.remove("+")
            components.percentEncodedQuery = parameters.map {
                $0.addingPercentEncoding(withAllowedCharacters: cs)!
                + "=" + "\($1)".addingPercentEncoding(withAllowedCharacters: cs)!
            }.joined(separator: "&")
            url = components.url ?? url
            
        }
        return url
    }
    
    open func parameters() -> [String : Any] {
        
        var params:[String : Any] = [:]
        if self.disableDefaultParameter{
            return params
        }
        
//        if needAccessToken, let access_token = Session.current.accessToken, self.method == .GET{
////            print("!@#$%^&* TOKEN \(access_token) | \(self.apiURL())")
//            params["access_token"] = access_token
//        }
//        if needUClientID, let uid = Session.current.getUserID(){
//            params["uClientId"] = uid
//        }
        //        params["version"] = version
        return params
    }
    
    
    open func jsonParameter() -> String {
        let params = self.parameters();
        guard let jsonData = try? JSONSerialization.data(withJSONObject: params) else {
            return "{}";
        }
        
        if let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8){
            return jsonString
        }
        return "{}";
    }
    
    open func headers() -> [String: String] {
        return [:];
    }
}
