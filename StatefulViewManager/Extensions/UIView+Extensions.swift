//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

extension UIView {
    static func fromNib<T>() -> T {
        guard let instance = Bundle(for: self)
            .loadNibNamed(String(describing: T.self), owner: self, options: nil)?.first as? T else {
                fatalError("Unable to load instance from nib. \(String(describing: T.self))")
        }

        return instance
    }
}
