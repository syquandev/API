//
//  ImageExtensions.swift
//  Core
//
//  Created by Quan on 15/02/2023.
//

import UIKit

extension UIImage{
    public func tinted(color: UIColor) -> UIImage? {
        let image = self.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        
        UIGraphicsBeginImageContext(image.size)
        if let context = UIGraphicsGetCurrentContext() {
            imageView.layer.render(in: context)
            let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return tintedImage
        } else {
            return self
        }
    }
    
    public convenience init?(name: String?, bundle: Bundle?) {
        guard let name = name,
            let bundle = bundle else{
                self.init()
                return
        }
        self.init(named: name, in: bundle, compatibleWith: nil)
//        let fixedPath = bundle.bundlePath + "/" + name
//        self.init(named: fixedPath)
    }
}
