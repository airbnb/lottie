# HTML player installation
## Static URL
여기에서 스크립트 파일을 사용할 수 있습니다.
https://cdnjs.com/libraries/lottie-web

## From Extension
플레이어 가져 오기를 클릭하여 AE 플러그인에서 직접 가져 오기

## lottie light
확장 프로그램에는 svg로 내 보낸 애니메이션을 재생할`lottie_light.js`가 포함되어 있습니다.

## NPM
```bash
npm install lottie-web
```

## Bower
```bash
bower install lottie-web
```

### HTML
- 최신 빌드를 위해 lottie.js 파일을 build / player / 폴더에서 가져옵니다.
- html에 .js 파일을 포함하십시오 (프로덕션을 위해 gzip을 기억하십시오)
```html
<script src="js/lottie.js" type="text/javascript"></script>
```

lottie.loadAnimation ()을 호출하여 애니메이션을 시작할 수 있습니다.
다음과 같이 객체를 고유 한 매개 변수로 사용합니다.
- animationData: export 된 애니메이션 데이터를 가지는 Object
- path: 애니메이션 객체에 대한 상대 경로. (animationData와 path는 함께 사용할 수 없습니다.
- loop: true / false / number
- autoplay: true / false 준비가되면 바로 재생을 시작합니다.
- name: 나중에 참조 할 수 있도록 애니메이션 이름
- renderer: 'svg' / 'canvas' / 'html' 렌더러를 설정하는 방법
- container: 애니메이션을 렌더링 할 DOM 요소


play, pause, setSpeed ​​등으로 제어 할 수있는 애니메이션 인스턴스를 반환합니다.

```js
lottie.loadAnimation({
  container: element, // the dom element that will contain the animation
  renderer: 'svg',
  loop: true,
  autoplay: true,
  path: 'data.json' // the path to the animation json
});
```

## Usage

애니메이션 인스턴스에는 다음과 같은 주요 메소드가 있습니다.
**anim.play()** <br/>
**anim.stop()** <br/>
**anim.pause()** <br/>
**anim.setLocationHref(locationHref)** -- one param usually pass as `location.href`. Its useful when you experience mask issue in safari where your url does not have `#` symbol. <br/>
**anim.setSpeed(speed)** -- one param speed (1 is normal speed) <br/>
**anim.goToAndStop(value, isFrame)** first param is a numeric value. second param is a boolean that defines time or frames for first param <br/>
**anim.goToAndPlay(value, isFrame)** first param is a numeric value. second param is a boolean that defines time or frames for first param <br/>
**anim.setDirection(direction)** -- one param direction (1 is normal direction.) <br/>
**anim.playSegments(segments, forceFlag)** -- first param is a single array or multiple arrays of two values each(fromFrame,toFrame), second param is a boolean for forcing the new segment right away<br/>
**anim.setSubframe(flag)** -- If false, it will respect the original AE fps. If true, it will update as much as possible. (true by default)<br/>
**anim.destroy()**<br/>

lottie에는 8 가지 주요 방법이 있습니다.
**lottie.play()** -- with 1 optional parameter **name** to target a specific animation <br/>
**lottie.stop()** -- with 1 optional parameter **name** to target a specific animation <br/>
**lottie.setSpeed()** -- first param speed (1 is normal speed) -- with 1 optional parameter **name** to target a specific animation <br/>
**lottie.setDirection()** -- first param direction (1 is normal direction.) -- with 1 optional parameter **name** to target a specific animation <br/>
**lottie.searchAnimations()** -- looks for elements with class "lottie" <br/>
**lottie.loadAnimation()** -- Explained above. returns an animation instance to control individually. <br/>
**lottie.destroy()** -- To destroy and release resources. The DOM element will be emptied.<br />
**lottie.registerAnimation()** -- you can register an element directly with registerAnimation. It must have the "data-animation-path" attribute pointing at the data.json url<br />
**lottie.setQuality()** -- default 'high', set 'high','medium','low', or a number > 1 to improve player performance. In some animations as low as 2 won't show any difference.<br />

## Events
- onComplete
- onLoopComplete
- onEnterFrame
- onSegmentStart

addEventListener를 다음 이벤트와 함께 사용할 수도 있습니다.
- complete
- loopComplete
- enterFrame
- segmentStart
- config_ready (when initial config is done)
- data_ready (when all parts of the animation have been loaded)
- DOMLoaded (when elements have been added to the DOM)
- destroy

#### Other loading options
- 기존 캔버스를 사용하여 그리려면 다음과 같은 추가 객체 인 'renderer'를 전달하면됩니다.
```js
lottie.loadAnimation({
  container: element, // the dom element
  renderer: 'svg',
  loop: true,
  autoplay: true,
  animationData: animationData, // the animation data
  rendererSettings: {
    context: canvasContext, // the canvas context
    scaleMode: 'noScale',
    clearCanvas: false,
    progressiveLoad: false, // Boolean, only svg renderer, loads dom elements when needed. Might speed up initialization for large number of elements.
    hideOnTransparent: true //Boolean, only svg renderer, hides elements when opacity reaches 0 (defaults to true)
  }
});
```
이렇게하면 각 프레임 후에 캔바스를 처리해야합니다.
<br/>

애니메이션을로드하는 또 다른 방법은 dom 요소에 특정 속성을 추가하는 것입니다.
div를 포함 시켜서 lottie 클래스로 설정해야합니다.
페이지를로드하기 전에 작업하면 자동으로 "lottie"클래스의 모든 태그를 검색합니다.
또는 페이지로드 후 lottie.searchAnimations ()를 호출하면 클래스 "lottie"가있는 모든 요소를 ​​검색합니다.
<br/>
- add the data.json to a folder relative to the html
- create a div that will contain the animation.
<br/>
 **Required**
 <br/>
 . a class called "lottie"
 . a "data-animation-path" attribute with relative path to the data.json
 <br/>
**Optional**
<br/>
 . a "data-anim-loop" attribute
 . a "data-name" attribute to specify a name to target play controls specifically
 <br/>
 **Example**
 <br/>
```html
 <div style="width:1067px;height:600px" class="lottie" data-animation-path="animation/" data-anim-loop="true" data-name="ninja"></div>
```
<br/>
