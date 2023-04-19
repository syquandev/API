//
//  ResponseCode.swift
//  Network
//
//  Created by Quan on 07/02/2023.
//

import UIKit

public class ResponseCode: NSObject {

    public static let defaultCode = 100
    public static let systemTimeout = -1001
    public static let cancelled = -999
    public static let apiError = -998
    public static let forceUpdate = -997
    public static let dataExist = 901
    public static let networkError = -1009
    public static let sessionTaskFailed = 13
    public static let unauthorized = 401
    public static let blocked = 4010
    public static let notFound = 404
    public static let forbidden = 403
    
    public static let success = 200
    public static let badRequest = 400
    public static let internalError = 500
    public static let notAcceptable = 406
    public static let notAllowed = 405
    public static let proxyRequire = 407
    public static let requestTimeout = 408
    public static let noContent = 204
    public static let businessConfirm = 5003
    public static let notExitsInDB = 902
    public static let tourNotAvailable = 2012
    public static let limitedFriend = 8003
    public static let userUnactive = 40001
    public static let unvalidatePhone = 1015
    public static let waitingTime = 505
    public static let tokenInvalid = 4124
    
    public static let uploadReadError = 78534
}
