import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: "Page,Route")
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
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'events',
              page: EventsListingRoute.page,
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
          path: '/events/:id/:name',
          page: EventDetailRoute.page,
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
          path: '/404',
          page: EmptyRoute.page,
        ),
        AutoRoute(
          path: '/browser',
          page: WebviewRoute.page,
          fullscreenDialog: true,
        ),
      ];
}
