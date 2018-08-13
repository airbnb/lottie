# Images

Lottie is designed to work with vector shapes. Although Lottie supports rendering images, there are disadvantages to using them:
* The files are an order of magnitude larger than their equivalent vector animation.
* They get pixelated when scaled.
* They add complexity to the animation. Instead of one file, you have the json file plus all of the images.

A common cause of images in Lottie files is that bodymovin exports Illustrator layers from After Effects as images. If you think this might be the case, follow the instructions [here](/after-effects/artwork-to-lottie-walkthrough.md).

## Setting your images
You can set Lottie images in three ways:
### src/assets
If you do need to use images, put the images in a folder inside of `src/assets` and don't change the filenames of the images. You then need to direct Lottie to the assets folder where the images are stored by calling `setImageAssetsFolder` on `LottieAnimationView` or
`LottieDrawable` with the relative folder inside of assets. Again,make sure that the images that
bodymovin export are in that folder with their names unchanged (should be img_#).
If you use `LottieDrawable` directly.
You should call `recycleBitmaps` when you are done animating.
### Zip file
Alternatively, you can create a zip file with your json and images together. Lottie can unzip and read the contents. This can be done for local files or from a url.
### Providing your own images
Sometimes, you don't have the images bundled with the device. You may do this to save space in your apk or if you downloaded the animation from the network. To handle this case, you can set an `ImageAssetDelegate` on your `LottieAnimationView` or `LottieDrawable`. The delgate will be called every time Lottie tries to render an image. It will pass the image name and ask you to return the bitmap. If you don't have it yet (if it's still downloading, for example) then just return null and Lottie will continue to ask on every frame until you return a non-null value.

 ```java
animationView.setImageAssetDelegate(new ImageAssetDelegate() {
  @Override public Bitmap fetchBitmap(LottieImageAsset asset) {
    if (downloadedBitmap == null) {
      // We don't have it yet. Lottie will keep
      // asking until we return a non-null bitmap.
      return null;
    }
    return downloadedBitmap;
  }
});
```