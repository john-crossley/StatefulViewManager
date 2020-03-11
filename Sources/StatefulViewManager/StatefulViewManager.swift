//
//  Copyright © 2018 - 2020 John Crossley. All rights reserved.
//

#if canImport(UIKit)
import UIKit

open class StatefulViewManager {
    public typealias CustomStateIdentifier = String

    public enum State: Equatable {
        case idle, loading, loaded, error, empty
        case custom(CustomStateIdentifier)
    }

    private(set) var state = State.idle

    private(set) weak var rootController: UIViewController?

    private var loadingController: UIViewController
    private var errorController: UIViewController
    private var emptyController: UIViewController

    private var customControllers: [CustomStateIdentifier: UIViewController] = [:]

    public init() {
        self.loadingController = UnimplementedLoadingController()
        self.errorController = UnimplementedErrorController()
        self.emptyController = UnimplementedEmptyController()

        bind(controller: loadingController, to: .loading)
        bind(controller: errorController, to: .error)
        bind(controller: emptyController, to: .empty)
    }

    open func show(_ state: State, animated: Bool = false) {
        self.state = state

        switch state {
        case .idle: break
        case .loading: transition(to: loadingController, animated: animated)
        case .loaded: removeControllers(animated: animated)
        case .error: transition(to: errorController, animated: animated)
        case .empty: transition(to: emptyController, animated: animated)
        // Special case
        case .custom(let customState):
            guard let controller = customControllers[customState] else { return }
            transition(to: controller, animated: animated)
        }
    }

    open func bind(controller: UIViewController, to state: State) {
        switch state {
        case .idle: break
        case .loading: loadingController = controller
        case .loaded: break
        case .error: errorController = controller
        case .empty: emptyController = controller
        case .custom(let customState): customControllers[customState] = controller
        }
    }

    open func attach(to rootController: UIViewController) {
        self.rootController = rootController
    }

    private func transition(to controller: UIViewController, animated: Bool) {
        guard let rootController = self.rootController else { return }
        removeControllers(animated: animated)
        rootController.add(controller, animated: animated)
    }

    private func removeControllers(animated: Bool) {
        loadingController.remove(animated: animated)
        errorController.remove(animated: animated)
        emptyController.remove(animated: animated)
        customControllers.forEach { (_, controller) in
            controller.remove(animated: animated)
        }
    }
}
#endif
