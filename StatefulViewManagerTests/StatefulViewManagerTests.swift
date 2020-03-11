//
//  StatefulViewManagerTests.swift
//  StatefulViewManagerTests
//
//  Created by John Crossley on 14/10/2018.
//  Copyright © 2018 - 2020 John Crossley. All rights reserved.
//

import XCTest
@testable import StatefulViewManager

private final class RootViewController: UIViewController {}

private final class MyCustomErrorController: UIViewController {}
private final class MyCustomEmptyController: UIViewController {}
private final class MyCustomLoadingController: UIViewController {}

class StatefulViewManagerTests: XCTestCase {

    var manager: StatefulViewManager!
    var rootController: UIViewController!

    override func setUp() {
        super.setUp()
        rootController = UIViewController()
        manager = StatefulViewManager()

        manager.bind(controller: MyCustomErrorController(), to: .error)
        manager.bind(controller: MyCustomEmptyController(), to: .empty)
        manager.bind(controller: MyCustomLoadingController(), to: .loading)
        manager.attach(to: rootController)
    }

    func testItIsIdleByDefault() {
        XCTAssertEqual(manager.state, .idle)
    }

    func testItCanChangeToAnEmptyState() {
        let emptyController = MyCustomEmptyController()
        manager.bind(controller: emptyController, to: .empty)
        manager.show(.empty)

        let controller = manager.rootController?.children[0]
        XCTAssertEqual(controller, emptyController)
    }

    func testItCanChangeToAnLoadingState() {
        let loadingController = MyCustomLoadingController()
        manager.bind(controller: loadingController, to: .loading)
        manager.show(.loading)

        let controller = manager.rootController?.children[0]
        XCTAssertEqual(controller, loadingController)
    }

    func testItCanAddErrorController() {
        let errorController = MyCustomEmptyController()

        manager.bind(controller: errorController, to: .error)
        manager.show(.error)

        let controller = manager.rootController?.children[0]
        XCTAssertEqual(errorController, controller)
    }

    func testItCanHandleCustomStates() {
        let customStateIdentifier = "sad-ping-pong-ball"
        let randomController = UIViewController()
        manager.bind(controller: randomController, to: .custom(customStateIdentifier))
        manager.show(.custom(customStateIdentifier))

        let controller = manager.rootController?.children[0]
        XCTAssertEqual(randomController, controller)
    }

    func testItRemovesCustomStatusViewsWhenTransitioningToLoaded() {
        let customStateIdentifier = "sad-ping-pong-ball"
        let randomController = UIViewController()
        manager.bind(controller: randomController, to: .custom(customStateIdentifier))
        manager.show(.custom(customStateIdentifier))
        manager.show(.loaded)

        XCTAssert(manager.rootController!.children.isEmpty)
    }

    func testItRemovesLoadingStatusControllerWhenTransitioningToLoaded() {
        manager.bind(controller: .init(), to: .loading)
        manager.show(.loading)

        XCTAssertFalse(manager.rootController!.children.isEmpty)

        manager.show(.loaded)

        XCTAssert(manager.rootController!.children.isEmpty)
    }

    func testItRemovesErrorStatusControllerWhenTransitioningToLoaded() {
        manager.bind(controller: .init(), to: .error)
        manager.show(.error)

        XCTAssertFalse(manager.rootController!.children.isEmpty)

        manager.show(.loaded)

        XCTAssert(manager.rootController!.children.isEmpty)
    }

    func testItRemovesEmptyStatusControllerWhenTransitioningToLoaded() {
        manager.bind(controller: .init(), to: .empty)
        manager.show(.empty)

        XCTAssertFalse(manager.rootController!.children.isEmpty)

        manager.show(.loaded)

        XCTAssert(manager.rootController!.children.isEmpty)
    }
}
