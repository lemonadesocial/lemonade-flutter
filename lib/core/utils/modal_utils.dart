import 'package:app/core/presentation/widgets/coming_soon_modal.dart';
import 'package:flutter/material.dart';

void showComingSoonDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return ComingSoonModal(
        onClose: () {
          Navigator.of(context).pop();
        },
      );
    },
  );
}
