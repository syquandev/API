//
//  NetworkDelegate.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import UIKit

public protocol NetworkDelegate: class{
    func serviceAPIError(_ status: ResponseStatus, requestData: BaseRequest?)
    func serviceAPIUnauthorized(_ requestData: BaseRequest, completionHandler: @escaping NetworkResponseHandler)
    func serviceAPIUserUnactive()
    func getNetwork() -> Network
}
