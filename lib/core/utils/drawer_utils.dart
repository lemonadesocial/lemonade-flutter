import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DrawerUtils {
  static final GlobalKey<ScaffoldState> _drawerGlobalKey =
      GlobalKey<ScaffoldState>();

  static GlobalKey<ScaffoldState> get drawerGlobalKey => _drawerGlobalKey;

  static void openDrawer(BuildContext context) {
    final authSession = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    if (authSession != null) {
      drawerGlobalKey.currentState?.openDrawer();
    } else {
      AutoRouter.of(context).navigate(const LoginRoute());
      return;
    }
  }

  static void openEndDrawer() {
    drawerGlobalKey.currentState?.openEndDrawer();
  }

  static void closeDrawer() {
    drawerGlobalKey.currentState?.closeDrawer();
  }
}
