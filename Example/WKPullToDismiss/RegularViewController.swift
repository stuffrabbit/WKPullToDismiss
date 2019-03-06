//
//  RegularViewController.swift
//  WKPullToDismiss_Example
//
//  Created by Wojtek Kordylewski on 04.03.19.
//  Copyright © 2019 Wojtek Kordylewski. All rights reserved.
//

import UIKit
import WKPullToDismiss

class RegularViewController: UIViewController {

    var pullToDismiss: WKPullToDismiss!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullToDismiss = WKPullToDismiss(viewController: self, dismissView: view)
        // Do any additional setup after loading the view.
    }

}
