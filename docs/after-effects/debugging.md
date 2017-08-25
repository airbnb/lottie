# Debugging animations

There will be times when your animation looks different in Lottie than it does in After Effects. Here are some things you can try to isolate the problems and find a workaround

## Dig into your shape layers
Sometimes when you bring an asset in from Sketch or Illustrator and convert it to a shape layer there will be some wierd things hidden in your shape layers. Its important to dig in and check each shape layer for errand paths or groups to make your file cleaner.

Heres an example of a file that has extra paths, groups and merge paths. On the left is what was exported from Sketch. You can see there are two weird large artboards that extend way out of the composition bounds and on the right is the cleaned up version which is only the necessary shapes

![Comparison](/images/Debugging01.png)



## Isolate problem layers
Sometimes when you have a really complicated composition with lots of layers you'll need to isolate problem areas. I recommend turning on layers one by one or by groups of a few starting from the bottom of the stack, and just test them until you can see which layer is causing the issues.

Once you see which layer is looking strange you can dig into the shape layer and remove any weird paths or rebuild certain shapes to better work for lottie


## Check for Effects, or Layer styles
Lottie doesnt support effects or layer styles so If a layer has them it will probably be broken in Lottie. 




## Check for unsupported features



## Gradient issues



## Animation easings are off

