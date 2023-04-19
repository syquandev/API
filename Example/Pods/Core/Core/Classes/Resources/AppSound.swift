//
//  AppSound.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import Foundation

public class AppSound: NSObject{
    public static func message(){
        SoundUtilities.systemSound("message_sound")
    }
}
