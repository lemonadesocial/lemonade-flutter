import 'package:another_flushbar/flushbar.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> _rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class SnackBarUtils {
  static ColorScheme? _colorScheme;
  static BuildContext? _context;

  static GlobalKey<ScaffoldMessengerState> get rootScaffoldMessengerKey =>
      _rootScaffoldMessengerKey;

  static init({
    required ColorScheme colorScheme,
    required BuildContext context,
  }) {
    _colorScheme = colorScheme;
    _context = context;
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
    Flushbar(
      duration: const Duration(seconds: 2),
      borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
      margin: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: const Color(0xffc0392b),
      messageText: Text(
        message,
        style: Typo.medium
            .copyWith(color: _colorScheme?.onPrimary ?? LemonColor.white),
      ),
    ).show(_context!);
  }

  static void showSuccessSnackbar(String message) {
    Flushbar(
      duration: const Duration(seconds: 2),
      borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
      margin: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: LemonColor.snackBarSuccess,
      messageText: Text(
        message,
        style: Typo.medium
            .copyWith(color: _colorScheme?.onPrimary ?? LemonColor.white),
      ),
    ).show(_context!);
  }
}
