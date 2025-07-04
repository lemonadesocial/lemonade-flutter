import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

final lensRoutes = [
  AutoRoute(
    page: CreateLensPostRoute.page,
  ),
  AutoRoute(
    page: LensPostDetailRoute.page,
  ),
  AutoRoute(
    page: CreateLensPostReplyRoute.page,
  ),
  AutoRoute(
    page: CreateLensAccountRoute.page,
  ),
  AutoRoute(
    page: LensUserProfileRoute.page,
  ),
  AutoRoute(
    page: CreateLensUsernameRoute.page,
  ),
];
