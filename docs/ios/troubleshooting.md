# Troubleshooting
There may be times in which Lottie doesn't render your animation correctly. After effects has an enormous number of features, not all of which are supported by Lottie. If an animation doesn't look correct, run through the following steps before reporting an issue.

## Check the supported features page.
Check the [supported features page](/supported-features.md) on this site to see if you are using anything that isn't supported.

## Debug logging
If you checkout LOTHelpers.h you will see two debug flags. ENABLE_DEBUG_LOGGING and ENABLE_DEBUG_SHAPES. ENABLE_DEBUG_LOGGING increases the verbosity of Lottie Logging. It logs anytime an animation node is set during animation. If your animation if not working, turn this on and play your animation. The console log might give you some clues as to whats going on.

ENABLE_DEBUG_SHAPES Draws a colored square for the anchor-point of every layer and shape. This is helpful to see if anything is on screen.

## Find the root problem
Try rendering individual parts of the animation to see which feature isn't rendering correctly. See if you can narrow it down to a specific combination of shapes and effects or anything more specific than "it doesn't look right". If the issue should be supported and isn't, file an issue on the appropriate lottie github page with a description and a zip of the aep file.