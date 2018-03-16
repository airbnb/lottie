# Getting Started
Gradle is the only supported build configuration, so just add the dependency to your project `build.gradle` file:

<pre><code class="lang-groovy">dependencies {
    ...
    compile 'com.airbnb.android:lottie:{{ book.androidVersion }}'
    ...
}
</code></pre>

# Loading an Animation

### From XML
Lottie supports API 16 and above.
The simplest way to use it is with LottieAnimationView:

Lottie support loading bundled animations from res/raw or assets/.
It is recommended to use res/raw because you can use static references to your animationt through `R` instead of just using string names. This can also aid in build static analysis because it can track the usage of your animations.
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

Or you can load it programmatically in multiple ways. When the animation is loaded, it asynchronously deserializes the composition. Any API calls such as `playAnimation()` `setMinFrame(...)` or anything else will be deferred until the composition is loaded.

### From res/raw or assets/
```java
LottieAnimationView animationView = ...
animationView.setAnimation(R.raw.hello_world.json);
// or
animationView.setAnimation(R.raw.hello_world.json);
animationView.playAnimation();
```
This method will load the file and parse the animation in the background and asynchronously start rendering once completed.


### From a network request

One advantage of Lottie is that you can load an animation from a network request. To do so, you should start with the json body of your response in a String format. Lottie uses a streaming json deserializer to improve performance and memory usage so do not convert it to a JSONObject on your own. That will only hurt performance.
```java
LottieAnimationView animationView = ...
// This allows lottie to use the streaming deserializer mentioned above.
JsonReader jsonReader = new JsonReader(new StringReader(json.toString()))
animationView.setAnimation(jsonReader)
animationView.playAnimation
```


### Caching Animations

There may be animations in your app that are used frequently such as a heart, loader, etc. To avoid the overhead of loading the file and deserializing it each time, you can set a cache strategy on your animation. All of the `setAnimation` APIs above can take an optional second parameter `CacheStrategy`. By default, Lottie will hold a weak reference to your animation which should be sufficient for most use cases. However, if you know that an animation will definitely be used frequently, change it to `CacheStrategy.Strong` or if you know that it is large and won't be used frequently, change it to `CacheStrategy.None`.

### Using Lottie as a Drawable instead of a View

LottieAnimationView is an ImageView wrapper around LottieDrawable. All of the APIs on LottieAnimationView are mirrored on LottieDrawable so you can create your own instance of it and use it anywhere you would use a drawable such as your own custom views or in a menu.

### Using LottieComposition to preload an animation

The backing model for an animation is a LottieComposition. In most cases, calling `setAnimation(...)` on `LottieAnimationView` or `LottieDrawable` is sufficent. However, if you want to preload an animation so it is instantly available, you may use the `LottieComposition.Factory` APIs which will return a LottieComposition object that you can set directly on a `LottieAnimationView` or `LottieDrawable`.
Again, it isn't normally necessary to add the overhead of managing compositions yourself. The default caching in LottieAnimationView is sufficient for most use cases.

Example
```java
 LottieAnimationView animationView = ...;
 ...
 Cancellable compositionLoader = LottieComposition.Factory.fromJsonString(getResources(), jsonString, (composition) -> {
     animationView.setComposition(composition);
     animationView.playAnimation();
 });

 // Cancel to stop asynchronous loading of composition
 // compositionCancellable.cancel();
```


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

Although `playAnimation()` is sufficient for the vast majority of use cases, you can call `setProgress(...)` in the update callback for your own animator.

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

# Animation Scale

_**Lottie converts all px values in After Effects to dps**_ on device so that everything is rendered at the same size across devices. This means that instead of making an animation in After Effects that is 1920x1080, it should be more like 411x731px in After Effects which roughly corresponds to the dp screen size of most phones today.

However, if your animation isn't the perfect size, you have two options:

### ImageView `scaleType`

LottieAnimationView is a wrapped `ImageView` and it supports `centerCrop` and `centerInside` so you may use those two as you would with any other image.

### Lottie `setScale(...)`

`LottieAnimationView` and `LottieDrawable` both have a `setScale(float)` API that you can use to manually scale up or down your animation. This is rarely useful but can be in certain situations.

If your animation is performing slowly, make sure to check the documentation on [performance](/android/performance.md). However, try scaling your animation down in combination with a scaleType. This will reduce the amount that Lottie renders per frame. This is particularly helpful if you have large mattes or masks.

# Play Animation Segments

It is often convenient to play/loop a single part of an animation. For example, you may have an "on" state for the first half of your animation and an "off" state for second half. `LottieAnimationView` and `LottieDrawable` have:

 `setMinFrame(...)`

 `setMinFrame(...)`

 `setMaxProgress(...)`

 `setMaxProgress(...)`

 `setMinAndMaxFrame(...)`

 `setMinAndMaxProgress(...)`

 APIs to control the current segment. Looping APIs will respect the min/max frame set here.


# Hardware Acceleration

Lottie supports hardware acceleration but it is disabled out of the box. Read [this article](https://developer.android.com/guide/topics/graphics/hardware-accel.html) to learn more about hardware acceleration. It is disabled by default because it doesn't support anti-aliasing, stroke caps (pre-API 18), and a few other things. In addition, depending on the animation, they may actually be less performant. Read [this article](http://blog.danlew.net/2015/10/20/using-hardware-layers-to-improve-animation-performance/) to understand why.

If you are having performance issues with your animation, make sure to read the [performance](/android/performance.md) docs first. There is more information about how to benchmark and determine if your animation would benefit from hardware acceleration there.

# Merge Paths

Merge paths are only supported on KitKat and above. There is also some performance overhead in using them because [Path.Op](https://developer.android.com/reference/android/graphics/Path.html#op(android.graphics.Path,%20android.graphics.Path.Op) can be slow. To prevent engineers from testing on new devices with merge paths enabled while shipping a broken experience to users on older phones, they are disabled by default. If your `minSdk` is >=19 then you can enable then with `enableMergePathsForKitKatAndAbove()`

# Sample App

You can build the sample app yourself or download it from the [Play Store](https://play.google.com/store/apps/details?id=com.airbnb.lottie). The sample app includes some built in animations but also allows you to load an animation from internal storage or from a url.
<br/>
<a href='https://play.google.com/store/apps/details?id=com.airbnb.lottie'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="80px"/></a>