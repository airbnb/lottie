## Getting Started

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
project(':lottie-react-native').projectDir = new File(rootProject.projectDir, '../node_modules/lottie-react-native/lib/android')
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

With this change you should be ready to go.

Lottie's animation progress can be controlled with an `Animated` value:

```jsx
import React from 'react';
import { Animated } from 'react-native';
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
