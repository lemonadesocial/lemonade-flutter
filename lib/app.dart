import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/widgets/custom_error_widget.dart';

import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/data/post/newsfeed_repository_impl.dart';
import 'package:app/core/service/newsfeed/newsfeed_service.dart';

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
          BlocProvider<NewsfeedListingBloc>(
            create: (context) => NewsfeedListingBloc(
              NewsfeedService(NewsfeedRepositoryImpl()),
            ),
          ),
        ],
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      minTextAdapt: true,
      designSize: getDeviceType() == DeviceType.phone
          ? const Size(375, 812) //Iphone X screen size, match Figma
          : const Size(1024, 1366), //Ipad Pro 12.9 inches
    );
    return _translationProviderBuilder(
      _portalBuilder(
        _globalBlocProviderBuilder(_App(_appRouter)),
      ),
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

class _App extends StatelessWidget {
  final AppRouter router;

  const _App(this.router);

  @override
  Widget build(BuildContext context) {
    SnackBarUtils.init(lemonadeAppDarkThemeData.colorScheme);

    return MaterialApp.router(
      scaffoldMessengerKey: SnackBarUtils.rootScaffoldMessengerKey,
      locale: _getCurrentLocale(context), // use provider
      supportedLocales: _supportedLocales,
      localizationsDelegates: _localizationsDelegates,
      themeMode: ThemeMode.dark,
      darkTheme: lemonadeAppDarkThemeData,
      theme: lemonadeAppLightThemeData,
      routerDelegate: router.delegate(),
      routeInformationParser:
          router.defaultRouteParser(includePrefixMatches: true),
      builder: (context, widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        return FlutterEasyLoading(child: widget);
      },
    );
  }

  get _supportedLocales => AppLocaleUtils.supportedLocales;

  get _localizationsDelegates => GlobalMaterialLocalizations.delegates;

  Locale _getCurrentLocale(BuildContext context) =>
      TranslationProvider.of(context).flutterLocale;
}

enum DeviceType { phone, tablet }
