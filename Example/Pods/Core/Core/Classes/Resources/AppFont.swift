//
//  AppFont.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation
import UIKit
import FontAwesome

//public class AppFont: NSObject{
//
//}

public enum AppFont{
    case light_12
    case regular_12
    case bold_12
    
    case light_15
    case regular_15
    case medium_15
    case semibold_15
    case bold_15
    
    case light_16
    case regular_16
    case medium_16
    case semibold_16
    case bold_16
    
    case light_17
    case regular_17
    case medium_17
    case semibold_17
    case bold_17
    case black_17
    
    case regular_18
    case medium_18
    case semibold_18
    case bold_18
    
    case custom(CGFloat, UIFont.Weight)
    
    case italic(CGFloat)
    case light_italic(CGFloat)
    case light(CGFloat)
    
    case bold(CGFloat)
    case bold_italic(CGFloat)
    
    case extra_bold(CGFloat)
    case extra_light(CGFloat)
    case extra_light_italic(CGFloat)
    
    case medium(CGFloat)
    case regular(CGFloat)
    case semi_bold(CGFloat)
    case semi_bold_italic(CGFloat)
    
    public func getFont() -> UIFont{
        return AppFont.getFont(self)
    }
    
    private static func getFont(_ code: AppFont) -> UIFont {
        var weight = UIFont.Weight.regular
        let name = String(describing: code)
        let fixedSize = CGFloat(13)
        var italic = false
        
        switch code {
        case .custom(_, let w):
            weight = w
            
        case .light(_):
            weight = .light
            
        case .light_italic(_):
            weight = .light
            italic = true
            
        case .extra_light(_):
            weight = .ultraLight
            
        case .extra_light_italic(_):
            weight = .ultraLight
            italic = true
            
            
            
        case .regular(_):
            weight = .regular
            
            
        case .italic(_):
            weight = .regular
            italic = true
            
            
            
        case .medium(_):
            weight = .medium
            
            
            
        case .semi_bold(_):
            weight = .semibold
            
        case .semi_bold_italic(_):
            weight = .semibold
            italic = true
            
            
        case .bold(_):
            weight = .bold
            
        case .bold_italic(_):
            weight = .bold
            italic = true
            
        case .extra_bold(_):
            weight = .black
            
        default:
            if name.contains("bold"){
                weight = .bold
                
            }else if name.contains("medium"){
                weight = .medium
                
            }else if name.contains("light"){
                weight = .light
            }else if name.contains("ultraLight"){
                weight = .ultraLight
            }else if name.contains("semibold"){
                weight = .semibold
            }else if name.contains("black"){
                weight = .black
            }
            break
        }
        if italic{
            return UIFont.italicSystemFont(ofSize: fixedSize)
        }
        
        return UIFont.systemFont(ofSize: fixedSize, weight: weight)
    }
}
