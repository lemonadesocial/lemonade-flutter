import 'package:flutter/material.dart';

class DrawerUtils {
  static GlobalKey<ScaffoldState> _drawerGlobalKey = GlobalKey<ScaffoldState>();

  static GlobalKey<ScaffoldState> get drawerGlobalKey => _drawerGlobalKey;

  static openDrawer() {
    drawerGlobalKey.currentState?.openDrawer();
  }

  static openEndDrawer() {
    drawerGlobalKey.currentState?.openEndDrawer();
  }

  static closeDrawer() {
    drawerGlobalKey.currentState?.closeDrawer();
  }
}