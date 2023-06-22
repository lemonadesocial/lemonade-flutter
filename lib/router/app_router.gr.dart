// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/presentation/auth/pages/login_page.dart' as _i2;
import 'package:app/presentation/event/pages/event_detail_page.dart' as _i6;
import 'package:app/presentation/event/pages/events_listing_page.dart' as _i5;
import 'package:app/presentation/home/pages/home_page.dart' as _i1;
import 'package:app/presentation/notification/pages/notification_page.dart'
    as _i3;
import 'package:app/presentation/profile/pages/profile_page.dart' as _i4;
import 'package:app/router/root_tab_navigator.dart' as _i7;
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.NotificationPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ProfilePage(),
      );
    },
    EventsListingRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EventsListingPage(),
      );
    },
    EventDetailRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EventDetailPage(),
      );
    },
    RootTabNavigator.name: (routeData) {
      final args = routeData.argsAs<RootTabNavigatorArgs>(
          orElse: () => const RootTabNavigatorArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(child: _i7.RootTabNavigatorPage(key: args.key)),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NotificationPage]
class NotificationRoute extends _i8.PageRouteInfo<void> {
  const NotificationRoute({List<_i8.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ProfilePage]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EventsListingPage]
class EventsListingRoute extends _i8.PageRouteInfo<void> {
  const EventsListingRoute({List<_i8.PageRouteInfo>? children})
      : super(
          EventsListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsListingRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EventDetailPage]
class EventDetailRoute extends _i8.PageRouteInfo<void> {
  const EventDetailRoute({List<_i8.PageRouteInfo>? children})
      : super(
          EventDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventDetailRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RootTabNavigatorPage]
class RootTabNavigator extends _i8.PageRouteInfo<RootTabNavigatorArgs> {
  RootTabNavigator({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          RootTabNavigator.name,
          args: RootTabNavigatorArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RootTabNavigator';

  static const _i8.PageInfo<RootTabNavigatorArgs> page =
      _i8.PageInfo<RootTabNavigatorArgs>(name);
}

class RootTabNavigatorArgs {
  const RootTabNavigatorArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'RootTabNavigatorArgs{key: $key}';
  }
}
