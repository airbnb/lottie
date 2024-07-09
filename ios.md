# Supported Platforms

The [lottie-ios](https://github.com/airbnb/lottie-ios) package supports iOS, macOS, tvOS, and visionOS.

# Installing Lottie

Lottie supports [Swift Package Manager](https://www.swift.org/package-manager/), [CocoaPods](https://cocoapods.org/), and [Carthage](https://github.com/Carthage/Carthage) (Both dynamic and static).

## Github Repo

You can pull the [Lottie Github Repo](https://github.com/airbnb/lottie-ios/) and include the `Lottie.xcodeproj` to build a dynamic or static library.

## Swift Package Manager

To install Lottie using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the Lottie repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter https://github.com/airbnb/lottie-spm.git

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.3.3")
```

When using Swift Package Manager we recommend using the [lottie-spm](https://github.com/airbnb/lottie-spm) repo instead of the main lottie-ios repo.  The main git repository for [lottie-ios](https://github.com/airbnb/lottie-ios) is somewhat large (300+ MB), and Swift Package Manager always downloads the full repository with all git history. The [lottie-spm](https://github.com/airbnb/lottie-spm) repo is much smaller (less than 500kb), so can be downloaded much more quickly. 

Instead of downloading the full git history of Lottie and building it from source, the lottie-spm repo just contains a pointer to the precompiled XCFramework included in the [latest lottie-ios release](https://github.com/airbnb/lottie-ios/releases/latest) (typically ~8MB). If you prefer to include Lottie source directly your project, you can directly depend on the main lottie-ios repo by referencing `https://github.com/airbnb/lottie-ios.git` instead.

## CocoaPods
Add the pod to your Podfile:
```ruby
pod 'lottie-ios'
```

And then run:
```ruby
pod install
```
After installing the cocoapod into your project import Lottie with
```swift
import Lottie
```

## Carthage
Add Lottie to your Cartfile:
```
github "airbnb/lottie-ios" "master"
```

And then run:
```
carthage update
```
In your application targets “General” tab under the “Linked Frameworks and Libraries” section, drag and drop lottie-ios.framework from the Carthage/Build/iOS directory that `carthage update` produced.

# Quick Start

Lottie loads and renders animations and vectors exported in the bodymovin JSON format. Bodymovin JSON can be created and exported from After Effects with [bodymovin](https://github.com/bodymovin/bodymovin), Sketch with [Lottie Sketch Export](https://github.com/buba447/Lottie-Sketch-Export), and from [Haiku](https://www.haiku.ai). 

Lottie provides components for displaying and rendering Lottie animations, which are compatible with SwiftUI, UIKit, and Core Animation:
  - `LottieAnimationLayer`: a Core Animation `CALayer` subclass that renders Lottie animations
  - `LottieAnimationView`: a UIKit `UIView` subclass that wraps `LottieAnimationLayer` and provides the same set of APIs.
  - `LottieView`: a SwiftUI `View` that wraps the UIKit `LottieAnimationView` and provides a SwiftUI-style declarative API.

`LottieAnimation` is the main type for representing a Lottie animation. It supplies many static helper methods for loading `LottieAnimation`s, including asynchronously from URLs. Lottie also supports the [dotLottie](https://dotlottie.io/) format, available as the `DotLottieFile` type.

## UIKit

You can quickly load a Lottie animation with:
```swift
let starAnimationView = LottieAnimationView(name: "StarAnimation")
```
Additionally you can choose to load an `LottieAnimationView` without any animation, and set the animation later:
```swift
let starAnimationView = LottieAnimationView()
/// Some time later
let starAnimation = LottieAnimation.named("StarAnimation")
starAnimationView.animation = starAnimation
```
You can load animations from a specific bundle, a filepath, or even asynchronously from a URL. Read more about loading animations [Here](#loading-animation)

After loading an animation it can be played with:
```swift
starAnimationView.play { (finished) in
  /// LottieAnimation finished
}
```
Read more about playing animations [Here](#playing-animations)

## SwiftUI

The `LottieView` SwiftUI view provides many of the same APIs as the UIKit `LottieAnimationView`.

For example, here's how you load and play a simple local animation:

```swift
LottieView(animation: .named("StarAnimation"))
  .playing()
```

`LottieView` also provides a convenient API for loading animations asynchronously, e.g. by downloading them from a URL:

```swift
LottieView {
  try await LottieAnimation.loadedFrom(url: myAnimationDownloadURL)
}
.playing()
```

You can use an `@State` property with a `LottiePlaybackMode` to control animation playback. For example, here's how you can trigger an animation to be played in response to a button being pressed:

```swift
@State var playbackMode = LottiePlaybackMode.paused

var body: some View {
  LottieView(animation: .named("StarAnimation"))
    .playbackMode(playbackMode)
    .animationDidFinish { _ in
      playbackMode = .paused
    }
  
  Button {
    playbackMode = .playing(fromProgress(0, toProgress: 1, loopMode: .playOnce))
  } label: {
    Image(systemName: "play.fill")
  }
}
```

# LottieAnimation Model
The `LottieAnimation` model is the top level model object in Lottie. An `LottieAnimation` holds all of the animation data backing a Lottie LottieAnimation. `LottieAnimation`s are deserialized from JSON using the schema defined [here](https://github.com/airbnb/lottie-web/tree/master/docs/json).
 
## Loading LottieAnimation
There are a variety of ways to load an `LottieAnimation` on its own. Additionally you can load an animation while initializing an `LottieAnimationView` through one of the convenience initializers on `LottieAnimationView`.

Animations can be stored in an `AnimationCacheProvider` to reduce the overhead of deserializing the same animations over and over. Read more [here](#animation-cache).
#
### Loading from a Bundle
```swift
LottieAnimation.named(_ name: String, bundle: Bundle, subdirectory: String?, animationCache: AnimationCacheProvider?) -> LottieAnimation?
```
Loads an animation model from a bundle by its name. Returns `nil` if an animation is not found. 

Parameters:
: **name**: The name of the json file without the json extension. EG "StarAnimation"
: **bundle**: The bundle in which the animation is located. Defaults to `Bundle.main`
: **subdirectory**: A subdirectory in the bundle in which the animation is located. Optional.
: **animationCache**: A cache for holding loaded animations. Optional.

Example:
```swift
/// Load from the main bundle.
let animation = LottieAnimation.named("StarAnimation")
/// Load from a specific bundle/
let animation = LottieAnimation.named("StarAnimation", bundle: myBundle)
/// Load from a subdirectory in a bundle.
let animation = LottieAnimation.named("StarAnimation", subdirectory: "Animations")
/// Load with an animation cache.
let animation = LottieAnimation.named("StarAnimation", animationCache: LRUAnimationCache.sharedCache)
```

### Loading from a Filepath
```swift
LottieAnimation.filepath(_ filepath: String, animationCache: AnimationCacheProvider?) -> LottieAnimation?
```
Loads an animation model from an absolute filepath. Returns `nil` if an animation is not found. 

Parameters:
: **filepath**: The absolute filepath of the animation to load. EG "/User/Me/starAnimation.json"
: **animationCache**: A cache for holding loaded animations. Optional.

Example:
```swift
let animation = LottieAnimation(filepathURL.path, animationCache: LRUAnimationCache.sharedCache)
```

# LottieAnimation View
`LottieAnimationView` is a UIView (NSView on macOS) subclass that displays animation content. `LottieAnimationView` offers a number of ways to load, play, and even change animations. Lottie is also available as a `LottieView` SwiftUI `View` and a `LottieAnimationLayer` Core Animation `CALayer`.

## Creating LottieAnimation Views
LottieAnimation views can be allocated with or without animation data. There are a handful of convenience initializers for initializing with animations. 

## Supplying Images
`LottieAnimationView` uses `AnimationImageProvider` to retrieve the images for its animation.
An image provider can be supplied when the LottieAnimation View is initialized, or after by setting its `imageProvider` property. 
To force an LottieAnimationView to reload its images call `reloadImages()` on the LottieAnimationView.

Read more about `AnimationImageProvider` [here](#image-provider)

## Playing Animations
### Time
There are several methods for playing animations, and portions of animations. Lottie describes Time in three ways:
 - Frame Time - Describes time in a frames per second format. `(Seconds * Framerate)` *eg: 0.5 second is FrameTime 12 when framerate is 24*.
 - Progress Time - Describes time in progress from 0 (the beginning of the animation timeline) to 1 (the end of the animation timeline).
 - Time - Describes time in seconds.

All three can be used to play and set time on an `LottieAnimationView`

### Basic Playing
```swift
LottieAnimationView.play(completion: LottieCompletionBlock?)
```
Plays the animation from its current state to the end of its timeline. Calls the completion block when the animation is stopped.

Parameters:
: **completion**: A completion block that is called when the animation completes. The block will be passed `true` if the animation completes and `false` if the animation was interrupted. Optional.

Example:
```swift
starAnimationView.play { finished in
  /// LottieAnimation stopped
}

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playing()
  .animationDidFinish { finished in
    /// LottieAnimation did finish
  }
```

### Play with Progress Time
```swift
LottieAnimationView.play(fromProgress: AnimationProgressTime?, toProgress: AnimationProgressTime, loopMode: LottieLoopMode?, completion: LottieCompletionBlock?)
```
Plays the animation from a `Progress Time` to a `Progress Time` with options.

Parameters:
: **fromProgress**: The start progress of the animation. If `nil` the animation will start at the current progress. (Optional)
: **toProgress**: The end progress of the animation.
: **loopMode**: The loop behavior of the animation. If `nil` the view's `loopMode` property will be used.  (Optional)
: **completion**: An optional completion closure to be called when the animation stops.  (Optional)

Example:
```swift
/// Play only the last half of an animation.
animationView.play(fromProgress: 0.5, toProgress: 1)

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playing(.fromProgress(0.5, toProgress: 1, loopMode: .playOnce))
```

### Play with Frame Time
```swift
LottieAnimationView.play(fromFrame: AnimationProgressTime?, toFrame: AnimationFrameTime, loopMode: LottieLoopMode?, completion: LottieCompletionBlock?)
```
Plays the animation from a `Frame Time` to a `Frame Time` with options.

Parameters:
: **fromFrame**: The start frame of the animation. If `nil` the animation will start at the current frame. (Optional)
: **toFrame**: The end frame of the animation.
: **loopMode**: The loop behavior of the animation. If `nil` the view's `loopMode` property will be used.  (Optional)
: **completion**: An optional completion closure to be called when the animation stops.  (Optional)

Example:
```swift
/// Play from frame 24 to 48 of an animation.
animationView.play(fromFrame: 24, toFrame: 48)


// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playing(.fromFrame(24, toFrame: 48, loopMode: .playOnce))
```

### Play with Marker Names
```swift
LottieAnimationView.play(fromMarker: String?, toMarker: String, loopMode: LottieLoopMode?, completion: LottieCompletionBlock?)
```
Plays the animation from a named marker to another marker. Markers are point in time that are encoded into the LottieAnimation data and assigned a name.
Read more on Markers [here](#using-markers)
==NOTE==: If markers are not found the play command will exit. 

Parameters:
: **fromMarker**: The start marker for the animation playback. If `nil` the animation will start at the current progress. (Optional)
: **toMarker**: The end marker for the animation playback.
: **loopMode**: The loop behavior of the animation. If `nil` the view's `loopMode` property will be used.  (Optional)
: **completion**: An optional completion closure to be called when the animation stops.  (Optional)

Example:
```swift
/// Play from marker "ftue1_begin" to marker "ftue1_end" of an animation.
animationView.play(fromMarker: "ftue1_begin", toMarker: "ftue1_end")


// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playing(.fromMarker("ftue1_begin", toMarker: "ftue1_end", loopMode: .playOnce))
```

### Stop
```swift
LottieAnimationView.stop()
```
Stops the currently playing animation, if any. The animation view is reset to its start frame. The previous animation's completion block will be closed with `false`
Example:
```swift
animationView.stop()
```

### Pause
```swift
LottieAnimationView.pause()
```
Pauses the animation in its current state. The previous animation's completion block will be closed with `false`
Example:
```swift
animationView.pause()

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playbackMode(.paused)
```

## LottieAnimation Settings
`LottieAnimationView` has a variety of settings for controlling playback, and visual state.

### Content Mode
```swift
/// iOS
var LottieAnimationView.contentMode: UIViewContentMode { get set }
/// MacOS
var LottieAnimationView.contentMode: LottieContentMode { get set }
```
Describes how the LottieAnimationView should resize and scale its contents.

Options:
: **scaleToFill**: LottieAnimation scaled to fill the bounds of LottieAnimationView. The animation will be stretched if the aspect of the LottieAnimationView is different than the LottieAnimation.
: **scaleAspectFit**: LottieAnimation will be scaled to fit the LottieAnimationView while preserving its aspect ratio.
: **scaleAspectFill**: LottieAnimation will be scaled to fill the LottieAnimationView while preserving its aspect ratio.
: **topLeft**: LottieAnimation will not be scaled.

### Background Behavior
```swift
var LottieAnimationView.backgroundBehavior: LottieBackgroundBehavior { get set }
```
Describes the behavior of an LottieAnimationView when the app is moved to the background. (iOS only)

The default is `.continuePlaying` when using the Core Animation rendering engine, and `.pauseAndRestore` when using the Main Thread rendering engine.

Options:
: **stop**: Stop the animation and reset it to the beginning of its current play time. The completion block is called.
: **pause**: Pause the animation in its current state. The completion block is called.
: **pauseAndRestore**: Pause the animation and restart it when the application moves back to the foreground. The completion block is stored and called when the animation completes. This is the default when using the Main Thread rendering engine.
: **continuePlaying**: The animation continues playing in the background. This is the default when using the Core Animation rendering engine.

### Loop Mode
```swift
var LottieAnimationView.loopMode: LottieLoopMode { get set }
```
Sets the loop behavior for `play` calls. Defaults to `playOnce`
Options:
: **playOnce**: LottieAnimation is played once then stops.
: **loop**: LottieAnimation will loop from end to beginning until stopped.
: **autoReverse**: LottieAnimation will play forward, then backwards and loop until stopped.
: **repeat(amount)**: LottieAnimation will loop from end to beginning up to *amount* of times.
: **repeatBackwards(amount)**: LottieAnimation will play forward, then backwards a *amount* of times.

### Is LottieAnimation Playing
```swift
var LottieAnimationView.isAnimationPlaying: Bool { get set }
```
Returns `true` if the animation is currently playing, `false` if it is not.

### Should Rasterize When Idle
```swift
var LottieAnimationView.shouldRasterizeWhenIdle: Bool { get set }
```
When `true` the animation view will rasterize its contents when not animating. Rasterizing will improve performance of static animations. This may be required to avoid unexpected artifacts if your `LottieAnimationView` is not opaque with `alpha = 1.0` (e.g. if applying a crossfade to your view).
==Note:== this will not produce crisp results at resolutions above the animation's natural resolution.

Defaults to `false`

### Respect LottieAnimation Frame Rate
```swift
var LottieAnimationView.respectAnimationFrameRate: Bool { get set }
```
When `true` the animation will play back at the framerate encoded in the `LottieAnimation` model. When `false` the animation will play at the framerate of the device.

Defaults to `false`

### LottieAnimation Speed
```swift
var LottieAnimationView.animationSpeed: CGFloat { get set }
```
Sets the speed of the animation playback. Higher speed equals faster time.
Defaults to `1`
#
### Current Progress
```swift
var LottieAnimationView.currentProgress: AnimationProgressTime { get set }

// SwiftUI LottieView API: setting current progress
LottieView(animation: myAnimation)
  .currentProgress(0.5)

// SwiftUI LottieView API: getting current progress
LottieView(animation: myAnimation)
  .playing()
  .getRealtimeAnimationProgress($progressBinding)
```
Sets the current animation time with a Progress Time. Returns the current Progress Time, or the final Progress Time if an animation is in progress.
==Note==: Setting this will stop the current animation, if any.

### Current Time
```swift
var LottieAnimationView.currentTime: TimeInterval { get set }

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .currentTime(4.0)
```
Sets the current animation time with a TimeInterval. Returns the current TimeInterval, or the final TimeInterval if an animation is in progress.
==Note==: Setting this will stop the current animation, if any.

### Current Frame
```swift
var LottieAnimationView.currentFrame: AnimationFrameTime { get set }

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .currentFrame(120.0)
```
Sets the current animation time with a Frame Time. Returns the current  Frame Time, or the final  Frame Time if an animation is in progress.
==Note==: Setting this will stop the current animation, if any.

### Realtime Frame
```swift
var LottieAnimationView.realtimeAnimationFrame: AnimationFrameTime { get }
```
Returns the realtime Frame Time of an LottieAnimationView while an animation is in flight.
ress
```swift
var LottieAnimationView.realtimeAnimationProgress: AnimationProgressTime { get }
```
Returns the realtime Progress Time of an LottieAnimationView while an animation is in flight.


## Using Markers
Markers are a way to describe a point in time by a key name. Markers are encoded into animation JSON. By using markers a designer can mark playback points for a developer to use without having to worry about keeping track of animation frames. If the animation file is updated, the developer does not need to update playback code.

Markers can be used to [playback sections of animation](#play-with-marker-names), or can be read directly for more advanced use. Both `LottieAnimation` and `LottieAnimationView` have methods for reading Marker Times.

### Reading Marker Time
```swift
/// LottieAnimation View Methods
LottieAnimationView.progressTime(forMarker named: String) -> AnimationProgressTime?
LottieAnimationView.frameTime(forMarker named: String) -> AnimationFrameTime?
/// LottieAnimation Model Methods
LottieAnimation.progressTime(forMarker named: String) -> AnimationProgressTime?
LottieAnimation.frameTime(forMarker named: String) -> AnimationFrameTime?
```
Each method returns the time for the marker specified by name. Returns nil if the marker is not found.

## Dynamic LottieAnimation Properties
Nearly all properties of a Lottie animation can be changed at runtime using a combination of [LottieAnimation Keypaths](#animation-keypaths) and [Value Providers](#value-providers). Setting a ValueProvider on a keypath will cause the animation to update its contents and read the new Value Provider.
In addition, animation properties can be read using `LottieAnimation Keypaths`.

### Setting Dynamic Properties
```swift
LottieAnimationView.setValueProvider(_ valueProvider: AnyValueProvider, keypath: AnimationKeypath)
```
Sets a ValueProvider for the specified keypath. The value provider will be set on all properties that match the keypath.

Parameters
: **valueProvider**: The new value provider for the property.
: **keypath**: The keypath used to search for properties.

Example:
```swift
/// A keypath that finds the color value for all `Fill 1` nodes.
let fillKeypath = AnimationKeypath(keypath: "**.Fill 1.Color")
/// A Color Value provider that returns a reddish color.
let redValueProvider = ColorValueProvider(Color(r: 1, g: 0.2, b: 0.3, a: 1))

/// Set the provider on the animationView.
animationView.setValueProvider(redValueProvider, keypath: fillKeypath)

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playing()
  .valueProvider(redValueProvider, for: fillKeypath)
```

### Reading LottieAnimation Properties
```swift
LottieAnimationView.getValue(for keypath: AnimationKeypath, atFrame: AnimationFrameTime?) -> Any?
```
Reads the value of a property specified by the Keypath.
Returns nil if no property is found.
Only supported by the Main Thread rendering engine.

Parameters
: **for**: The keypath used to search for the property.
: **atFrame**: The Frame Time of the value to query. If nil then the current frame is used.

Example:
```swift
/// A keypath that finds the Position of `Group 1` in `Layer 1`
let fillKeypath = AnimationKeypath(keypath: "Layer 1.Group 1.Transform.Position")
let position = animationView.getValue(for: fillKeypath, atFrame: nil)
/// Returns Vector(10, 10, 0) for currentFrame. 
```

### Logging Keypaths
```swift
// UIKit LottieAnimationView API
LottieAnimationView.logHierarchyKeypaths()

// SwiftUI LottieView API
LottieView(animation: myAnimation)
  .playing()
  .configure { lottieAnimationView in
    lottieAnimationView.logHierarchyKeypaths()
  }
```
Logs all child keypaths of the animation into the console.

# Rendering Engines

Lottie for iOS includes two rendering engine implementations, which are responsible for actually displaying and rendering Lottie animations:

 - The Core Animation rendering engine (enabled by default in Lottie 4.0+) uses Core Animation `CAAnimation`s to deliver better performance than the older Main Thread rendering engine.
 - The Main Thread rendering engine (the default before Lottie 4.0) runs code on the main thread once per frame to update and re-render the animation.

You can learn more about the Core Animation rendering engine in [this post](https://medium.com/airbnb-engineering/announcing-lottie-4-0-for-ios-d4d226862a54) on Airbnb's Tech Blog: **[Announcing Lottie 4.0 for iOS](https://medium.com/airbnb-engineering/announcing-lottie-4-0-for-ios-d4d226862a54)**.

The Core Animation rendering engine and Main Thread rendering engine support different sets of functionality. A complete list of supported functionality is available [here](https://airbnb.io/lottie/#/supported-features).

Most animations are rendered exactly the same by both rendering engines, but s shown above the Core Animation rendering engine and Main Thread rendering engine support slightly different sets of functionality. 

As of [Lottie 4.0](https://medium.com/airbnb-engineering/announcing-lottie-4-0-for-ios-d4d226862a54), Lottie uses the Core Animation rendering engine by default. If Lottie detects that an animation uses functionality not supported by the Core Animation rendering engine, it will automatically fall back to the Main Thread rendering engine. You can also configure which rendering engine is used by configuring the `LottieConfiguration.renderingEngine`.


# Image Provider
Image provider is a protocol that is used to supply images to `LottieAnimationView`.

Some animations require a reference to an image. The image provider loads and provides those images to the `LottieAnimationView`.  Lottie includes a couple of prebuilt Image Providers that supply images from a Bundle, or from a FilePath.

Additionally custom Image Providers can be made to load images from a URL, or to Cache images.

## BundleImageProvider
```swift
public class BundleImageProvider: AnimationImageProvider
```
An `AnimationImageProvider` that provides images by name from a specific bundle. The `BundleImageProvider` is initialized with a bundle and an optional searchPath.

```swift
/// Create a bundle that loads images from the Main bundle in the subdirectory "AnimationImages"
let imageProvider = BundleImageProvider(bundle: Bundle.main, searchPath: "AnimationImages")
/// Set the provider on an animation.
animationView.imageProvider = imageProvider
```

## FilepathImageProvider
```swift
public class FilepathImageProvider: AnimationImageProvider
```
An `AnimationImageProvider` that provides images by name from a specific local filepath.

```swift
/// Create a bundle that loads images from a local URL filepath.
let imageProvider = AnimationImageProvider(filepath: url)
/// Set the provider on an animation.
animationView.imageProvider = imageProvider
```

# LottieAnimation Cache

`AnimationCacheProvider` is a protocol that describes an LottieAnimation Cache. LottieAnimation Cache is used when loading `LottieAnimation` models. Using an LottieAnimation Cache can increase performance when loading an animation multiple times.

Lottie comes with a prebuilt LRU LottieAnimation Cache.

## LRUAnimationCache
An LottieAnimation Cache that will store animations up to `cacheSize`. Once `cacheSize` is reached, the least recently used animation will be ejected. The default size of the cache is 100.

LRUAnimationCache has a global `sharedCache` that is used to store the animations.

You may also call `LRUAnimationCache.sharedCache.clearCache()` to clear the cache.


# Value Providers
`AnyValueProvider` is a protocol that return animation data for a property at a given time. Every fame an `LottieAnimationView` queries all of its properties and asks if their ValueProvider has an update. If it does the LottieAnimationView will read the property and update that portion of the animation.

Value Providers can be used to dynamically set animation properties at run time.

## Primitives

ValueProviders work with a few Primitive data types. 

 - **LottieColor**: A primitive that describes a color in R G B A (0-1)
 - **LottieVector1D**: A single float value.
 - **LottieVector3D**: A three dimensional vector. (X, Y, Z)
 
## Prebuilt Providers
Lottie comes with a handful of prebuilt providers for each Primitive Type. Each Provider can be initialized with a single value, or a block that will be called on a frame-by-frame basis.

Example
```swift

/// A Color Value provider that returns a reddish color.
let redValueProvider = ColorValueProvider(LottieColor(r: 1, g: 0.2, b: 0.3, a: 1))

/// A keypath that finds the color value for all `Fill 1` nodes.
let fillKeypath = AnimationKeypath(keypath: "**.Fill 1.Color")
/// Set the provider on the animationView.
animationView.setValueProvider(redValueProvider, keypath: fillKeypath)

/// Later...
/// Changing the value provider will update the animation.
redValueProvider.color = LottieColor(r: 0, g: 0.2, b: 1, a: 1)
```
# LottieAnimation Keypaths
`AnimationKeypath` is an object that describes a keypath search for nodes in the animation JSON. `AnimationKeypath` matches views and properties inside of `LottieAnimationView` to their backing `LottieAnimation` model by name.

A keypath can be used to set properties on an existing animation, or can be validated with an existing `LottieAnimation`. `AnimationKeypath` can describe a specific object, or can use wildcards for fuzzy matching of objects. Acceptable wildcards are either "*" (star) or "**" (double star). Single star will search a single depth for the next object. Double star will search any depth.

An `AnimationKeypath` can be initialized with a dot-separated keypath, or with an array of keys. 

Keypath Examples:
```
/// Represents a specific color node on a specific stroke.
@"Layer.Shape Group.Stroke 1.Color"
```
```
/// Represents the color node for every Stroke named "Stroke 1" in the animation.
@"**.Stroke 1.Color"
```

Code Example:
```swift
/// A keypath that finds the color value for all `Fill 1` nodes.  
let fillKeypath =  AnimationKeypath(keypath:  "**.Fill 1.Color")
```

# Animated Control
Lottie comes prepacked with a two Animated Controls, `AnimatedSwitch` and `AnimatedButton`. Both of these controls are built on top of `AnimatedControl`

`AnimatedControl` is a subclass of `UIControl` that provides an interactive mechanism for controlling the visual state of an animation in response to user actions.

The `AnimatedControl` will show and hide layers depending on the current `UIControl.State` of the control.

Users of `AnimationControl` can set a Layer Name for each `UIControl.State`. When the state is change the `AnimationControl` will change the visibility of its layers.

# Animated Switch

Also available as `LottieSwitch`, a SwiftUI `View` implementation.

![SwitchButton](images/switchTest.gif)

An interactive switch with an 'On' and 'Off' state. When the user taps on the switch the state is toggled and the appropriate animation is played.

Both the 'On' and 'Off' have an animation play range associated with their state.

To change the play range for each state use:
```swift
/// Sets the play range for the given state. When the switch is toggled, the animation range is played.
public func setProgressForState(fromProgress: AnimationProgressTime,
    toProgress: AnimationProgressTime,
    forState onState: Bool)
```

# Animated Button

Also available as `LottieButton`, a SwiftUI `View` implementation.

![HeartButton](images/HeartButton.gif)

An interactive button that plays an animation when pressed.
The `AnimatedButton` can play a variety of time ranges for different `UIControl.Event`.  Play ranges are set using either:
```swift
/// Set a play range with Progress Time.
public func setPlayRange(fromProgress: AnimationProgressTime, 
    toProgress: AnimationProgressTime, 
    event: UIControl.Event)
/// Set a play range with Marker Keys.
public func setPlayRange(fromMarker fromName: String, 
    toMarker toName: String, 
    event: UIControl.Event)
```
Once set the  animation will automatically play when the event is triggered.

Example:
```swift
/// Create a button.
let twitterButton = AnimatedButton()
twitterButton.translatesAutoresizingMaskIntoConstraints = false
/// Set an animation on the button.
twitterButton.animation = LottieAnimation.named("TwitterHeartButton", subdirectory: "TestAnimations")
/// Turn off clips to bounds, as the animation goes outside of the bounds.
twitterButton.clipsToBounds = false
/// Set animation play ranges for touch states
twitterButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
twitterButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
twitterButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
view.addSubview(twitterButton)
```

# Examples

## Changing Animations at Runtime

Lottie can do more than just play beautiful animations. Lottie allows you to **change** animations at runtime.

## Say we want to create 4 toggle switches.
![Toggle](images/switch_Normal.gif)

It's easy to create the four switches and play them:

```swift
let animationView = LottieAnimationView(name: "toggle");
self.view.addSubview(animationView)
animationView.play()

let animationView2 = LottieAnimationView(name: "toggle");
self.view.addSubview(animationView2)
animationView2.play()

let animationView3 = LottieAnimationView(name: "toggle");
self.view.addSubview(animationView3)
animationView3.play()

let animationView4 = LottieAnimationView(name: "toggle");
self.view.addSubview(animationView4)
animationView4.play()

```
## Now lets change their colors
![Recolored Toggle](images/switch_BgColors.gif)

```swift

/// A Color Value provider that returns a reddish color.
let redValueProvider = ColorValueProvider(Color(r: 1, g: 0.2, b: 0.3, a: 1))
/// A Color Value provider that returns a reddish color.
let orangeValueProvider = ColorValueProvider(Color(r: 1, g: 1, b: 0, a: 1))
/// A Color Value provider that returns a reddish color.
let greenValueProvider = ColorValueProvider(Color(r: 0.2, g: 1, b: 0.3, a: 1))



let keypath = AnimationKeypath(keypath: "BG-On.Group 1.Fill 1.Color")
animationView2.setValueProvider(greenValueProvider, keypath: keypath)

animationView3.setValueProvider(redValueProvider, keypath: keypath)

animationView4.setValueProvider(orangeValueProvider, keypath: keypath)
```
The keyPath is a dot separated path of layer and property names from After Effects.
LottieAnimationView provides `func logHierarchyKeypaths()` which will recursively log all settable keypaths for the animation.
![Key Path](images/aftereffectskeypath.png)

"BG-On.Group 1.Fill 1.Color"

## Now lets change a couple of properties
![Multiple Colors](images/switch_MultipleBgs.gif)

Lottie allows you to change **any** property that is animatable in After Effects. 

# Alternatives
1. Build animations by hand. Building animations by hand is a huge time commitment for design and engineering across Android and iOS. It's often hard or even impossible to justify spending so much time to get an animation right.
2. [Facebook Keyframes](https://github.com/facebookincubator/Keyframes). Keyframes is a wonderful new library from Facebook that they built for reactions. However, Keyframes doesn't support some of Lottie's features such as masks, mattes, trim paths, dash patterns, and more.
2. Gifs. Gifs are more than double the size of a bodymovin JSON and are rendered at a fixed size that can't be scaled up to match large and high density screens.
3. Png sequences. Png sequences are even worse than gifs in that their file sizes are often 30-50x the size of the bodymovin json and also can't be scaled up.

# Why is it Called Lottie?
Lottie is named after a German film director and the foremost pioneer of silhouette animation. Her best known films are The Adventures of Prince Achmed (1926) – the oldest surviving feature-length animated film, preceding Walt Disney's feature-length Snow White and the Seven Dwarfs (1937) by over ten years.
[The art of Lotte Reineger](https://www.youtube.com/watch?v=LvU55CUw5Ck&feature=youtu.be)

# Contributing
Contributors are more than welcome. Just post a PR with a description of your changes. For larger changes, please open a discussion first to help build alignment on the necessary changes and the design direction.

# Issues or Feature Requests?

Use GitHub issues for for filing bug reports about crashes, regressions, unexpected behavior, etc. Be sure to check the [list of supported features](https://airbnb.io/lottie/#/supported-features) before submitting. If an animation is not working, please attach the After Effects file or animation JSON file to your issue.

If you have a question or feature request, please start a discussion here:
https://github.com/airbnb/lottie-ios/discussions

