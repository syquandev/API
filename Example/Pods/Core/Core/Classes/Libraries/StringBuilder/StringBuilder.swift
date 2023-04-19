//
//  StringBuilder.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 16/03/2023.
//

import Foundation
import UIKit
import FontAwesome
//import DTCoreText

public class StringBuilder: NSObject {
    public static var shared = StringBuilder()
    
    public static var defaultRegular = AppFont.regular_15
    public static var defaultMedium = AppFont.medium_15
    public static var defaultBold = AppFont.bold_15
    public static var bold17 = AppFont.bold_17
    
    private static let miniumFont = AppFont.regular_12
//    public var awesomeFont: UIFont = AppFont.getAwesome(.size_14)
//    public var italicFont:UIFont = AppFont.getItalic(.regular_15)
    
    
    public var subFont:UIFont = AppFont.regular_12.getFont()
    public var normalFont:UIFont = StringBuilder.defaultRegular.getFont()
    public var mediumFont:UIFont = StringBuilder.defaultMedium.getFont()
    public var boldFont:UIFont = StringBuilder.defaultBold.getFont()
    
    public var semiFont:UIFont = AppFont.regular_16.getFont()
    public var semiBoldFont:UIFont = AppFont.bold_16.getFont()
    
    public var titleFont:UIFont = AppFont.regular_18.getFont()
    public var titleBoldFont:UIFont = AppFont.bold_18.getFont()
    
    public var color: UIColor = AppColor.normal.getColor()
    public var focus: UIColor = UIColor.green
    public var hightLight: UIColor = AppColor.primary.getColor()
    public var userColor: UIColor = UIColor.black
    public var userOfStreamColor: UIColor = UIColor.white
    public var light: UIColor = UIColor.lightGray
    
    
//    public var bTag: Style!
//    public var iTag: Style!
//    public var linkTag: Style!
//    public var otherTag: Style!
    
    public var value: NSMutableAttributedString
    public var style: NSMutableParagraphStyle?
    
    public override init() {
        value = NSMutableAttributedString(string: "")
        super.init()
        self.initStyle()
        self.clear()
    }
    
    
    public func initStyle(){
        
//        self.bTag =  Style("b").font(self.boldFont).foregroundColor(self.color)
//        self.iTag =  Style("i").font(self.italicFont).foregroundColor(self.color)
//        self.otherTag =  Style.font(self.normalFont).foregroundColor(self.color)
//        self.linkTag =  Style.font(self.normalFont).foregroundColor(self.hightLight)
    }
    
    @discardableResult
    public func clear() -> StringBuilder{
        self.value = NSMutableAttributedString(string: "", attributes: getDefaulAttributed())
        return self
    }
    public func getDefaulAttributed(color: UIColor? = nil, font: UIFont? = nil) -> [NSAttributedString.Key:Any]{
        let aFont = font ?? self.normalFont
        let aColor = color ?? self.color
        
        var attributes: [NSAttributedString.Key:Any] =  [.foregroundColor: aColor, .font: aFont]
        if let style = self.style{
            attributes[.paragraphStyle] = style
        }
        return attributes
    }
    
    //MARK: - Core
    
    public func getCacheColor(_ color: AppColor) -> UIColor{
        switch color {
        case .normal:
            return self.color
        case .primary:
            return hightLight
        default:
            return color.getColor()
        }
    }
    
    public func getCacheFont(_ font: AppFont) -> UIFont{
        switch font {
        case .regular_12:
            return subFont
            
        case .regular_15:
            return normalFont
        case .medium_15:
            return mediumFont
        case .bold_15:
            return boldFont
            
        case .regular_16:
            return semiFont
        case .bold_16:
            return semiBoldFont
            
        case .regular_18:
            return titleFont
        case .bold_18:
            return titleBoldFont
            
        case .custom(_, _):
            return font.getFont()
        default:
            return font.getFont()
            
        }
    }
    
    @discardableResult
    public func append(_ string: String, font: UIFont, color: UIColor) -> StringBuilder {
        return append(string, font: font, color: color, customKeys: nil)
    }
    
    @discardableResult
    public func append(_ string: String, font: UIFont, color: UIColor, customKeys: String?) -> StringBuilder {
        var attributes: [NSAttributedString.Key:Any] =  getDefaulAttributed()
        attributes[.foregroundColor] = color
        attributes[.font] = font
        if let key = customKeys {
            attributes[NSAttributedString.Key(rawValue: key)] = key
        }
        
        return self.append(string, attributes: attributes)
    }
    
    @discardableResult
    public func append(_ string: String, fontWeight: UIFont.Weight, fontSize: CGFloat, color: UIColor, customKeys: String? = nil) -> StringBuilder {
        let font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        return self.append(string, font: font, color: color, customKeys: customKeys)
    }
    
    @discardableResult
    public func append(_ string: String, font: AppFont, color: AppColor, customKeys: String? = nil) -> StringBuilder {
        return self.append(string, font: getCacheFont(font), color: getCacheColor(color), customKeys: customKeys)
    }
    
    @discardableResult
    public func append(_ string: String, color: AppColor, font: AppFont) -> StringBuilder {
        return self.append(string, font: getCacheFont(font), color: getCacheColor(color))
    }
    
    @discardableResult
    public func append(_ string: String, font: AppFont, color: AppColor) -> StringBuilder {
        return self.append(string, font: getCacheFont(font), color: getCacheColor(color))
    }
    
    @discardableResult
    public func append(_ string: String) -> StringBuilder {
        return self.append(string, font: StringBuilder.defaultRegular, color: AppColor.normal)
    }
    
    @discardableResult
    public func append(_ string: String, color: AppColor) -> StringBuilder {
        return self.append(string, font: StringBuilder.defaultRegular, color: color)
    }
    
    @discardableResult
    public func append(_ string: String, font: AppFont) -> StringBuilder {
        return self.append(string, font: font, color: AppColor.normal)
    }
    
    //MARK: - Custom
    
    @discardableResult
    public func appendBold(_ string: String, color: AppColor = AppColor.normal) -> StringBuilder {
        return self.append(string, font: StringBuilder.defaultBold, color: color)
    }
    
    @discardableResult
    public func appendMedium(_ string: String, color: AppColor = AppColor.normal) -> StringBuilder {
        return self.append(string, font: StringBuilder.defaultMedium, color: color)
    }
    
//    @discardableResult
//    public func appendSmall(_ string: String, color: AppColor = AppColor.light) -> StringBuilder {
//        return self.append(string, font: AppFont.regular_12, color: color)
//    }
//
//    @discardableResult
//    public func appendLight(_ string: String, font: AppFont = StringBuilder.defaultRegular) -> StringBuilder {
//        return self.append(string, font: font, color: AppColor.light)
//    }
//
//    @discardableResult
//    public func appendUltraLight(_ string: String, font: AppFont = StringBuilder.defaultRegular) -> StringBuilder {
//        return self.append(string, font: font, color: .textUltraLight)
//    }
    
    @discardableResult
    public func appendPrimary(_ string: String, font: AppFont = StringBuilder.defaultRegular) -> StringBuilder {
        return self.append(string, font: font, color: AppColor.primary)
    }
    
    @discardableResult
    public func replaceString(_ string: String, color: AppColor) -> StringBuilder{

        let range = (value.string as NSString).range(of: string)

        value.addAttribute(NSAttributedString.Key.foregroundColor, value: color.getColor() , range: range)
        
        return self
    }
    
    //MARK: - Special character
    
    @discardableResult
    public func enterSpace() -> StringBuilder {
        return enter(-5)
    }
    
    @discardableResult
    public func enterParagraph() -> StringBuilder {
        return append("\n\n")
    }
    
    @discardableResult
    public func enterExtra() -> StringBuilder {
        return enter(-13)
    }
    
    @discardableResult
    public func enterLevel(_ level: UInt8 = 1) -> StringBuilder {
        
        var e = ""
        for _ in 0..<level{
            e.append("\n")
        }
        return self.append(e, font: StringBuilder.miniumFont)
    }
    
    @discardableResult
    public func enter(_ level: CGFloat = 0) -> StringBuilder {
        var font = self.normalFont
        
//        if level != 0 {
//            font = AppFont.custom(AppFontSize.size_14.getValue() + level, UIFont.Weight.regular).getFont()
//            return self.append("\n\n", font: font, color: self.color)
//        }
        return self.append("\n", font: font, color: self.color)
    }
    
    @discardableResult
    public func tab(_ value: Int = 1) -> StringBuilder {
        var tab = ""
        for _ in 0..<value{
            tab += "\t"
        }
        return self.append(tab)
    }
    
    
//    //MARK: - Awesome
//
//    @discardableResult
//    public func appendAwesome(_ icon: FontAwesome, size: AppFontSize = .size_14, color: AppColor = .normal) -> StringBuilder {
//        return self.appendAwesome(icon.rawValue, size: size, color: color)
//    }
//
//    @discardableResult
//    public func appendAwesome(_ icon: String, size: AppFontSize = .size_14, color: AppColor = .normal) -> StringBuilder {
//        let afont = AppFont.getAwesome(size)
//        return self.append(icon, font: afont, color: getCacheColor(color))
//    }
//
//    @discardableResult
//    public func appendAwesome(_ icon: FontAwesome, color: AppColor = .normal) -> StringBuilder {
//        return self.appendAwesome(icon.rawValue, size: .size_14, color: color)
//    }
//
//    @discardableResult
//    public func appendAwesome(_ icon: String, color: AppColor = .normal) -> StringBuilder {
//        return self.appendAwesome(icon, size: .size_14, color: color)
//    }
    
    //MARK: - Other
    
    @discardableResult
    public func append(_ string: String, attributes:[NSAttributedString.Key:Any]) -> StringBuilder {
        //        let attr = NSMutableAttributedString(string: string)
        //        attr.addAttributes(attributes, range: NSMakeRange(0, attr.length))
        //        self.attributedString.append(attr)
        
        let attr = NSAttributedString(string: string, attributes: attributes)
        //        self.attributedString.beginEditing()
        self.value.append(attr)
        //        self.attributedString.endEditing()
        return self
    }
    
    
    
    public func appendViewMore(_ content: String = "more") -> StringBuilder{
        var attributes:[NSAttributedString.Key:Any] = getDefaulAttributed(color: hightLight)
        
//        attributes[TextElementAttrkey.more] = content
        return self.append(" ..."+"see_more".localized , attributes: attributes)
        
    }
    
    public func appendLink(_ url: String, display: String? = nil, color: UIColor? = nil, font: UIFont? = nil) -> StringBuilder{
        var attributes:[NSAttributedString.Key:Any] = getDefaulAttributed(color: color ?? hightLight, font: font ?? normalFont)
        if let u = URL(string: url){
//            attributes[TextElementAttrkey.link] = u
        }
        return self.append(display ?? url, attributes: attributes)
        
    }
    
    @discardableResult
    public func appendAttributed(_ string: NSAttributedString?) -> StringBuilder{
        if string != nil{
            self.value.append(string!)
        }
        return self
    }
    
    
    @discardableResult
    public func appendBackground(_ string: String, font: AppFont, fore: AppColor, back: AppColor) -> StringBuilder {
        
        var attributes: [NSAttributedString.Key:Any] =  getDefaulAttributed(color: getCacheColor(fore)) //[.foregroundColor: fore, .backgroundColor: back, .font: font]
        attributes[.backgroundColor] = getCacheColor(back)
        
        return self.append(string, attributes: attributes)
    }
    
    @discardableResult
    public func appendStrike(_ string: String, font: AppFont, color: AppColor) -> StringBuilder {
        var attributes:[NSAttributedString.Key:Any] = getDefaulAttributed(color: getCacheColor(color), font: getCacheFont(font))// [.foregroundColor: color, .font: font, .strikethroughColor: color, .strikethroughStyle: 1]
        attributes[.strikethroughColor] = color.getColor()
        attributes[.strikethroughStyle] = 1
        
        
        return self.append(string, attributes: attributes)
    }
    @discardableResult
    public func appendUnderline(_ string: String, font: AppFont, color: AppColor) -> StringBuilder {
        var attributes:[NSAttributedString.Key:Any] = getDefaulAttributed(color: getCacheColor(color), font: getCacheFont(font))// [.foregroundColor: color, .font: font, .strikethroughColor: color, .strikethroughStyle: 1]
        attributes[.underlineColor] = color.getColor()
        attributes[.underlineStyle] = 1
        
        
        return self.append(string, attributes: attributes)
    }
    
    //MARK: - Apply Style
    
//    @discardableResult
//    public func highlightHashTag() -> StringBuilder{
////        let regex = "#\\w+"
//        let regex = #"#[^\s!@#$%^&*()=+.\-\/,\[{\]};:'"?><\p{Emoji_Presentation}]+"#
//        let ranges = self.value.string.subNSRange(regex: regex)
//
//
//        for range in ranges {
//            let hashtag = value.string.subString(range) ?? ""
//            let attributes:[NSAttributedStringKey:Any] = [.foregroundColor: self.hightLight, TextElementAttrkey.hashtag: hashtag]
//            value.addAttributes(attributes, range: range)
//
//        }
//        return self
//    }
//
//    @discardableResult
//    public func highlightLink() -> StringBuilder{
//        self.value = NSMutableAttributedString(attributedString: self.value.styleLinks(self.linkTag).attributedString)
//        return self
//    }
//
//
    @discardableResult
    public func highlightString(_ string: String?) -> StringBuilder{
        guard let string = string else{
            return self
        }
        self.value.string.ranges(of: string).forEach { (rangeIndex) in
            let attributes:[NSAttributedString.Key:Any] =  [.foregroundColor: getCacheColor(.primary)]
            let range = NSRange(rangeIndex, in: self.value.string)
            self.value.addAttributes(attributes, range: range)
        }
        return self
    }
    
    @discardableResult
    public func addColor(_ color: UIColor?, forString string: String?, indexs: [Int] = [], font: AppFont? = nil) -> StringBuilder{
        guard let string = string,
              let color = color else{
            return self
        }
        
        let arrs = value.string.ranges(of: string)
        for(index, element) in arrs.enumerated(){
            if indexs.count == 0 || indexs.contains(index){
                var attributes: [NSAttributedString.Key:Any] =  [.foregroundColor: color]
                if let f = font{
                    attributes.safeAdd(key: .font, value: f.getFont())
                }
                let range = NSRange(element, in: value.string)
                value.addAttributes(attributes, range: range)
            }
        }
        
        return self
    }
    
    @discardableResult
    public func appendURL(_ url: String, string: String? = nil) -> StringBuilder{
        let display = string ?? url
        let attr = NSMutableAttributedString(string: display)
        let url = URL(string: url)!
        
        // Set the 'click here' substring to be the link\
        attr.setAttributes([.link: url], range: NSRange(location: 0, length: attr.length))
        self.value.append(attr)
        
        return self
    }
    
    @discardableResult
    public func replaceCode(_ code: String, display: String, color: AppColor, font: AppFont) -> StringBuilder{
        let content = StringBuilder().append(display, font: font, color: color).value
        while true{
            let str = value.string
            if let r = str.range(of: code){
                let range = NSRange(r, in: str)
                value.replaceCharacters(in: range, with: content)
            }else{
                break
            }
        }
        return self
    }
}
