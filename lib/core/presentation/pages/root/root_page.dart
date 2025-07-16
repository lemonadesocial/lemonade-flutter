import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/payment/payment_listener/payment_listener.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/lemon_drawer.dart';
import 'package:app/core/presentation/pages/lens/widget/auto_sync_lens_lemonade_profile_widget/auto_sync_lens_lemonade_profile_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_transfer_controller_widget/poap_claim_transfer_controller_widget.dart';
import 'package:app/core/service/shorebird_codepush_service.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/router/my_router_observer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';

GlobalKey<BottomBarState> bottomBarGlobalKey = GlobalKey<BottomBarState>();

@RoutePage(name: 'RootRoute')
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageViewState();
}

class _RootPageViewState extends State<RootPage> {
  bool isReady = false;

  Future<void> initWalletConnect() async {
    await getIt<WalletConnectService>().init(context);
    context.read<WalletBloc>().add(const WalletEvent.init());
    context.read<LensAuthBloc>().add(const LensAuthEvent.init());
    setState(() {
      isReady = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initWalletConnect();
      getIt<ShorebirdCodePushService>().checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Scaffold(
        body: Center(
          child: Loading.defaultLoading(context),
        ),
      );
    }

    final storeController = UpgraderStoreController(
      oniOS: () => UpgraderAppcastStore(appcastURL: AppConfig.appCastUrl),
      onAndroid: () => UpgraderAppcastStore(appcastURL: AppConfig.appCastUrl),
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
          return UpgradeAlert(
            upgrader: Upgrader(
              durationUntilAlertAgain: const Duration(seconds: 30),
              storeController: storeController,
              debugLogging: kDebugMode,
            ),
            child: Stack(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      authenticated: (session) => const Align(
                        child: PoapClaimTransferControllerWidget(),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
                const AutoSyncLensLemonadeProfileWidget(),
                AutoTabsScaffold(
                  navigatorObservers: () => [
                    TabRouterObserver(),
                  ],
                  extendBody: true,
                  extendBodyBehindAppBar: true,
                  scaffoldKey: DrawerUtils.drawerGlobalKey,
                  drawerEnableOpenDragGesture:
                      isAuthenticated == true ? true : false,
                  backgroundColor: primaryColor,
                  routes: [
                    const HomeRoute(),
                    authState.maybeWhen(
                      authenticated: (session) => const HomeSpaceListingRoute(),
                      orElse: EmptyRoute.new,
                    ),
                    DiscoverRoute(),
                    // authState.maybeWhen(
                    //   authenticated: (session) => const NotificationRoute(),
                    //   orElse: EmptyRoute.new,
                    // ),
                    authState.maybeWhen(
                      authenticated: (session) => const ChatStackRoute(),
                      orElse: EmptyRoute.new,
                    ),
                  ],
                  drawer: authState.maybeWhen(
                    authenticated: (session) => const LemonDrawer(),
                    orElse: () => null,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBuilder: (_, tabsRouter) {
                    return BottomBar(
                      key: bottomBarGlobalKey,
                    );
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

class TabRouterObserver extends MyRouterObserver {
  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    bottomBarGlobalKey.currentState?.tabNavigated(route);
  }
}
