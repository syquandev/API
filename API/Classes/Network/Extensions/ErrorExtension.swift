//
//  ErrorExtension.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import UIKit

extension Error {
    public func getErrorCode() -> Int {
        return (self as NSError).code
    }
}
