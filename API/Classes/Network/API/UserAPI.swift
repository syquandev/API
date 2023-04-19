//
//  UserAPI.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import ObjectMapper
import Core

open class AuthAPI: NSObject{
    open class Login: APIBase{
        open override var method: APIMethod {.POST}
        public override var requestType: APIRequest {.Gateway}
        public override var api: String {"auth/login"}
        
        public var userName: String? = "manhlongcntt@gmail.com"
        public var password: String? = "123456"
        
        open override func params(map: Map) {
            super.params(map: map)
            userName <- map["userName"]
            password <- map["password"]
        }
        
        public func request(completion:  ((ResponseStatus, UserModel?) -> Void)?){
            Network.shared.request(self.getRequest()) { status, response in
                var ret : UserModel?
                if let res = response{
                    ret = ElementObjectModel<UserModel>.create(dictionary: res)?.elements
                }
                completion?(status, ret)
            }
        }
    }
}
