//
//  DataTransform.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit
import ObjectMapper
import SwiftDate

public class DateStringYYYYMMDDTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = value.date()
            //            return value.date(format: DateFormats.custom("yyyy-MM-dd"))?.absoluteDate
            return date
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        let dateString = value?.string()
//        let dateString = value?.string(format: DateFormats.custom("yyyy-MM-dd"))
        return dateString
    }
}
public class DateStringTimezoneXMinuteTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = value.date()
            //            return value.date(format: DateFormats.custom("yyyy-MM-dd"))?.absoluteDate
            return date
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let dateString = value?.string(){
            return dateString + ",\(0 - (TimeZone.current.secondsFromGMT()/60))"
        }
        return nil
    }
}

public class DateStringNotTimezoneTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            if let date = value.toISODate()?.date {

                return date - TimeZone.current.secondsFromGMT().seconds
            }
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let date = value{
            let fixdate = date + TimeZone.current.secondsFromGMT().seconds
            return fixdate.string()
        }
        return nil
    }
}

public class DateStringTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            return value.toISODate()?.date
//            return value.date(format: DateFormats.iso8601Auto)?.absoluteDate
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.toString(DateToStringStyles.iso(ISOFormatter.Options.withInternetDateTime))
//        return value?.string(format: DateFormats.iso8601Auto)
    }
}
public class DateProfileStringTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = value.date(custom: .score_yyyyMMddd)
            
            return date
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.string(.score_yyyyMMddd)
    }
    
}
public class DateDDMMYYStringTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = value.date(custom: .slash_ddMMyyyy)
            
            return date
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.string(.slash_ddMMyyyy)
    }
    
}
public class DateTimestampTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = Date(timeIntervalSince1970: value/1000.0)
            
            return date
        }
        
        else if(value is String)
        {
            let getString = value as! String
            let doubleValue = Double.init(getString) ?? 0
            
            return Date(timeIntervalSince1970: doubleValue/1000.0)
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.timeIntervalSince1970
    }
    
}

public class DateTimestampMiliTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double
    
//    public init() {
//        print("DateTimestampMiliTransform")
//    }
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = Date(timeIntervalSince1970: value/1000)
            return date
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value{
            return value.timeIntervalSince1970*1000.rounded()
        }
        return nil
    }
}

public class DateOffsetNotTimezoneTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = [String]
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let timeString = value.joined(separator: " ")
            // Không hiểu sao dùng string yyyy_mm_dd hh:mm:ss lại lỗi trên real device!!
            
            var date = timeString.date(custom: .yyyy_mm_dd_hhmmss)
            if date == nil{
                date = timeString.toISODate()?.date
            }
            return date
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let v = value{
            return v.string(.yyyy_mm_dd_hhmmss).components(separatedBy: " ")
        }
        return nil
    }
}

public class DateTimestampNotTimezoneTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            let date = Date(timeIntervalSince1970: value/1000.0)
            return date - TimeZone.current.secondsFromGMT().seconds
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let v = value{
            return (v + TimeZone.current.secondsFromGMT().seconds).timeIntervalSince1970
        }
        return 0
    }
    
    public static func create() -> DateTimestampTransform{
        return DateTimestampTransform()
    }
}

public class DateNumberTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            return value.toISODate()?.date
//            return value.date(format: DateFormats.iso8601Auto)?.absoluteDate
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.toString(DateToStringStyles.iso(ISOFormatter.Options.withInternetDateTime))
//        return value?.string(format: DateFormats.iso8601Auto)
    }
}

public class BoolIntTransform: TransformType {
    public typealias Object = Bool
    public typealias JSON = Int
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            
            return value == 1 ? true : false
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let val = value{
            return val ? 1 : 0
        }
        return nil
    }
}
public class ArrayStringAfterTransform: TransformType {
    public typealias Object = String
    public typealias JSON = Any //[Any]
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let arr = value as? [Any]{
            let ret = arr.compactMap { item -> String? in
                return "\(item)"
            }.joined(separator: ",")
            return "\(ret)"
        }
        
        if let str = value as? String{
            return str
        }
        
        if let obj = value{
            return "\(obj)"
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let val = value?.components(separatedBy: ","){
            return val
        }
        return nil
    }
}

public class BoolNilTransform: TransformType {
    public typealias Object = Bool?
    public typealias JSON = Int?
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            if let v = value, v > 0{
                return true
            }
        }
        return false
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if value == true{
            
            return 1
        }
        return nil
    }
}

public class BoolIntReverseTransform: TransformType {
    public typealias Object = Bool
    public typealias JSON = Int
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            
            return value > 0 ? false : true
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let val = value{
            return val ? 0 : 1
        }
        return nil
    }
}
public class StringIntTransform: TransformType {
    public typealias Object = Int
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            
            return Int(value)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let val = value{
            return "\(val)"
        }
        return nil
    }
}

public class StringFloatTransform: TransformType {
    public typealias Object = CGFloat
    public typealias JSON = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            
            return CGFloat(Float(value) ?? 0)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let val = value{
            return "\(val)"
        }
        return nil
    }
}

public class EncodeUrlTransform: TransformType {
    
    public typealias JSON = String
    public typealias Object = String
    
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? JSON {
            
            var url = value
            
            if(url.contains("<size>_<quanlity>"))
            {
                url = value.replacingOccurrences(of: "<size>_<quanlity>", with: "1080x1080_high")
            }
            
            return url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        
        return nil
    }
}
