//
//  AppColor.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation

public enum AppColor{
    case black
    case red
    case primary
    case primary2
    case background
    case placeholder
    case normal
    case money
    case clear
    case backgroundCell
    
    public func getColor() -> UIColor{
        switch self {
        case .black:
            return UIColor.black
        case .red:
            return UIColor.red
        case .primary:
            return AppColorDefine.primary
        case .primary2:
            return AppColorDefine.primary2
        case .background:
            return UIColor.groupTableViewBackground
        case .placeholder:
            return AppColorDefine.textPlaceholder
        case .normal:
            return UIColor.black
        case .money:
            return AppColorDefine.primary2
        case .clear:
            return AppColorDefine.primary2
        case .backgroundCell:
            return AppColorDefine.primary2
        }
    }
}

public class AppColorDefine: NSObject{
    public static let primary                   =   UIColor.init(hexString: "#E7F0EE")!
    public static let primary2                  =   UIColor.init(hexString: "#24A8D8")!
    public static let text                      =   UIColor.init(hexString: "#000000")!
    public static let textLight                 =   UIColor.init(hexString: "#9C9C9C")!
    public static let textUltraLight            =   UIColor.init(hexString: "#888888")!
    public static let textPlaceholder           =   UIColor.init(hexString: "#C7C7CD")!
    public static let lightRedText              =   UIColor.init(hexString: "#FF3F34")!
    public static let greenText                 =   UIColor.init(hexString: "#0AC46B")!
    public static let backgroundCell            =   UIColor.init(hexString: "#F6F6F6")!
}
