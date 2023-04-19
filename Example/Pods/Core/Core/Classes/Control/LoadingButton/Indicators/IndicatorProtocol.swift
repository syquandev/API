//
//  IndicatorProtocol.swift
//  Alamofire
//
//  Created by Quan on 15/02/2023.
//

import UIKit

public protocol IndicatorProtocol {
    /**
     The radius of the indicator.
     */
    var radius: CGFloat { get set }
    /**
     The primary color of the indicator.
     */
    var color: UIColor { get set }
    /**
     Current status of animation, read-only.
     */
    var isAnimating: Bool { get }
    /**
     Start animating.
     */
    func startAnimating()
    /**
     Stop animating and remove layer.
     */
    func stopAnimating()
    /**
     Set up the animation of the indicator.
     
     - Parameter layer: The layer to present animation.
     - Parameter size:  The size of the animation.
     */
    func setupAnimation(in layer: CALayer, size: CGSize)
}

