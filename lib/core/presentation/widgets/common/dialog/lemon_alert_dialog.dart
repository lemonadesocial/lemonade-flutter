import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class LemonAlertDialog extends StatelessWidget {
  final Widget child;
  final String? buttonLabel;

  const LemonAlertDialog({
    super.key,
    required this.child,
    this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Dialog(
      backgroundColor: LemonColor.atomicBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        padding: EdgeInsets.all(Spacing.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            SizedBox(height: Spacing.small),
            LinearGradientButton(
              onTap: () => Navigator.of(context).pop(),
              label: buttonLabel ?? t.common.actions.dismiss,
              mode: GradientButtonMode.lavenderMode,
            )
          ],
        ),
      ),
    );
  }
}
