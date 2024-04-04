import 'package:app/core/presentation/widgets/common/snackbar/custom_snackbar_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

final GlobalKey<ScaffoldMessengerState> _rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class SnackBarUtils {
  static ColorScheme? _colorScheme;

  static GlobalKey<ScaffoldMessengerState> get rootScaffoldMessengerKey =>
      _rootScaffoldMessengerKey;

  static init(ColorScheme colorScheme) {
    _colorScheme = colorScheme;
  }

  static void showComingSoon() {
    showToastWidget(
      CustomSnackbar(
        colorScheme: SnackBarUtils._colorScheme,
        title: t.common.comingSoon,
        message: t.common.commingSoonDescription,
        icon: Container(
          width: Sizing.medium,
          height: Sizing.medium,
          decoration: ShapeDecoration(
            color: LemonColor.jet,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icons.icClockStar.svg(),
            ],
          ),
        ),
      ),
      isIgnoring: false,
    );
  }

  static void showCustom({
    String? title,
    String? message,
    Widget? icon,
    bool? showIconContainer,
    Color? iconContainerColor,
  }) {
    showToastWidget(
      CustomSnackbar(
        colorScheme: SnackBarUtils._colorScheme,
        title: title ?? '',
        message: message ?? '',
        icon: icon,
        showIconContainer: showIconContainer,
        iconContainerColor: iconContainerColor,
      ),
      isIgnoring: false,
    );
  }

  static void showInfo({
    String? title,
    String? message,
  }) {
    showToastWidget(
      CustomSnackbar(
        colorScheme: SnackBarUtils._colorScheme,
        title: title ?? t.common.info,
        message: message ?? '',
      ),
      isIgnoring: true,
    );
  }

  static void showSuccess({
    String? title,
    String? message,
  }) {
    showToastWidget(
      CustomSnackbar(
        colorScheme: SnackBarUtils._colorScheme,
        title: title ?? t.common.success,
        message: message ?? '',
        icon: Assets.icons.icSuccess.svg(),
      ),
      isIgnoring: false,
    );
  }

  static void showError({
    String? title,
    String? message,
  }) {
    showToastWidget(
      CustomSnackbar(
        colorScheme: SnackBarUtils._colorScheme,
        title: title ?? t.common.error.label,
        message: message ?? t.common.somethingWrong,
        icon: Assets.icons.icError.svg(),
      ),
      isIgnoring: false,
    );
  }
}
