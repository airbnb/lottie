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
Refer to the troubleshooting guilds on [Android](/android/troubleshooting.md) or [iOS](/ios/troubleshooting.md).