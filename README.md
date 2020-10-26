# Lottie Documentation

This repo is the home of the unified Lottie docs hosted at [http://airbnb.io/lottie](http://airbnb.io/lottie). This repo is NOT the place to contribute to or report issues on any of the players or the After Effects plugin.

# Looking for the libraries?
## Official Libraries
* [Android](https://github.com/airbnb/lottie-android/)
* [iOS](https://github.com/airbnb/lottie-ios/)
* [Web](https://github.com/airbnb/lottie-web/)
* [After Effects Plugin](https://github.com/airbnb/lottie-web/)

## Unofficial Libraries
* [React Native](https://github.com/lottie-react-native/lottie-react-native)
* [Windows](https://github.com/windows-toolkit/Lottie-Windows)
* [Qt](https://blog.qt.io/blog/2019/03/08/announcing-qtlottie/)
* [Skia](https://skia.org/user/modules/skottie)
* [Xamarin](https://github.com/martijn00/LottieXamarin)
* [NativeScript](https://github.com/bradmartin/nativescript-lottie)
* [Axway Appcelerator](https://github.com/m1ga/ti.animation)
* [Qt QML](https://sea-region.github.com/kbroulik/lottie-qml)
* [Rlottie](https://github.com/Samsung/rlottie)
* [Python](https://gitlab.com/mattia.basaglia/python-lottie)


# Contributing to the docs directly on GitHub (easy)
Because the Lottie docs are created directly from the markdown in this repo, you can use the GitHub web editor to edit and propose changes to the docs directly from your browser without any knowledge of git.
To do that, find the markdown file with the docs you want to edit and follow [GitHub's instructions](https://docs.github.com/en/free-pro-team@latest/github/managing-files-in-a-repository/editing-files-in-another-users-repository) to edit and propose changes to a markdown file. Once approved, the docs will be updated immediately.

# Contributing to the docs by forking this repo (still pretty easy)
[http://airbnb.io/lottie](http://airbnb.io/lottie) runs on [docsify](https://docsify.js.org/#/?id=docsify). Docsify was chosen because it takes hosted markdown and generates the page dynamically. That means that simply updating the markdown files here is all that is needed to update [http://airbnb.io/lottie](http://airbnb.io/lottie).

1. Fork and clone this repo.
1. Install docsify: `sudo npm instal -g docsify-cli`.
1. Startup the local docsify server with `docsify serve .` from the root of this repo.
1. Edit the markdown and verify your changes on the localhost url outputted from the `docsify serve` command.
1. Put up a pull request to this repo and tag `@gpeal`
1. Enjoy the updated docs!