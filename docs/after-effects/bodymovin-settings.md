# Composition Settings

In the Bodymovin panel each composition has a gear next to it which takes to you to the settings. Here is what each of those items means.

![Bodymovin settings](/images/BodymovinSettings.png)


**Split:** Attempts to exports animation in multiple json files. If the main comp has more than one layer, the exporter will segment your main comp considering where a layer starts in time.<br/>

**Glyphs:** When checked, it will convert all text characters to shapes. If unchecked, you need to provide a font file or a classname in order to render the correct font.<br/>

**Hidden:** When checked, it will include all hidden layers. This is usually needed when you have expressions pointing to hidden layers. Keep in mind that all hidden layers will get exported, adding to the final file size<br/>

**Guided:** When checked, it will include all guided layers. This is usually needed when you have expressions pointing to guided layers. Keep in mind that all guided layers will get exported, adding to the final file size<br/>

**Extra Comps:** You can select additional compositions to be exported as part of the animation. this is only needed if you have expressions pointing to external comps that not included in the main comp or subcomps tree<br/>

**Original Assets Name:** If you have rasterized assets like jpgs, it will export them to an images folder with their original source name.<br/>

**Standalone:** When checked, it will export the animation and the player all bundled into a single file. Might be useful if you only have one animation in your page. For example for delivering banners.<br/>

**Demo:** It will export a demo.html file so you can preview the animation easily.<br/>