# Lottie vs Android Vector Drawable (AVD)

There are two ways to render After Effects animations:
1. Export json with Bodymovin and play it with lottie-android.
2. Export AndroidVectorDrawable xml with Bodymovin and play it using the Android SDK.

## Pros of Lottie
* Supports a much larger set of After Effects features. See [supported features](/after-effects/supported-features.md) for a full list.
* Manually set progress to hook up an animation to a gesture, event, etc.
* Download animations from the network.
* Dynamic playback speed.

## Pros of AnimatedVectorDrawable
* Faster peformance due to the animation running on the [RenderThread](https://medium.com/@workingkills/understanding-the-renderthread-4dc17bcaf979) vs the main thread.