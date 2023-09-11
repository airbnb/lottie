# Getting Started

Get started with Lottie by installing the node module with yarn or npm:

<pre><code class="bash">yarn add lottie-react-native@{{ book.reactNativeVersion }}
# or
npm i --save lottie-react-native@{{ book.reactNativeVersion }}
</code></pre>

### iOS

If you're using CocoaPods on iOS, you can put the following in your `Podfile`:

```ruby
pod 'lottie-ios', :path => '../node_modules/lottie-ios'
pod 'lottie-react-native', :path => '../node_modules/lottie-react-native'
```

If you're not using CocoaPods on iOS, you can use `react-native link`:

```bash
react-native link lottie-ios
react-native link lottie-react-native
```

After this, open the Xcode project configuration and add the `Lottie.framework` as `Embedded
Binaries`.

### Android

For android, you can `react-native link` as well:

```bash
react-native link lottie-react-native
```

or you can add it manually:

`settings.gradle`:

<pre><code class="lang-groovy">
include ':lottie-react-native'
project(':lottie-react-native').projectDir = new File(rootProject.projectDir, '../node_modules/lottie-react-native/src/android')
</code></pre>

`build.gradle`:

<pre><code class="lang-groovy">
dependencies {
  ...
  compile project(':lottie-react-native')
  ...
}
</code></pre>

Lottie requires Android support library version 26. If you're using the `react-native init`
template, you may still be using 23. To change this, simply go to `android/app/build.gradle` and
find the `compileSdkVersion` option inside of the `android` block and change it to

```
android {
    compileSdkVersion 26 // <-- update this to 26
    // ...
```

You must also add the `LottiePackage` to `getPackages()` in your `ReactApplication`

```java
    import com.airbnb.android.react.lottie.LottiePackage;
    
    ...
    
    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          ...
          new LottiePackage()
      );
    }
  };
```

Then, go to `android/build.gradle` and make sure it has  :

```
allprojects {
    repositories {
        mavenLocal()
        jcenter()
        // Add the following 3 lines
        maven {
            url 'https://maven.google.com'
        }
        maven {
            // All of React Native (JS, Obj-C sources, Android binaries) is installed from npm
            url "$rootDir/../node_modules/react-native/android"
        }
    }
}
```

With this change you should be ready to go.

Lottie's animation progress can be controlled with an `Animated` value:

```jsx
import React from 'react';
import { Animated, Easing } from 'react-native';
import LottieView from 'lottie-react-native';

export default class BasicExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      progress: new Animated.Value(0),
    };
  }

  componentDidMount() {
    Animated.timing(this.state.progress, {
      toValue: 1,
      duration: 5000,
      easing: Easing.linear,
    }).start();
  }

  render() {
    return (
      <LottieView source={require('../path/to/animation.json')} progress={this.state.progress} />
    );
  }
}
```

Additionally, there is an imperative API which is sometimes simpler.

```jsx
import React from 'react';
import LottieView from 'lottie-react-native';

export default class BasicExample extends React.Component {
  componentDidMount() {
    this.animation.play();
    // Or set a specific startFrame and endFrame with:
    this.animation.play(30, 120);
  }

  render() {
    return (
      <LottieView
        ref={animation => {
          this.animation = animation;
        }}
        source={require('../path/to/animation.json')}
      />
    );
  }
}
```

## Sample App

You can check out the example project with the following instructions

1. Clone the repo: `git clone https://github.com/airbnb/lottie-react-native.git`
2. Open: `cd lottie-react-native` and Install: `npm install`
3. Run `npm start` to start the packager. ** The packager must be running to use the sample apps.**
4. In another CLI window, do the following:

For Running iOS:

1. If you don't have CocoaPods installed, run `bundle install`
2. Install pods: `npm run build:pods`
3. Run Example: `npm run run:ios`

For Running Android:

1. Run Example: `npm run run:android`

# Props

```
type AnimationProps = {
  // The source of animation. Can be referenced as a local asset by a string, or remotely
  // with an object with a `uri` property, or it can be an actual JS object of an
  // animation, obtained (for example) with something like
  // `require('../path/to/animation.json')`
  source: string | AnimationJson | { uri: string },

  // A number between 0 and 1, or an `Animated` number between 0 and 1. This number
  // represents the normalized progress of the animation. If you update this prop, the
  // animation will correspondingly update to the frame at that progress value. This
  // prop is not required if you are using the imperative API.
  progress: number | Animated = 0,

  // The speed the animation will progress. This only affects the imperative API. The
  // default value is 1.
  speed: number = 1,

  // A boolean flag indicating whether or not the animation should loop.
  loop: boolean = false,

  // Style attributes for the view, as expected in a standard `View`:
  // http://facebook.github.io/react-native/releases/0.39/docs/view.html#style
  // CAVEAT: border styling is not supported.
  style?: ViewStyle,

  // [Android] Relative folder inside of assets containing image files to be animated.
  // Make sure that the images that bodymovin export are in that folder with their names unchanged (should be img_#).
  // Refer to https://github.com/airbnb/lottie-android#image-support for more details.
  imageAssetsFolder: string,
};

```


Methods:

```
class Animation extends React.Component {

  // play the animation all the way through, at the speed specified as a prop.
  play();


  // Reset the animation back to `0` progress.
  reset();

}
```

# Troubleshooting

If you are trying to run `pod install` and you get:

```
[!] Unable to find a specification for `lottie-ios`
```

Run `pod repo update` and retry.

When your build fails with:

```
LottieReactNative/LRNContainerView.h: 'Lottie/Lottie.h' file not found
```

Add the `Lottie.framework` to the `Embedded Binaries` in your Xcode project configuration.

## Animation issues

Refer to the [troubleshooting guide](https://github.com/lottie-react-native/lottie-react-native#troubleshooting).
