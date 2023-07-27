import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/app_limit_layout_builder_widget.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/utils/navigation_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.dart';
import 'package:app/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';

class LemonadeApp extends StatefulWidget {
  const LemonadeApp({super.key});

  @override
  State<StatefulWidget> createState() => _LemonadeAppViewState();
}


class _LemonadeAppViewState extends State<LemonadeApp> {
  final _appRouter = AppRouter();

  Widget _translationProviderBuilder(Widget child) => TranslationProvider(child: child);

  Widget _portalBuilder(Widget child) => Portal(child: child);

  Widget _globalBlocProviderBuilder(Widget child) => BlocProvider.value(
        value: getIt<AuthBloc>(),
        child: child,
      );

  Widget _limitAppLayoutBuilder(Widget child) => AppLimitLayoutBuilder(
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return _limitAppLayoutBuilder(
      _translationProviderBuilder(
        _portalBuilder(
          _globalBlocProviderBuilder(_App(_appRouter)),
        ),
      ),
    );
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      try {
          String type = initialMessage.data['type']; 
          String objectId = initialMessage.data['object_id']; 
          String objectType = initialMessage.data['object_type'];
          NavigationUtils.handleNotificationNavigate(context, type, objectType, objectId);
        } catch (e) {
          print("Error parsing JSON: $e");
        }
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FirebaseService.setContext(context);
    });
    FirebaseService().addFcmToken();
    setupInteractedMessage();
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
      routeInformationParser: router.defaultRouteParser(includePrefixMatches: true),
    );
  }

  get _supportedLocales => AppLocaleUtils.supportedLocales;

  get _localizationsDelegates => GlobalMaterialLocalizations.delegates;

  Locale _getCurrentLocale(BuildContext context) => TranslationProvider.of(context).flutterLocale;
}
