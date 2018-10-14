//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

public protocol StatefulViewManagerDelegate: class {
    func didSelectRetry()
}

public class StatefulViewManager {

    weak var rootView: UIView?
    public weak var delegate: StatefulViewManagerDelegate?

    private var state: State = .idle

    private lazy var loadingView: LoadingView = {
        let view: LoadingView = .fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var reloadingView: ReloadingView = {
        let view = ReloadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let errorView: ErrorView = {
        let view: ErrorView = .fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emptyView: EmptyView = {
        let view: EmptyView = .fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    enum State {
        case idle
        case loading
        case loaded
        case error
        case empty
    }

    public init() {
        #warning("TODO - The ability to set a theme")
        errorView.delegate = self
    }

    public func attach(to view: UIView) {
        self.rootView = view
    }

    public func error() {
        if state == .loaded {
            return
        }
        state = .error
        transition(to: errorView)
    }

    public func empty() {
        state = .empty
        transition(to: emptyView)
    }

    public func loading() {
        defer { state = .loading }

        if state == .loaded {
            transition(to: reloadingView)
            return
        }

        transition(to: loadingView)
    }

    public func loaded() {
        state = .loaded
        removeStatusViews()
    }

    private func transition(to view: UIView) {
        guard let rootView = rootView else { return }
        removeStatusViews()

        rootView.addSubview(view)

        view.leadingAnchor.constraint(equalTo: rootView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: rootView.trailingAnchor).isActive = true
    }

    private func removeStatusViews() {
        loadingView.removeFromSuperview()
        errorView.removeFromSuperview()
        reloadingView.removeFromSuperview()
        emptyView.removeFromSuperview()
    }

}

extension StatefulViewManager: ErrorViewDelegate {
    func didSelectRetry() {
        delegate?.didSelectRetry()
    }
}
