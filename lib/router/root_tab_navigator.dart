import 'dart:ui';

import 'package:app/application/auth/auth_bloc.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// RootNavigator use logic from AuthBloc to decide which navigator should be rendered
@RoutePage(name: 'RootTabNavigator')
class RootTabNavigatorPage extends StatelessWidget implements AutoRouteWrapper {
  RootTabNavigatorPage({super.key});

  _resolveAuthBlocProvider(Widget child) => BlocProvider.value(
        value: getIt<AuthBloc>()..add(const AuthEvent.checkAuthenticated()),
        child: child,
      );

  @override
  Widget wrappedRoute(BuildContext context) {
    return _resolveAuthBlocProvider(this);
  }

  late TabsRouter? _tabRouter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AutoTabsScaffold(
          routes: const [
            HomeRoute(),
            EventsListingRoute(),
            NotificationRoute(),
            ProfileRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            _tabRouter = tabsRouter;
            return const SizedBox();
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                  height: 100,
                  color: Colors.black.withOpacity(0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(onTap: () => _tabRouter?.setActiveIndex(0), child: const Icon(Icons.home)),
                      const Icon(Icons.event),
                      const Icon(Icons.notifications),
                      GestureDetector(onTap: () => _tabRouter?.setActiveIndex(3), child: const Icon(Icons.person))
                    ],
                  )),
            ),
          ),
        )
      ],
    );
  }
}
