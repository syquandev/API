//
//  ElasticRequest.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import UIKit

open class ElasticRequest: BaseRequest {
    public var after: String?
    public override init() {
        super.init()
        self.hostName = ""
    }
}
