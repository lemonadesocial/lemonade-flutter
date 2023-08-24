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

1. Open a terminal or command prompt and navigate to the project directory.
2. If you haven't enabled Flutter on your machine, visit the [Flutter installation guide](https://flutter.dev/docs/get-started/install) and follow the instructions for your operating system.
3. Ensure you have the appropriate Flutter devices set up by running `flutter devices`. If no devices are found or configured, follow the [device setup instructions](https://flutter.dev/docs/get-started/install).
4. Run the app by executing `flutter run`.

With the `.env` file configured and the app built and run via Flutter, you can now successfully use the Lemonade Flutter app.

## How to obtain the debug.keystore

The debug.keystore is a crucial file required for Android app development and debugging in Flutter projects. To ensure security, this file should not be publicly shared or included in version control.

If you need access to the debug.keystore for this project, please contact the engineering team responsible for project management. They will provide you with the necessary file for your development purposes.

After obtaining the debug.keystore, move the file to the `android/app`` folder of your Flutter project. This location is where the Android build process expects to find the debug.keystore for signing the app during development and debugging. Placing it there will enable a seamless build process for your Flutter project on Android.