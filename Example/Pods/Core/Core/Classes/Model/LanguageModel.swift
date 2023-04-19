//
//  LanguageModel.swift
//  Alamofire
//
//  Created by Quan on 10/02/2023.
//

import UIKit
import ObjectMapper
import Network

public enum LanguageModelCode: String {
    case vi = "vi"
    case en = "en"
    case unknown
}

//public class LanguageModel: BaseModel {
//    public var name: String?
//    public var code: String?
//
//    override public func mapping(map: Map) {
//        super.mapping(map: map)
//        name <-  map["name"]
//        code <- map["code"]
//    }
//
//    public static func getDefault() -> LanguageModel{
//        let code = Localize.currentLanguage()
//        return LanguageModel.createByCode(code)
//    }
//
//    public static func createByCode(_ code: String) -> LanguageModel{
//        let all = LanguageModel.supported()
//        let low = code.lowercased()
//        if let lang = all.first(where: { item in
//            if item.code?.lowercased() == low{
//                return true
//            }
//            return false
//        }){
//            return lang
//        }
//        let english = LanguageModel()
//        english.code = "en"
//        english.name = "English"
//        return english
//    }
//
//    public static func supported() -> [LanguageModel]
//    {
//        var dataList = [LanguageModel]()
//
//        let english = LanguageModel()
//        english.code = "en"
//        english.name = "English"
//        dataList.append(english)
//
//        let vietnamese = LanguageModel()
//        vietnamese.code = "vi"
//        vietnamese.name = "Tiếng Việt"
//        dataList.append(vietnamese)
//
//        let chineseSimplified = LanguageModel()
//        chineseSimplified.code = "zh-Hans"
//        chineseSimplified.name = "中国人"
//        dataList.append(chineseSimplified)
//
//        let french = LanguageModel()
//        french.code = "fr"
//        french.name = "Français"
//        dataList.append(french)
//
//        let spanish = LanguageModel()
//        spanish.code = "es"
//        spanish.name = "Español"
//        dataList.append(spanish)
//
//        let german = LanguageModel()
//        german.code = "de"
//        german.name = "Deutsch"
//        dataList.append(german)
//
//        let russian = LanguageModel()
//        russian.code = "ru"
//        russian.name = "Pусский"
//        dataList.append(russian)
//
//        let italian = LanguageModel()
//        italian.code = "it-IT"
//        italian.name = "Italiano"
//        dataList.append(italian)
//
//        let portuguese = LanguageModel()
//        portuguese.code = "pt-BR"
//        portuguese.name = "Português"
//        dataList.append(portuguese)
//
//        let japanese = LanguageModel()
//        japanese.code = "ja"
//        japanese.name = "日本語"
//        dataList.append(japanese)
//
//        let korean = LanguageModel()
//        korean.code = "ko"
//        korean.name = "한국어"
//        dataList.append(korean)
//
//        let hindi = LanguageModel()
//        hindi.code = "hi"
//        hindi.name = "भारतीय भाषा"
//        dataList.append(hindi)
//
//        let thai = LanguageModel()
//        thai.code = "th"
//        thai.name = "ไทย"
//        dataList.append(thai)
//
//        let indonesian = LanguageModel()
//        indonesian.code = "id"
//        indonesian.name = "Bahasa Indo"
//        dataList.append(indonesian)
//
//        let malay = LanguageModel()
//        malay.code = "ms"
//        malay.name = "Bahasa Melayu"
//        dataList.append(malay)
//
//        let burmese = LanguageModel()
//        burmese.code = "my"
//        burmese.name = "ဗမာဘာသာစကား"
//        dataList.append(burmese)
//
//        let filipinos = LanguageModel()
//        filipinos.code = "fil"
//        filipinos.name = "Filipinas"
//        dataList.append(filipinos)
//
//        let bengali = LanguageModel()
//        bengali.code = "bn-BD"
//        bengali.name = "Bengali"
//        dataList.append(bengali)
//
//        let swahili = LanguageModel()
//        swahili.code = "sw"
//        swahili.name = "Swahili"
//        dataList.append(swahili)
//
//        let turkish = LanguageModel()
//        turkish.code = "tr-TR"
//        turkish.name = "Turkish"
//        dataList.append(turkish)
//
//        let tamil = LanguageModel()
//        tamil.code = "ta"
//        tamil.name = "இலங்கை"
//        dataList.append(tamil)
//
//        let ukraina = LanguageModel()
//        ukraina.code = "uk-UA"
//        ukraina.name = "Українська мова"
//        dataList.append(ukraina)
//
//        let finnish = LanguageModel()
//        finnish.code = "fi-FI"
//        finnish.name = "suomi"
//        dataList.append(finnish)
//
//        let slovenian = LanguageModel()
//        slovenian.code = "sl"
//        slovenian.name = "Slovenian"
//        dataList.append(slovenian)
//
//        let polish = LanguageModel()
//        polish.code = "pl"
//        polish.name = "Polski"
//        dataList.append(polish)
//
//        let romanian = LanguageModel()
//        romanian.code = "ro"
//        romanian.name = "Daco-Romanian"
//        dataList.append(romanian)
//
//        let belarusian = LanguageModel()
//        belarusian.code = "be"
//        belarusian.name = "беларуская мова"
//        dataList.append(belarusian)
//
//        let azerbaijani = LanguageModel()
//        azerbaijani.code = "az"
//        azerbaijani.name = "Azeri"
//        dataList.append(azerbaijani)
//
//        let tatar = LanguageModel()
//        tatar.code = "tt"
//        tatar.name = "Tatar"
//        dataList.append(tatar)
//
//        let greek = LanguageModel()
//        greek.code = "el-GR"
//        greek.name = "Greek"
//        dataList.append(greek)
//
//        let bulgarian = LanguageModel()
//        bulgarian.code = "bg"
//        bulgarian.name = "Bulgarian"
//        dataList.append(bulgarian)
//
//        let hungarian = LanguageModel()
//        hungarian.code = "hu"
//        hungarian.name = "Hungarian"
//        dataList.append(hungarian)
//
//        let serbian = LanguageModel()
//        serbian.code = "sr"
//        serbian.name = "Serbian"
//        dataList.append(serbian)
//
//        let czech = LanguageModel()
//        czech.code = "cs"
//        czech.name = "Czech"
//        dataList.append(czech)
//
//        let kazakh = LanguageModel()
//        kazakh.code = "kk"
//        kazakh.name = "Kazakh"
//        dataList.append(kazakh)
//
//        let lithuania = LanguageModel()
//        lithuania.code = "lt"
//        lithuania.name = "Lithuania"
//        dataList.append(lithuania)
//
//        let latvian = LanguageModel()
//        latvian.code = "lv"
//        latvian.name = "Latvian"
//        dataList.append(latvian)
//
//        let croatia = LanguageModel()
//        croatia.code = "hr"
//        croatia.name = "Croatia"
//        dataList.append(croatia)
//
//        let bosnian = LanguageModel()
//        bosnian.code = "bs"
//        bosnian.name = "Bosnian"
//        dataList.append(bosnian)
//
//        let slovak = LanguageModel()
//        slovak.code = "sk"
//        slovak.name = "Slovak"
//        dataList.append(slovak)
//
//        let estonia = LanguageModel()
//        estonia.code = "et"
//        estonia.name = "Estonia"
//        dataList.append(estonia)
//
//        let dutch = LanguageModel()
//        dutch.code = "nl"
//        dutch.name = "Dutch"
//        dataList.append(dutch)
//
//        let albanian = LanguageModel()
//        albanian.code = "sq"
//        albanian.name = "Albanian"
//        dataList.append(albanian)
////
////        let cataln = LanguageModel()
////        cataln.code = "ca"
////        cataln.name = "Cataln"
////        dataList.append(cataln)
//
//        let swedish = LanguageModel()
//        swedish.code = "sv"
//        swedish.name = "Swedish"
//        dataList.append(swedish)
//
//        return dataList
//    }
//}
//
//
