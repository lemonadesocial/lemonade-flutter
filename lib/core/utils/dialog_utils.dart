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
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              child: Text(confirmText ?? 'Ok'),
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
}