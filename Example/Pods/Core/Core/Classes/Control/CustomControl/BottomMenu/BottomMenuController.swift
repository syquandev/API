//
//  BottomMenuController.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  
//

import UIKit

public class BottomMenuController: UIViewController{
    let core = BottomMenuCore()
    var config: BottomMenuConfiguration {core.config}
    var delegate: BottomMenuDelegate? {core.config.delegate}
    
    @IBOutlet weak var animationBackgroundView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightCst: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomCst: NSLayoutConstraint!
    
    let cellHeight: CGFloat = 60
    let gestureHandler = AIGestureHandler()
    
    func initNavigation(){
        self.title = "BottomMenu"
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
    
    func viewReady(){
        core.viewReady()
        if let t = config.title{
            titleView.isHidden = false
            titleLabel.text = t
        }else{
            titleView.isHidden = true
        }
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableHeightCst.constant = cellHeight * CGFloat(config.datas.count)
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
                bottom = -self.tableHeightCst.constant
                dismiss = true
            }
            self.contentViewBottomCst.constant = bottom
            dismissAnimation(dismiss: dismiss)
        }else{
            contentViewBottomCst.constant = bottom
            
        }
    }
    
    func dismissAnimation(dismiss: Bool = true, handler: (()->Void)? = nil){
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
    
}

extension BottomMenuController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = config.datas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomMenuCell", for: indexPath) as! BottomMenuCell
        cell.configCell(data)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return config.datas.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = config.datas[indexPath.row]
        config.datas.forEach { item in
            item.selected = false
        }
        data.selected = true
        tableView.reloadData()
        dismissAnimation(dismiss: true) {
            self.delegate?.bottomMenuSelect(data, tag: self.config.tag)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
}
