# Replacing a static asset with Lottie
One of the primary motivations behind Lottie is to make shipping animations just as easy as shipping static assets.

### Switch from static assets to animations with 3 lines of code!

## Static Asset Workflow
Put your pngs or vector drawables (xml) in `res/drawable`
Include it in your layout
```xml
<ImageView
        android:id="@+id/image_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:scaleType="centerCrop"
        android:src="@drawable/your_drawable" />
```

## Lottie workflow

Put your lottie json in `res/raw`
Include it in your layout:
```xml
<com.airbnb.lottie.LottieAnimationView
        android:id="@+id/animation_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:scaleType="centerCrop"
        app:lottie_rawRes="@raw/your_animation"
        app:lottie_loop="true"
        app:lottie_autoPlay="true" />
```

`LottieAnimationView` extends `ImageView` so you can start by simply replacing your ImageViews with LottieAnimationViews even if you are still using drawables!
