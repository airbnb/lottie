# Getting Started
Gradle is the only supported build configuration, so just add the dependency to your project `build.gradle` file:

```groovy
dependencies {
  implementation 'com.airbnb.android:lottie:2.5.5'
}
```
The latest version is: ![lottieVersion](https://maven-badges.herokuapp.com/maven-central/com.airbnb.android/lottie/badge.svg)

# Sample App

You can build the sample app yourself or download it from the [Play Store](https://play.google.com/store/apps/details?id=com.airbnb.lottie). The sample app includes some built in animations but also allows you to load an animation from internal storage or from a url.
<br/>
<a href='https://play.google.com/store/apps/details?id=com.airbnb.lottie'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="80px"/></a>

# Core Classes

* `LottieAnimationView` extends `ImageView` and is the default and simplest way to load a Lottie animation.
* `LottieDrawable` has most of the same APIs as LottieAnimationView but you can use it on any View you want.

# Loading an Animation

Lottie supports API 16 and above.

Lottie animations can load animations from:
* A json animation in `src/main/res/raw`.
* A json file in `src/main/assets`.
* A zip file in `src/main/assets`. See [images docs](/android/images.md) for more info.
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

### Caching Animations

All Lottie animations are cached with a LRU cache by default. Default cache keys will be created for animations loaded from `res/raw/` or `assets/`. Other APIs require setting a cache key.
If you fire multiple animation requests for the same animation in parallel such as a wishlist heart in a RecyclerView, subsequent requests will join the existing task so it only gets parsed once (Lottie >= 2.6.0).

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

# Animation Size (px vs dp)

_**Lottie converts all px values in After Effects to dps**_ on device so that everything is rendered at the same size across devices. This means that instead of making an animation in After Effects that is 1920x1080, it should be more like 411x731px in After Effects which roughly corresponds to the dp screen size of most phones today.

However, if your animation isn't the perfect size, you have two options:

# ImageView `scaleType`

LottieAnimationView is a wrapped `ImageView` and it supports `centerCrop` and `centerInside` so you may use those two as you would with any other image.

# Scaling Up/Down

`LottieAnimationView` and `LottieDrawable` both have a `setScale(float)` API that you can use to manually scale up or down your animation. This is rarely useful but can be in certain situations.

If your animation is performing slowly, make sure to check the documentation on [performance](/android/performance.md). However, try scaling your animation down in combination with a scaleType. This will reduce the amount that Lottie renders per frame. This is particularly helpful if you have large mattes or masks.

# Play Animation Segments

It is often convenient to play/loop a single part of an animation. For example, you may have an "on" state for the first half of your animation and an "off" state for second half. `LottieAnimationView` and `LottieDrawable` have:
* `setMinFrame(...)`
* `setMaxFrame(...)`
* `setMinProgress(...)`
* `setMaxProgress(...)`
* `setMinAndMaxFrame(...)`
* `setMinAndMaxProgress(...)`


# Hardware Acceleration

Lottie supports hardware acceleration but it is disabled out of the box. Read [this article](https://developer.android.com/guide/topics/graphics/hardware-accel.html) to learn more about hardware acceleration. It is disabled by default because it doesn't support anti-aliasing, stroke caps (pre-API 18), and a few other things. In addition, depending on the animation, they may actually be less performant. Read [this article](http://blog.danlew.net/2015/10/20/using-hardware-layers-to-improve-animation-performance/) to understand why.

If you are having performance issues with your animation, make sure to read the [performance](/android/performance.md) docs first. There is more information about how to benchmark and determine if your animation would benefit from hardware acceleration there.

# Merge Paths

Merge paths are only supported on KitKat and above. There is also some performance overhead in using them because [Path.Op](https://developer.android.com/reference/android/graphics/Path.html#op(android.graphics.Path,%20android.graphics.Path.Op) can be slow. To prevent engineers from testing on new devices with merge paths enabled while shipping a broken experience to users on older phones, they are disabled by default. If your `minSdk` is >=19 then you can enable then with `enableMergePathsForKitKatAndAbove()`

# What is the impact of Lottie on APK size?

Very small:
* ~800 methods.
* 111kb uncompressed.
* 45kb gzipped when downloaded through the Play Store.