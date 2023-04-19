//
//  SubStringExtension.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit

extension String.UTF16View{
    
    
    public func subString(from: Int, to: Int? = nil) -> String? {
        let scount = self.count
        let f = from
        let t = to ?? scount
        let toIndex = Swift.max(f, t)
        let fromIndex = Swift.min(f, t)
        
        if fromIndex < 0 || toIndex > scount || fromIndex >= toIndex {
            return nil
        }
        let lowerBound = String.Index(encodedOffset: fromIndex)
        let upperBound = String.Index(encodedOffset: toIndex)
        let string = String(self[lowerBound..<upperBound])
        return string
    }
}


extension String {
    
    public func containRegex(_ regex: String) -> Bool{
        
        do {
            let rgx = try NSRegularExpression(pattern: regex)
            let result = rgx.firstMatch(in: self, options: [], range: NSRange(self.startIndex..., in: self))
            let length =  result?.range.length
            let location =  result?.range.location
           
            if  result != nil {
                return true
            }
            
            return false
        } catch let error {
//            Log.console("invalid regex: \(error.localizedDescription)")
            return false
        }
        
    }
    
    public func isValidURL() -> Bool{
        let low = self.lowercased()
        if !low.contains("http://") && !low.contains("https://") && !low.contains("www."){
            return false
        }
        if !self.contains("."){
            return false
        }
        if self.last == "." {
            return false
        }
        return URL(string: self) != nil
    }
    
    public func isNeedAddLastSpace() -> Bool{
        if self.count == 0 {
            return false
        }
        if self.last == " "{
            return false
        }
        if self.last == "\n"{
            return false
        }
        return true
    }
    
    public func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        
        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        
        return indices
    }
    
    public func subString(_ nsrange: NSRange) -> Substring? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return self[range]
    }
    
    public func subString(from: Int, to: Int? = nil) -> String? {
        let scount = self.count
        let f = from
        let t = to ?? scount
        let toIndex = max(f, t)
        let fromIndex = min(f, t)
        
        if fromIndex < 0 || toIndex > scount || fromIndex >= toIndex {
            return nil
        }
        let lowerBound = String.Index(encodedOffset: fromIndex)
        let upperBound = String.Index(encodedOffset: toIndex)
        let string = String(self[lowerBound..<upperBound])
        return string
    }
    
    public func trimBlankSpace() -> String{
        let first = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = first.components(separatedBy: .whitespaces)
        let filter = components.filter { (string) -> Bool in
            return string != " " && string != ""
        }
        let second = filter.joined(separator: " ")
        return second
    }
    
    public func trimBlank() -> String{
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed
    }
    
    public func trimHTMLCode() -> String{
        return self
            .replacingOccurrences(of: "&amp;nbsp;", with: "")
            .replacingOccurrences(of: "&nbsp;", with: "")
            .replacingOccurrences(of: "<p>", with: "\n")
            .replacingOccurrences(of: "<p>", with: "\n")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<span class=\"user\">", with: "")
            .replacingOccurrences(of: "\n ", with: "\n")
    }
    
    public func replaceRegex(_ regex: String, withString: String) -> String{
        if let rgx = try? NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive){
            let range = NSRange(location: 0, length: self.count)
            return rgx.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: withString)
        }
        return self
    }
}


extension StringProtocol where Index == String.Index {
    public func index<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    public func endIndex<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    public func indexes<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    public func ranges<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound  ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
}
