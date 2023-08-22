// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/domain/event/entities/event.dart' as _i22;
import 'package:app/core/presentation/pages/auth/login_page.dart' as _i7;
import 'package:app/core/presentation/pages/chat/chat_detail/chat_detail_page.dart'
    as _i6;
import 'package:app/core/presentation/pages/chat/chat_list/chat_list_page.dart'
    as _i3;
import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart'
    as _i5;
import 'package:app/core/presentation/pages/chat/chat_setting/chat_setting_page.dart'
    as _i2;
import 'package:app/core/presentation/pages/chat/chat_stack_page.dart' as _i4;
import 'package:app/core/presentation/pages/create_post/create_post_page.dart'
    as _i9;
import 'package:app/core/presentation/pages/event/event_detail_page.dart'
    as _i19;
import 'package:app/core/presentation/pages/event/event_selecting_page.dart'
    as _i17;
import 'package:app/core/presentation/pages/event/events_listing_page.dart'
    as _i18;
import 'package:app/core/presentation/pages/home/home_page.dart' as _i1;
import 'package:app/core/presentation/pages/notification/notifications_listing_page.dart'
    as _i8;
import 'package:app/core/presentation/pages/poap/popap_listing_page.dart'
    as _i11;
import 'package:app/core/presentation/pages/profile/my_profile_page.dart'
    as _i12;
import 'package:app/core/presentation/pages/profile/profile_page.dart' as _i13;
import 'package:app/core/presentation/pages/root/empty_page.dart' as _i16;
import 'package:app/core/presentation/pages/root/root_page.dart' as _i15;
import 'package:app/core/presentation/pages/wallet/wallet_page.dart' as _i14;
import 'package:app/core/presentation/pages/webview/webview_page.dart' as _i10;
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/cupertino.dart' as _i23;
import 'package:flutter/material.dart' as _i21;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ChatSettingRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatSettingPage(),
      );
    },
    ChatListRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatListPage(),
      );
    },
    ChatStackRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.WrappedRoute(child: const _i4.ChatStackPage()),
      );
    },
    ChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatRouteArgs>(
          orElse: () => ChatRouteArgs(roomId: pathParams.getString('id')));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ChatPage(
          key: args.key,
          sideView: args.sideView,
          roomId: args.roomId,
        ),
      );
    },
    ChatDetailRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ChatDetailPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.NotificationPage(),
      );
    },
    CreatePostRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CreatePostPage(),
      );
    },
    WebviewRoute.name: (routeData) {
      final args = routeData.argsAs<WebviewRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.WebviewPage(
          key: args.key,
          uri: args.uri,
        ),
      );
    },
    PoapListingRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PoapListingPage(),
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MyProfilePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => ProfileRouteArgs(userId: pathParams.getString('id')));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    WalletRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.WalletPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.RootPage(),
      );
    },
    EmptyRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.EmptyPage(),
      );
    },
    EventSelectingRoute.name: (routeData) {
      final args = routeData.argsAs<EventSelectingRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.EventSelectingPage(
          key: args.key,
          onEventTap: args.onEventTap,
        ),
      );
    },
    EventsListingRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.EventsListingPage(),
      );
    },
    EventDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventDetailRouteArgs>(
          orElse: () => EventDetailRouteArgs(
                eventId: pathParams.getString('id'),
                eventName: pathParams.getString('name'),
              ));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.EventDetailPage(
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
class HomeRoute extends _i20.PageRouteInfo<void> {
  const HomeRoute({List<_i20.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatSettingPage]
class ChatSettingRoute extends _i20.PageRouteInfo<void> {
  const ChatSettingRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ChatSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatSettingRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatListPage]
class ChatListRoute extends _i20.PageRouteInfo<void> {
  const ChatListRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChatStackPage]
class ChatStackRoute extends _i20.PageRouteInfo<void> {
  const ChatStackRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ChatStackRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatStackRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChatPage]
class ChatRoute extends _i20.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i21.Key? key,
    _i21.Widget? sideView,
    required String roomId,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            sideView: sideView,
            roomId: roomId,
          ),
          rawPathParams: {'id': roomId},
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i20.PageInfo<ChatRouteArgs> page =
      _i20.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    this.sideView,
    required this.roomId,
  });

  final _i21.Key? key;

  final _i21.Widget? sideView;

  final String roomId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, sideView: $sideView, roomId: $roomId}';
  }
}

/// generated route for
/// [_i6.ChatDetailPage]
class ChatDetailRoute extends _i20.PageRouteInfo<void> {
  const ChatDetailRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ChatDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatDetailRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i20.PageRouteInfo<void> {
  const LoginRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.NotificationPage]
class NotificationRoute extends _i20.PageRouteInfo<void> {
  const NotificationRoute({List<_i20.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CreatePostPage]
class CreatePostRoute extends _i20.PageRouteInfo<void> {
  const CreatePostRoute({List<_i20.PageRouteInfo>? children})
      : super(
          CreatePostRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatePostRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i10.WebviewPage]
class WebviewRoute extends _i20.PageRouteInfo<WebviewRouteArgs> {
  WebviewRoute({
    _i21.Key? key,
    required Uri uri,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          WebviewRoute.name,
          args: WebviewRouteArgs(
            key: key,
            uri: uri,
          ),
          initialChildren: children,
        );

  static const String name = 'WebviewRoute';

  static const _i20.PageInfo<WebviewRouteArgs> page =
      _i20.PageInfo<WebviewRouteArgs>(name);
}

class WebviewRouteArgs {
  const WebviewRouteArgs({
    this.key,
    required this.uri,
  });

  final _i21.Key? key;

  final Uri uri;

  @override
  String toString() {
    return 'WebviewRouteArgs{key: $key, uri: $uri}';
  }
}

/// generated route for
/// [_i11.PoapListingPage]
class PoapListingRoute extends _i20.PageRouteInfo<void> {
  const PoapListingRoute({List<_i20.PageRouteInfo>? children})
      : super(
          PoapListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'PoapListingRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MyProfilePage]
class MyProfileRoute extends _i20.PageRouteInfo<void> {
  const MyProfileRoute({List<_i20.PageRouteInfo>? children})
      : super(
          MyProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProfileRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ProfilePage]
class ProfileRoute extends _i20.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i21.Key? key,
    required String userId,
    List<_i20.PageRouteInfo>? children,
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

  static const _i20.PageInfo<ProfileRouteArgs> page =
      _i20.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i21.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i14.WalletPage]
class WalletRoute extends _i20.PageRouteInfo<void> {
  const WalletRoute({List<_i20.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i15.RootPage]
class RootRoute extends _i20.PageRouteInfo<void> {
  const RootRoute({List<_i20.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i16.EmptyPage]
class EmptyRoute extends _i20.PageRouteInfo<void> {
  const EmptyRoute({List<_i20.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.EventSelectingPage]
class EventSelectingRoute extends _i20.PageRouteInfo<EventSelectingRouteArgs> {
  EventSelectingRoute({
    _i21.Key? key,
    required void Function(_i22.Event) onEventTap,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          EventSelectingRoute.name,
          args: EventSelectingRouteArgs(
            key: key,
            onEventTap: onEventTap,
          ),
          initialChildren: children,
        );

  static const String name = 'EventSelectingRoute';

  static const _i20.PageInfo<EventSelectingRouteArgs> page =
      _i20.PageInfo<EventSelectingRouteArgs>(name);
}

class EventSelectingRouteArgs {
  const EventSelectingRouteArgs({
    this.key,
    required this.onEventTap,
  });

  final _i21.Key? key;

  final void Function(_i22.Event) onEventTap;

  @override
  String toString() {
    return 'EventSelectingRouteArgs{key: $key, onEventTap: $onEventTap}';
  }
}

/// generated route for
/// [_i18.EventsListingPage]
class EventsListingRoute extends _i20.PageRouteInfo<void> {
  const EventsListingRoute({List<_i20.PageRouteInfo>? children})
      : super(
          EventsListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsListingRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i19.EventDetailPage]
class EventDetailRoute extends _i20.PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    _i23.Key? key,
    required String eventId,
    required String eventName,
    List<_i20.PageRouteInfo>? children,
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

  static const _i20.PageInfo<EventDetailRouteArgs> page =
      _i20.PageInfo<EventDetailRouteArgs>(name);
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.eventId,
    required this.eventName,
  });

  final _i23.Key? key;

  final String eventId;

  final String eventName;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId, eventName: $eventName}';
  }
}
