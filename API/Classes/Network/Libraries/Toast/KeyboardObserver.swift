//
//  KeyboardObserver.swift
//  Network
//
//  Created by Quan on 08/02/2023.
//

import Foundation
import UIKit

final class KeyboardObserver {
  
  static let shared = KeyboardObserver()
  
  private(set) var didKeyboardShow: Bool = false
  
  init() {
    #if swift(>=4.2)
    let keyboardWillShowName = UIWindow.keyboardWillShowNotification
    let keyboardDidHideName = UIWindow.keyboardDidHideNotification
    #else
    let keyboardWillShowName = NSNotification.Name.UIKeyboardWillShow
    let keyboardDidHideName = NSNotification.Name.UIKeyboardDidHide
    #endif
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: keyboardWillShowName,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardDidHide),
      name: keyboardDidHideName,
      object: nil
    )
  }
  
  @objc private func keyboardWillShow() {
    didKeyboardShow = true
  }
  
  @objc private func keyboardDidHide() {
    didKeyboardShow = false
  }
  
}

