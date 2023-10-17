import 'package:flutter/material.dart';

class DeviceUtils {
  static bool isIpad() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide > 550;
  }
}
