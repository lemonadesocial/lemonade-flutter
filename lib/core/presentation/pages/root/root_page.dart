import 'package:app/core/presentation/widgets/bottom_bar_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'RootRoute')
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        AutoTabsScaffold(
          backgroundColor: primaryColor,
          routes: [
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
