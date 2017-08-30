# Updating Properties Dynamically [(WIP)](https://github.com/airbnb/lottie-android/pull/447/files)

With Lottie, you can update properties dynamically at runtime. This can be used for a variety of purposes such as:
* Theming (day and night or arbitrary themes).
* Responding to events such as an error or a success.
* Animating a single part of an animation in response to an event.
* Responding to view sizes or other values not known at design time.

The following value can be modified:
* Position (PointF)
* Anchor Point (PointF)
* Scale (ScaleXY)
* Rotation (Float)
* Color Filter (ColorFilter)
* Color (Integer)
* Opacity (Integer)
* Stroke Width (Float)

## LottieValue

LottieValues are classes that take a value and apply it to content. You never need to implement one yourself and just need to use the static factory methods that ship with Lottie. Each LottieValue subclass is typed and can update properties of that type. The type for each updateable property can be seen above.
For example, if you want to update a rotation to 45 degrees, use `FloatValue.forRotation(45)`.

## KeyPath

KeyPaths are how you specify what content(s) a value will be applied to. These KeyPaths map directly to the layer hierarchy in After Effects.
Let's say your layers in After Effects look like this:
![Layers](/images/KeyPathLayers.png)

You could:
 * Match all of Gabriel: `new KeyPath("Gabriel", "*");`
 * Match Gabriel left hand fill: `new KeyPath("Gabriel", "Body", "Left Hand", "Fill");`
 * Match Gabriel and Brandon's left hand fill: `new KeyPath("*", "Body", Left Hand", "Fill");`


 ### Wildcards

 You can use `*` wildcards in the middle or end of a KeyPath.
 If a wildcard is in the middle of a keypath, it will match any content at that depth.
 If a wildcard is at the end of a keypath, it will recursively apply to that content as well as any children all the way down to the leaf contents.

 ## Updating Keyframes

If you use the LottieValue factory methods that only take the value, it will update beginning of the animation. In the case of a property that doesn't have an animation, it will become the new static value. In the case of a property that is animated, it will update the start value of the first keyframe.

However, if you want to change the start/end frame of a specific keyframe, each animatable property has a factory method that takes a frame number and whether to updateValues.

If `updateValue` is true, the value will update the value of the keyframe closest to the
specified frame. Within the keyframe, either the start or end value will be updated depending
on which is closer to the specified frame.
If the previous/next keyframe is contiguous with the one being updated, its start/end values
will be updated to maintain continuity.

`updateValues` does not currently support false but eventually, it will insert a new keyframe at the specified frame.