# Troubleshooting

## Missing masks
For missing mask in Safari browser, please anim.setLocationHref(locationHref) before animation is generated. It usually caused by usage of base tag in html. (see above for description of setLocationHref)

## Cameras

You can use a 3d one-node or two-node Camera.
Camera options are not exportable. The idea of using a camera is to provide a moving point of view for the composition.
You can parent layers to the camera, but you can't parent the camera to any layer. It will probably be supported soon.

## Masks and 3d don't go well together on browsers.

So if you mask a layer it will lose it's 3d properties. What you can do, is use masks inside 3d comps that have 2d layers.

## Scaling and z axis.

If an element needs to be rendered larger than the original size, it won't be smoothed since browsers promote layers to hardware rendering as textures and they won't redraw them as vectors like the canvas and svg renderers do.

## Text
* Text boxes can't contain more than one style (AE doesn't expose multi font text layers).
* Many paragraph and character settings are not supported yet.
* Some fonts have special combinations of chars that are spaced differently than default. These are not supported yet, they will be spaced as any other char and you might notice some differences.
* Some fonts can't be converted to glyphs on AE and will result on an error on the plugin. I've seen this behavior specially with fonts that simulate pixelled fonts.
* If you use Typekit fonts, make sure you load them on a single kit, and provide for each font the css Selector displayed on the kit editor.