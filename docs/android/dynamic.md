# Updating Properties Dynamically

With Lottie 2.5.0+, you can update properties dynamically at runtime. This can be used for a variety of purposes such as:
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
### Wildcard `*`
Wildcards match any single content name in its position in the keypath.
### Globstar `**`
Globstars match zero or more layers.

### KeyPath resolution
KeyPaths have the ability to store an internal reference to the content that they resolve to. When you create a new KeyPath object, it will be unresolved. LottieDrawable and LottieAnimationView has a `resolveKeyPath()` method that takes a KeyPath and returns a list of zero or more resolved KeyPaths that each resolve to a single piece of content and are internally resolved. This can be used to discover the structure of your animation if you don't know it. To do so, in a development environment, resolve `new KeyPath("**")` and log the returned list. However, you shouldn't use `**` by itself with a ValueCallback because it will be applied to every single piece of content in your animation. If you resolve your KeyPaths and want to subsequently add a value callback, use the KeyPaths returned from that method because they will be internally resolved and won't have to do a tree walk to find the content again.

See the documentation for `KeyPath` for more information.

### Property
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

### ValueCallback classes
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
