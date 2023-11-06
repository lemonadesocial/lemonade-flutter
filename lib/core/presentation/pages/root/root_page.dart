import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/lemon_drawer.dart';
import 'package:app/core/presentation/widgets/home/create_pop_up_page.dart';
import 'package:app/core/presentation/widgets/home/floating_create_button.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_transfer_controller_widget/poap_claim_transfer_controller_widget.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';

@RoutePage(name: 'RootRoute')
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appCastConfiguration = AppcastConfiguration(
      url: AppConfig.appCastUrl,
      supportedOS: ['android', 'ios'],
    );

    final isIpad = DeviceUtils.isIpad();
    final heightFactor = isIpad ? 0.35 : 0.60;
    final primaryColor = Theme.of(context).colorScheme.primary;
    return BlocConsumer<AuthBloc, AuthState>(
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
            showIgnore: false,
            durationUntilAlertAgain: const Duration(seconds: 30),
            dialogStyle: UpgradeDialogStyle.cupertino,
            cupertinoButtonTextStyle:
                TextStyle(color: Colors.white, fontSize: Typo.small.fontSize!),
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
                backgroundColor: primaryColor,
                routes: [
                  const HomeRoute(),
                  const DiscoverRoute(),
                  authState.maybeWhen(
                    authenticated: (session) => NotificationRoute(),
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
                          const CreatePopUpPage().showAsBottomSheet(
                        context,
                        heightFactor: heightFactor,
                      ),
                      orElse: () => context.router.navigate(const LoginRoute()),
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
    );
  }
}
