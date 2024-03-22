import 'dart:async';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/connectivity/connectivity_bloc.dart';
import 'package:app/core/application/notification/watch_notifications_bloc/watch_notification_bloc.dart';
import 'package:app/core/application/profile/block_user_bloc/block_user_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/service/connectivity/connectivity_service.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/my_router_observer.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/widgets/custom_error_widget.dart';
import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/data/post/newsfeed_repository_impl.dart';
import 'package:app/core/service/newsfeed/newsfeed_service.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class LemonadeApp extends StatefulWidget {
  const LemonadeApp({super.key});

  @override
  State<StatefulWidget> createState() => _LemonadeAppViewState();
}

class _LemonadeAppViewState extends State<LemonadeApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    FlutterAppBadger.removeBadge();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getIt<MatrixService>().backgroundPush.setupContextAndRouter(
            router: _appRouter,
            context: context,
          );
      getIt<FirebaseService>().setupContextAndRouter(
        router: _appRouter,
        context: context,
      );
      setupInteractedMessage();
      FlutterNativeSplash.remove();
    });
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = LemonColor.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  Widget _translationProviderBuilder(Widget child) =>
      TranslationProvider(child: child);

  Widget _portalBuilder(Widget child) => Portal(child: child);

  Widget _globalBlocProviderBuilder(Widget child) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<AuthBloc>(),
          ),
          // TODO: newsfeed should not be global
          BlocProvider<NewsfeedListingBloc>(
            create: (context) => NewsfeedListingBloc(
              NewsfeedService(NewsfeedRepositoryImpl()),
            ),
          ),
          // TODO: blocker user should not be global
          BlocProvider(
            create: (context) => BlockUserBloc(getIt<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => WatchNotificationsBloc(),
          ),
          BlocProvider(
            create: (context) => ConnectivityBloc(),
          ),
          BlocProvider(
            create: (context) => WalletBloc()
              ..add(
                const WalletEvent.getActiveSessions(),
              ),
          ),
        ],
        child: child,
      );

  Widget _gqlProviderBuilder(Widget child) => GraphQLProvider(
        client: ValueNotifier(getIt<AppGQL>().client),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: getDeviceType() == DeviceType.phone
          ? const Size(375, 812) // Iphone X screen size, match Figma
          : const Size(1024, 1366), // Ipad Pro 12.9 inches
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return _translationProviderBuilder(
          _gqlProviderBuilder(
            _portalBuilder(
              _globalBlocProviderBuilder(_App(_appRouter)),
            ),
          ),
        );
      },
    );
  }

  Future<void> setupInteractedMessage() async {
    if (kDebugMode) {
      print('Not start setupInteractedMessage');
      return;
    }
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      try {
        // String type = initialMessage.data['type'];
        // String objectId = initialMessage.data['object_id'];
        // String objectType = initialMessage.data['object_type'];
        // NavigationUtils.handleNotificationNavigate(context, type, objectType, objectId);
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing JSON: $e');
        }
      }
    }
  }

  DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }
}

class _App extends StatefulWidget {
  final AppRouter router;

  const _App(this.router);

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  late final connectivityService = ConnectivityService.instance;
  late final t = Translations.of(context);

  @override
  void initState() {
    super.initState();
    connectivityService.initialise();
    connectivityService.myStream.listen((isConnected) {
      context.read<ConnectivityBloc>().onConnectivityStatusChange(isConnected);
    });
  }

  @override
  void dispose() {
    connectivityService.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SnackBarUtils.init(lemonadeAppDarkThemeData.colorScheme);
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (prev, cur) => prev != cur,
      listener: (context, state) {
        state.maybeWhen(
          connected: () => SnackBarUtils.showSuccessSnackbar(
            t.common.internetConnectionStatus.connected,
          ),
          notConnected: () => SnackBarUtils.showError(
            message: t.common.internetConnectionStatus.disconnected,
          ),
          orElse: () {},
        );
      },
      child: Web3ModalTheme(
        isDarkMode: true,
        child: StyledToast(
          locale: const Locale('en', 'US'),
          toastPositions: StyledToastPosition.top,
          toastAnimation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.fade,
          curve: Curves.linearToEaseOut,
          reverseCurve: Curves.linearToEaseOut,
          duration: const Duration(seconds: 4),
          animDuration: const Duration(milliseconds: 800),
          dismissOtherOnShow: true,
          fullWidth: false,
          isHideKeyboard: false,
          isIgnoring: true,
          child: MaterialApp.router(
            scaffoldMessengerKey: SnackBarUtils.rootScaffoldMessengerKey,
            locale: _getCurrentLocale(context),
            // use provider
            supportedLocales: _supportedLocales,
            localizationsDelegates: _localizationsDelegates,
            themeMode: ThemeMode.dark,
            darkTheme: lemonadeAppDarkThemeData,
            theme: lemonadeAppLightThemeData,
            routerDelegate: widget.router.delegate(
              navigatorObservers: () => <NavigatorObserver>[MyRouterObserver()],
            ),
            routeInformationParser:
                widget.router.defaultRouteParser(includePrefixMatches: true),
            builder: (context, widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomError(errorDetails: errorDetails);
              };
              return FlutterEasyLoading(child: widget);
            },
          ),
        ),
      ),
    );
  }

  get _supportedLocales => AppLocaleUtils.supportedLocales;

  get _localizationsDelegates => GlobalMaterialLocalizations.delegates;

  Locale _getCurrentLocale(BuildContext context) =>
      TranslationProvider.of(context).flutterLocale;
}

enum DeviceType { phone, tablet }
