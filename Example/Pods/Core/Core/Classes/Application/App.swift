//
//  App.swift
//  Alamofire
//
//  Created by Quan on 10/02/2023.
//

import Foundation

public protocol APIFunctionInterface: class{
    func loginComplete()
    func languageChanged()
    func currencyChanged()
}

public protocol NetworkFunctionInterface: class{
    func loginComplete()
}

open class App: NSObject{
    public static var shared: App = App()
//    public static var media: MediaFunction = MediaFunction()
    public static var api: APIFunctionInterface?
    public static var network: NetworkFunctionInterface?
    public var lastProfileID: String? = nil
    
    open func clearCache(){
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    public static func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//Settings appdelegate:
//func injection(){
//    Log.shared = AppLogImp()
//    Modules.shared = AppModuleManagerImp()
//
//    App.api = API.shared
//    App.network = Network.shared
//    App.shared = AppImp()
////        App.messenger = Messenger.shared
////        Router.messenger = Messenger.router
//    App.media = Media.shared
//
//    Router.app = AppRouterImp()
//    Router.auth = Auth.router
//    Router.payment = Payment()
//}
