# Caching and Preloading

If your animation will be frequently reused, `LottieAnimationView` has an optional caching strategy built in. Use `LottieAnimationView#setAnimation(String, CacheStrategy)`. `CacheStrategy` can be `Strong`, `Weak`, or `None` to have `LottieAnimationView` hold a strong or weak reference to the loaded and parsed animation.

You can also load a LottieComposition manually, hold a reference to it, and call `LottieAnimationView#setComposition(LottieComposition)` with the composition to have the animation load instantly rather than waiting for the deserialization.
