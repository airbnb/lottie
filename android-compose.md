# Getting Started
Add the dependency to your project `build.gradle` file:

<pre><code class="lang-groovy">dependencies {
    ...
    implementation "com.airbnb.android:lottie-compose:$lottieVersion"
    ...
}
</code></pre>
The latest stable version is: ![lottieVersion](https://maven-badges.herokuapp.com/maven-central/com.airbnb.android/lottie-compose/badge.svg)

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

# Basic Usage
```kotlin
@Composable
fun Loader() {
    val composition by rememberLottieComposition(LottieCompositionSpec.RawRes(R.raw.loading))
    val progress by animateLottieCompositionAsState(composition)
    LottieAnimation(
        composition,
        progress,
    )
}
```
Or with the `LottieAnimation` overload that merges `LottieAnimation` and `animateLottieCompositionsState()`
```kotlin
@Composable
fun Loader() {
    val composition by rememberLottieComposition(LottieCompositionSpec.RawRes(R.raw.loading))
    LottieAnimation(composition)
}
```

# LottieComposition
`LottieComposition` is the parsed version of your Lottie json file. It is stateless and can be cached/reused freely.
To create a `LottieComposition`:
* Use `rememberLottieComposition(spec)`
* Pass in a `LottieCompositionSpec`. `LottieCompositionSpec` is a sealed class that lets you select the source (res/raw, assets, string, network, etc.).

For example:
```kotlin
val composition1 by rememberLottieComposition(LottieCompositionSpec.RawRes(R.raw.animation))
val composition2 by rememberLottieComposition(LottieCompositionSpec.Url("https://..."))
// src/main/assets/animations/animation.json
val composition3 by rememberLottieComposition(LottieCompositionSpec.Asset("animations/animation.json"))
```

The type returned from `rememberLottieComposition(spec)` is
```kotlin
interface LottieCompositionResult : State<LottieComposition?>
```
This allows you to use it in two ways:
```kotlin
val composition: LottieComposition? by rememberLottieComposition(spec)
```
This will return null until the composition is parsed and then will return the `LottieComposition` object.
Use this version in most cases, especially if you don't need any of the extra functionality on `LottieCompositionResult`.

```kotlin
val compositionResult: LottieCompositionResult = rememberLottieComposition(spec)
```
`LottieCompositionResult` lets you:
1. Access the composition via `compositionResult.value`
2. Access `error`, `isLoading`, `isComplete`, `isFailure`, and `isSuccess` properties.
3. Call `await()` to await the parsed composition from a coroutine.

### Retries
In most cases, you shouldn't expect parsing to fail. However, if you are loading an animation from the network or loading an animation from a file without the correct permissions, it may fail. To handle failures and retries:
```kotlin
val retrySignal = rememberLottieRetrySignal()
val composition by rememberLottieComposition(
    LottieCompositionSpec.Url("not a url"),
    onRetry = { failCount, exception ->
        retrySignal.awaitRetry()
        // Continue retrying. Return false to stop trying.
        true
    }
)
```
Then, you can call `retrySignal.retry()` from something like a click listener to retry loading.

# LottieAnimation Composable
`LottieAnimation` is the primary Lottie composable. It's parameters include:
1. The `LottieComposition` that should be rendered (or null if it hasn't been loaded or parsed yet).
1. The progress that should be rendered. Driving the animation progress is decoupled from the composable so that you can either use Lottie's animation utilities or create your own based on other animation sources or app state like download progress or gestures.
3. Render settings such as speed, dynamic properties, images, render mode (hardware or software), etc.

# Animating/Updating Progress

You have the option of handling progress entirely yourself. If you choose to do that, just pass in `progress` to your `LottieAnimation` composable.

In most cases, you will want to use either `animateLottieCompositionAsState()` or `LottieAnimatable`. These APIs were designed to be analogous to the standard Jetpack Compose APIs. `animateLottieCompositionAsState` is analogous to [animate*AsState](https://developer.android.com/jetpack/compose/animation#animatable) and `LottieAnimatable` is analogous to [Animatable](https://developer.android.com/jetpack/compose/animation#animatable).

The decision for whether to use one over the other is similar as well:
* If your animation is very simple or a function of other state properties, use `animateLottieCompositionAsState()`.
* If you need to imperatively call `animate` or `snapTo` from something like a `LaunchedEffect` then use `LottieAnimatable`.

`animateLottieCompositionAsState()` returns and `LottieAnimatable` implements:
```kotlin
interface LottieAnimationState : State<Float>
```

### animateLottieCompositionAsState()
```kotlin
val progress by animateLottieCompositionAsState(composition)
```
```kotlin
val progress by animateLottieCompositionAsState(
    composition,
    iterations = LottieConstants.IterateForever,
)
```
```kotlin
val progress by animateLottieCompositionAsState(
    composition,
    clipSpec = LottieClipSpec.Progress(0.5f, 0.75f),
)
```

### LottieAnimation overload
There is an overloaded version of the `LottieAnimation` composable that merges the `LottieAnimation` and `animateLottieCompositionAsState` parameters.
```kotlin
LottieAnimation(
    composition,
    iterations = LottieConstants.IterateForever,
    clipSpec = LottieClipSpec.Progress(0.5f, 0.75f),
)
```

### LottieAnimatable
```kotlin
@Stable
class MyHoistedState {
    val lottieAnimatable = LottieAnimatable()
    val somethingElse by mutableStateOf(0f)
}
```
```kotlin
val composition = rememberLottieComposition(LottieCompositionSpec.RawRes(R.raw.animation))
val lottieAnimatable by rememberLottieAnimatable()
LaunchedEffect(Unit) {
    lottieAnimatable.animate(
        composition,
        iteration = LottieConstants.IterateForever,
        clipSpec = LottieClipSpec.Progress(0.5f, 0.75f),
    )
}
```

# Images

Images should be avoided whenever possible. They are much large, less performant, and can lead to pixelation. Whenever possible, try and make your animation consist solely of vectors. However, Lottie does support images in one of 4 ways:
1. Baked into the Lottie json file. This is done via an option in the exporter (such as teh Bodymovin After Effects plugin). When done, images are encoded as a base64 string and embedded directly in the json file. This is the simplest way to use images because everything is contained in a single file and no additional work is necessary to make them work.
1. Zipped with the json file in a single zip file. When parsing the animation, Lottie will unzip the animation and automatically link any images in zip file to the composition. These zip files can be stored in `src/main/assets` and loaded via `LottieCompositionSpec.Asset` or downloaded via the internet and loaded via `LottieCompositionSpec.Url`.
1. Stored in `src/main/assets/*`. When the animation is exported, it may include references to external images referenced via their file name. When this method is used, the images should be stored in a subdirectory within your assets folder and set via the `imageAssetsFolder` parameter on your `LottieAnimation` composable.
1. Manually returned via an `ImageAssetDelegate` and set as the `imageAssetDelegate` parameter on your `LottieAnimation` composable.

# Dynamic Properties

Lottie allows you to update Lottie animation properties at runtime. Some reasons you may want to do this are:
1. Change colors for day/night or other app theme.
2. Change the progress of a specific layer to show download progress.
3. Change the size and position of something in response to a gesture.

To use dynamic properties, you need 3 things:
1. a `LottieProperty`. These are static constants that represent what you are trying to change. The type of the property represents the type that you will return to Lottie to update its value. For example, `LottieProperty.OPACITY` is an `Integer` and accepts values 0-100.
1. A `KeyPath`. A KeyPath is a path to the animation node that has the property that you want to animate. Refer to the docs for `KeyPath` on how to construct one.
1. A `LottieValueCallback` that will get called on each frame or a single value that will be returned on every frame until you update it.

You use those three to construct a `LottieDynamicProperties` object like this:
```kotlin
val dynamicProperties = rememberLottieDynamicProperties(
    rememberLottieDynamicProperty(
        property = LottieProperty.COLOR,
        value = color.toArgb(),
        keyPath = arrayOf(
            "H2",
            "Shape 1",
            "Fill 1",
        )
    ),
)
```
and pass it as a parameter to your `LottieAnimation` composable.

You can chain together multiple dynamic properties if you want to update several at the same time. This example changes the heart color of [heart.json](https://raw.githubusercontent.com/airbnb/lottie-android/master/sample/src/main/res/raw/heart.json) and can also be seen in [these examples](https://github.com/airbnb/lottie-android/blob/master/sample-compose/src/main/java/com/airbnb/lottie/sample/compose/examples/DynamicPropertiesExamplesPage.kt).

