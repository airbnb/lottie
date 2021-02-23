# Getting Started

## Previewing Lottie JSON Files

Use the [Lottie Viewer application](https://aka.ms/lottieviewer) to test the visual accuracy of your Lottie animations and identify potential issues. 
Simply use drag-and-drop or use a file-picker to open local JSON files and URIs. A warning icon may light up to indicate any issues with your animation.

![Lottie Viewer gif](/images/windows_lottieviewer.gif ':width=600')

<a href='https://www.microsoft.com/store/apps/9p7x9k692tmw?ocid=badge'><img src='https://assets.windowsphone.com/13484911-a6ab-4170-8b7e-795c1e8b4165/English_get_L_InvariantCulture_Default.png' alt='English badge' width='127px' height='52px'/></a>

## Using JSON 

To get started with Lottie-Windows, you will require:

*  Windows 10 SDK version 1809 (17763) or above
* [Microsoft.UI.Xaml nuget package](https://www.nuget.org/packages/Microsoft.UI.Xaml/) which contains the [AnimatedVisualPlayer](https://www.docs.microsoft.com/uwp/api/microsoft.ui.xaml.controls.animatedvisualplayer) XAML element
* [Microsoft.Toolkit.Uwp.UI.Lottie nuget package](https://www.nuget.org/packages/Microsoft.Toolkit.Uwp.UI.Lottie/) which produces a [LottieVisualSource](https://docs.microsoft.com/dotnet/api/microsoft.toolkit.uwp.ui.lottie.lottievisualsource)

```xaml
    xmlns:lottie="using:Microsoft.Toolkit.Uwp.UI.Lottie"
    xmlns:winui="using:Microsoft.UI.Xaml.Controls"
```

You can now bring high-quality, resolution-independent vector animations to your Windows applications with just a couple of lines of XAML:

```xaml
    <!--  AnimatedVisualPlayer with AutoPlay  -->
    <winui:AnimatedVisualPlayer x:Name="LottiePlayer">
        <!--  LottieVisualSource that parses a JSON Uri at run-time  -->
        <lottie:LottieVisualSource UriSource="ms-appx:///AnimatedVisuals/LottieLogo1.json" />
    </winui:AnimatedVisualPlayer>
```

For detailed steps and code samples for getting started with a JSON file, check out [this tutorial](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/getting_started_json).

## Using Codegen

In addition to using JSON files, Lottie-Windows allows you to use generated C# / C++ classes for better performance 
by avoiding the cost of parsing and translating JSON files at run-time. You may generate the code by using:

* [LottieGen command-line tool](https://aka.ms/lottiegen), or
* [Lottie Viewer application](https://github.com/windows-toolkit/Lottie-Windows/tree/master/LottieViewer#usage)

Having generated your C# or C++ class, you'll need to configure your AnimatedVisualPlayer to consume it:

```xaml
    <!--  AnimatedVisualPlayer with AutoPlay  -->
    <winui:AnimatedVisualPlayer x:Name="LottiePlayer">
        <!--  Codegen source with C# class: AnimatedVisuals/LottieLogo1.cs  -->
        <animatedvisuals:LottieLogo1 />
    </winui:AnimatedVisualPlayer>
```

For detailed steps and code samples for using codegen in lieu of JSON, check out [this tutorial](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/getting_started_codegen).

## JSON versus Codegen

Both approaches — JSON and Codegen — produce the same visual results but have different tradeoffs and workflows; 
to decide which is best suited for your application, check out [this comparison](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/json_codegen). Here's how all the pieces fit together:

![Workflow](/images/windows_workflow.png 'width=450')

# Tutorials

Here are [some tutorials](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie#tutorials) to help you with 
common Lottie animation scenarios, including:

* [Getting started with JSON](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/getting_started_json)
* [Using Codegen](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/getting_started_codegen)
* [JSON versus Codegen](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/json_codegen)
* [Configuring animation playback](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/playback)
* [Interactive segments on an animation timeline](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/segments)
* [Asynchronous Play method](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/async_play)
* [Handling failure and down-level](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/fallback)
    
## Code Samples

The [Lottie Samples application](https://aka.ms/lottiesamples) accompanies the tutorials by providing simple code examples. 
The source code for the samples may be [found here](https://github.com/windows-toolkit/Lottie-Windows/tree/master/samples).

![Lottie Samples image](/images/windows_lottiesamples.png ':width=600')

<a href='https://www.microsoft.com/store/apps/9n3j5tg8ff7f?ocid=badge'><img src='https://assets.windowsphone.com/13484911-a6ab-4170-8b7e-795c1e8b4165/English_get_L_InvariantCulture_Default.png' alt='English badge' width='127px' height='52px'/></a>

# Troubleshooting

Here's more information about supported AfterEffects features and issues you may enocunter:
* Comparative list of [supported AfterEffects features](supported-features.md) 
* Lottie-Windows [version history](https://github.com/windows-toolkit/Lottie-Windows/blob/master/VERSION_HISTORY.md)

## Help and Feedback

Feel free to reach out to us with questions, feedback, and bug reports [via Github](https://github.com/windows-toolkit/Lottie-Windows/issues).
