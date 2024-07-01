import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showAlert({
    required BuildContext context,
    String? title,
    String? message,
    String? confirmText = 'OK',
    Function()? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              child: Text(confirmText ?? "Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) {
                  onConfirm();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static void showConfirmDialog(
    BuildContext context, {
    required String message,
    required VoidCallback onConfirm,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: LemonColor.chineseBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Container(
            padding: EdgeInsets.all(Spacing.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Spacing.small),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: LinearGradientButton(
                        onTap: () => Navigator.of(context).pop(),
                        label: t.common.actions.cancel,
                        mode: GradientButtonMode.defaultMode,
                      ),
                    ),
                    SizedBox(width: Spacing.medium),
                    Expanded(
                      flex: 1,
                      child: LinearGradientButton(
                        onTap: onConfirm,
                        label: t.common.actions.ok,
                        mode: GradientButtonMode.lavenderMode,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
