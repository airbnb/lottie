# Android Jetpack Compose (Alpha)

Initial work has been done to add Lottie support to Jetpack Compose. It is currently in a pre-alpha stage but a public preview will be published soon.

## Getting Started
Add the dependency to your project `build.gradle` file:

<pre><code class="lang-groovy">dependencies {
    ...
    implementation "com.airbnb.android:lottie-compose:$lottieVersion"
    ...
}
</code></pre>
The latest stable version is: ![lottieVersion](https://maven-badges.herokuapp.com/maven-central/com.airbnb.android/lottie-compose/badge.svg)

For the time being, we won't provide numbered releases for every new Jetpack Compose
version. Check out our snapshot builds instead.

#### Snapshot Versions
Snapshots are hosted on Sonatype. First, add the Sonatype repository to your `build.gradle` file:

```groovy
allprojects {
    repositories {
        ...
        maven { url "https://oss.sonatype.org/content/repositories/snapshots/" }
    }
}
```

The latest snapshot version is: ![lottieSnapshotVersion](https://img.shields.io/nexus/s/com.airbnb.android/lottie-compose?server=https%3A%2F%2Foss.sonatype.org)

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
    val animationSpec = remember { LottieAnimationSpec.RawRes(R.raw.loading) }
    // You can control isPlaying/progress/repeat/etc. with this.
    val animationState = rememberLottieAnimationState(autoPlay = true, repeatCount = Integer.MAX_VALUE)

    LottieAnimation(
        animationSpec,
        modifier = Modifier.preferredSize(100.dp),
        animationState
    )
}
```
