# Getting Started
Gradle is the only supported build configuration, so just add the dependency to your project `build.gradle` file:

<pre><code class="lang-groovy">dependencies {
    ...
    compile 'com.airbnb.android:lottie:{{ book.androidVersion }}'
    ...
}
</code></pre>

Lottie supports ICS (API 14) and above.
The simplest way to use it is with LottieAnimationView:

```xml
<com.airbnb.lottie.LottieAnimationView
        android:id="@+id/animation_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        app:lottie_fileName="hello-world.json"
        app:lottie_loop="true"
        app:lottie_autoPlay="true" />
```

Or you can load it programmatically in multiple ways.
From a json asset in app/src/main/assets:
```java
LottieAnimationView animationView = (LottieAnimationView) findViewById(R.id.animation_view);
animationView.setAnimation("hello-world.json");
animationView.loop(true);
animationView.playAnimation();
```
This method will load the file and parse the animation in the background and asynchronously start rendering once completed.

If you want to reuse an animation such as in each item of a list or load it from a network request JSONObject:
```java
 LottieAnimationView animationView = (LottieAnimationView) findViewById(R.id.animation_view);
 ...
 Cancellable compositionCancellable = LottieComposition.Factory.fromJson(getResources(), jsonObject, (composition) -> {
     animationView.setComposition(composition);
     animationView.playAnimation();
 });

 // Cancel to stop asynchronous loading of composition
 // compositionCancellable.cancel();
```

You can then control the animation or add listeners:
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
// Custom animation speed or duration.
ValueAnimator animator = ValueAnimator.ofFloat(0f, 1f)
    .setDuration(500);
animator.addUpdateListener(animation -> {
    animationView.setProgress(animation.getAnimatedValue());
});
animator.start();
...
animationView.cancelAnimation();
```

Under the hood, `LottieAnimationView` uses `LottieDrawable` to render its animations. If you need to, you can use the drawable form directly:
```java
LottieDrawable drawable = new LottieDrawable();
LottieComposition.Factory.fromAssetFileName(getContext(), "hello-world.json", (composition) -> {
    drawable.setComposition(composition);
});
```

# Sample App

You can build the sample app yourself or download it from the [Play Store](https://play.google.com/store/apps/details?id=com.airbnb.lottie). The sample app includes some built in animations but also allows you to load an animation from internal storage or from a url.
<br/>
<a href='https://play.google.com/store/apps/details?id=com.airbnb.lottie'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="80px"/></a>