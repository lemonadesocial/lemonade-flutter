# Lemonade Flutter App
## Build Status

### Build Staging iOS

| Environment             | Status                                                                                                    |
|-------------------------|-----------------------------------------------------------------------------------------------------------|
| Build Staging iOS       | [![iOS Staging Build Status](https://api.codemagic.io/apps/6493f698db20b1801c5e821b/ios-staging/status_badge.svg)](https://codemagic.io/apps/6493f698db20b1801c5e821b/ios-staging/latest_build)       |
| Build Staging Android   | [![Android Staging Build Status](https://api.codemagic.io/apps/6493f698db20b1801c5e821b/android-staging/status_badge.svg)](https://codemagic.io/apps/6493f698db20b1801c5e821b/android-staging/latest_build)   |
| Build Production (iOS and Android)       | [![iOS and Android Production Build Status](https://api.codemagic.io/apps/6493f698db20b1801c5e821b/ios-android-production/status_badge.svg)](https://codemagic.io/apps/6493f698db20b1801c5e821b/ios-android-production/latest_build) |

## Introduction

## Installation Guide

To run the Lemonade Flutter app, you need to set up a `.env` configuration file containing the required variables. Follow the steps below:

1. Create a `.env` file in the root directory of the project.
2. Ask team member about `.env` config file

## Setup commitlint check in local

Follow [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/)

1. cd scripts
2. Execute `./install_dev_env.sh`
3. After this setup, everytime time you commit code, it's will automate trigger check your commit conventions

### Build and run the app with Flutter

Recommend to use fvm [Flutter version management](https://fvm.app/) and use Flutter version 3.16.9 and Dart 3.2.6

How to install & use

```
fvm install 3.16.9
fvm use 3.16.9
```

How to run Staging & Production
```
fvm flutter run --flavor staging  --target lib/main_staging.dart
fvm flutter run --flavor production  --target lib/main_production.dart
```

With the `.env` file configured and the app built and run via Flutter, you can now successfully use the Lemonade Flutter app.

## How to obtain the debug.keystore

The debug.keystore is a crucial file required for Android app development and debugging in Flutter projects. To ensure security, this file should not be publicly shared or included in version control.

If you need access to the debug.keystore for this project, please contact the engineering team responsible for project management. They will provide you with the necessary file for your development purposes.

After obtaining the debug.keystore, move the file to the `android/app`` folder of your Flutter project. This location is where the Android build process expects to find the debug.keystore for signing the app during development and debugging. Placing it there will enable a seamless build process for your Flutter project on Android.

## Check app version

Appcast, in this Flutter package, is used by the upgrader widgets to download app details from an appcast, based on the Sparkle framework by Andy Matuschak. You can read the Sparkle documentation here: https://sparkle-project.org/documentation/publishing/.

An appcast is an RSS feed with one channel that has a collection of items that each describe one app version. The appcast will describe each app version and will provide the latest app version to upgrader that indicates when an upgrade should be recommended.

- Staging : appcast_staging.xml
- Production : appcast.xml

Uncomment this one to force update app version
```xml
<!-- Force update version -->
<!-- <sparkle:tags> <sparkle:criticalUpdate /> </sparkle:tags> -->
```
## How to test Stripe payment on staging
- In order to test payment with Stripe properly, you can use one of the demo card provided by Stripe. The card list can be found [here](https://stripe.com/docs/testing#cards)

## How to fix when sign commit gpg stuck

rm -rf ~/.gnupg/*.lock

rm -rf ~/.gnupg/public-keys.d/*.lock