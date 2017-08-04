## Getting Started on iOS or MacOS
Lottie Uses Cocoapods, Carthage, Static and Dynamic modules.
Lottie supports iOS 8+ and MacOS 10.10+

## Installing Lottie

### Github Repo
You can pull the [Lottie Github Repo](https://github.com/airbnb/lottie-ios/) and include the Lottie.xcodeproj to build a dynamic or static library.

### Cocoapods
Get [Cocoapods](https://cocoapods.org/)
Add the pod to your podfile
```
pod 'lottie-ios'
```
run
```
pod install
```

After installing the cocoapod into your project import Lottie with
 Objective C
`#import <Lottie/Lottie.h>`
Swift
`import Lottie`

### Carthage
Get [Carthage](https://github.com/Carthage/Carthage)

Add Lottie to your Cartfile
```
github "airbnb/lottie-ios" "master"
```
run
```
carthage update
```

In your application targets “General” tab under the “Linked Frameworks and Libraries” section, drag and drop lottie-ios.framework from the Carthage/Build/iOS directory that `carthage update` produced.

## iOS Sample App

Clone this repo and try out [the Sample App](https://github.com/airbnb/lottie-ios/tree/master/Example)
The repo can build a MacOS Example and an iOS Example

The iOS Example App demos several of the features of Lottie

![Example 1](/images/iosexample1.png)![Example 2](/images/iosexample2.png)
![Example 3](/images/iosexample3.png)

The animation Explorer allows you to scrub, play, loop, and resize animations.
Animations can be loaded from the app bundle or from [Lottie Files](http://www.lottiefiles.com) using the built in QR Code reader.

## MacOS Sample App

Clone this repo and try out [the Sample App](https://github.com/airbnb/lottie-ios/tree/master/Example)
The repo can build a MacOS Example and an iOS Example

![Lottie Viewer](/images/macexample.png)

The Lottie Viewer for MacOS allows you to drag and drop JSON files to open, play, scrub and loop animations. This app is backed by the same animation code as the iOS app, so you will get an accurate representation of Mac and iOS animations.


## Objective C Examples


Lottie animations can be loaded from bundled JSON or from a URL
To bundle JSON just add it and any images that the animation requires to your target in xcode.

```
LOTAnimationView *animation = [LOTAnimationView animationNamed:@"Lottie"];
[self.view addSubview:animation];
[animation playWithCompletion:^(BOOL animationFinished) {
  // Do Something
}];
```

If you are working with multiple bundles you can use.

```
LOTAnimationView *animation = [LOTAnimationView animationNamed:@"Lottie" inBundle:[NSBundle YOUR_BUNDLE]];
[self.view addSubview:animation];
[animation playWithCompletion:^(BOOL animationFinished) {
  // Do Something
}];
```

Or you can load it programmatically from a NSURL
```
LOTAnimationView *animation = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:URL]];
[self.view addSubview:animation];
```

Lottie supports the iOS `UIViewContentModes` aspectFit, aspectFill and scaleFill

You can also set the animation progress interactively.
```
CGPoint translation = [gesture getTranslationInView:self.view];
CGFloat progress = translation.y / self.view.bounds.size.height;
animationView.animationProgress = progress;
```

Or you can play just a portion of the animation:
```
[lottieAnimation playFromProgress:0.25 toProgress:0.5 withCompletion:^(BOOL animationFinished) {
// Do Something
}];
```
## Swift Examples

Lottie animations can be loaded from bundled JSON or from a URL
To bundle JSON just add it and any images that the animation requires to your target in xcode.

```swift
let animationView = LOTAnimationView(name: "LottieLogo")
self.view.addSubview(animationView)
animationView.play()
```

If your animation is in another bundle you can use
```swift
let animationView = LOTAnimationView(name: "LottieLogo" bundle:yourBundle)
self.view.addSubview(animationView)
animationView.play()
```

Or you can load it asynchronously from a URL
```swift
let animationView = LOTAnimationView(contentsOf: WebURL)
self.view.addSubview(animationView)
animationView.play()
```

You can also set the animation progress interactively.
```swift
let translation = gesture.getTranslationInView(self.view)
let progress = translation.y / self.view.bounds.size.height;
animationView.animationProgress = progress
```

Or you can play just a portion of the animation:
```swift
animationView.play(fromProgress: 0.25, toProgress: 0.5, withCompletion: nil)
```

## iOS View Controller Transitioning

Lottie comes with a `UIViewController` animation-controller for making custom viewController transitions!

```
#pragma mark -- View Controller Transitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition1"
                                                                                                          fromLayerNamed:@"outLayer"
                                                                                                            toLayerNamed:@"inLayer"
                                                                                                 applyAnimationTransform:NO];
  return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition2"
                                                                                                          fromLayerNamed:@"outLayer"
                                                                                                            toLayerNamed:@"inLayer"
                                                                                                 applyAnimationTransform:NO];
  return animationController;
}

```

## Changing Animations At Runtime

Lottie can do more than just play beautiful animations. Lottie allows you to **change** animations at runtime.

### Say we want to create 4 toggle switches.
![Toggle](/images/switch_Normal.gif)
Its easy to create the four switches and play them:
```swift
let animationView = LOTAnimationView(name: "toggle");
self.view.addSubview(animationView)
animationView.frame.origin.x = 40
animationView.frame.origin.y = 20
animationView.autoReverseAnimation = true
animationView.loopAnimation = true
animationView.play()

let animationView2 = LOTAnimationView(name: "toggle");
self.view.addSubview(animationView2)
animationView2.frame.origin.x = 40
animationView2.frame.origin.y = animationView.frame.maxY + 4
animationView2.autoReverseAnimation = true
animationView2.loopAnimation = true
animationView2.play()

let animationView3 = LOTAnimationView(name: "toggle");
self.view.addSubview(animationView3)
animationView3.frame.origin.x = 40
animationView3.frame.origin.y = animationView2.frame.maxY + 4
animationView3.autoReverseAnimation = true
animationView3.loopAnimation = true
animationView3.play()

let animationView4 = LOTAnimationView(name: "toggle");
self.view.addSubview(animationView4)
animationView4.frame.origin.x = 40
animationView4.frame.origin.y = animationView3.frame.maxY + 4
animationView4.autoReverseAnimation = true
animationView4.loopAnimation = true
animationView4.play()

```
### Now lets change their colors
![Recolored Toggle](/images/switch_BgColors.gif)
```swift
animationView2.setValue(UIColor.green, forKeypath: "BG-On.Group 1.Fill 1.Color", atFrame: 0)
animationView3.setValue(UIColor.red, forKeypath: "BG-On.Group 1.Fill 1.Color", atFrame: 0)
animationView4.setValue(UIColor.orange, forKeypath: "BG-On.Group 1.Fill 1.Color", atFrame: 0)
```
The keyPath is a dot seperated path of layer and property names from After Effects.
![Key Path](/images/aftereffectskeypath.png)
"BG-On.Group 1.Fill 1.Color"

### Now lets change a couple of properties
![Multiple Colors](/images/switch_MultipleBgs.gif)
```swift
animationView2.setValue(UIColor.green, forKeypath: "BG-On.Group 1.Fill 1.Color", atFrame: 0)
animationView2.setValue(UIColor.red, forKeypath: "BG-Off.Group 1.Fill 1.Color", atFrame: 0)
```

Lottie allows you to change **any** property that is animatable in After Effects. If a keyframe does not exist, a linear keyframe is created for you. If a keyframe does exist then just its data is replaced.
