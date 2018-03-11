# Sizing (px -> dp)
Any pixel values in After Effects will get converted to density independent pixels (points on iOS and dp on Android). For example, if you want an animation to be 24dp x 24dp, the After Effects composition should be 24px x 24px. You can find a list of common screen sizes in dps [here](https://material.io/devices/).

# Masks and Mattes
Masks and mattes on android have the larges performance hit. Their performance hit is also proportional to the intersection bounds of the masked/matted layer and the mask/matte so the smaller the mask/matte, the less of a performance hit there will be.
On Android, if you are using masks or mattes, there will be a several X performance improvement when using hardware acceleration.

# Hardware Acceleration
Android can render animations with hardware or software acceleration. Hardware acceleration is often much faster but has some limitations.
The following features have limited support
* Anti aliasing (API 16+ only)
* Clip to composition bounds (API 18+ only)
* Stroke caps (API 19+ only)

For more information, read [this](https://developer.android.com/guide/topics/graphics/hardware-accel.html).

However, [it is not always faster](http://blog.danlew.net/2015/10/20/using-hardware-layers-to-improve-animation-performance/) so you should try it for your animation specifically to test.

To benchmark your animation, refer to the other sections on this page.


# Render Graph
The Lottie sample app has a real time render graph that can be enabled from the menu in the top right. It also has guidelines for 16.66 and 33.333ms per frame which represent the maximum render time to hit 60fps and 30fps respectively.
![Render Graph](/images/render-graph.png)


# Render Times Per Layer
The Lottie sample app also has a bottom sheet with the time it took each layer to render. To access it, click the render graph in the control bar and then tap "View render times per layer".

If there are any layers that are particularly slow, try optimizing their shapes, eliminated masks, mattes, and merge paths where possible.

![Render times](/images/render-times-per-layer.png)