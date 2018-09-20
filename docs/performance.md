# Optimizing Animation Performance

## Sizing (px -> points/dp)
Any pixel values in After Effects will get converted to density independent pixels (points on iOS and dp on Android). For example, if you want an animation to be 24dp x 24dp, the After Effects composition should be 24px x 24px.

## Masks and Mattes
Masks and mattes on android have the larges performance hit. Their performance hit is also proportional to the intersection bounds of the masked/matted layer and the mask/matte so the smaller the mask/matte, the less of a performance hit there will be.
On Android, if you are using masks or mattes, there will be a several X performance improvement when using hardware acceleration.

## Reused Animations (Android)
Animations are often reused many times such as a wish list heart in a list. To avoid deserialization for each one, you may cache the deserialized composition. To do that, you may either set a cache strategy on your `LottieAnimationView` or load the `LottieComposition` directly, hold a reference yourself, and then set that directly on the `LottieAnimationView`.

## Hardware Acceleration (Android)
Android can render animations with hardware or software acceleration. Hardware acceleration is much faster but has some limitations.
The following features have limited support
* Anti aliasing (API 16+ only)
* Clip to comp bounds (API 18+ only)
* Stroke caps (API 19+ only)

For more information, read [this](https://developer.android.com/guide/topics/graphics/hardware-accel.html).

In general, try your animation with hardware acceleration and use it if it works. You can try toggling it in the sample app.


## Render Graph (Android)
The Lottie sample app has a real time render graph that can be enabled from the menu in the top right.
![Render Graph](/images/render-graph.png)
