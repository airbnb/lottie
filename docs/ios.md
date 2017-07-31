## Getting Started on iOS
Lottie Uses Cocoapods and supports iOS 8 and above!

Get the Cocoapod or clone this repo and try out [the Sample App](https://github.com/airbnb/lottie-ios/tree/master/Example)
After installing the cocoapod into your project import Lottie with
`#import <Lottie/Lottie.h>`

Try with Carthage.
In your application targets “General” tab under the “Linked Frameworks and Libraries” section, drag and drop lottie-ios.framework from the Carthage/Build/iOS directory that `carthage update` produced.
### CocoaPods
Add the pod to your podfile
```
pod 'lottie-ios'
```
run
```
pod install
```

### Carthage
Install Carthage (https://github.com/Carthage/Carthage)
Add Lottie to your Cartfile
```
github "airbnb/lottie-ios" "master"
```
run
```
carthage update
```

Lottie animations can be loaded from bundled JSON or from a URL

To bundle JSON just add it and any images that the animation requires to your target in xcode.

The simplest way to use it is with LOTAnimationView:
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

Want to mask arbitrary views to animation layers in a Lottie View?
Easy-peasy as long as you know the name of the layer from After Effects

```
UIView *snapshot = [self.view snapshotViewAfterScreenUpdates:YES];
[lottieAnimation addSubview:snapshot toLayerNamed:@"AfterEffectsLayerName"];
```

Lottie comes with a `UIViewController` animation-controller for making custom viewController transitions!

```
#pragma mark -- View Controller Transitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
  LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition1"
                                                                                                          fromLayerNamed:@"outLayer"
                                                                                                            toLayerNamed:@"inLayer"];
  return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition2"
                                                                                                          fromLayerNamed:@"outLayer"
                                                                                                            toLayerNamed:@"inLayer"];
  return animationController;
}

```

If your animation will be frequently reused, `LOTAnimationView` has an built in LRU Caching Strategy.

## Swift Support

Lottie works just fine in Swift too!
Simply `import Lottie` at the top of your swift class, and use Lottie as follows

```swift
let animationView = LOTAnimationView(name: "hamburger")
self.view.addSubview(animationView)

animationView.play(completion: { finished in
    // Do Something
})
```
## Note:
Animation file name should be first added to your project. as for the above code sample, It won't work until you add an animation file called `hamburger.json`..
`let animationView = LOTAnimationView(name: "here_goes_your_json_file_name_without_.json")`

## Roadmap (In no particular order)
- Add support for interactive animated transitions
- Add support for parenting programmatically added layers, moving/scaling
- Programmatically alter animations
- Animation Breakpoints/Seekpoints
- Gradients
- LOTAnimatedButton
- Repeater objects
