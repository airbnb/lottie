# After Effects

Get up and running creating animations for Lottie in After Effects!

[Bodymovin](https://github.com/airbnb/lottie-web) is an After Effects plugin created by Hernan Torrisi that exports After effects files as json and includes a javascript web player. We've built on top of his great work to extend its usage to Android, iOS, React Native, and Windows.

[LottieFiles for After Effects](https://lottiefiles.com/plugins/after-effects) is a plugin created by LottieFiles, lets you render your animation natively but also offers additional features such as testing on mobile and a render graph that lets you check your animations CPU usage as you create your Lottie. You can access a library of 1000s of free animations with their AEP file on LottieFiles straight from within the plugin itself too.

# Installing Bodymovin

### 1 - Close After Effects if it's open

### 2 - Install the ZXP installer

[http://aescripts.com/learn/zxp-installer/](http://aescripts.com/learn/zxp-installer/)

![ZxpInstaller](/images/ZxpInstaller.png)

### 3 - Download the latest bodymovin extension
[https://github.com/airbnb/lottie-web/tree/master/build/extension](https://github.com/airbnb/lottie-web/blob/master/build/extension/bodymovin.zxp)

![Bodymovin ZxpInstaller](/images/BodymovinZxp.png)

### 4 - Open the ZXP installer and drag the bodymovin extension into the window

![Bodymovin ZxpInstaller](/images/BodymovinZxp.gif)

### 5 - Open After Effects

Under the menu "Window > Extensions" you should see "Bodymovin"

![Bodymovin in the menu](/images/BodymovinMenu.gif)

Now you're good to go!

# More Bodymovin info

Check out information about the Bodymovin settings [here](/after-effects/bodymovin-settings.md) <br>
Also here is a video walkthrough of how to install and use Bodymovin [here](https://www.youtube.com/watch?v=5XMUJdjI0L8)

# Composition Settings

In the Bodymovin panel each composition has a gear next to it which takes to you to the settings. Here is what each of those items means.

![Bodymovin settings](/images/BodymovinSettings.png)


**Split:** Attempts to exports animation in multiple json files. If the main comp has more than one layer, the exporter will segment your main comp considering where a layer starts in time.<br/>

**Glyphs:** When checked, it will convert all text characters to shapes. If unchecked, you need to provide a font file or a classname in order to render the correct font.<br/>

**Hidden:** When checked, it will include all hidden layers. This is usually needed when you have expressions pointing to hidden layers. Keep in mind that all hidden layers will get exported, adding to the final file size<br/>

**Guided:** When checked, it will include all guided layers. This is usually needed when you have expressions pointing to guided layers. Keep in mind that all guided layers will get exported, adding to the final file size<br/>

**Extra Comps:** You can select additional compositions to be exported as part of the animation. this is only needed if you have expressions pointing to external comps that not included in the main comp or subcomps tree<br/>

**Original Assets Name:** If you have rasterized assets like jpgs, it will export them to an images folder with their original source name.<br/>

**Standalone:** When checked, it will export the animation and the player all bundled into a single file. Might be useful if you only have one animation in your page. For example for delivering banners.<br/>

**Demo:** It will export a demo.html file so you can preview the animation easily.<br/>

# Creating Lottie animations

Creating animations for Lottie is a bit different than the usual After Effects workflow. Here are some general tips for creating Lottie animations.

## Keep it Simple

When building for Lottie you always have to keep in mind that these JSON files need to be as compact and small as possible for mobile products. For example use parenting whenever you can. Duplicating the same keyframes on a similar layers adds extra code. Only use path keyframe animations when absolutely have to. Those eat up the most space because its adding data for each vertex on each keyframe. Techniques such as Autotrace, or the wiggler that give you a keyframe every frame, may make your JSON file size very large and may impact performance negatively. There has to be a balance with the way the compositions are setup so that things are as efficient as possible.

## Shape layers for vector artwork / Adobe Illustrator

Convert any Adobe Illustrator, EPS, SVG, or PDF assets to shape layers in After Effects otherwise they will not work in your Lottie animation.

![Create Shapes](/images/CreateShapes_sm.png)

After you've converted to shape layers remove the assets from your composition so they aren't exported with the JSON. Shape layers is where Lottie does best.

## Export at 1x

You can work in After Effects at whatever composition size you want, but be sure to export with a composition size that is 1x the size of your asset.

![1x](/images/Create1x_sm.png)

All pixel values in After Effects will be converted to points on iOS and dps on Android to ensure that they look the same across all screen densities. Google has put together [a collection](https://material.io/devices/) of device metrics with screen size in dps for common devices.

## No expressions or effects

Lottie does not yet support expressions, or any effects from the effects menu.

![NoEffects](/images/NoEffects.png)

![NoEffects](/images/NoExpressions.png)

## Matte and mask size matters

Using alpha mattes can impact performance. If you're using an alpha matte or an alpha inverted matte, the size of the matte will impact performance even more. If you must use Mattes, cover the smallest area you can.

## Debugging

If an animation is broken. Try debugging the animation by exporting only certain layers at a time to see which ones work and which ones don't. After you isolate the problem areas, be sure to file a github issue with the After effects file attached and then you can choose to remake those layers in a different way.

## No Blending modes or Luma mattes

Blending modes such as Multiply, Screen or Add, aren't yet supported nor are Luma mattes.

## No layer styles

Lottie does not yet support layer effects like drop shadow, color overlay or stroke.


## Full screen animations

Export an animation wider than the widest screen you intend to support and use the `centerCrop` scale type on Android or the `aspectFill` content mode on iOS.

![Full screen animations](/images/LottieFullScreen.gif)


## Make Nulls visible and have 0% opacity

If you're using a null to control a bunch of layers and usually turn the visibility off, be sure to turn the visibility ON and turn the opacity to 0% otherwise they won't come through in the JSON file

# Sketch/SVG/Illustrator to Lottie workflow

This walkthrough explains how to get artwork from Sketch to Lottie. If you already have an SVG skip to step 3. If you're working in illustrator start at step 4.

It doesn't dive into any animation techniques. For that check out one of our other walkthroughs.

We're assuming you have three things. Adobe Illustrator, Adobe After Effects, and [Bodymovin](https://github.com/airbnb/lottie-web). For a walkthrough on how to install Bodymovin go [here](/bodymovin-installation.md).


### 1 - Ensure artwork is grouped

To get the asset exported in one piece everything needs to be put into a single group in Sketch

![ArtworkWalkthrough_01](/images/ArtworkWalkthrough_01.png)

### 2 - Select the group and export as an SVG

You might be thinking 🤔 Why not export artwork as a PDF or EPS that goes directly into AE?? We'll explain why later. If you don't have illustrator a PDF or EPS will still work, you just might have to do more cleanup in After Effects. Check out cleanup tips in the [Debugging section](/after-effects/debugging.md)

![ArtworkWalkthrough_02](/images/ArtworkWalkthrough_02.png)

If you have Googles [Sketch2AE](https://google.github.io/sketch2ae/) tool, you can use that instead. You'll be able to skip steps 3, 4, 5 and 6

### 3 - Open SVG in Illustrator and save as a .AI file

![ArtworkWalkthrough_03](/images/ArtworkWalkthrough_03.png)
![ArtworkWalkthrough_04](/images/ArtworkWalkthrough_04.png)

### 4 - Import that .AI file into After Effects

After you open After Effects either drag the illustrator file onto the project window or go to File > Import

![ArtworkWalkthrough_05](/images/ArtworkWalkthrough_05.gif)

### 5 - Create composition, set duration and check Frame-rate

After dragging the Illustrator file down to the little composition icon in the bottom of the project panel you will have a new composition perfectly sized for your file.

![ArtworkWalkthrough_06](/images/ArtworkWalkthrough_06.png)


Next you can go to the menu and select Composition > Composition settings. I usually work in 30fps or 60fps.

Its important to pick the right frame-rate up front because if you have to change it later things can get weird with pre-existing keyframes. Also you can choose your duration. If you're intending to export a static asset just make the duration a second. If you're going to animate, its up to you. You can always change it again later


### 6 - Convert illustrator file into shape layers

Select the layer in the composition and in the Layer menu select "Create shapes from vector layer" It then creates a new "Shape Layer" based off of your illustrator artwork, that has editable vector properties of the artwork, such as paths, strokes, fills, etc.

![ArtworkWalkthrough_07](/images/ArtworkWalkthrough_07.gif)


So back to that question "Why didn't I just export a PDF or EPS from Sketch??" This is where it counts. When you export a PDF or EPS from Sketch sometimes it adds artboard paths to the shape layer when its converted.

![ArtworkWalkthrough_08](/images/ArtworkWalkthrough_08.png)

The one on the left is an SVG converted, and the example on the right is an EPS converted. The example on the right you can see the transparency is inverted, because its got some paths that are the size of the artboard. If you have a complicated piece of artwork things can really get strange. You can always go through and cleanup the shape layer by deleting unused paths and artboard paths, its just time consuming and annoying. Thats why SVG is best.


### 6 - Do some animation magic. Or not.

Here you can choose to do some animation magic, or if you're just looking to create a static asset for Lottie you're done.


### 7 - Exporting with Bodymovin

Next if the panel isn't already open go to Window > Extensions > Bodymovin.

![ArtworkWalkthrough_09](/images/ArtworkWalkthrough_09.gif)

Select the composition you want to export by clicking the circle to the left. Next select the destination by selecting the 3 dots on the right. Name your file, and press Render the big green button on the top left


### 8 - Testing your animation

Next step is to test your animation to ensure you're not using any unsupported features, and that everything looks as desired.

There are a few different ways to test, one of the easiest is by using Lottiefiles.com.


### 9 - Upload onto Lottiefiles.com

Open up your browser to Lottiefiles.com and drag your json file directly onto the page

![Lottiefiles](/images/LottiefilesPreview.gif)

You should see your animation. If it looks correct, thats a great sign, as it means you're using bodymovin supported features.

The next step is to test it on your platform of choice, android or iOS.


### 10 - Download Lottie files preview app

Download the Lottie app from the Google play store or the Lottie Preview app from the App store.

![Lottiefiles preview app](/images/LottiefilesPreviewApp.png)


### 11 - Scan the QR code

After its downloaded just use the camera to scan the QR code.

![Lottiefiles preview app](/images/LottiefilesPreviewApp.gif)

If you're animation looks correct in the preview app, you are good to go!

If it doesn't then its time to do some debugging. Check out our [After Effects debugging tips](/after-effects/debugging.md) to see some techniques to get your animation working. If all else fails file an issue on github in the respective repo ([iOS](http://www.github.com/airbnb/lottie-ios), [Android](http://www.github.com/airbnb/lottie-android)) with your AE file attached and we'll do our best to support you.


# Advanced Illustrator to Lottie workflow

Coming soon...

# Troubleshooting

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

Coming soon...


## Gradient issues

Coming soon...

## Animation easings are off

Coming soon...
