# Fenrir

[![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/Fenrir/badge.png)](http://cocoadocs.org/docsets/Fenrir)
[![GitHub release](https://img.shields.io/github/tag/movile/fenrir-ios.svg)](https://github.com/Movile/Fenrir-iOS/releases)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Movile/Fenrir-iOS/master/Fenrir/LICENSE)

Fenrir is an Analytics companion that automatically (or manually) tracks your app and generates events whenever it's buttons/cells/gestured views are touched - including time and name of the screen it happened, with minimal setup. Ideally, you should be using it alongside a system that can parse it's data into usage graphs.

To use Fenrir, tag your views with the `.fenrirTag` property:
```swift
let button = UIButton()
button.fenrirTag = "subscriptionButton"
```
and start it at your AppDelegate:
```swift
Fenrir.instance.isTracking = true
Fenrir.instance.debugMode = true // Prints logs
Fenrir.instance.stackAmount = 3 // Optional - Amount of events to stack before firing the handler. Default is 1. You can set nil to only send events after the app goes into background.
Fenrir.instance.eventHandler = { event in
  print(event)
  //Send the event to your analytics providers, like Google Analytics
}
```
If you're using a custom `stackAmount` and not going to use automatic mode, add these calls as well:
```swift
func applicationDidEnterBackground(_ application: UIApplication) {
  Fenrir.instance.dispatchEventsIfNeeded()
}

func applicationWillTerminate(_ application: UIApplication) {
  Fenrir.instance.dispatchEventsIfNeeded()
}
```

## Manual Tracking: Touch

Send manual events to Fenrir by calling:
```swift
Fenrir.instance.register(touchOn: someObject)
```
`register()` accepts a `FenrirTrackeable` object. By default, every UIView and it's subclasses implement this protocol, but if for some reason you want to track something that is not touchable, you can add this protocol to your it and then manually call this method.
Alternatively, you can call it directly with a tag:
```swift
Fenrir.instance.register(touchWithTag: "aButton")
```

## Manual Tracking : Flow

To generate detailed events, you can also manually track your app's flow in order to Fenrir to be able to be to tell where a certain action happened.
For example, here we're tracking a View Controller:
```swift
override func viewDidAppear(_ animated: Bool) {
  super.viewDidAppear(animated)
  Fenrir.instance.registerFlow(self)
}
```
This will add `self`'s Class's name as an event parameter.

## Automatic Tracking

Fenrir can [swizzle](http://nshipster.com/method-swizzling/) every revelant call from your app in order to do all the tracking for you, without you having to call the `register()`, `registerFlow()` and `dispatchEventsIfNeeded()` methods. **Although this sounds really cool, it's currently very error prone and can cause nasty, untraceable side-effects to your app. Consider using it only when you're sure your app is working as intended.**

You can enable automatic tracking by adding a `fenrirAutoMode` boolean at your `Info.plist`:
<img src=http://i.imgur.com/EYZNi8r.png>

### Automatic Tracking requirements


To use automatic tracking at it's maximum potential, a few changes might need to be done.

**UITableViewDelegates:** To track cell touches automatically, overrides of `tableView(_:didSelectRowAt:)` must call `super.tableView(_:didSelectRowAt:)`. This is because Fenrir swizzles only the original call.

**Navigation Buttons:** Although no changes are needed in order to detect the touches, you might want to init your UIBarButtonItems with the `customView:` initializer. Since you can't access it's internal button, this is the only way of putting a `fenrirTag` inside a navigation button in Fenrir's automatic mode.

**Flow Tracking:** Like UITableViewDelegates, overrides of `viewDidAppear(_:)` must call `super.viewDidAppear(_:)`, as the swizzle happens at the original UIViewController.

## Installation


Using [CocoaPods](http://cocoapods.org/):

```ruby
use_frameworks!
pod 'Fenrir'
```

## License

Fenrir is released under the MIT license. See LICENSE for details.
