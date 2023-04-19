//
//  IndicatorType.swift
//  Alamofire
//
//  Created by Quan on 15/02/2023.
//

import UIKit

public enum IndicatorType: String {
    case ballPulseSync = "Ball Pulse Sync"
    case ballSpinFade = "Ball Spin"
    case lineScale = "Line Scale"
    case ballBeat = "Ball Beat"
    
    public var indicator: UIView & IndicatorProtocol {
        // Add light and dark theme loader for iOS 13.0 or later platform.
        if #available(iOS 13.0, *) {
            switch self {
                //1
            case .ballPulseSync:
                return BallPulseSyncIndicator(color: .label)
                //3
            case .ballSpinFade:
                return BallSpinFadeIndicator(color: .label)
                //4
            case .lineScale:
                return LineScaleIndicator(color: .label)
                //2
            case .ballBeat:
                return BallBeatIndicator(color: .label)
            }
        } else {
            switch self {
            case .ballPulseSync:
                return BallPulseSyncIndicator(color: .gray)
            case .ballSpinFade:
                return BallSpinFadeIndicator(color: .gray)
            case .lineScale:
                return LineScaleIndicator(color: .gray)
            case .ballBeat:
                return BallBeatIndicator(color: .gray)
            }
        }
    }
}
