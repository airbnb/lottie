# Debugging animations

There will be times when your animation looks different in Lottie than it does in After Effects. Here are a few common issues we've encountered and how to navigate them.

If an animation is broken. Try debugging the animation by exporting only certain layers at a time to see which ones work and which ones don't. After you isolate the problem areas, be sure to file a github issue with the After effects file attached and then you can choose to remake those layers in a different way.


## Animation easings are off

There currently an issue with Lottie that has to do with control points on a position path. For some reason it affects the easing between two keyframes. This animation on the left is what it looks like in After Effects, and on the right is how its coming out in Lottie.

In this animation when the layer is selected you can see there are control points there. If those

Current workaround:
Until we can get this issue fixed there are many different ways to solve this. This instance in particular can be solved if you simply

## Sample App


## Sample App