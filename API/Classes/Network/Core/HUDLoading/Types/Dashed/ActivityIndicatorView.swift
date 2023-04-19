//
//  ActivityIndicatorView.swift
//  Loader
//

//
import Foundation
import UIKit

public class ActivityIndicatorView: UIActivityIndicatorView {
  public private(set) var view: UIView!

    public override func didMoveToSuperview() {
        handleAnimating()
    }

  var timeline: Timeline? {
    return nil
  }
    
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  public func createView() -> UIView {
    return UIView(frame: CGRect.null)
  }

  //add the animation view
  public func setup() {
    view = createView()
    layer.backgroundColor = UIColor.clear.cgColor
    layer.shadowRadius = 4
    layer.masksToBounds = false
    layer.shadowRadius = 2
    layer.shadowOpacity = 0.25
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    addSubview(view)
  }

  /// Used for when launching from interface builder, checks the state and automatically plays
  func handleAnimating() {
    if isAnimating {
      timeline?.play()
    }
  }

    public override func startAnimating() {
    super.startAnimating()
    timeline?.play()
  }

    public override func stopAnimating() {
    super.stopAnimating()
    timeline?.pause()
    timeline?.offset(to: 0)
  }
}
