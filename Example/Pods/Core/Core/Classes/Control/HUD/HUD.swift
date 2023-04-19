//
//  HUDBuilder.swift
//  Alamofire
//
//  Created by Quan on 15/02/2023.
//

import Foundation

public class HUD: NSObject{
    public static func showAlert(_ title: String, icon: String){
        let toast = ToastNotificationView(title: title, icon: UIImage(name: icon, bundle: Core.getBundle()))
        toast.position = .bottom
        toast.show()
    }
}
