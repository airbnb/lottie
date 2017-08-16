## Getting Started
Get started with Lottie by installing the node module with yarn or npm:
<pre><code class="bash">yarn add lottie-react-native@{{ book.reactNativeVersion }}
# or
npm i --save lottie-react-native@{{ book.reactNativeVersion }}
</code></pre>

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

After this, open the Xcode project configuration and add the `Lottie.framework` as `Embedded Binaries`.

For android, you can `react-native link` as well:

```bash
react-native link lottie-react-native
```
or you can add it to your `build.gradle` file:
<pre><code class="lang-groovy">
dependencies {
  ...
  compile 'com.airbnb.android:lottie:{{ book.androidVersion }}'
  ...
}
</code></pre>

Lottie requires Android support library version 25. If you're using the `react-native init` template,
you may still be using 23. To change this, simply go to `android/app/build.gradle` and find the
`compileSdkVersion` option inside of the `android` block and change it to

```
android {
    compileSdkVersion 25 // <-- update this to 25
    // ...
```

With this change you should be ready to go.

Lottie's animation progress can be controlled with an `Animated` value:

```jsx
import React from 'react';
import { Animated } from 'react-native';
import Animation from 'lottie-react-native';

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
      <Animation
        style={{
          width: 200,
          height: 200,
        }}
        source={require('../path/to/animation.json')}
        progress={this.state.progress}
      />
    );
  }
}
```

Additionally, there is an imperative API which is sometimes simpler.

```jsx
import React from 'react';
import Animation from 'lottie-react-native';

export default class BasicExample extends React.Component {
  componentDidMount() {
    this.animation.play();
  }

  render() {
    return (
      <Animation
        ref={animation => { this.animation = animation; }}
        style={{
          width: 200,
          height: 200,
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