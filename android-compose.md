# Android Jetpack Compose (Alpha)

Initial work has been done to add Lottie support to Jetpack Compose. It is currently in a pre-alpha stage but a public preview will be published soon.

## Core Composables and Classes

The primary Composable used for Lottie is `LottieAnimation`. It takes two parameters:
* LottieAnimationSpec or LottieComposition?
* LottieAnimationState

### LottieAnimationSpec
`LottieAnimationSpec` is a Kotlin sealed class that has a subtype for each animation source:
* res/raw
* assets
* url
* file

### LottieAnimationState
`LottieAnimationState` gives you access to the current state of the animation such as its progress and play state and lets you call actions on it such as play/pause, speed, etc.

## Basic Usage
```kotlin
@Composable
fun Loader() {
    val animationSpec = remember { LottieAnimationSpec.RawRes(R.raw.loading) }
    LottieAnimation(
        animationSpec,
        modifier = Modifier.preferredSize(100.dp)
    )
}
```

```kotlin
@Composable
fun Loader() {
    val spec = remember { LottieAnimationSpec.RawRes(R.raw.loading) }
    // You can control isPlaying/progress/repeat/etc. with this.
    val animationState = rememberLottieAnimationState(autoPlay = true, repeatCount = Integer.MAX_VALUE)

    LottieAnimation(
        spec,
        animationState,
        modifier = Modifier.preferredSize(100.dp)
    )
}
```