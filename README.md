# WKPullToDismiss

[![Version](https://img.shields.io/cocoapods/v/WKPullToDismiss.svg?style=flat)](https://cocoapods.org/pods/WKPullToDismiss)
[![License](https://img.shields.io/cocoapods/l/WKPullToDismiss.svg?style=flat)](https://cocoapods.org/pods/WKPullToDismiss)
[![Platform](https://img.shields.io/cocoapods/p/WKPullToDismiss.svg?style=flat)](https://cocoapods.org/pods/WKPullToDismiss)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 5.0

## Installation

WKPullToDismiss is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WKPullToDismiss'
```

## Demo

![Output sample](demo.gif)

## Quick start

Create an object of type `WKPullToDismiss` and pass the view controller to be dismissed, as well as the view which is supposed to trigger the transition.

```swift
pullToDismiss = WKPullToDismiss(viewController: self, dismissView: view)
```
If you pass `UIScrollView` as `dismissView` parameter, the scrollviews `UIPanGestureRecognizer` will be used to trigger the dismissal. Otherwise, a new `UIPanGestureRecognizer` will be created and added to the `dismissView`. Make sure that other gesture recognizers do not interfere. Additionally, make sure to hold a reference to this object in your view controller. 

**Important**: The object `WKPullToDismiss` will set itself as the transitioning delegate of the passed viewcontroller upon initialization. There is no more action required. However, in case you have multiple transitions to handle and want to set a custom transitionin delegate, read the chapter [Custom transitioning delegate](#custom-transitioning-delegate). 


## Advanced

You can make the following adjustments at runtime:
* `customScrollTriggerValue: CGFloat?`
If you are using a Scrollview as view for dismissal you can set a custom offset (Y value) at which the transition is supposed to be triggered.
By default the respective Scrollview's contentInset.top value is used.
* `isEnabled: Bool`
Defines if the pan gesture recognizer is supposed to trigger the transition. Default is `true`.
* `interactionController = WKPullToDismissInteractionController()`. The interaction controller for the transition. You can modify its `dismissThreshold` property. It defines the percentage which has to be completed in order to finish the transition. Default value is `0.3`.
* `transitionDuration: TimeInterval`. The duration of the transition. Default is `0.5` seconds.

## Custom transitioning delegate
The object `WKPullToDismiss` will set itself as the transitioning delegate of the passed view controller upon initialization. You can still change the viewcontrollers transitioning delegate afterwards to another object e.g. if you want to handle additional tranistions. This, however, requires to pass the given interaction controller and the anmiation controller of this library at the given time to the respective methods of `UIViewControllerTransitioningDelegate`:
```swift
func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?`
func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
```

This library provides the classes `WKPullToDismissInteractionController` and `WKPullToDismissAnimationController`, which have to be returned in those methods in order to make the transition work.

## Feedback

Let me know if you have any questions. Either directly or via github. I will try to respond asap.

## Author

Wojtek Kordylewski

## License

WKPullToDismiss is available under the MIT license. See the LICENSE file for more info.
