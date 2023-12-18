import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerUtils {
  static final GlobalKey<ScaffoldState> _drawerGlobalKey =
      GlobalKey<ScaffoldState>();

  static GlobalKey<ScaffoldState> get drawerGlobalKey => _drawerGlobalKey;

  static void openDrawer(BuildContext context) {
    context.read<AuthBloc>().state.maybeWhen(
          authenticated: (session) =>
              drawerGlobalKey.currentState?.openDrawer(),
          orElse: () => AutoRouter.of(context).navigate(const LoginRoute()),
        );
  }

  static void openEndDrawer() {
    drawerGlobalKey.currentState?.openEndDrawer();
  }

  static void closeDrawer() {
    drawerGlobalKey.currentState?.closeDrawer();
  }
}
