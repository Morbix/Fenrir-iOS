# Fenrir (WIP)

Fenrir is an Analytics companion that automatically tracks every UIButton / UIBarButtonItem / UITapGestured view in your app and generates events whenever they are touched - including time and name of the screen it happened, with minimal setup. Ideally, you should be using it alongside a system that can parse it's data into usage graphs.

To start Fenrir, add this to your AppDelegate:
```swift
Fenrir.instance.isTracking = true
Fenrir.instance.debugMode = true //Prints logs
Fenrir.instance.stackAmount = 3 //Optional - Amount of events to stack before firing the handler. Default is 1. You can set nil to only send events after the app goes into background.
Fenrir.instance.eventHandler = { event in
  print(event)
  //Send the event to your analytics providers, like Google Analytics
}
```


## Tracking: Tags

Although Fenrir tracks button touches automatically, you should tag your buttons/views to allow Fenrir to generate events that make sense to you.
```swift
let button = UIButton()
button.fenrirTag = "subscriptionButton"
```
`.fenrirTag` is a property from the `FenrirTrackeable` protocol. By default, every UIView and it's subclasses implement this protocol. If for some reason you want to track something that is not touchable, you can add this protocol to your class and then manually call the touch event:
```swift
Fenrir.instance.register(touchOn: someObject)
```


## Tracking: Flow

To generate more detailed events, you can also manually track your app's flow in order to Fenrir to be able to be to tell where a certain action happened.
For example, here we're tracking a View Controller:
```swift
override func viewDidAppear(_ animated: Bool) {
  Fenrir.instance.registerFlow(self)
}
```


## License

Fenrir is released under the MIT license. See LICENSE for details.
