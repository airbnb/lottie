# Lottie for [Android](https://github.com/airbnb/lottie-android), [iOS](https://github.com/airbnb/lottie-ios), and [React Native](https://github.com/airbnb/lottie-react-native)
<a href='https://play.google.com/store/apps/details?id=com.airbnb.lottie'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="80px"/></a>

Lottie is a mobile library for Android and iOS that parses [Adobe After Effects](http://www.adobe.com/products/aftereffects.html) animations exported as json with [Bodymovin](https://github.com/bodymovin/bodymovin) and renders them natively on mobile!

For the first time, designers can create **and ship** beautiful animations without an engineer painstakingly recreating it by hand. They say a picture is worth 1,000 words so here are 13,000:

![Example1](gifs/Example1.gif)


![Example2](gifs/Example2.gif)


![Example3](gifs/Example3.gif)


![Community](gifs/Community%202_3.gif)


![Example4](gifs/Example4.gif)


All of these animations were created in After Effects, exported with Bodymovin, and rendered natively with no additional engineering effort.

[Bodymovin](https://github.com/bodymovin/bodymovin) is an After Effects plugin created by Hernan Torrisi that exports After effects files as json and includes a javascript web player. We've built on top of his great work to extend its usage to Android, iOS, and React Native.

Read more about it on our [blog post](http://airbnb.design/introducing-lottie/)
Or get in touch on GitHub or via lottie@airbnb.com

## Other Platforms
 * [Web](https://github.com/bodymovin/bodymovin)
 * [Xamarin](https://github.com/martijn00/LottieXamarin)
 * [NativeScript](https://github.com/bradmartin/nativescript-lottie)
 * [Appcelerator Titanium](https://github.com/m1ga/ti.animation)

## Sample App

You can build the sample app for Android yourself or download it from the [Play Store](https://play.google.com/store/apps/details?id=com.airbnb.lottie). The sample app includes some built in animations but also allows you to load an animation from internal storage or from a url.

## Shipping something with Lottie?

Email us at lottie@airbnb.com and soon we will create a testimonals and use cases page with real world usages of Lottie from around the world.
We also have an internal regression testing repo that we can use to prevent causing regressions with your animations.

## Alternatives
1. Build animations by hand. Building animations by hand is a huge time commitment for design and engineering across Android and iOS. It's often hard or even impossible to justify spending so much time to get an animation right.
2. [Facebook Keyframes](https://github.com/facebookincubator/Keyframes). Keyframes is a wonderful new library from Facebook that they built for reactions. However, Keyframes doesn't support some of Lottie's features such as masks, mattes, trim paths, dash patterns, and more.
2. Gifs. Gifs are more than double the size of a bodymovin JSON and are rendered at a fixed size that can't be scaled up to match large and high density screens.
3. Png sequences. Png sequences are even worse than gifs in that their file sizes are often 30-50x the size of the bodymovin json and also can't be scaled up.
4. Animated Vector Drawable (Android only). More performant because it runs on the RenderThread instead of the main thread. Supports only a subset of Lottie features. Progress can't be manually set. Doesn't support text or dynamic colors. Can't be loaded programatically or over the internet.

## Why is it called Lottie?
Lottie is named after a German film director and the foremost pioneer of silhouette animation. Her best known films are The Adventures of Prince Achmed (1926) – the oldest surviving feature-length animated film, preceding Walt Disney's feature-length Snow White and the Seven Dwarfs (1937) by over ten years
[The art of Lotte Reineger](https://www.youtube.com/watch?v=LvU55CUw5Ck&feature=youtu.be)

## Contributing
Contributors are more than welcome. Just upload a PR with a description of your changes.

If you would like to add more JSON files feel free to do so!

## Issues or feature requests?
File github issues for anything that is unexpectedly broken. If an After Effects file is not working, please attach it to your issue. Debugging without the original file is much more difficult.