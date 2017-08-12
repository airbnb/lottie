# Creating Lottie animations

Creating animations for Lottie is a bit different than the usual After Effects workflow. Here are some general tips for creating Lottie animations.

## Keep it Simple

When building for Lottie you always have to keep in mind that these JSON files need to be as compact and small as possible for mobile products. For example use parenting whenever you can. Duplicating the same keyframes on a similar layers adds extra code. Only use path keyframe animations when absolutely have to. Those eat up the most space because its adding data for each vertex on each keyframe. Techniques such as Autotrace, or the wiggler that give you a keyframe every frame, may make your JSON file size very large and may impact performance negatively. There has to be a balance with the way the compositions are setup so that things are as efficient as possible.

## Shape layers for vector artwork / Adobe Illustrator

Convert any Adobe Illustrator, EPS, SVG, or PDF assets to shape layers otherwise they will not work in your Lottie animation. After you've converted to shape layers remove the assets from your composition so they aren't exported with the JSON. Shape layers is where Lottie does best.

## Work in points/dps

All pixel values in After Effects will be converted to points on iOS and dps on Android to ensure that they look the same across all screen densities. Google has put together [a collection](https://material.io/devices/) of device metrics with screen size in dps for common devices.

## No expressions or effects

Lottie does not yet support expressions, or any effects from the effects menu.

## Matte and mask size matters

Using alpha mattes can impact performance. If you're using an alpha matte or an alpha inverted matte, the size of the matte will impact performance even more. If you must use Mattes, cover the smallest area you can.

## Debugging

If an animation is broken. Try debugging the animation by exporting only certain layers at a time to see which ones work and which ones don't. After you isolate the problem areas, be sure to file a github issue with the After effects file attached and then you can choose to remake those layers in a different way.

## No Blending modes or Luma mattes

Blending modes such as Multiply, Screen or Add, don't work nor do Luma mattes.

## Full screen animations

Export an animation wider than the widest screen you intend to support and use the `centerCrop` scale type on Android or the `aspectFill` content mdoe on iOS.

## Make Nulls visible and have 0% opacity

If you're using a null to control a bunch of layers and usually turn the visibility off, be sure to turn the visibility ON and turn the opacity to 0% otherwise they won't come through in the JSON file

## Sketch workflow

If you are bringing in assets from Sketch, you can export artboards as PDFs. Bring that PDF into illustrator to break things out into layers and do some organization. Then save that PDF as an illustrator file that can be brought into After Effects and converted into a shape layer. Hopefully one day someone writes a script / tool to automate this process

