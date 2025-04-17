import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

final spaceRoutes = [
  AutoRoute(
    page: SpacesListingRoute.page,
  ),
  AutoRoute(
    page: SpaceDetailRoute.page,
  ),
  AutoRoute(
    page: SpaceEventRequestsManagementRoute.page,
  ),
];
