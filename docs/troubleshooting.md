# Troubleshooting Animations

There may be times in which Lottie doesn't render your animation correctly. After effects has an enormous number of features, not all of which are supported by Lottie. If an animation doesn't look correct, run through the following steps before reporting an issue.

## Check for Warnings (Android)
The Lottie for Android will automatically detect and report some errors. It doesn't catch everything but will catch many common cases. You can either call `getWarnings()` from your own code or open the animation in the [Lottie sample app](https://play.google.com/store/apps/details?id=com.airbnb.lottie) and see if warnings show up in the top right. If they do, tapping it will give you more information.
![Warnings](/images/warnings.png)

## Check the supported features page.
Check the [supported features page](/supported-features.md) on this site to see if you are using anything that isn't supported.

## Debug
Try rendering individual parts of the animation to see which feature isn't rendering correctly. See if you can narrow it down to a specific combination of shapes and effects or anything more specific than "it doesn't look right". If the issue should be supported and isn't, file an issue on the appropriate lottie github page with a description and a zip of the aep file.

## Animation Clipping (Android)
If you notice that your animation is smaller than you expect or if it looks like it's only rendering some portion of the animation in the top left quadrant then you have mask or matte clipping. Masks and mattes cannot render anything larger than the bounds of your view. To fix this, see if you can avoid using masks or mattes (see [performance](/performance.md)), make your animation composition smaller (px values in AE get converted to dp values), or set your view to `wrap_content`.