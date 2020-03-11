//
//  Copyright © 2018 - 2020 John Crossley. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, animated: Bool) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = view.bounds
        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        if animated {
            child.view.layer.opacity = 0
            UIView.animate(withDuration: 0.2) {
                child.view.layer.opacity = 1
            }
        }
        child.didMove(toParent: self)
    }

    func remove(animated: Bool) {
        guard parent != nil else { return }
        willMove(toParent: nil)
        if animated {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.view.layer.opacity = 0
            }
        }
        view.removeFromSuperview()
        removeFromParent()
    }
}
