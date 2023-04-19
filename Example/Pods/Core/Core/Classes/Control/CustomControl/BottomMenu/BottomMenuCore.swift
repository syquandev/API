//
//  BottomMenuCore.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  
//

import Foundation

public class BottomMenuItem: NSObject{
    public var data: Any?
    public var title: String?
    public var attTitle: NSAttributedString?
    public var image: UIImage?
    public var tag: Int = -1
    public var imageWidth: CGFloat = 24
    
    //Cái này chỉ dùng cho nội bộ
    var selected: Bool?
    var selectedImage: UIImage?
    var unselectedImage: UIImage?
    
    public init(title: String, tag: Int = -1, image: UIImage? = nil) {
        super.init()
        self.title = title
        self.image = image
        self.tag = tag
    }
    
    public static func create(_ datas: [String]) -> [BottomMenuItem]{
        var count = 0
        let rets = datas.compactMap { str -> BottomMenuItem in
            let item = BottomMenuItem(title: str.localized)
            item.tag = count
            count += 1
            return item
        }
        return rets
    }
}

public class BottomMenuConfiguration{
    static let defaultSelected = UIImage(name: "button_circle_checked", bundle: Core.getBundle())!
    static let defaultUnselected = UIImage(name: "button_circle_uncheck", bundle: Core.getBundle())!
    public var datas = [BottomMenuItem]()
    public var selected: BottomMenuItem?
    public var tag: Int = 0
    public var title: String?
    
    public var selectedImage: UIImage = BottomMenuConfiguration.defaultSelected
    public var unselectedImage: UIImage = BottomMenuConfiguration.defaultUnselected
    
    public weak var delegate : BottomMenuDelegate?
    public init(delegate: BottomMenuDelegate? = nil) {
        self.delegate = delegate
    }
}

public protocol BottomMenuDelegate: class {
    func bottomMenuSelect(_ item: BottomMenuItem, tag: Int)
}

extension BottomMenuController{
    public static func create(_ config: BottomMenuConfiguration? = nil) -> BottomMenuController {
        //MARK: - Code Based
        //let presenter: BottomMenuPresenter = BottomMenuPresenter()

        //MARK: -  Storyboard Base
        let controller: BottomMenuController = BottomMenuController.createFromStoryboard("BottomMenuView", bundle: Core.getBundle())
        controller.setConfig(config)
        
        return controller
    }
    
    public static func create(delegate: BottomMenuDelegate? = nil, datas: [BottomMenuItem], selected: BottomMenuItem? = nil) -> BottomMenuController {
        let controller = BottomMenuController.create()
        let cf = controller.config
        cf.delegate = delegate
        cf.datas = datas
        cf.selected = selected
        controller.core.setConfig(cf)
        return controller
    }
    
    func setConfig(_ config: BottomMenuConfiguration?){
        guard let config = config else{
            return
        }
        core.setConfig(config)
    }
}

public class BottomMenuCore: NSObject{
    var config = BottomMenuConfiguration()
    
    private weak var controller: BottomMenuController?
    public func setController(_ controller: BottomMenuController?){
        self.controller = controller
    }
    
    public override init() {
        super.init()
        self.setConfig(config)
    }
    
    
    public func setConfig(_ config: BottomMenuConfiguration){
        self.config = config
        updateSelectedSources()
    }
    
    func viewReady(){
        
    }
    
    func updateSelectedSources(){
        guard let selected = config.selected else{
            return
        }
        for item in config.datas{
            item.selected = false
            item.selectedImage = config.selectedImage
            item.unselectedImage = config.unselectedImage
            if item == selected{
                item.selected = true
                continue
            }
            
            if item.title == selected.title && selected.title != nil{
                item.selected = true
                continue
            }
            
            if item.attTitle?.string == selected.attTitle?.string && selected.attTitle != nil{
                item.selected = true
                continue
            }
        }
    }
}

