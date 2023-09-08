import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            AutoRoute(
              path: '',
              initial: true,
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'discover',
              page: DiscoverRoute.page,
            ),
            AutoRoute(
              path: 'notification',
              page: NotificationRoute.page,
            ),
            AutoRoute(
              path: 'wallet',
              page: WalletRoute.page,
            ),
            AutoRoute(
              path: 'me',
              page: MyProfileRoute.page,
            ),
            AutoRoute(
              path: '404',
              page: EmptyRoute.page,
            )
          ],
        ),
        AutoRoute(
          path: '/profile/:id',
          page: ProfileRoute.page,
        ),
        AutoRoute(
          path: '/poap',
          page: PoapListingRoute.page,
        ),
        AutoRoute(
          page: CreatePostRoute.page,
        ),
        AutoRoute(
          page: OnboardingWrapperRoute.page,
          children: [
            AutoRoute(
              page: OnboardingUsernameRoute.page,
            ),
            AutoRoute(
              page: OnboardingProfilePhotoRoute.page,
            ),
            AutoRoute(
              page: OnboardingAboutRoute.page,
            ),
          ],
        ),
        chatRoutes,
        ...eventRoutes,
        ...commonRoutes,
      ];
}

final chatRoutes = AutoRoute(
  page: ChatStackRoute.page,
  path: '/chat',
  children: [
    AutoRoute(
      initial: true,
      path: '',
      page: ChatListRoute.page,
    ),
    AutoRoute(path: 'detail/:id', page: ChatRoute.page),
    AutoRoute(
      path: 'setting/:id',
      page: ChatSettingRoute.page,
    ),
  ],
);

final eventRoutes = [
  AutoRoute(
    path: '/events',
    page: EventsListingRoute.page,
  ),
  AutoRoute(
    path: '/events/:id',
    page: GuestEventDetailRoute.page,
  ),
  AutoRoute(
    page: EventDetailRoute.page,
  ),
  AutoRoute(
    page: EventSelectingRoute.page,
  ),
  AutoRoute(page: RSVPEventSuccessPopupRoute.page)
];

final commonRoutes = [
  AutoRoute(
    page: PhotosGalleryRoute.page,
  ),
  AutoRoute(
    path: '/404',
    page: EmptyRoute.page,
  ),
  AutoRoute(
    path: '/browser',
    page: WebviewRoute.page,
    fullscreenDialog: true,
  ),
];
