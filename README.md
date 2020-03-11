# StatefulViewManager

### Basic usage
StatefulViewManager is a simple library that will make handling various states easy.

1. We need to bind our current `UIViewController` to stateful view manager. 
This can be done on `viewDidLoad()`

```swift
viewManager.attach(to: self)
```

2. Next we need to register our controllers to various states, the available states are:
`.idle`, `loading`, `.loaded`, `.error`, `.empty` and `.custom(key: String)`

You do not have to register controllers for all of them unless you're going to use them

```swift
let myEmptyController = UIViewController()
viewManager.bind(myEmptyController: emptyController, to: .empty)

let authenticationController = AuthController()
viewManager.bind(authenticationController, to: .custom("auth")
```

3. Then simply call show to have that view switched out

```swift
viewManager.show(.empty)

viewManager.show(.custom("auth"))
```

✌️
