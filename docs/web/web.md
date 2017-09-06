## Getting Started
Bodymovin can render Lottie JSON files on the web.

First, get the bodymovin player javascript library. It is statically hosted at [https://cdnjs.com/libraries/bodymovin](https://cdnjs.com/libraries/bodymovin) or you can get the javascript directly by clicking `Get Player` in the bodymovin plugin.

```html
<script src="js/bodymovin.js" type="text/javascript"></script>
<!-- OR -->
<script src="https://cdnjs.com/libraries/bodymovin" type="text/javascript"></script>
```

Bodymovin is also available on npm and bower.

Then playing the animation is as simple as:
```javascript
var animation = bodymovin.loadAnimation({
  container: document.getElementById('lottie'), // Required
  path: 'data.json', // Required
  renderer: 'svg/canvas/html', // Required
  loop: true, // Optional
  autoplay: true, // Optional
  name: "Hello World", // Name for future reference. Optional.
})
```