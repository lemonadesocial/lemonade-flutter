import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/lemon_drawer.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'RootRoute')
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) => AutoTabsScaffold(
        scaffoldKey: DrawerUtils.drawerGlobalKey,
        backgroundColor: primaryColor,
        routes: [
          HomeRoute(),
          EventsListingRoute(),
          WalletRoute(),
          authState.maybeWhen(
            authenticated: (session) => NotificationRoute(),
            orElse: () => EmptyRoute(),
          ),
          authState.maybeWhen(
            authenticated: (session) => MyProfileRoute(),
            orElse: () => EmptyRoute(),
          )
        ],
        drawer: const LemonDrawer(),
        endDrawer: const LemonDrawer(),
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomBar();
        },
      ),
    );
  }
}