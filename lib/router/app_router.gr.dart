// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/presentation/pages/auth/login_page.dart' as _i6;
import 'package:app/core/presentation/pages/chat/chat_detail/chat_detail_page.dart'
    as _i5;
import 'package:app/core/presentation/pages/chat/chat_list/chat_list_page.dart'
    as _i3;
import 'package:app/core/presentation/pages/chat/chat_setting/chat_setting_page.dart'
    as _i2;
import 'package:app/core/presentation/pages/chat/chat_stack_page.dart' as _i4;
import 'package:app/core/presentation/pages/event/event_detail_page.dart'
    as _i16;
import 'package:app/core/presentation/pages/event/events_listing_page.dart'
    as _i15;
import 'package:app/core/presentation/pages/home/home_page.dart' as _i1;
import 'package:app/core/presentation/pages/notification/notifications_listing_page.dart'
    as _i7;
import 'package:app/core/presentation/pages/poap/popap_listing_page.dart'
    as _i9;
import 'package:app/core/presentation/pages/profile/my_profile_page.dart'
    as _i10;
import 'package:app/core/presentation/pages/profile/profile_page.dart' as _i11;
import 'package:app/core/presentation/pages/root/empty_page.dart' as _i14;
import 'package:app/core/presentation/pages/root/root_page.dart' as _i13;
import 'package:app/core/presentation/pages/wallet/wallet_page.dart' as _i12;
import 'package:app/core/presentation/pages/webview/webview_page.dart' as _i8;
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/cupertino.dart' as _i19;
import 'package:flutter/material.dart' as _i18;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ChatSettingRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatSettingPage(),
      );
    },
    ChatListRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatListPage(),
      );
    },
    ChatStackRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i4.ChatStackPage()),
      );
    },
    ChatDetailRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChatDetailPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.NotificationPage(),
      );
    },
    WebviewRoute.name: (routeData) {
      final args = routeData.argsAs<WebviewRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.WebviewPage(
          key: args.key,
          uri: args.uri,
        ),
      );
    },
    PoapListingRoute.name: (routeData) {
      final args = routeData.argsAs<PoapListingRouteArgs>(
          orElse: () => const PoapListingRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.PoapListingPage(key: args.key),
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MyProfilePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => ProfileRouteArgs(userId: pathParams.getString('id')));
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    WalletRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.WalletPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RootPage(),
      );
    },
    EmptyRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.EmptyPage(),
      );
    },
    EventsListingRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.EventsListingPage(),
      );
    },
    EventDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventDetailRouteArgs>(
          orElse: () => EventDetailRouteArgs(
                eventId: pathParams.getString('id'),
                eventName: pathParams.getString('name'),
              ));
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.EventDetailPage(
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
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatSettingPage]
class ChatSettingRoute extends _i17.PageRouteInfo<void> {
  const ChatSettingRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChatSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatSettingRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatListPage]
class ChatListRoute extends _i17.PageRouteInfo<void> {
  const ChatListRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChatStackPage]
class ChatStackRoute extends _i17.PageRouteInfo<void> {
  const ChatStackRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChatStackRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatStackRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChatDetailPage]
class ChatDetailRoute extends _i17.PageRouteInfo<void> {
  const ChatDetailRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChatDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatDetailRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NotificationPage]
class NotificationRoute extends _i17.PageRouteInfo<void> {
  const NotificationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.WebviewPage]
class WebviewRoute extends _i17.PageRouteInfo<WebviewRouteArgs> {
  WebviewRoute({
    _i18.Key? key,
    required Uri uri,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          WebviewRoute.name,
          args: WebviewRouteArgs(
            key: key,
            uri: uri,
          ),
          initialChildren: children,
        );

  static const String name = 'WebviewRoute';

  static const _i17.PageInfo<WebviewRouteArgs> page =
      _i17.PageInfo<WebviewRouteArgs>(name);
}

class WebviewRouteArgs {
  const WebviewRouteArgs({
    this.key,
    required this.uri,
  });

  final _i18.Key? key;

  final Uri uri;

  @override
  String toString() {
    return 'WebviewRouteArgs{key: $key, uri: $uri}';
  }
}

/// generated route for
/// [_i9.PoapListingPage]
class PoapListingRoute extends _i17.PageRouteInfo<PoapListingRouteArgs> {
  PoapListingRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          PoapListingRoute.name,
          args: PoapListingRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PoapListingRoute';

  static const _i17.PageInfo<PoapListingRouteArgs> page =
      _i17.PageInfo<PoapListingRouteArgs>(name);
}

class PoapListingRouteArgs {
  const PoapListingRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'PoapListingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.MyProfilePage]
class MyProfileRoute extends _i17.PageRouteInfo<void> {
  const MyProfileRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MyProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProfileRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ProfilePage]
class ProfileRoute extends _i17.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i18.Key? key,
    required String userId,
    List<_i17.PageRouteInfo>? children,
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

  static const _i17.PageInfo<ProfileRouteArgs> page =
      _i17.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i18.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i12.WalletPage]
class WalletRoute extends _i17.PageRouteInfo<void> {
  const WalletRoute({List<_i17.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RootPage]
class RootRoute extends _i17.PageRouteInfo<void> {
  const RootRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i14.EmptyPage]
class EmptyRoute extends _i17.PageRouteInfo<void> {
  const EmptyRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.EventsListingPage]
class EventsListingRoute extends _i17.PageRouteInfo<void> {
  const EventsListingRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EventsListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsListingRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i16.EventDetailPage]
class EventDetailRoute extends _i17.PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    _i19.Key? key,
    required String eventId,
    required String eventName,
    List<_i17.PageRouteInfo>? children,
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

  static const _i17.PageInfo<EventDetailRouteArgs> page =
      _i17.PageInfo<EventDetailRouteArgs>(name);
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.eventId,
    required this.eventName,
  });

  final _i19.Key? key;

  final String eventId;

  final String eventName;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId, eventName: $eventName}';
  }
}
