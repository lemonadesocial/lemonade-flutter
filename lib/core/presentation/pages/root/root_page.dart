import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/payment/payment_listener/payment_listener.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/lemon_drawer.dart';
import 'package:app/core/presentation/widgets/home/floating_create_button.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_transfer_controller_widget/poap_claim_transfer_controller_widget.dart';
import 'package:app/core/service/shorebird_codepush_service.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';

@RoutePage(name: 'RootRoute')
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageViewState();
}

class _RootPageViewState extends State<RootPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getIt<ShorebirdCodePushService>().checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appCastConfiguration = AppcastConfiguration(
      url: AppConfig.appCastUrl,
      supportedOS: ['android', 'ios'],
    );
    final primaryColor = Theme.of(context).colorScheme.primary;
    final authState = BlocProvider.of<AuthBloc>(context).state;
    final isAuthenticated = authState is AuthStateAuthenticated;
    return PaymentListener(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            onBoardingRequired: (user) {
              OnboardingUtils.startOnboarding(context, user: user);
            },
            orElse: () {},
          );
        },
        builder: (context, authState) {
          context.read<NewsfeedListingBloc>().add(NewsfeedListingEvent.fetch());
          return UpgradeAlert(
            upgrader: Upgrader(
              durationUntilAlertAgain: const Duration(seconds: 30),
              appcastConfig: appCastConfiguration,
              debugLogging: kDebugMode,
            ),
            child: Stack(
              children: [
                const Align(
                  child: PoapClaimTransferControllerWidget(),
                ),
                AutoTabsScaffold(
                  extendBody: true,
                  scaffoldKey: DrawerUtils.drawerGlobalKey,
                  drawerEnableOpenDragGesture:
                      isAuthenticated == true ? true : false,
                  backgroundColor: primaryColor,
                  routes: [
                    const HomeRoute(),
                    const DiscoverRoute(),
                    authState.maybeWhen(
                      authenticated: (session) => const NotificationRoute(),
                      orElse: EmptyRoute.new,
                    ),
                    authState.maybeWhen(
                      authenticated: (session) => const MyProfileRoute(),
                      orElse: EmptyRoute.new,
                    ),
                  ],
                  drawer: const LemonDrawer(),
                  floatingActionButton: FloatingCreateButton(
                    onTap: () {
                      authState.maybeWhen(
                        authenticated: (session) =>
                            context.router.push(const AIRoute()),
                        orElse: () =>
                            context.router.navigate(const LoginRoute()),
                      );
                    },
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBuilder: (_, tabsRouter) {
                    return const BottomBar();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
