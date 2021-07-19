# Lottie for&nbsp;[Android](https://github.com/airbnb/lottie-android), [iOS](https://github.com/airbnb/lottie-ios), [Web](https://github.com/airbnb/lottie-web), [React Native](https://github.com/airbnb/lottie-react-native), and [Windows](https://aka.ms/lottie)


Lottie is a library for Android, iOS, Web, and Windows that parses [Adobe After Effects](http://www.adobe.com/products/aftereffects.html) animations exported as json with [Bodymovin](https://github.com/airbnb/lottie-web) and renders them natively on mobile and on the web!

For the first time, designers can create **and ship** beautiful animations without an engineer painstakingly recreating it by hand. They say a picture is worth 1,000 words so here you go:

![Lottie Logo animation](images/Introduction_00_sm.gif ':size=500')


The above animation was created in After Effects, and can be rendered natively across all platforms with a simple json file.

## Sponsors

Lottie is made possible because of our supporters on GitHub Sponsors and Open Collective. To learn more, please check out our [sponsorship page](/sponsorship.md).

We would especially like to thank our sponsorships from

[![Lottiefiles](images/lottiefiles.svg ':size=300')](https://www.lottiefiles.com/)

[![Airbnb](images/airbnb.svg ':size=300')](https://www.airbnb.com/)

[![Tonal](images/tonal.svg ':size=300')](https://www.tonal.com/)

[![Stream](images/stream.png ':size=300')](https://getstream.io/chat/sdk/android/?utm_source=lottie&utm_medium=sponsorship&utm_content=developer)

[![Duolingo](images/duolingo.svg ':size=300')](https://www.duolingo.com/)

Read more about it on our [blog post](http://airbnb.design/introducing-lottie/)
Or get in touch on GitHub or via lottie@airbnb.com

## Sample App
<table>
  <tr>
    <th>
      <a href='https://play.google.com/store/apps/details?id=com.airbnb.lottie'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="80px"/></a>
    </th>
    <th>
      <a href='https://www.microsoft.com/store/apps/9p7x9k692tmw?ocid=badge'><img src='https://developer.microsoft.com/store/badges/images/English_get-it-from-MS.png' alt='English badge' width='127px' height='52px'/></a>
    </th>
  </tr>
</table>

You can build the sample app for Android yourself or download it from the [Play Store](https://play.google.com/store/apps/details?id=com.airbnb.lottie). The sample app includes some built in animations but also allows you to load an animation from internal storage or from a url.

For Windows, you can get the [Lottie Viewer app](https://aka.ms/lottieviewer) to preview Lottie animation and codegen classes, and the [Lottie Samples app](https://aka.ms/lottiesamples) to get started with code samples and simple tutorials.

## Shipping something with Lottie?

We would love to feature your work on our [community showcase](/community-showcase.md)! To do so, Put up a PR on [github.com/lottie](https://github.com/airbnb/lottie) with a change to [community-showcase.md](https://github.com/airbnb/lottie/blob/master/community-showcase.md) with a description and gif of your animation.
We also have an internal regression testing repo that we can use to prevent causing regressions with your animations.

## Alternatives
1. Build animations by hand. Building animations by hand is a huge time commitment for design and engineering across Android and iOS. It's often hard or even impossible to justify spending so much time to get an animation right.
1. Gifs. Gifs are more than double the size of a bodymovin JSON and are rendered at a fixed size that can't be scaled up to match large and high density screens.
1. Png sequences. Png sequences are even worse than gifs in that their file sizes are often 30-50x the size of the bodymovin json and also can't be scaled up.
1. Animated Vector Drawable (Android only). More performant because it runs on the RenderThread instead of the main thread. Supports only a subset of Lottie features. Progress can't be manually set. Doesn't support text or dynamic colors. Can't be loaded programatically or over the internet.

## Why is it called Lottie?
Lottie is named after a German film director and the foremost pioneer of silhouette animation. Her best known films are The Adventures of Prince Achmed (1926) – the oldest surviving feature-length animated film, preceding Walt Disney's feature-length Snow White and the Seven Dwarfs (1937) by over ten years
[The art of Lotte Reineger](https://www.youtube.com/watch?v=LvU55CUw5Ck&feature=youtu.be)

## Contributing to Documentation
Contributors are more than welcome. Just put up a PR to [github.com/airbnb](https://github.com/airbnb/lottie).

## Issues or feature requests?
File github issues for anything that is unexpectedly broken. If an After Effects file is not working, please attach it to your issue. Debugging without the original file is much more difficult.

## Articles, Interviews & Podcasts

Here are some articles and podcasts from the Lottie team @ Airbnb

[Behind the scenes: Why we built Lottie, our new open-source animation tool here.](https://airbnb.design/introducing-lottie/)

[Dig into the details and back story with Brandon Withrow and Salih Abdul-Karim on the School of motion podcast](https://www.schoolofmotion.com/blog/after-effects-to-code-lottie-from-airbnb)

[Learn more about Lottie from Gabriel Peal on the Fragmented Podcast](http://fragmentedpodcast.com/episodes/82/)

[Lottie Animation with Brandon Withrow and Gabriel Peal on Software engineering daily podcast](https://softwareengineeringdaily.com/2017/08/10/lottie-animation-with-brandon-withrow-and-gabriel-peal/)


## Community articles and videos

Heres some links from around the community

[A Lottie to Like](https://t.co/dadjvgv9vk) by Nick Butcher

[Creating better user experiences with animations and Lottie](https://pspdfkit.com/blog/2017/creating-better-user-experiences-with-animations-and-lottie/) by Samo Korosec and Stefan Keileithner

[10 amazing web animations with Lottie \(In Spanish\)](https://www.youtube.com/watch?v=IFp3tyy3cRA) by AnimatiCSS

[How to use Lottie \(In Spanish\)](https://www.youtube.com/watch?v=hLUBXENQSOc) by AnimatiCSS

[How to use Lottie \(In Chinese\)](https://goo.gl/e7BkND) by PattyDraw

[A Beginning’s Guide to Lottie: Creating Amazing Animations in iOS Apps](https://www.appcoda.com/lottie-beginner-guide/#) by Simon NG

[Take your animations to the next level with Airbnb framework, Lottie](https://medium.com/@jamesrochabrun/take-your-animations-to-the-next-level-with-airbnb-framework-lottie-ab6c6152acba) by James Rochabrun

[iOS Swift Tutorial: Animations with After Effects and Lottie](https://www.youtube.com/watch?v=ESjFEaZx7UI) by Brian Advent

[iOS Swift Tutorial: Interactive Animations with After Effects and Lottie](https://www.youtube.com/watch?v=QyL-jp9bFdM) by Brian Advent

[After Effects for wiOS Developers: Dynamic Content in Animations](https://youtu.be/2HhgLir6Jz0?list=PLUDTy1CWIw-qu2EuzNVFQawyW5jmC5W7G) by Brian Advent

[Creating cool animations in android using Lottie](https://www.youtube.com/watch?v=T4v72xJqNpQ)[Chetan Sachdeva](https://www.youtube.com/channel/UC_4TBWZcI-tdZ02wESTRVNw) by Chetan Sachdeva

[Boost Your User Experience with Lottie for React Native](https://blog.reactnativecoach.com/boost-your-user-experience-with-lottie-for-react-native-5da1ac589982) by Samuli Hakoniemi

[How to use 'Lottie' in Framer X](https://www.youtube.com/watch?v=GflnbO5RMZI) by ruucm
