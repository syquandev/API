//
//  BottomPopupController.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  
//

import UIKit

public class BottomPopupController: UIViewController{
    let core = BottomPopupCore()
    var config: BottomPopupConfiguration {core.config}
    var delegate: BottomPopupDelegate? {core.config.delegate}
    
    @IBOutlet weak var animationBackgroundView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var contentViewBottomCst: NSLayoutConstraint!
    let gestureHandler = AIGestureHandler()
    
    func initNavigation(){
        self.title = "BottomPopup"
        self.addDefaultNavBackButton()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        core.setController(self)
        initNavigation()
        viewReady()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.animationBackgroundView.alpha = 0.8
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.animationBackgroundView.alpha = 0.8
        }
    }
    
    func initPaneGesture(){
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGestureHandler(_:)))
        self.view.addGestureRecognizer(panGesture);
    }
    
    
    @objc
    func panGestureHandler(_ sender:UIPanGestureRecognizer){
        
        self.gestureHandler.update(gesture: sender);
        let deltaY = -self.gestureHandler.delta.y
        var bottom = deltaY + contentViewBottomCst.constant
        print("bottom \(bottom)")
        if bottom > 0 {
            bottom = 0
        }
        if sender.state == .ended {
            var dismiss = false
            let goUp = self.gestureHandler.isGoUp
            if goUp {
                bottom = 0
            }else{
                bottom = -self.containerView.height
                dismiss = true
            }
            self.contentViewBottomCst.constant = bottom
            dismissAnimation(dismiss: dismiss)
        }else{
            contentViewBottomCst.constant = bottom
            
        }
    }
    
    public func dismissAnimation(dismiss: Bool = true, handler: (()->Void)? = nil){
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            if dismiss {
                self.view.alpha = 0
            }
        }) { (finished) in
            if dismiss {
                self.dismissViewController(completion: handler)
            }
        }
    }
    
    public func show(vc: UIViewController? = nil){
        self.modalPresentationStyle = .overCurrentContext
        if let prs = vc ?? Presenter.getVeryTopViewController(){
            prs.present(self, animated: false)
        }
    }
    
    @IBAction func onDismiss(_ sender: UIButton) {
        dismissAnimation()
    }
    
    func viewReady(){
        core.viewReady()
        if let t = config.title{
            titleView.isHidden = false
            titleLabel.text = t
        }else{
            titleView.isHidden = true
        }
        if let v = config.view as? UIViewController{
            stackView.addArrangedSubview(v.view)
        }else if let v = config.view as? UIView{
            stackView.addArrangedSubview(v)
        }
    }
    
}

