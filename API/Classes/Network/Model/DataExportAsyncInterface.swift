//
//  DataExportAsyncInterface.swift
//  Network
//
//  Created by HU-IOS-DT-QUAN on 07/04/2023.
//

import Foundation
import UIKit

public protocol DataExportAsyncInterface: class{
    func exportData(_ completion: @escaping ((URL?, String?) -> Void))
//    func getUploadImage() -> UIImage?
    func exportImage(_ completion: @escaping ((URL?, String?) -> Void))
    func getLocalThumb() -> UIImage?
    func getAsset() -> Any?
}
