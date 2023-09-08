import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/lemon_drawer.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import '../../../data/post/newsfeed_repository_impl.dart';
import '../../../service/newsfeed/newsfeed_service.dart';

@RoutePage(name: 'RootRoute')
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) => MultiBlocProvider(
        providers: [
          BlocProvider<NewsfeedListingBloc>(
            create: (context) =>
                NewsfeedListingBloc(NewsfeedService(NewsfeedRepositoryImpl()))
                  ..add(NewsfeedListingEvent.fetch()),
          ),
          // Add other Blocs here if needed.
        ],
        child: AutoTabsScaffold(
          extendBody: true,
          scaffoldKey: DrawerUtils.drawerGlobalKey,
          backgroundColor: primaryColor,
          routes: [
            const HomeRoute(),
            const DiscoverRoute(),
            authState.maybeWhen(
              authenticated: (session) => NotificationRoute(),
              orElse: EmptyRoute.new,
            ),
            authState.maybeWhen(
              authenticated: (session) => const WalletRoute(),
              orElse: EmptyRoute.new,
            ),
            authState.maybeWhen(
              authenticated: (session) => const MyProfileRoute(),
              orElse: EmptyRoute.new,
            )
          ],
          drawer: const LemonDrawer(),
          endDrawer: const LemonDrawer(),
          bottomNavigationBuilder: (_, tabsRouter) {
            return const BottomBar();
          },
        ),
      ),
    );
  }
}
