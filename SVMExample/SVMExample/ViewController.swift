//
//  ViewController.swift
//  SVMExample
//
//  Created by John Crossley on 14/10/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import StatefulViewManager

class ViewController: UIViewController {

    private let viewManager = StatefulViewManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewManager.delegate = self

        viewManager.attach(to: self.view)

//        viewManager.startLoading()
//        viewManager.finishLoading()
//        viewManager.startLoading()
//        viewManager.hasErrored()
        viewManager.empty()

    }
}

extension ViewController: StatefulViewManagerDelegate {
    func didSelectRetry() {
        print(">>> You pressed me")
    }
}
