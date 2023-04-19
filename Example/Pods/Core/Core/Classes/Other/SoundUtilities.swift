//
//  SoundUtilities.swift
//  Core
//
//  Created by Quan on 10/02/2023.
//

import UIKit
import AVFoundation
import AudioToolbox

public class SoundUtilities: NSObject {
    public static var player: AVAudioPlayer?
    
    public static func setupSound(){
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    public static func playSoundFile(_ name: String, withExtenstion fileExtension: String = "mp3", bundle: Bundle? = Bundle.main){
        guard let url = bundle?.url(forResource: name, withExtension: fileExtension) else {
            print("url not found")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            if let player = try? AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue){
                self.player = player
                player.prepareToPlay()
                player.play()
            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public static func systemSound(_ name: String, withExtenstion fileExtension: String = "mp3", bundle: Bundle? = Bundle.main) {
        
        guard let url = bundle?.url(forResource: name, withExtension: fileExtension) else {
            print("url not found")
            return
        }
        var sound: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(url as CFURL, &sound)
        
        AudioServicesAddSystemSoundCompletion(sound, nil, nil, { (sound, _) -> Void in
            AudioServicesDisposeSystemSoundID(sound)
        }, nil)
        
        AudioServicesPlaySystemSound(sound)
    }
    
    public static func registerSystemsound(_ name: String, withExtenstion fileExtension: String = "mp3", code: Int, bundle: Bundle? = Bundle.main){
        
        guard let url = bundle?.url(forResource: name, withExtension: fileExtension) else {
            print("url not found")
            return
        }
        var sound: SystemSoundID = SystemSoundID(code)
        
        AudioServicesCreateSystemSoundID(url as CFURL, &sound)
    }

}
