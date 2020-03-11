//
//  ViewController.swift
//  SVMExample
//
//  Created by John Crossley on 14/10/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import StatefulViewManager

private class AwesomeCustomController: UIViewController {}
private class EmptyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}

class ViewController: UIViewController {

    private let viewManager = StatefulViewManager()
    private lazy var emptyController = EmptyController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Attach the current controller to the viewManager
        viewManager.attach(to: self)

        // Bind all your controllers up.
        viewManager.bind(controller: emptyController, to: .empty)

        // Call show to `state` show the controller bound to that state
        viewManager.show(.empty)
//        viewManager.show(.loading)
//        viewManager.show(.loaded)
//        viewManager.show(.error)

//        viewManager.bind(controller: AwesomeCustomController(), to: .custom("login-failed"))

    }
}
