import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';

class LemonadeApp extends StatelessWidget {
  LemonadeApp({super.key});

  final _appRouter = AppRouter();

  Widget _translationProviderBuilder(Widget child) => TranslationProvider(child: child);

  Widget _portalBuilder(Widget child) => Portal(child: child);

  @override
  Widget build(BuildContext context) {
    return _translationProviderBuilder(
      _portalBuilder(
        _App(_appRouter),
      ),
    );
  }
}

class _App extends StatelessWidget {
  final AppRouter router;
  const _App(this.router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
