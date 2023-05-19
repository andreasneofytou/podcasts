# Podcasts

# Updating JSON Models

`dart run build_runner build`

# Updating packages

If you’ve modified your pubspec.yaml file, or you want to update only the packages that your app depends upon (instead of both the packages and Flutter itself), then use one of the flutter pub commands.

To update to the latest compatible versions of all the dependencies listed in the pubspec.yaml file, use the upgrade command:

`flutter pub upgrade`

To identify out-of-date package dependencies and get advice on how to update them, use the outdated command. For details, see the Dart pub outdated documentation.

`dart pub outdated --color`

# Emulator

`emulator -avd Pixel_XL_API_26 -no-snapshot-load`

# Useful tools

[Icon maker](https://easyappicon.com/)
[Colour palettes](https://coolors.co/)
[Splashscreen generator](https://apetools.webprofusion.com/)
[Flutter examples](https://flutterexamples.com/)
[Material icons](https://material.io/resources/icons/?style=baseline)

# Android Key Properties file layout

# Name the file key.properties

storePassword=**123
keyPassword=**3
keyAlias=key
storeFile=C:\\Users\\Varun\\Desktop\\\*\*\*.jks

# Generate icons according to our configuration

https://apetools.webprofusion.com/#/tools/imagegorilla

`flutter pub run flutter_launcher_icons:main`

# Publish Android version

First, make sure that `android/key.properties` exist

`flutter build appbundle`

## Publish iOS version

`flutter build ipa`

`open build/ios/archive/Runner.xcarchive`
