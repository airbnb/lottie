# Getting Started
Lottie Uses Cocoapods, Carthage, Static and Dynamic modules.
Lottie supports iOS 8+ and MacOS 10.10+

# Installing Lottie

## Github Repo
You can pull the [Lottie Github Repo](https://github.com/airbnb/lottie-ios/) and include the Lottie.xcodeproj to build a dynamic or static library.

## Cocoapods
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

## Carthage
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

# iOS Sample App

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

# View Controller Transitions

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

# Dynamic Properties

Lottie can do more than just play beautiful animations. Lottie allows you to **change** animations at runtime. Changing animations is done through Lottie's dynamic properties API. The dynamic properties API features a class for searching through animation data, `LOTKeypath`, a protocol for setting animation data `LOTValueDelegate`, several helper objects for common animation scenarios `LOTValueCallback`, `LOTBlockCallback`, `LOTInterpolatorCallback`, and finally a method for setting animation delegates on `LOTAnimationView` `setValueDelegate:forKeypath:`.

##LOTKeypath

To understand how to change animation properties in Lottie, you should first understand how animation properties are stored in Lottie.
Animation properties are stored in a data tree that mimics the information heirarchy of After Effects. In After Effects a `Composition` is a collection of `Layers` that each have their own timelines. `Layer` objects have string names, and their contents can be an image, shape layers, fills, strokes, or just about anything that is drawable. Each object in After Effects has a name. Lottie can find these objects and properties by their name using a `LOTKeypath`. A `LOTKeypath` is an object initialized with a list of `String` names. `LOTKeypath`  is used to search the backing animation data for properties and objects. Keypath string names should match the names used for layers and objects in the animation data.

Wildcards (\*) and Globstars (\*\*) can be used to search through keypaths. Wildcards will search through a single depth layer, globstars will search any depth.

###Creating a LOTKeypath

`LOTKeypath` is initialized with either a list of strings (Objective-C only), or a single dot-seperated string.
As an example, lets say we have an animation with a layer named `Boat` and we want to target its `Position` property.

![Boat_Props](/images/Boat_Loader_Props.png)

We can search for it explicitly by creating a keypath that targets `Boat.Transform.Position`

####Swift
```swift
let keypath = LOTKeypath(string: "Boat.Transform.Position")
```
####Objective-C
```objectivec
LOTKeypath *keypath = [LOTKeypath keypathWithKeys:@"Boat", @"Transform", @"Position", nil];
//  ----OR-----
LOTKeypath *keypath = [LOTKeypath keypathWithString@"Boat.Transform.Position"];
```

###Using Wildcards

Suppose you are interested in changing the color of any shape group named `Fish` in the Animation. You can do this with Globstars, or double wild cards.

####Swift
```swift
let keypath = LOTKeypath(string: "**.Fish.Fill.Color")
```
####Objective-C
```objectivec
LOTKeypath *keypath = [LOTKeypath keypathWithKeys:@"**", @"Fish", @"Fill", @"Color", nil];
//  ----OR-----
LOTKeypath *keypath = [LOTKeypath keypathWithString@"*.Fish.Fill.Color"];
```

##LOTValueDelegate

`LOTValueDelegate` is a collection of 5 protocols used to provide new animation data for a given `LOTKeypath` search.
A value delegate is called every frame while an animation plays and requests the override data for the given property. The delegate is given the current frame of the animation, and the animation property's current data. If animation already existed for the property the delegate is given the leading and trailing keyframe as well as the current interpolated progress. Each of the 5 protocols returns a different type of animated data.

The protocols are `LOTColorValueDelegate`, `LOTNumberValueDelegate`, `LOTPointValueDelegate`, `LOTSizeValueDelegate`, `LOTPathValueDelegate`.

##Predefined LOTValueDelegate Objects

Lottie contains several predefined objects that conform to `LOTValueDelegate` that support a number of basic operations. There are three types of objects, `LOTValueCallback`, `LOTBlockCallback`, and `LOTInterpolatorCallback`. Each type contains an object for a specific data type. Example `LOTValueCallback` contains `LOTNumberValueCallback`, `LOTColorValueCallback`, etc.

###LOTValueCallback

`LOTValueCallbacks` are used to simply set a value. Each object has a property for its data type that can be set. While the animaiton is playing, Lottie will set the keypath to the value specified by the value callback. There are 5 different value callback objects: `LOTColorValueCallback`, `LOTNumberValueCallback`, `LOTPointValueCallback`, `LOTSizeValueCallback`, `LOTPathValueCallback`.

Example:
####Swift
```swift
let colorCallback = LOTColorValueCallback(color:UIColor.blueColor.CGColor)
```
####Objective-C
```objectivec
LOTColorValueCallback *colorCallback = [LOTColorValueCallback withCGColor:[UIColor blueColor].CGColor];
```

###LOTBlockCallback

`LOTBlockCallback` is similar to valueCallback, but instead holds a block or closure that is called every frame for the property. There are 5 different block callback objects: `LOTColorBlockCallback`, `LOTNumberBlockCallback`, `LOTPointBlockCallback`, `LOTSizeBlockCallback`, `LOTPathBlockCallback`.

Example:
####Swift
```swift
let colorBlock = LOTColorBlockCallback { (currentFrame, startKeyFrame, endKeyFrame, interpolatedProgress, startColor, endColor, interpolatedColor) -> Unmanaged<CGColor> in
	return aColor
}
```
####Objective-C
```objectivec
LOTColorBlockCallback *colorBlock = [LOTColorBlockCallback withBlock:^CGColorRef _Nonnull(CGFloat currentFrame, CGFloat startFrame, CGFloat endFrame, CGFloat interpolatedProgress, CGColorRef  _Nullable startColor, CGColorRef  _Nullable endColor, CGColorRef  _Nullable interpolatedColor) {
    return aColor;
}];
```

###LOTInterpolatorCallback

`LOTInterpolatorCallback` is used to interpolate between two values using a progress from 0 to 1. Each Interpolator contains a startValue, endvalue, and a currentProgress. When currentProgress is changed externally, the property is set with the interpolated value. There are 5 different interpolator callback objects: `LOTColorInterpolatorCallback`, `LOTNumberInterpolatorCallback`, `LOTPointInterpolatorCallback`, `LOTSizeInterpolatorCallback`, `LOTPathInterpolatorCallback`.

Example:
####Swift
```swift
let positionInterpolator = LOTPointInterpolatorCallback(from: startPoint, to: endPoint)
positionInterpolator.currentProgress = 0.5
// Sets the position to the halfway point between start and end point.
```
####Objective-C
```objectivec
LOTPointInterpolatorCallback *positionInterpolator = [LOTPointInterpolatorCallback withFromPoint:startPoint toPoint:endPoint];
positionInterpolator.currentProgress = 0.5;
// Sets the position to the halfway point between start and end point.
```

##Setting a Value Delegate

After creating a `LOTKeypath` and a `LOTValueDelegate` it is possible to set the delegate on an existing `LOTAnimationView`.

`setValueDelegate:forKeypath:` will search through the exisiting animation view, and set the `valueDelegate` on each property that matches the `keypath`. The animation will be forced to redraw. An exception will be thrown if the data type of the property does not match the data type of the delegate (Example: setting number delegate on color property).

**NOTE** `LOTAnimationView` maintains a WEAK reference to the delegate. This helps reduce retain cycles. You must maintain a reference to the delegate to keep it in memory.

##Example

Say we want to create 4 toggle switches.
![Toggle](/images/switch_Normal.gif)
<br />
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
## Now lets change their colors
![Recolored Toggle](/images/switch_BgColors.gif)
```swift
// Create a LOTKeypath
let keypath = LOTKeypath(string: "BG-On.Group 1.Fill 1.Color")

// Create some Color Values
let greenColorValue = LOTColorValueCallback(color:UIColor.green.CGColor)
let redColorValue = LOTColorValueCallback(color:UIColor.red.CGColor)
let orangeColorValue = LOTColorValueCallback(color:UIColor.orange.CGColor)

// Now set them on the animations.
animationView2.setValueDelegate(greenColorValue for:keypath)
animationView3.setValueDelegate(redColorValue for:keypath)
animationView4.setValueDelegate(orangeColorValue for:keypath)
```

The keyPath is a dot seperated path of layer and property names from After Effects.
![Key Path](/images/aftereffectskeypath.png)
"BG-On.Group 1.Fill 1.Color"

## Now lets change a couple of properties
![Multiple Colors](/images/switch_MultipleBgs.gif)
```swift
let onKeypath = LOTKeypath(string: "BG-On.Group 1.Fill 1.Color")
let offKeypath = LOTKeypath(string: "BG-Off.Group 1.Fill 1.Color")
animationView2.setValueDelegate(greenColorValue for:onKeypath)
animationView2.setValueDelegate(redColorValue for:offKeypath)
```

---

# [Dynamic Properties Tutorial](/ios_dynamic_properties_tutorial.md)

---

# Adding Views to an Animation at Runtime

Not only can you [change animations at runtime](/ios?id=dynamic-properties) with Lottie, you can also add custom UI to a LOTAnimation at runtime.
The example below shows some advance uses of this to create a dynamic image loader.

## A Dynamic Image Loading Spinner

![Spinner](/images/spinner.gif)

The example above shows a single LOTAnimationView that is set with a loading spinner animation. The loading spinner loops a portion of its animation while an image is downloaded asynchronously. When the download is complete, the image is added to the animation and the rest of the animation is played seamlessly. The image is cleanly animated in and a completion block is called.

![Spinner_Alt](/images/spinner_Alternative.gif)

Now, the animation has been changed by a designer and needs to be updated. All that is required is updating the JSON file in the bundle. No code change needed!

![Spinner_Dark](/images/spinner_DarkMode.gif)

Here, the design has decided to add a 'Dark Mode' to the app. Just a few lines of code change the color of the animation at runtime.


Pretty powerful eh?

Check out the code below for an example!
Download the After Effects file [here](/AEP/LoadingSpinner.zip)

```swift

import UIKit
import Lottie

class ViewController: UIViewController {

  var animationView: LOTAnimationView = LOTAnimationView(name: "SpinnerSpin")
  var colorCallback = LOTColorValueCallback(color: UIColor.darkGray.cgColor)
  var maskOpacityCallback = LOTNumberValueCallback(number: 0)

  override func viewDidLoad() {
    super.viewDidLoad()

    // Setup our animaiton view
    animationView.contentMode = .scaleAspectFill
    animationView.frame = CGRect(x: 20, y: 20, width: 200, height: 200)

    self.view.addSubview(animationView)
    // Lets change some of the properties of the animation
    // We arent going to use the MaskLayer, so lets just hide it

    let maskKeypath = LOTKeypath(string: "MaskLayer.Ellipse 1.Transform.Opacity")
    animationView.setValueDelegate(maskOpacityCallback, for: maskKeypath)

    // All of the strokes and fills are white, lets make them DarkGrey
    animationView.setValueDelegate(colorCallback, for: LOTKeypath(string: "OuterRing.Stroke.Color"))
    animationView.setValueDelegate(colorCallback, for: LOTKeypath(string: "InnerRing.Stroke.Color"))
    animationView.setValueDelegate(colorCallback, for: LOTKeypath(string: "InnerRing.Fill.Color"))

    // Lets turn looping on, since we want it to repeat while the image is 'Downloading'
    animationView.loopAnimation = true
    // Now play from 0 to 0.5 progress and loop indefinitely.
    animationView.play(fromProgress: 0, toProgress: 0.5, withCompletion: nil)

    // Lets simulate a download that finishes in 4 seconds.
    let dispatchTime = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
      self.simulateImageDownloaded()
    }
  }

  func simulateImageDownloaded() {
    // Our downloaded image
    let image = UIImage(named: "avatar.jpg")
    let imageView = UIImageView(image: image)

    let layerKeypath = LOTKeypath(string: "TransformLayer")

    // We want the image to show up centered in the animation view at 150Px150P
    // Convert that rect to the layers animations coordinate space
    let imageRect = animationView.convert(CGRect(x: 0, y: 0, width: 150, height: 150), toKeypathLayer:layerKeypath)

    // Setup our image view with the rect and add rounded corners
    imageView.frame = imageRect
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = imageRect.width / 2;

    // Now we set the completion block on the currently running animation
    animationView.completionBlock = { (result: Bool) in ()
      // Add the image view to the layer named "TransformLayer"
      self.animationView.addSubview(imageView, toKeypathLayer: layerKeypath)
      // Now play the last half of the animation
      self.animationView.play(fromProgress: 0.5, toProgress: 1, withCompletion: { (complete: Bool) in
        // Now the animation has finished and our image is displayed on screen
        print("Image Downloaded and Displayed")
      })
    }

    // Turn looping off. Once the current loop finishes the animation will stop
    // and the completion block will be called.
    animationView.loopAnimation = false
  }

}

```