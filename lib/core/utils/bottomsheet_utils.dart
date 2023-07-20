import 'package:flutter/material.dart';

class BottomSheetUtils {
  static showSnapBottomSheet(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: builder,
    );
  }
}
