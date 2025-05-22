import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ReportSubmittedPopup extends StatelessWidget {
  const ReportSubmittedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      backgroundColor: LemonColor.atomicBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          LemonRadius.normal,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(Spacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.common.submitted,
                  style: Typo.large.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.clashDisplay,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.small),
            Text(
              t.common.report.reportSuccess,
              style: Typo.medium.copyWith(color: colorScheme.onSecondary),
            ),
            SizedBox(height: Spacing.small),
            LinearGradientButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              label: t.common.actions.dismiss,
              mode: GradientButtonMode.defaultMode,
            ),
          ],
        ),
      ),
    );
  }
}
