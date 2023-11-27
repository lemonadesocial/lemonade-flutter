import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> _rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class SnackBarUtils {
  static ColorScheme? _colorScheme;

  static GlobalKey<ScaffoldMessengerState> get rootScaffoldMessengerKey =>
      _rootScaffoldMessengerKey;

  static init(ColorScheme colorScheme) {
    _colorScheme = colorScheme;
  }

  static void showCustomSnackbar(SnackBar snackbar) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  static void showSnackbar(String message, {Color? backgroundColor}) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Typo.medium
              .copyWith(color: _colorScheme?.onPrimary ?? LemonColor.white),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            backgroundColor ?? _colorScheme?.primary ?? LemonColor.black,
      ),
    );
  }

  static void showErrorSnackbar(String message) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Typo.medium
              .copyWith(color: _colorScheme?.onPrimary ?? LemonColor.white),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffc0392b),
      ),
    );
  }

  static void showSuccessSnackbar(String message) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Typo.medium
              .copyWith(color: _colorScheme?.onPrimary ?? LemonColor.white),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: LemonColor.snackBarSuccess,
      ),
    );
  }
}
