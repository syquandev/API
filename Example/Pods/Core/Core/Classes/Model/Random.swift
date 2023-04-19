//
//  Random.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation

public class Random: NSObject {
    public static func randomKey() -> Int {
        return Int(arc4random_uniform(UInt32(100000)))
    }
    public static func randomIn(from: Int, to: Int) -> Int {
        let random = arc4random_uniform(UInt32(to - from))
        let result = UInt32(random) + UInt32(from)
        return Int(result)
    }
    
    public static func stringKey() -> String {
        return UUID().uuidString
    }
}
