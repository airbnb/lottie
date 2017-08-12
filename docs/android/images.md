# Images
You can animate images if your animation is loaded from assets and your image file is in a
subdirectory of assets. Just call `setImageAssetsFolder` on `LottieAnimationView` or
`LottieDrawable` with the relative folder inside of assets and make sure that the images that
bodymovin export are in that folder with their names unchanged (should be img_#).
If you use `LottieDrawable` directly, you should call `recycleBitmaps` when you are done with it.

If you need to provide your own bitmaps if you downloaded them from the network or something, you
 can provide a delegate to do that:
 ```java
animationView.setImageAssetDelegate(new ImageAssetDelegate() {
  @Override public Bitmap fetchBitmap(LottieImageAsset asset) {
    // Your bitmap fetching code
  }
});
```