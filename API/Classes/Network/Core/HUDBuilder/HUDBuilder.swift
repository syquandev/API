//
//  HUDBuilder.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import SVProgressHUD

public class HUDBuilder : NSObject {
    fileprivate static var toasConfiged = false
    public static func showAlert(message:String, title: String? = nil, cancel:String = "OK", viewController:UIViewController? = nil){
        if !toasConfiged{
            let appearance = ToastView.appearance()
            appearance.backgroundColor = .black
            appearance.textColor = .white
            appearance.font = UIFont.systemFont(ofSize: 15)
            appearance.textInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
            appearance.bottomOffsetPortrait = 32
            appearance.layer.cornerRadius = 10
            appearance.clipsToBounds = true
            appearance.maxWidthRatio = 0.7
            toasConfiged = true
        }
        DispatchQueue.main.async {
            Toast(text: message).show()
        }
    }
    
    public static func showStatus(_ status: ResponseStatus){
        DispatchQueue.main.async {
            switch status.code{
            case 200:
                SVProgressHUD.showSuccess(withStatus: "Success")
            default:
                SVProgressHUD.showError(withStatus: "Error")
            }
        }
    }
    
    public static func showLoading(message:String? = nil, block: Bool = true){
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultMaskType(block ? .clear : .none)
            if let status = message {
                SVProgressHUD.show(withStatus: status)
            } else {
                SVProgressHUD.show()
            }
        }
    }
    
    public static func dismissLoading(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
