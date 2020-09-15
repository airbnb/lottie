# Getting Started
Gradle is the only supported build configuration, so just add the dependency to your project `build.gradle` file:

<pre><code class="lang-groovy">dependencies {
    ...
    implementation "com.airbnb.android:lottie:$lottieVersion"
    ...
}
</code></pre>
The latest version is: ![lottieVersion](https://maven-badges.herokuapp.com/maven-central/com.airbnb.android/lottie/badge.svg)

# Sample App

You can build the sample app yourself or download it from the [Play Store](https://play.google.com/store/apps/details?id=com.airbnb.lottie). The sample app includes some built in animations but also allows you to load an animation from internal storage or from a url.
<br/>
<a href='https://play.google.com/store/apps/details?id=com.airbnb.lottie'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="80px"/></a>


# Core Classes

* `LottieAnimationView` extends ImageView and is the default and simplest way to load a Lottie animation.
* `LottieDrawable` has most of the same APIs as LottieAnimationView but you can use it on any View you want.
* `LottieComposition` is the stateless model repesentation of an animation. You can create one with LottieCompositionFactory and set it on a LottieDrawable or LottieAnimationView.

# Loading an Animation

Lottie supports API 16 and above.

Lottie animations can load animations from:
* A json animation in `src/main/res/raw`.
* A json file in `src/main/assets`.
* A zip file in `src/main/assets`. See [images docs](/android?id=images) for more info.
* A url to a json or zip file.
* A json string. The source can be from anything including your own network stack.
* An InputStream to either a json file or a zip file.

### From XML

The simplest way to use it is with LottieAnimationView:

It is recommended to use `lottie_rawRes` because you can use static references to your animation through `R` instead of just using string names.
#### From res/raw (`lottie_rawRes`) or assets/ (`lottie_fileName`)
```xml
<com.airbnb.lottie.LottieAnimationView
        android:id="@+id/animation_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"

        app:lottie_rawRes="@raw/hello_world"
        // or
        app:lottie_fileName="hello_world.json"

        // Loop indefinitely
        app:lottie_loop="true"
        // Start playing as soon as the animation is loaded
        app:lottie_autoPlay="true" />
```

### Programmatically

You can also call many Lottie APIs on LottieAnimationView directly. View the class reference for the full set of APIs.

Note: to correctly load dark mode (`-night`) resources, make sure you pass `Activity` as a context where possible (instead of e.g. the application context). The `Activity` won't be leaked.

### Caching Animations

All Lottie animations are cached with a LRU cache by default. Default cache keys will be created for animations loaded from `res/raw/` or `assets/`. Other APIs require setting a cache key.
If you fire multiple animation requests for the same animation in parallel such as a wishlist heart in a RecyclerView, subsequent requests will join the existing task so it only gets parsed once (Lottie >= 2.6.0).

# Replacing a static asset with Lottie
One of the primary motivations behind Lottie is to make shipping animations just as easy as shipping static assets.

## Switch from static assets to animations with 3 lines of code!

### Static Asset Workflow
Put your pngs or vector drawables (xml) in `res/drawable`
Include it in your layout
```xml
<ImageView
        android:id="@+id/image_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:scaleType="centerCrop"
        android:src="@drawable/your_drawable" />
```

### Lottie workflow

Put your lottie json in `res/raw`
Include it in your layout:
```xml
<com.airbnb.lottie.LottieAnimationView
        android:id="@+id/animation_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:scaleType="centerCrop"
        app:lottie_rawRes="@raw/your_animation"
        app:lottie_loop="true"
        app:lottie_autoPlay="true" />
```

`LottieAnimationView` extends `ImageView` so you can start by simply replacing your ImageViews with LottieAnimationViews even if you are still using drawables!

# Animation Listeners

You can control the animation or add listeners:
```java
animationView.addAnimatorUpdateListener((animation) -> {
    // Do something.
});
animationView.playAnimation();
...
if (animationView.isAnimating()) {
    // Do something.
}
...
animationView.setProgress(0.5f);
...
```

In the update listener callback:
`animation.getAnimatedValue()` will return the progres of the animation regardless of the currently set min/max frame [0,1].

`animation.getAnimatedFraction()` will return the progress of the animation taking into account the set min/max frame [minFrame,maxFrame].

### Custom animators

Although `playAnimation()` is sufficient for the vast majority of use cases, you can call `setProgress(...)` in the update callback for your own animator. This can be useful to tie an animation to something like a gesture, download progress, or scroll position.

```java
// Custom animation speed or duration.
ValueAnimator animator = ValueAnimator.ofFloat(0f, 1f);
animator.addUpdateListener(animation -> {
    animationView.setProgress(animation.getAnimatedValue());
});
animator.start();
```

# Looping

Lottie support advanced looping functionality that mirrors `ValueAnimator`. As such, you can call `setRepeatMode(...)` or `setRepeatCount(...)` as you would on a `ValueAnimator`
You can also enable looping from xml with `lottie_loop="true"`

You can loop a specific part of an animation by using `setMinFrame`, `setMaxFrame`, or `setMinAndMaxFrame`. There are multiple versions of each that take frame, progress (from 0.0 to 1.0) or a marker name (specified in After Effects).

# Animation Size (px vs dp)

_**Lottie converts all px values in After Effects to dps**_ on device so that everything is rendered at the same size across devices. This means that instead of making an animation in After Effects that is 1920x1080, it should be more like 411x731px in After Effects which roughly corresponds to the dp screen size of most phones today.

However, if your animation isn't the perfect size, you have two options:

# ImageView scaleType

LottieAnimationView is a wrapped `ImageView` and it supports `centerCrop` and `centerInside` so you may use those two as you would with any other image.

## Scaling Up/Down

`LottieAnimationView` and `LottieDrawable` both have a `setScale(float)` API that you can use to manually scale up or down your animation. This is rarely useful but can be in certain situations.

If your animation is performing slowly, make sure to check the documentation on [performance](/android/performance.md). However, try scaling your animation down in combination with a scaleType. This will reduce the amount that Lottie renders per frame. This is particularly helpful if you have large mattes or masks.

# Dynamic Properties

You can update properties dynamically at runtime. This can be used for a variety of purposes such as:
* Theming (day and night or arbitrary themes).
* Responding to events such as an error or a success.
* Animating a single part of an animation in response to an event.
* Responding to view sizes or other values not known at design time.

## Understanding After Effects
To understand how to change animation properties in Lottie, you should first understand how animation properties are stored in Lottie.
Animation properties are stored in a data tree that mimics the information heirarchy of After Effects. In After Effects a `Composition` is a collection of `Layers` that each have their own timelines. `Layer` objects have string names, and their contents can be an image, shape layers, fills, strokes, or just about anything that is drawable. Each object in After Effects has a name. Lottie can find these objects and properties by their name using a `KeyPath`.

## Usage
To update a property at runtime, you need 3 things:
1. KeyPath
1. LottieProperty
1. LottieValueCallback

### KeyPath
A KeyPath is used to target a specific content or a set of contents that will be updated. A KeyPath is specified by a list of strings that correspond to the hierarchy of After Effects contents in the original animation.

KeyPaths can include the specific name of the contents or wildcards:
* **Wildcard** `*`
  * Wildcards match any single content name in its position in the keypath.
* **Globstar** `**`
  * Globstars match zero or more layers.

### KeyPath resolution
KeyPaths have the ability to store an internal reference to the content that they resolve to. When you create a new KeyPath object, it will be unresolved. LottieDrawable and LottieAnimationView has a `resolveKeyPath()` method that takes a KeyPath and returns a list of zero or more resolved KeyPaths that each resolve to a single piece of content and are internally resolved. This can be used to discover the structure of your animation if you don't know it. To do so, in a development environment, resolve `new KeyPath("**")` and log the returned list. However, you shouldn't use `**` by itself with a ValueCallback because it will be applied to every single piece of content in your animation. If you resolve your KeyPaths and want to subsequently add a value callback, use the KeyPaths returned from that method because they will be internally resolved and won't have to do a tree walk to find the content again.

See the documentation for `KeyPath` for more information.

### LottieProperty
LottieProperty is an enumeration of properties that can be set. They correspond to the animatable value in After Effects and the available properties are listed above and in the documentation for `LottieProperty`

### ValueCallback
The ValueCallback is what gets called every time the animation is rendered. The callback provides:
1. Start frame of the current keyframe.
1. End frame of the current keyframe.
1. Start value of the current keyframe.
1. End value of the current keyframe.
1. Progress from 0 to 1 in the current keyframe without any time interpolation.
1. Progress in the current keyframe with the keyframe's interpolator applied.
1. Progress in the overall animation from 0 to 1.

There are also some helper `ValueCallback` subclasses such as `LottieStaticValueCallback` that takes a single value of the correct type in its constructor and will always return that. Think of it as a fire and forget value. There is also a relative value callback that offsets the real animation value by a specified amount.

#### ValueCallback classes
* LottieValueCallback<T>: Either set a static value in the contructor or override getValue() to set the value on every frame.
* LottieRelativeTYPEValueCallback: Either set a static value in the constructor or override getOffset() to set a value taht will be applied as an offset to the actual animation value on each frame. TYPE is the same type as the LottieProperty parameter.
* LottieInterpolatedTYPEValue: Supply a start value, end value, and optional interpolator to have the value automatically interpolate across the entire animation. TYPE is the same type as the LottieProperty parameter.

## Usage
```java
  animationView.addValueCallback(
      new KeyPath("Shape Layer", "Rectangle", "Fill"),
      LottieProperty.COLOR,
      new LottieStaticValueCallback<>(Color.RED));
```

```java
animationView.addValueCallback(
    new KeyPath("Shape Layer", "Rectangle", "Fill"),
    LottieProperty.COLOR,
    (frameInfo) -> {
      return overallProgress < 0.5 ? Color.GREEN : Color.RED;
    }
);
```

or Kotlin
```kotlin
  animationView.addValueCallback(
      KeyPath("Shape Layer", "Rectangle", "Fill"),
      LottieProperty.COLOR_FILTER) { Color.RED };
```
```kotlin
animationView.addValueCallback(
    KeyPath("Shape Layer", "Rectangle", "Fill"),
    LottieProperty.COLOR_FILTER) { frameInfo -> frameInfo.overallProgress < 0.5 ? Color.GREEN : Color.RED }
);
```

## Animatable Properties

The following value can be modified:
### Transform:
 * `TRANSFORM_ANCHOR_POINT`
 * `TRANSFORM_POSITION`
 * `TRANSFORM_OPACITY`
 * `TRANSFORM_SCALE`
 * `TRANSFORM_ROTATION`

### Fill:
 * `COLOR` (non-gradient)
 * `OPACITY`
 * `COLOR_FILTER`

### Stroke:
 * `COLOR (non-gradient)`
 * `STROKE_WIDTH`
 * `OPACITY`
 * `COLOR_FILTER`

### Ellipse:
 * `POSITION`
 * `ELLIPSE_SIZE`

### Polystar:
 * `POLYSTAR_POINTS`
 * `POLYSTAR_ROTATION`
 * `POSITION`
 * `POLYSTAR_OUTER_RADIUS`
 * `POLYSTAR_OUTER_ROUNDEDNESS`
 * `POLYSTAR_INNER_RADIUS` (star)
 * `POLYSTAR_INNER_ROUNDEDNESS` (star)

### Repeater:
 * All transform properties
 * `REPEATER_COPIES`
 * `REPEATER_OFFSET`
 * `TRANSFORM_ROTATION`
 * `TRANSFORM_START_OPACITY`
 * `TRANSFORM_END_OPACITY`

### Layers:
 * All transform properties
 * `TIME_REMAP` (composition layers only)

## Notable Properties

### Time Remapping
Compositions and precomps (composition layers) have an a time remap proprty. If you set a value callback for time remapping, you control the progress of a specific layer. To do so, return the desired time value in seconds from your value callback.

### Color Filters
The only animatable property that doesn't map 1:1 to an After Effects property is the color filter property you can set on fill content. This can be used to set blend modes on layers. It will only apply to the color of that fill, not any overlapping content.

## Migrating from the old `addColorFilter` API
If you were using the old API to dynamically change a color, you will need to migrate to the new one. To do so upgrade your code as follows:
```java
animationView.addColorFilter(colorFilter);
```
becomes
```java
animationView.addValueCallback(new KeyPath("**"), LottieProperty.COLOR_FILTER, new LottieValueCallback<ColorFilter>(colorFilter));
```
------
```java
animationView.addColorFilterToLayer("hello_layer", colorFilter);
```
becomes
```java
animationView.addValueCallback(new KeyPath("hello_layer", "**"), LottieProperty.COLOR_FILTER, new LottieValueCallback<ColorFilter>(colorFilter));
```
------
```java
animationView.addColorFilterToContent("hello_layer", "hello", colorFilter);
```
becomes
```java

animationView.addValueCallback(new KeyPath("hello_layer", "**", "hello"), LottieProperty.COLOR_FILTER, new LottieValueCallback<ColorFilter>(colorFilter));
```
------
```java
animationView.clearColorFilters();
```
becomes
```java
animationView.addValueCallback(new KeyPath("**"), LottieProperty.COLOR_FILTER, null);
```

# Images

Lottie is designed to work with vector shapes. Although Lottie supports rendering images, there are disadvantages to using them:
* The files are an order of magnitude larger than their equivalent vector animation.
* They get pixelated when scaled.
* They add complexity to the animation. Instead of one file, you have the json file plus all of the images.

A common cause of images in Lottie files is that bodymovin exports Illustrator layers from After Effects as images. If you think this might be the case, follow the instructions [here](/after-effects/artwork-to-lottie-walkthrough.md).

## Setting your images
You can set Lottie images in three ways:
### src/assets
If you do need to use images, put the images in a folder inside of `src/assets` and don't change the filenames of the images. You then need to direct Lottie to the assets folder where the images are stored by calling `setImageAssetsFolder` on `LottieAnimationView` or
`LottieDrawable` with the relative folder inside of assets. Again,make sure that the images that
bodymovin export are in that folder with their names unchanged (should be img_#).
If you use `LottieDrawable` directly.
You should call `recycleBitmaps` when you are done animating.
### Zip file
Alternatively, you can create a zip file with your json and images together. Lottie can unzip and read the contents. This can be done for local files or from a url.
### Providing your own images
Sometimes, you don't have the images bundled with the device. You may do this to save space in your apk or if you downloaded the animation from the network. To handle this case, you can set an `ImageAssetDelegate` on your `LottieAnimationView` or `LottieDrawable`. The delgate will be called every time Lottie tries to render an image. It will pass the image name and ask you to return the bitmap. If you don't have it yet (if it's still downloading, for example) then just return null and Lottie will continue to ask on every frame until you return a non-null value.

 ```java
animationView.setImageAssetDelegate(new ImageAssetDelegate() {
  @Override public Bitmap fetchBitmap(LottieImageAsset asset) {
    if (downloadedBitmap == null) {
      // We don't have it yet. Lottie will keep
      // asking until we return a non-null bitmap.
      return null;
    }
    return downloadedBitmap;
  }
});
```

# What is the impact of Lottie on APK size?

Very small:
* ~800 methods.
* 111kb uncompressed.
* 45kb gzipped when downloaded through the Play Store.

# Lottie vs Android Vector Drawable (AVD)

There are two ways to render After Effects animations:
1. Export json with Bodymovin and play it with lottie-android.
2. Export AndroidVectorDrawable xml with Bodymovin and play it using the Android SDK.

## Pros of Lottie
* Supports a much larger set of After Effects features. See [supported features](/after-effects/supported-features.md) for a full list.
* Manually set progress to hook up an animation to a gesture, event, etc.
* Download animations from the network.
* Dynamic playback speed.
* Masks are anti-aliased.
* Dynamically change the color of a specific part of an animations

## Pros of AnimatedVectorDrawable
* Faster peformance due to the animation running on the [RenderThread](https://medium.com/@workingkills/understanding-the-renderthread-4dc17bcaf979) vs the main thread.


## Bodymovin AVD exporter
Bodymovin can export some animations directly as AVDs if they suit your needs better.
To do so, just check the AVD checkbox in the bodymovin settings:
![AVD](/images/BodymovinAvd.png)
This support is very experimental and only supports a subset of the functionality of lottie and avd.

# Performance

## Masks and Mattes
Masks and mattes on android have the larges performance hit. Their performance hit is also proportional to the intersection bounds of the masked/matted layer and the mask/matte so the smaller the mask/matte, the less of a performance hit there will be.
On Android, if you are using masks or mattes, there will be a several X performance improvement when using hardware acceleration.

# Hardware Acceleration

Lottie supports hardware acceleration but it is disabled out of the box. Read [this article](https://developer.android.com/guide/topics/graphics/hardware-accel.html) to learn more about hardware acceleration. It is disabled by default because it doesn't support anti-aliasing, stroke caps (pre-API 18), and a few other things. In addition, depending on the animation, they may actually be less performant. Read [this article](http://blog.danlew.net/2015/10/20/using-hardware-layers-to-improve-animation-performance/) to understand why.

If you are having performance issues with your animation, make sure to read the [performance](/android/performance.md) docs first. There is more information about how to benchmark and determine if your animation would benefit from hardware acceleration there.

# Merge Paths

Merge paths are only supported on KitKat and above. There is also some performance overhead in using them because [Path.Op](https://developer.android.com/reference/android/graphics/Path.html#op(android.graphics.Path,%20android.graphics.Path.Op) can be slow. To prevent engineers from testing on new devices with merge paths enabled while shipping a broken experience to users on older phones, they are disabled by default. If your `minSdk` is >=19 then you can enable then with `enableMergePathsForKitKatAndAbove()`

# Render Graph
The Lottie sample app has a real time render graph that can be enabled from the menu in the top right. It also has guidelines for 16.66 and 33.333ms per frame which represent the maximum render time to hit 60fps and 30fps respectively.


![Render Graph](/images/render-graph.png ':size=300')


# Render Times Per Layer
The Lottie sample app also has a bottom sheet with the time it took each layer to render. To access it, click the render graph in the control bar and then tap "View render times per layer".

If there are any layers that are particularly slow, try optimizing their shapes, eliminated masks, mattes, and merge paths where possible.

![Render times](/images/render-times-per-layer.png  ':size=300')

# Troubleshooting
There may be times in which Lottie doesn't render your animation correctly. After effects has an enormous number of features, not all of which are supported by Lottie. If an animation doesn't look correct, run through the following steps before reporting an issue.

## Check for Warnings
The Lottie for Android will automatically detect and report some errors. It doesn't catch everything but will catch many common cases. You can either call `getWarnings()` from your own code or open the animation in the [Lottie sample app](https://play.google.com/store/apps/details?id=com.airbnb.lottie) and see if warnings show up in the top right. If they do, tapping it will give you more information.

![Warnings](/images/warnings.png  ':size=300')

## Check the supported features page.
Check the [supported features page](/supported-features.md) on this site to see if you are using anything that isn't supported.

## Debug
Try rendering individual parts of the animation to see which feature isn't rendering correctly. See if you can narrow it down to a specific combination of shapes and effects or anything more specific than "it doesn't look right". If the issue should be supported and isn't, file an issue on the appropriate lottie github page with a description and a zip of the aep file.

## Missing merge paths
Merge paths are only available on KitKat and above so you must manually enable them using `enableMergePathsForKitKatAndAbove()`

## Animation Clipping
Make sure you are using the latest version of Lottie.

# Performance Testing

![YourKit](https://www.yourkit.com/images/yklogo.png)

Performance and memory testing was aided by [YourKit](https://www.yourkit.com/java/profiler/) which provides powerful performance and memory profiling tools for Java.