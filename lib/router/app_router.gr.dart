// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/presentation/pages/auth/login_page.dart' as _i2;
import 'package:app/core/presentation/pages/event/event_detail_page.dart'
    as _i11;
import 'package:app/core/presentation/pages/event/events_listing_page.dart'
    as _i10;
import 'package:app/core/presentation/pages/home/home_page.dart' as _i1;
import 'package:app/core/presentation/pages/notification/notifications_listing_page.dart'
    as _i3;
import 'package:app/core/presentation/pages/profile/my_profile_page.dart'
    as _i5;
import 'package:app/core/presentation/pages/profile/profile_page.dart' as _i6;
import 'package:app/core/presentation/pages/root/empty_page.dart' as _i9;
import 'package:app/core/presentation/pages/root/root_page.dart' as _i8;
import 'package:app/core/presentation/pages/wallet/wallet_page.dart' as _i7;
import 'package:app/core/presentation/pages/webview/webview_page.dart' as _i4;
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/cupertino.dart' as _i14;
import 'package:flutter/material.dart' as _i13;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.NotificationPage(),
      );
    },
    WebviewRoute.name: (routeData) {
      final args = routeData.argsAs<WebviewRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.WebviewPage(
          key: args.key,
          uri: args.uri,
        ),
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MyProfilePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => ProfileRouteArgs(userId: pathParams.getString('id')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    WalletRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.WalletPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RootPage(),
      );
    },
    EmptyRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.EmptyPage(),
      );
    },
    EventsListingRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.EventsListingPage(),
      );
    },
    EventDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventDetailRouteArgs>(
          orElse: () => EventDetailRouteArgs(
                eventId: pathParams.getString('id'),
                eventName: pathParams.getString('name'),
              ));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.EventDetailPage(
          key: args.key,
          eventId: args.eventId,
          eventName: args.eventName,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NotificationPage]
class NotificationRoute extends _i12.PageRouteInfo<void> {
  const NotificationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.WebviewPage]
class WebviewRoute extends _i12.PageRouteInfo<WebviewRouteArgs> {
  WebviewRoute({
    _i13.Key? key,
    required Uri uri,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          WebviewRoute.name,
          args: WebviewRouteArgs(
            key: key,
            uri: uri,
          ),
          initialChildren: children,
        );

  static const String name = 'WebviewRoute';

  static const _i12.PageInfo<WebviewRouteArgs> page =
      _i12.PageInfo<WebviewRouteArgs>(name);
}

class WebviewRouteArgs {
  const WebviewRouteArgs({
    this.key,
    required this.uri,
  });

  final _i13.Key? key;

  final Uri uri;

  @override
  String toString() {
    return 'WebviewRouteArgs{key: $key, uri: $uri}';
  }
}

/// generated route for
/// [_i5.MyProfilePage]
class MyProfileRoute extends _i12.PageRouteInfo<void> {
  const MyProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MyProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ProfilePage]
class ProfileRoute extends _i12.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i13.Key? key,
    required String userId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i12.PageInfo<ProfileRouteArgs> page =
      _i12.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i13.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i7.WalletPage]
class WalletRoute extends _i12.PageRouteInfo<void> {
  const WalletRoute({List<_i12.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RootPage]
class RootRoute extends _i12.PageRouteInfo<void> {
  const RootRoute({List<_i12.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.EmptyPage]
class EmptyRoute extends _i12.PageRouteInfo<void> {
  const EmptyRoute({List<_i12.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.EventsListingPage]
class EventsListingRoute extends _i12.PageRouteInfo<void> {
  const EventsListingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          EventsListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsListingRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.EventDetailPage]
class EventDetailRoute extends _i12.PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    _i14.Key? key,
    required String eventId,
    required String eventName,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          EventDetailRoute.name,
          args: EventDetailRouteArgs(
            key: key,
            eventId: eventId,
            eventName: eventName,
          ),
          rawPathParams: {
            'id': eventId,
            'name': eventName,
          },
          initialChildren: children,
        );

  static const String name = 'EventDetailRoute';

  static const _i12.PageInfo<EventDetailRouteArgs> page =
      _i12.PageInfo<EventDetailRouteArgs>(name);
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.eventId,
    required this.eventName,
  });

  final _i14.Key? key;

  final String eventId;

  final String eventName;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId, eventName: $eventName}';
  }
}
