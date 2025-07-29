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

**Prebuild**

Generate generated file 

```
./build_runner.sh
```

Generate i18n

```
./gen_i18n.sh
```

How to install & use

```
fvm install 3.24.1
fvm use 3.24.1
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

```
rm -rf ~/.gnupg/*.lock
rm -rf ~/.gnupg/public-keys.d/*.lock
```

# Lemonade Social App - Folder Structure & Functionality

## Overview

**Lemonade Social App** is a comprehensive Flutter-based social networking platform that combines traditional social features with Web3 capabilities. Version 2.8.0 supports iOS, Android, and Web platforms, built using Clean Architecture patterns with BLoC state management.

## Core Functionality

### 🚀 Main Features

#### 1. **Social Networking**
- **Posts & Newsfeed**: Create and share text/media posts with community
- **User Profiles**: Complete profile management with photos, bio, social handles
- **Social Connections**: Follow/unfollow users, friend requests, blocking functionality
- **Content Discovery**: Discover trending posts, users, and content

#### 2. **Event Management**
- **Event Creation**: Support for virtual, offline, and hybrid events
- **Event Ticketing**: Integrated ticketing system with payment processing
- **RSVP System**: Event registration and attendance tracking
- **POAP Integration**: Turn event tickets into digital collectibles
- **Event Discovery**: Browse and discover local and virtual events

#### 3. **Communication**
- **Matrix-based Chat**: Real-time messaging using Matrix protocol (deprecated)
- **Rooms & Guilds**: Create private/public chat rooms and communities (deprecated)
- **Community Spaces**: Organized spaces with membership management (deprecated)
- **Direct Messaging**: One-on-one private conversations (deprecated)

#### 4. **Web3 Integration**
- **Wallet Connectivity**: Support for multiple crypto wallets via WalletConnect
- **Lens Protocol**: Integration with Lens social protocol
- **Farcaster**: Connect and interact with Farcaster network (deprecated)
- **NFT Support**: Display and manage NFT collections
- **Token Gating**: Access control based on token ownership

#### 5. **Rewards & Gamification**
- **Quest System**: Complete tasks to earn rewards
- **Token Rewards**: Earn tokens for various activities
- **Points Tracking**: Comprehensive point system for user engagement
- **Achievements**: Badge system for user accomplishments

#### 6. **AI Integration**
- **AI Chat Assistant**: Integrated AI for content creation and assistance
- **Smart Content Creation**: AI-powered post and event creation helpers

#### 7. **Payment & Commerce**
- **Stripe Integration**: Secure payment processing
- **Crypto Payments**: Support for cryptocurrency transactions
- **Vault System**: Secure wallet management (deprecated)

## 📁 Folder Structure

### Root Directory
```
lemonade-flutter-refactor/
├── android/              # Android platform configuration
├── ios/                  # iOS platform configuration  
├── web/                  # Web platform assets
├── windows/              # Windows platform support
├── linux/                # Linux platform support
├── macos/                # macOS platform support
├── assets/               # Static assets (fonts, icons, images)
├── lib/                  # Main Flutter application code
├── test/                 # Unit and widget tests
├── scripts/              # Build and deployment scripts
├── docs/                 # Documentation
└── packages/             # Custom packages
```

### Core Application Structure (`lib/`)

#### **Main Application Files**
- `app.dart` - Main app widget with providers and routing setup
- `main_*.dart` - Environment-specific entry points (development, staging, production)

#### **Core Architecture (`lib/core/`)**

##### **Application Layer (`lib/core/application/`)**
Business logic and use cases organized by domain:
- `auth/` - Authentication and user session management
- `event/` - Event creation, management, and discovery (39 subdirectories)
- `chat/` - Real-time messaging and communication
- `profile/` - User profile management
- `payment/` - Payment processing and transactions
- `wallet/` - Cryptocurrency wallet integration
- `lens/` - Lens Protocol integration
- `farcaster/` - Farcaster network integration
- `notification/` - Push and in-app notifications
- `quest/` - Gamification and reward system
- `space/` - Community space management
- `token/` - Token and NFT handling
- `vault/` - Secure storage management
- `newsfeed/` - Social feed functionality
- `post/` - Content creation and sharing

##### **Domain Layer (`lib/core/domain/`)**
Business entities and repository interfaces:
- Defines core business entities for each domain
- Repository interfaces for data access
- Business rules and domain logic

##### **Data Layer (`lib/core/data/`)**
Data access and external service integration:
- Repository implementations
- Data transfer objects (DTOs)
- External API clients

##### **Service Layer (`lib/core/service/`)**
External service integrations:
- Firebase services
- Matrix chat service
- Wallet connectivity
- OAuth providers
- Lens and Farcaster APIs

##### **Presentation Layer (`lib/core/presentation/`)**
UI components and utilities:
- Reusable widgets
- Page layouts
- Utility functions

#### **Feature Organization**

##### **GraphQL Integration (`lib/graphql/`)**
- `backend/` - Main backend API operations
- `lens/` - Lens Protocol GraphQL operations
- `farcaster_airstack/` - Farcaster data operations
- `ai/` - AI service operations
- `cubejs/` - Analytics operations

##### **Internationalization (`lib/i18n/`)**
Multi-language support with domain-specific translations:
- `auth/`, `chat/`, `event/`, `profile/`, etc.
- JSON-based translation files
- Dynamic language switching

##### **Routing (`lib/router/`)**
- `app_router.dart` - Main routing configuration
- Feature-specific route definitions
- Deep linking support

##### **Theming (`lib/theme/` & `lib/app_theme/`)**
- Color schemes and palettes
- Typography definitions
- Dark/light theme support
- Dynamic theming

#### **Configuration & Setup**

##### **Dependency Injection (`lib/injection/`)**
- Service registration and dependency management
- Modular architecture support

##### **Environment Configuration**
- `.env`, `.env.staging`, `.env.production` - Environment variables
- Multi-environment build support
- Feature flags and configuration

## 🏗️ Architecture Patterns

### **Clean Architecture**
- **Separation of Concerns**: Clear boundaries between layers
- **Dependency Inversion**: Dependencies point inward toward business logic
- **Testability**: Each layer can be tested independently

### **State Management**
- **BLoC Pattern**: Business Logic Components for state management
- **Event-driven**: Reactive programming with streams
- **Global State**: Authentication, connectivity, wallet state

### **Data Flow**
```
UI → BLoC → Repository → Service → External APIs
```

## 🛠️ Development Workflow

### **Code Generation**
- **Freezed**: Immutable data classes and unions
- **JSON Serialization**: Automatic JSON parsing
- **GraphQL Code Generation**: Type-safe API operations
- **Build Runner**: Automated code generation

### **Multi-Environment Support**
- **Development**: Local development with debug features
- **Staging**: Testing environment with production-like setup
- **Production**: Live environment with optimizations

### **Build & Deployment**
- **CI/CD Pipeline**: Automated building and testing
- **Flavor-based Builds**: Different configurations per environment
- **Code Push**: Over-the-air updates via Shorebird

## 🔧 Key Technologies

### **Core Flutter Stack**
- **Flutter 3.24.1** with Dart 3.5.1
- **Material Design** with custom theming
- **Auto Route** for navigation
- **Flutter BLoC** for state management

### **Backend Integration**
- **GraphQL** for API communication
- **Matrix Protocol** for real-time chat
- **Firebase** for push notifications and analytics
- **Stripe** for payment processing

### **Web3 Technologies**
- **WalletConnect** for wallet integration
- **Lens Protocol** for decentralized social
- **Farcaster** for social networking
- **Web3Dart** for blockchain interactions

### **Development Tools**
- **Injectable/GetIt** for dependency injection
- **Freezed** for immutable classes
- **Sentry** for crash reporting
- **Flutter Gen** for asset generation

## 📱 Platform Support

### **Mobile Platforms**
- **iOS**: Native iOS app with platform-specific features
- **Android**: Native Android app with material design

## 🚀 Getting Started

### **Prerequisites**
- Flutter 3.24.1 (managed via FVM)
- Environment configuration files (.env)
- Platform-specific setup (Android Studio, Xcode)

### **Development Commands**
```bash
# Code generation
./build_runner.sh

# Internationalization
./gen_i18n.sh

# Run specific environments
fvm flutter run --flavor staging --target lib/main_staging.dart
fvm flutter run --flavor production --target lib/main_production.dart
```

## 📊 Key Metrics & Features

- **39 Event-related modules** - Comprehensive event management
- **17 Event ticketing modules** - Advanced ticketing system
- **300+ SVG icons** - Rich iconography
- **Multi-language support** - Global accessibility
- **Real-time communication** - Matrix-based messaging
- **Web3 ready** - Full cryptocurrency integration

---

*This documentation provides a high-level overview of the Lemonade Social App architecture and functionality. For detailed implementation guidelines, refer to the individual module documentation and code comments.* 