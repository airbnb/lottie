# Performance

## Sizing (px -> points/dp)
Any pixel values in After Effects will get converted to density independent pixels (points on iOS and dp on Android). For example, if you want an animation to be 24dp x 24dp, the After Effects composition should be 24px x 24px.

## Merge Paths
There is a performance overhead to using merge paths. They will work but should be simplified or avoided if possible.