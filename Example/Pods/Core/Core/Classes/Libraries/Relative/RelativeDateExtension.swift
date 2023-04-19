//
//  RelativeDateExtension.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import SwiftDate

extension String{
    
    public func date(custom: String = DateFormatString.score_yyyyMMddd.rawValue) -> Date?{
        return self.toDate(style: StringToDateStyles.custom(custom))?.date
    }
    public func date(custom: DateFormatString) -> Date?{
        return self.date(custom: custom.rawValue)
    }
}

public enum DateFormatString: String {
    case slash_ddMMyyyy = "dd/MM/yyyy"
    case slash_MMyyyy = "MM/yyyy"
    case score_yyyyMMddd = "yyyy-MM-dd"
    case score_ddMMyyyy = "dd-MM-yyyy"
    case full = "E, d MMM yyyy HH:mm"
    case clock = "E, d MMM yyyy"
    case month_year_text = "MMMM yyyy"
    case full_text = "EEEE, dd/MM/yyyy"
    case day_month = "dd/MM"
    case hour_min = "HH:mm"
    case dayMonthYear = "ddMMyyyy"
    case hourMinuteSecondDayMonthYear =  "HH:mm:ss - dd/MM/yyyy"
    //    case time_CheckIn_CheckOut = "HH:mm"
    case DATE_FORMAT_EEE_DD_MM_YYYY_VN  =   "EEE, dd/MM/yyyy"
    case DATE_FORMAT_EEE_DD_MM_YYYY_HH_MM_VN  =   "EEE, dd/MM/yyyy HH:mm"
    case DATE_FORMAT_HH_MM_DD_MM_YYYY_VN  =   "HH:mm dd/MM/yyyy"
    case DATE_FORMAT_DD_MM_YYYY_HH_MM_SS_VN  =   "dd/MM/yyyy HH:mm:ss"
    case clockAMPM =  "h:mm a"
    case MMM_d =  "MMM d"
    case d_MMMM =  "d MMMM"
    case d_MMMM_yyyy =  "d MMMM, yyyy"
    case yyyy_mm_dd_hhmmss = "yyyy-MM-dd HH:mm:ss"
    
    
    public func lcz() -> String{
        let lang = Localize.currentLanguage().lowercased()
        if lang == "vi" {
            return self.rawValue
        }
        
        switch self {
        case .slash_ddMMyyyy:
            return "MM/dd/yyyy"
            
        case .full_text:
            return "EEEE, MM/dd/yyyy"
            
        case .DATE_FORMAT_EEE_DD_MM_YYYY_VN:
            return "EEE, MM/dd/yyyy"
            
        case .DATE_FORMAT_EEE_DD_MM_YYYY_HH_MM_VN:
            return "EEE, MM/dd/yyyy HH:mm"
            
        case .DATE_FORMAT_HH_MM_DD_MM_YYYY_VN:
            return "HH:mm MM/dd/yyyy"
            
        case .d_MMMM:
            return "MMMM d"
        default:
            return self.rawValue
        }
    }
    
}

extension Date {
    
    public func stringLocalized(custom: String = DateFormatString.score_yyyyMMddd.lcz()) -> String{
        return self.toFormat(custom, locale: Localize.getCurrenLocale())
    }
    
    public func string(_ custom: DateFormatString) -> String{
        return self.toFormat(custom.lcz(), locale: Localize.getCurrenLocale())
    }
    
    public func string(custom: String = DateFormatString.score_yyyyMMddd.lcz()) -> String{
        return self.toString(DateToStringStyles.custom(custom))
    }
    public func stringClock() -> String {
        return self.string(custom: DateFormatString.clock.lcz())
    }
    public func stringDisplay() -> String {
        return self.string(custom: DateFormatString.slash_ddMMyyyy.lcz())
    }
    public func monthYearDisplay() -> String {
        return self.string(custom: DateFormatString.slash_MMyyyy.lcz())
    }
    public func stringFull() -> String {
        return self.string(custom: DateFormatString.full.lcz())
    }
    public func stringClockAMPM() -> String {
        return self.string(custom: DateFormatString.clockAMPM.lcz())
    }
//    public func stringTime() -> String {
//        return self.string(custom: DateFormatString.time_CheckIn_CheckOut.rawValue)
//    }
    //    public func stringSimpleAPI() -> String {
    //        return self.string(custom: "yyyy-MM-dd")
    //    }
    
    public func timeAgoSince() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: self, to: now)
        let minute  = components.minute ?? 0
        let hour    = components.hour ?? 0
        let day     = components.day ?? 0
        let month   = components.month ?? 0
        let year    = components.year ?? 0
        
        if now.year != self.year{
            return self.string(.d_MMMM_yyyy)
            
        }
        if year > 0 ||  month > 0 || day > 0 { //1 day
            return self.string(.d_MMMM)
        }
        
        if hour > 0 {
            if hour == 1{
                return "personal_wall_info_login_hour".localized
            }
            return "\(hour) \("personal_wall_info_login_hours".localized)"
        }
        
        if minute > 0 {
            if minute == 1{
                return "personal_wall_info_login_minute".localized
            }
            return "\(minute) \("personal_wall_info_login_minutes".localized)"
        }
        
//        if second > 0 {
            return "personal_wall_info_login_seconds".localized
//        }
        
//        return "personal_wall_info_login_seconds".localized
        
        
    }
    
    public static func daysBetween(_ first: Date, and: Date) -> Int{
        let gregorian = Calendar(identifier: .gregorian)
        
        let rangeCount = (gregorian.dateComponents([.day], from: and, to: first).day ?? 0)
        return abs(rangeCount)
    }
    
    public static func getDayDiff(_ first: Date, and: Date) -> Int{
        
        let calendar = NSCalendar.current as NSCalendar
        
        let gregorian = Calendar(identifier: .gregorian)
        
        let rangeCount = gregorian.dateComponents([.day], from: calendar.startOfDay(for: and), to: calendar.startOfDay(for: first)).day
        return rangeCount ?? 0
    }
}
