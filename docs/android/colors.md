# Dynamic Colors

You can add a color filter to the whole animation, a specific layer, or specific content within a layer:
```java
// Any class that conforms to the ColorFilter interface
PorterDuffColorFilter colorFilter = new PorterDuffColorFilter(Color.RED, PorterDuff.Mode.LIGHTEN);

// Color filter helper supplied by Lottie
colorFilter = new SimpleColorFilter(Color.RED);

// Adding a color filter to the whole view
animationView.addColorFilter(colorFilter);

// Adding a color filter to a specific layer
animationView.addColorFilterToLayer("hello_layer", colorFilter);

// Adding a color filter to specfic content on the "hello_layer"
animationView.addColorFilterToContent("hello_layer", "hello", colorFilter);

// Clear all color filters
animationView.clearColorFilters();
```
You can also add a color filter to the whole animation in the layout XML, which will be applied with `PorterDuff.Mode.SRC_ATOP`:

```xml
<com.airbnb.lottie.LottieAnimationView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        app:lottie_fileName="hello-world.json"
        app:lottie_colorFilter="@color/blue" />
```

Note: Color filters are only available for layers such as Image layer and Solid layer as well as content that includes fill, stroke, or group content.
