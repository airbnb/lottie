# Adding Views to an Animation at Runtime

Not only can you [change animations at runtime](/ios/dynamic.md) with Lottie, you can also add custom UI to a LOTAnimation at runtime.
The example below shows some advance uses of this to create a dynamic image loader.

## A Dynamic Image Loading Spinner

![Spinner](/images/spinner.gif)

The example above shows a single LOTAnimationView that is set with a loading spinner animation. The loading spinner loops a portion of its animation while an image is downloaded asynchronously. When the download is complete, the image is added to the animation and the rest of the animation is played seamlessly. The image is cleanly animated in and a completion block is called.

![Spinner_Alt](/images/spinner_Alternative.gif)

Now, the animation has been changed by a designer and needs to be updated. All that is required is updating the JSON file in the bundle. No code change needed!

![Spinner_Dark](/images/spinner_DarkMode.gif)

Here, the design has decided to add a 'Dark Mode' to the app. Just a few lines of code change the color of the animation at runtime.


Pretty powerful eh?

Check out the code below for an example!
Download the After Effects file [here](/AEP/LoadingSpinner.zip)

```swift

import UIKit
import Lottie

class ViewController: UIViewController {
  
  var animationView: LOTAnimationView = LOTAnimationView(name: "SpinnerSpin");
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup our animaiton view
    animationView.contentMode = .scaleAspectFill
    animationView.frame = CGRect(x: 20, y: 20, width: 200, height: 200)

    self.view.addSubview(animationView)
    // Lets change some of the properties of the animation
    // We arent going to use the MaskLayer, so lets just hide it
    animationView.setValue(0, forKeypath: "MaskLayer.Ellipse 1.Transform.Opacity", atFrame: 0)
    // All of the strokes and fills are white, lets make them DarkGrey
    animationView.setValue(UIColor.darkGray, forKeypath: "OuterRing.Stroke.Color", atFrame: 0)
    animationView.setValue(UIColor.darkGray, forKeypath: "InnerRing.Stroke.Color", atFrame: 0)
    animationView.setValue(UIColor.darkGray, forKeypath: "InnerRing.Fill.Color", atFrame: 0)
    
    // Lets turn looping on, since we want it to repeat while the image is 'Downloading'
    animationView.loopAnimation = true
    // Now play from 0 to 0.5 progress and loop indefinitely.
    animationView.play(fromProgress: 0, toProgress: 0.5, withCompletion: nil)
    
    // Lets simulate a download that finishes in 4 seconds.
    let dispatchTime = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
      self.simulateImageDownloaded()
    }
  }
  
  func simulateImageDownloaded() {
    // Our downloaded image
    let image = UIImage(named: "avatar.jpg")
    let imageView = UIImageView(image: image)

    // We want the image to show up centered in the animation view at 150Px150P
    // Convert that rect to the animations coordinate space
    // The origin is set to -75, -75 because the origin is centered in the animation view
    let imageRect = animationView.convert(CGRect(x: -75, y: -75, width: 150, height: 150), toLayerNamed: nil)
    
    // Setup our image view with the rect and add rounded corners
    imageView.frame = imageRect
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = imageRect.width / 2;
    
    // Now we set the completion block on the currently running animation
    animationView.completionBlock = { (result: Bool) in ()
      // Add the image view to the layer named "TransformLayer"
      self.animationView.addSubview(imageView, toLayerNamed: "TransformLayer", applyTransform: true)
      // Now play the last half of the animation
      self.animationView.play(fromProgress: 0.5, toProgress: 1, withCompletion: { (complete: Bool) in
        // Now the animation has finished and our image is displayed on screen
        print("Image Downloaded and Displayed")
      })
    }
    
    // Turn looping off. Once the current loop finishes the animation will stop 
    // and the completion block will be called.
    animationView.loopAnimation = false
  }
  
}

```