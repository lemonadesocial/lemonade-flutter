import 'package:flutter/material.dart';

class DrawerUtils {
  static final GlobalKey<ScaffoldState> _drawerGlobalKey =
      GlobalKey<ScaffoldState>();

  static GlobalKey<ScaffoldState> get drawerGlobalKey => _drawerGlobalKey;

  static void openDrawer() {
    drawerGlobalKey.currentState?.openDrawer();
  }

  static void openEndDrawer() {
    drawerGlobalKey.currentState?.openEndDrawer();
  }

  static void closeDrawer() {
    drawerGlobalKey.currentState?.closeDrawer();
  }
}
