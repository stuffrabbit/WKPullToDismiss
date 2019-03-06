//
//  TableViewController.swift
//  WKPullToDismiss_Example
//
//  Created by Wojtek Kordylewski on 06.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WKPullToDismiss

class TableViewController: UITableViewController {
    var pullToDismiss: WKPullToDismiss!

    override func viewDidLoad() {
        super.viewDidLoad()
        pullToDismiss = WKPullToDismiss(viewController: self, dismissView: tableView)
        // Set custom scroll trigger value, if necessary. Otherwise the transition will trigger as
        // soon as the scrollview scrolls below its contentInset.top value
        // pullToDismiss.customScrollTriggerValue = 100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Disable the interactive dismissal functionality whenever necessary
        // pullToDismiss.isEnabled = false
    }
}
