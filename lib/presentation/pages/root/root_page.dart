import 'package:app/application/auth/auth_bloc.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/presentation/widgets/bottom_bar_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage(name: 'RootRoute')
class RootPage extends StatelessWidget implements AutoRouteWrapper {
  const RootPage({super.key});

  _resolveAuthBlocProvider(Widget child) => BlocProvider.value(
        value: getIt<AuthBloc>()..add(const AuthEvent.checkAuthenticated()),
        child: child,
      );

  @override
  Widget wrappedRoute(BuildContext context) {
    return _resolveAuthBlocProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        AutoTabsScaffold(
          backgroundColor: primaryColor,
          routes: const [
            HomeRoute(),
            EventsListingRoute(),
            WalletRoute(),
            NotificationRoute(),
            ProfileRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return const SizedBox();
          },
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: BottomBar(),
        )
      ],
    );
  }
}
