//
//  BottomPopupCore.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  
//

import Foundation

public class BottomPopupConfiguration{
    public weak var delegate : BottomPopupDelegate?
    public var view: NSObject?
    public var title: String?
    public init(delegate: BottomPopupDelegate? = nil) {
        self.delegate = delegate
    }
}

public protocol BottomPopupDelegate: class {
    
}

extension BottomPopupController{
    public static func create(_ config: BottomPopupConfiguration? = nil) -> BottomPopupController {
        //MARK: - Code Based
        //let presenter: BottomPopupPresenter = BottomPopupPresenter()

        //MARK: -  Storyboard Base
        let controller: BottomPopupController = BottomPopupController.createFromStoryboard("BottomPopupView", bundle: Core.getBundle())
        controller.setConfig(config)
        
        return controller
    }
    
    func setConfig(_ config: BottomPopupConfiguration?){
        guard let config = config else{
            return
        }
        core.setConfig(config)
    }
}

public class BottomPopupCore: NSObject{
    var config = BottomPopupConfiguration()
    
    private weak var controller: BottomPopupController?
    public func setController(_ controller: BottomPopupController?){
        self.controller = controller
    }
    
    public override init() {
        super.init()
        self.setConfig(config)
    }
    
    
    public func setConfig(_ config: BottomPopupConfiguration){
        self.config = config
    }
    
    func viewReady(){
        
    }
}

