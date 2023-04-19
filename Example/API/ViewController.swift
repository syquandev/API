//
//  ViewController.swift
//  API
//
//  Created by 95286760 on 04/19/2023.
//  Copyright (c) 2023 95286760. All rights reserved.
//

import UIKit
import API
import Core

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func api(){
        let rq = AuthAPI.Login()
        HUDLoading.showLoading(self.view,.infinity)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            rq.request { status, model in
                HUDLoading.dismiss()
                if status.isError{
                    HUDBuilder.showAlert(message: status.message)
                }
                else{
                    print(status.code)
                    print(model?.name)
                }
            }
        }
        
    }
}

