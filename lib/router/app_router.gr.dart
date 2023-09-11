// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/domain/event/entities/event.dart' as _i31;
import 'package:app/core/domain/post/entities/post_entities.dart' as _i30;
import 'package:app/core/presentation/pages/auth/login_page.dart' as _i7;
import 'package:app/core/presentation/pages/chat/chat_list/chat_list_page.dart'
    as _i4;
import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart'
    as _i6;
import 'package:app/core/presentation/pages/chat/chat_setting/chat_setting_page.dart'
    as _i3;
import 'package:app/core/presentation/pages/chat/chat_stack_page.dart' as _i5;
import 'package:app/core/presentation/pages/create_post/create_post_page.dart'
    as _i9;
import 'package:app/core/presentation/pages/discover/discover_page/discover_page.dart'
    as _i2;
import 'package:app/core/presentation/pages/event/event_detail_page.dart'
    as _i20;
import 'package:app/core/presentation/pages/event/event_selecting_page.dart'
    as _i17;
import 'package:app/core/presentation/pages/event/events_listing_page.dart'
    as _i18;
import 'package:app/core/presentation/pages/event/guest_event_detail_page/guest_event_detail_page.dart'
    as _i19;
import 'package:app/core/presentation/pages/home/home_page.dart' as _i1;
import 'package:app/core/presentation/pages/notification/notifications_listing_page.dart'
    as _i8;
import 'package:app/core/presentation/pages/onboarding/onboarding_wrapper_page.dart'
    as _i21;
import 'package:app/core/presentation/pages/onboarding/sub_page/onboarding_about_page.dart'
    as _i22;
import 'package:app/core/presentation/pages/onboarding/sub_page/onboarding_profile_photo_page.dart'
    as _i24;
import 'package:app/core/presentation/pages/onboarding/sub_page/onboarding_username_page.dart'
    as _i23;
import 'package:app/core/presentation/pages/poap/popap_listing_page.dart'
    as _i11;
import 'package:app/core/presentation/pages/profile/my_profile_page.dart'
    as _i12;
import 'package:app/core/presentation/pages/profile/profile_page.dart' as _i13;
import 'package:app/core/presentation/pages/root/empty_page.dart' as _i16;
import 'package:app/core/presentation/pages/root/root_page.dart' as _i15;
import 'package:app/core/presentation/pages/wallet/wallet_page.dart' as _i14;
import 'package:app/core/presentation/pages/webview/webview_page.dart' as _i10;
import 'package:app/core/presentation/widgets/common/photos_gallery_page/photos_gallery_page.dart'
    as _i25;
import 'package:app/core/presentation/widgets/event/rsvp_event_success_popup_widget.dart'
    as _i26;
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:flutter/cupertino.dart' as _i32;
import 'package:flutter/foundation.dart' as _i28;
import 'package:flutter/material.dart' as _i29;

abstract class $AppRouter extends _i27.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    DiscoverRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DiscoverPage(),
      );
    },
    ChatSettingRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatSettingPage(),
      );
    },
    ChatListRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChatListPage(),
      );
    },
    ChatStackRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.WrappedRoute(child: const _i5.ChatStackPage()),
      );
    },
    ChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatRouteArgs>(
          orElse: () => ChatRouteArgs(roomId: pathParams.getString('id')));
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ChatPage(
          key: args.key,
          sideView: args.sideView,
          roomId: args.roomId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      final args = routeData.argsAs<NotificationRouteArgs>(
          orElse: () => const NotificationRouteArgs());
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.NotificationPage(key: args.key),
      );
    },
    CreatePostRoute.name: (routeData) {
      final args = routeData.argsAs<CreatePostRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.CreatePostPage(
          key: args.key,
          onPostCreated: args.onPostCreated,
        ),
      );
    },
    WebviewRoute.name: (routeData) {
      final args = routeData.argsAs<WebviewRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.WebviewPage(
          key: args.key,
          uri: args.uri,
        ),
      );
    },
    PoapListingRoute.name: (routeData) {
      final args = routeData.argsAs<PoapListingRouteArgs>(
          orElse: () => const PoapListingRouteArgs());
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.PoapListingPage(key: args.key),
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MyProfilePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => ProfileRouteArgs(userId: pathParams.getString('id')));
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    WalletRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.WalletPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.RootPage(),
      );
    },
    EmptyRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.EmptyPage(),
      );
    },
    EventSelectingRoute.name: (routeData) {
      final args = routeData.argsAs<EventSelectingRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.EventSelectingPage(
          key: args.key,
          onEventTap: args.onEventTap,
        ),
      );
    },
    EventsListingRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.EventsListingPage(),
      );
    },
    GuestEventDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GuestEventDetailRouteArgs>(
          orElse: () =>
              GuestEventDetailRouteArgs(eventId: pathParams.getString('id')));
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.GuestEventDetailPage(
          key: args.key,
          eventId: args.eventId,
        ),
      );
    },
    EventDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventDetailRouteArgs>(
          orElse: () => EventDetailRouteArgs(
                eventId: pathParams.getString('id'),
                eventName: pathParams.getString('name'),
              ));
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.EventDetailPage(
          key: args.key,
          eventId: args.eventId,
          eventName: args.eventName,
        ),
      );
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.WrappedRoute(child: const _i21.OnboardingWrapperPage()),
      );
    },
    OnboardingAboutRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.OnboardingAboutPage(),
      );
    },
    OnboardingUsernameRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.OnboardingUsernamePage(),
      );
    },
    OnboardingProfilePhotoRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.OnboardingProfilePhotoPage(),
      );
    },
    PhotosGalleryRoute.name: (routeData) {
      final args = routeData.argsAs<PhotosGalleryRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.PhotosGalleryPage(
          key: args.key,
          photos: args.photos,
          initialIndex: args.initialIndex,
          title: args.title,
        ),
      );
    },
    RSVPEventSuccessPopupRoute.name: (routeData) {
      final args = routeData.argsAs<RSVPEventSuccessPopupRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.RSVPEventSuccessPopupPage(
          key: args.key,
          event: args.event,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i27.PageRouteInfo<void> {
  const HomeRoute({List<_i27.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DiscoverPage]
class DiscoverRoute extends _i27.PageRouteInfo<void> {
  const DiscoverRoute({List<_i27.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatSettingPage]
class ChatSettingRoute extends _i27.PageRouteInfo<void> {
  const ChatSettingRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ChatSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatSettingRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChatListPage]
class ChatListRoute extends _i27.PageRouteInfo<void> {
  const ChatListRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChatStackPage]
class ChatStackRoute extends _i27.PageRouteInfo<void> {
  const ChatStackRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ChatStackRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatStackRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ChatPage]
class ChatRoute extends _i27.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i28.Key? key,
    _i29.Widget? sideView,
    required String roomId,
    List<_i27.PageRouteInfo>? children,
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

  static const _i27.PageInfo<ChatRouteArgs> page =
      _i27.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    this.sideView,
    required this.roomId,
  });

  final _i28.Key? key;

  final _i29.Widget? sideView;

  final String roomId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, sideView: $sideView, roomId: $roomId}';
  }
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute({List<_i27.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i8.NotificationPage]
class NotificationRoute extends _i27.PageRouteInfo<NotificationRouteArgs> {
  NotificationRoute({
    _i29.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          NotificationRoute.name,
          args: NotificationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i27.PageInfo<NotificationRouteArgs> page =
      _i27.PageInfo<NotificationRouteArgs>(name);
}

class NotificationRouteArgs {
  const NotificationRouteArgs({this.key});

  final _i29.Key? key;

  @override
  String toString() {
    return 'NotificationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.CreatePostPage]
class CreatePostRoute extends _i27.PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({
    _i29.Key? key,
    required void Function(_i30.Post) onPostCreated,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          CreatePostRoute.name,
          args: CreatePostRouteArgs(
            key: key,
            onPostCreated: onPostCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatePostRoute';

  static const _i27.PageInfo<CreatePostRouteArgs> page =
      _i27.PageInfo<CreatePostRouteArgs>(name);
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({
    this.key,
    required this.onPostCreated,
  });

  final _i29.Key? key;

  final void Function(_i30.Post) onPostCreated;

  @override
  String toString() {
    return 'CreatePostRouteArgs{key: $key, onPostCreated: $onPostCreated}';
  }
}

/// generated route for
/// [_i10.WebviewPage]
class WebviewRoute extends _i27.PageRouteInfo<WebviewRouteArgs> {
  WebviewRoute({
    _i28.Key? key,
    required Uri uri,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          WebviewRoute.name,
          args: WebviewRouteArgs(
            key: key,
            uri: uri,
          ),
          initialChildren: children,
        );

  static const String name = 'WebviewRoute';

  static const _i27.PageInfo<WebviewRouteArgs> page =
      _i27.PageInfo<WebviewRouteArgs>(name);
}

class WebviewRouteArgs {
  const WebviewRouteArgs({
    this.key,
    required this.uri,
  });

  final _i28.Key? key;

  final Uri uri;

  @override
  String toString() {
    return 'WebviewRouteArgs{key: $key, uri: $uri}';
  }
}

/// generated route for
/// [_i11.PoapListingPage]
class PoapListingRoute extends _i27.PageRouteInfo<PoapListingRouteArgs> {
  PoapListingRoute({
    _i29.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          PoapListingRoute.name,
          args: PoapListingRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PoapListingRoute';

  static const _i27.PageInfo<PoapListingRouteArgs> page =
      _i27.PageInfo<PoapListingRouteArgs>(name);
}

class PoapListingRouteArgs {
  const PoapListingRouteArgs({this.key});

  final _i29.Key? key;

  @override
  String toString() {
    return 'PoapListingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.MyProfilePage]
class MyProfileRoute extends _i27.PageRouteInfo<void> {
  const MyProfileRoute({List<_i27.PageRouteInfo>? children})
      : super(
          MyProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProfileRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ProfilePage]
class ProfileRoute extends _i27.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i29.Key? key,
    required String userId,
    List<_i27.PageRouteInfo>? children,
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

  static const _i27.PageInfo<ProfileRouteArgs> page =
      _i27.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i29.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i14.WalletPage]
class WalletRoute extends _i27.PageRouteInfo<void> {
  const WalletRoute({List<_i27.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i15.RootPage]
class RootRoute extends _i27.PageRouteInfo<void> {
  const RootRoute({List<_i27.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i16.EmptyPage]
class EmptyRoute extends _i27.PageRouteInfo<void> {
  const EmptyRoute({List<_i27.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i17.EventSelectingPage]
class EventSelectingRoute extends _i27.PageRouteInfo<EventSelectingRouteArgs> {
  EventSelectingRoute({
    _i29.Key? key,
    required void Function(_i31.Event) onEventTap,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          EventSelectingRoute.name,
          args: EventSelectingRouteArgs(
            key: key,
            onEventTap: onEventTap,
          ),
          initialChildren: children,
        );

  static const String name = 'EventSelectingRoute';

  static const _i27.PageInfo<EventSelectingRouteArgs> page =
      _i27.PageInfo<EventSelectingRouteArgs>(name);
}

class EventSelectingRouteArgs {
  const EventSelectingRouteArgs({
    this.key,
    required this.onEventTap,
  });

  final _i29.Key? key;

  final void Function(_i31.Event) onEventTap;

  @override
  String toString() {
    return 'EventSelectingRouteArgs{key: $key, onEventTap: $onEventTap}';
  }
}

/// generated route for
/// [_i18.EventsListingPage]
class EventsListingRoute extends _i27.PageRouteInfo<void> {
  const EventsListingRoute({List<_i27.PageRouteInfo>? children})
      : super(
          EventsListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsListingRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i19.GuestEventDetailPage]
class GuestEventDetailRoute
    extends _i27.PageRouteInfo<GuestEventDetailRouteArgs> {
  GuestEventDetailRoute({
    _i29.Key? key,
    required String eventId,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          GuestEventDetailRoute.name,
          args: GuestEventDetailRouteArgs(
            key: key,
            eventId: eventId,
          ),
          rawPathParams: {'id': eventId},
          initialChildren: children,
        );

  static const String name = 'GuestEventDetailRoute';

  static const _i27.PageInfo<GuestEventDetailRouteArgs> page =
      _i27.PageInfo<GuestEventDetailRouteArgs>(name);
}

class GuestEventDetailRouteArgs {
  const GuestEventDetailRouteArgs({
    this.key,
    required this.eventId,
  });

  final _i29.Key? key;

  final String eventId;

  @override
  String toString() {
    return 'GuestEventDetailRouteArgs{key: $key, eventId: $eventId}';
  }
}

/// generated route for
/// [_i20.EventDetailPage]
class EventDetailRoute extends _i27.PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    _i32.Key? key,
    required String eventId,
    required String eventName,
    List<_i27.PageRouteInfo>? children,
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

  static const _i27.PageInfo<EventDetailRouteArgs> page =
      _i27.PageInfo<EventDetailRouteArgs>(name);
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.eventId,
    required this.eventName,
  });

  final _i32.Key? key;

  final String eventId;

  final String eventName;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId, eventName: $eventName}';
  }
}

/// generated route for
/// [_i21.OnboardingWrapperPage]
class OnboardingWrapperRoute extends _i27.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i27.PageRouteInfo>? children})
      : super(
          OnboardingWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingWrapperRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i22.OnboardingAboutPage]
class OnboardingAboutRoute extends _i27.PageRouteInfo<void> {
  const OnboardingAboutRoute({List<_i27.PageRouteInfo>? children})
      : super(
          OnboardingAboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingAboutRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i23.OnboardingUsernamePage]
class OnboardingUsernameRoute extends _i27.PageRouteInfo<void> {
  const OnboardingUsernameRoute({List<_i27.PageRouteInfo>? children})
      : super(
          OnboardingUsernameRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingUsernameRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i24.OnboardingProfilePhotoPage]
class OnboardingProfilePhotoRoute extends _i27.PageRouteInfo<void> {
  const OnboardingProfilePhotoRoute({List<_i27.PageRouteInfo>? children})
      : super(
          OnboardingProfilePhotoRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingProfilePhotoRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i25.PhotosGalleryPage]
class PhotosGalleryRoute extends _i27.PageRouteInfo<PhotosGalleryRouteArgs> {
  PhotosGalleryRoute({
    _i29.Key? key,
    required List<String> photos,
    int initialIndex = 0,
    _i29.Widget? title,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          PhotosGalleryRoute.name,
          args: PhotosGalleryRouteArgs(
            key: key,
            photos: photos,
            initialIndex: initialIndex,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'PhotosGalleryRoute';

  static const _i27.PageInfo<PhotosGalleryRouteArgs> page =
      _i27.PageInfo<PhotosGalleryRouteArgs>(name);
}

class PhotosGalleryRouteArgs {
  const PhotosGalleryRouteArgs({
    this.key,
    required this.photos,
    this.initialIndex = 0,
    this.title,
  });

  final _i29.Key? key;

  final List<String> photos;

  final int initialIndex;

  final _i29.Widget? title;

  @override
  String toString() {
    return 'PhotosGalleryRouteArgs{key: $key, photos: $photos, initialIndex: $initialIndex, title: $title}';
  }
}

/// generated route for
/// [_i26.RSVPEventSuccessPopupPage]
class RSVPEventSuccessPopupRoute
    extends _i27.PageRouteInfo<RSVPEventSuccessPopupRouteArgs> {
  RSVPEventSuccessPopupRoute({
    _i29.Key? key,
    required _i31.Event event,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          RSVPEventSuccessPopupRoute.name,
          args: RSVPEventSuccessPopupRouteArgs(
            key: key,
            event: event,
          ),
          initialChildren: children,
        );

  static const String name = 'RSVPEventSuccessPopupRoute';

  static const _i27.PageInfo<RSVPEventSuccessPopupRouteArgs> page =
      _i27.PageInfo<RSVPEventSuccessPopupRouteArgs>(name);
}

class RSVPEventSuccessPopupRouteArgs {
  const RSVPEventSuccessPopupRouteArgs({
    this.key,
    required this.event,
  });

  final _i29.Key? key;

  final _i31.Event event;

  @override
  String toString() {
    return 'RSVPEventSuccessPopupRouteArgs{key: $key, event: $event}';
  }
}
