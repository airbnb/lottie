# Getting Started

## Previewing Lottie JSON Files

Use the [Lottie Viewer application](https://aka.ms/lottieviewer) to test the visual accuracy of your Lottie animations and identify potential issues. 
Simply use drag-and-drop or use a file-picker to open local JSON files and URIs. A warning icon may light up to indicate any issues with your animation.

<a><img src='/images/windows/windows_lottieviewer.gif' alt='Lottie Viewer gif' width='600px'/></a>

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
to decide which is best suited for your application, check out [this comparison](https://docs.microsoft.com/windows/communitytoolkit/animations/lottie-scenarios/json_codegen). Here's how all the pieces fit in together:

<img src="/images/windows/windows_workflow.png" alt="Workflow" width="450"/>
