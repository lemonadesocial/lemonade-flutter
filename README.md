# Lemonade Mobile Application

## Project Overview

Lemonade is a cutting-edge mobile application built with Flutter, designed to create seamless social and event experiences. The platform enables users to discover, host, and participate in events, connect with collaborators, and engage in a vibrant community ecosystem.

### Key Features

- 🎉 Event Creation and Management
- 👥 Collaborative Networking
- 🎫 Ticket Purchasing and Management
- 💬 Social Interaction and Messaging
- 🏆 Achievement and Reward Systems
- 🌐 Web3 and Blockchain Integration

## Supported Platforms

- **Android**: Fully supported
- **iOS**: Fully supported
- Minimum Android SDK version: 21
- Minimum iOS version: 13.0

## Prerequisites

Before getting started, ensure you have the following installed:

- Flutter SDK (version 3.16.9)
- Dart SDK (version 3.2.6)
- [Flutter Version Management (FVM)](https://fvm.app/)
- Android Studio or Xcode
- Git

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-organization/lemonade-flutter-app.git
cd lemonade-flutter-app
```

### 2. Install Flutter Version Management (FVM)

```bash
dart pub global activate fvm
fvm install 3.16.9
fvm use 3.16.9
```

### 3. Configure Environment

1. Create a `.env` file in the root directory
2. Request the `.env` configuration from your team lead or project manager

### 4. Install Dependencies

```bash
fvm flutter pub get
```

## Running the Application

### Staging Environment

```bash
fvm flutter run --flavor staging --target lib/main_staging.dart
```

### Production Environment

```bash
fvm flutter run --flavor production --target lib/main_production.dart
```

## Project Structure

```
lib/
├── core/
│   ├── application/   # Business logic and state management
│   ├── data/          # Data sources and repositories
│   ├── domain/        # Domain models and entities
│   ├── presentation/  # UI components and pages
│   └── service/       # Platform-specific services
├── graphql/           # GraphQL schemas and operations
├── i18n/              # Internationalization files
├── router/            # App navigation configuration
└── theme/             # Design system and styling
```

## Technologies Used

- **Framework**: Flutter
- **State Management**: BLoC
- **GraphQL**: Apollo Client
- **Authentication**: Firebase
- **Payments**: Stripe
- **Web3**: WalletConnect, Ethereum
- **Internationalization**: flutter_localizations
- **Navigation**: go_router

## Build and Deployment

### iOS

- Use Xcode to build and sign the app
- Deploy through TestFlight for beta testing
- App Store Connect for production release

### Android

- Generate signed APK/AAB using Android Studio
- Deploy through Google Play Console
- Use Codemagic for CI/CD

## License

[Specify your license type, e.g., MIT, Apache 2.0]

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes following [Conventional Commits](https://www.conventionalcommits.org/)
4. Open a pull request

## Support

For issues, feature requests, or support, please [open an issue](https://github.com/your-organization/lemonade-flutter-app/issues) on GitHub.

## Build Status

| Environment | Status |
|------------|--------|
| Staging iOS | [![iOS Staging Build](https://api.codemagic.io/apps/6493f698db20b1801c5e821b/ios-staging/status_badge.svg)](https://codemagic.io/apps/6493f698db20b1801c5e821b/ios-staging/latest_build) |
| Staging Android | [![Android Staging Build](https://api.codemagic.io/apps/6493f698db20b1801c5e821b/android-staging/status_badge.svg)](https://codemagic.io/apps/6493f698db20b1801c5e821b/android-staging/latest_build) |
| Production (iOS & Android) | [![Production Build](https://api.codemagic.io/apps/6493f698db20b1801c5e821b/ios-android-production/status_badge.svg)](https://codemagic.io/apps/6493f698db20b1801c5e821b/ios-android-production/latest_build) |