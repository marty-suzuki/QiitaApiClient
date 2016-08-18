//
//  ViewController.swift
//  QiitaApiClientSample
//
//  Created by 鈴木大貴 on 2016/08/17.
//  Copyright © 2016年 szk-atmosphere. All rights reserved.
//

import UIKit
import QiitaApiClient

class ViewController: UIViewController {

    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if loaded { return }
        loaded = true
        QiitaApiClient.sharedClient.request(.Get(.AuthenticatedUser), success: { dict in
            print(dict)
        }, failure: nil)
    }
}

