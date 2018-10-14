//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol ErrorViewDelegate: class {
    func didSelectRetry()
}

class ErrorView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!

    weak var delegate: ErrorViewDelegate?

    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func didSelectRetry() {
        delegate?.didSelectRetry()
    }
}
