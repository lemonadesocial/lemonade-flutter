import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class StateMessageItem extends StatelessWidget {
  const StateMessageItem(this.event, {super.key});
  final Event event;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.extraSmall,
        horizontal: Spacing.extraSmall,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
            vertical: Spacing.extraSmall,
          ),
          decoration: BoxDecoration(
            color: appColors.pageBg,
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
          child: FutureBuilder<String>(
            future: event.calcLocalizedBody(const MatrixDefaultLocalizations()),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ??
                    event.calcLocalizedBodyFallback(
                      const MatrixDefaultLocalizations(),
                    ),
                textAlign: TextAlign.center,
                style: appText.sm.copyWith(
                  color: appColors.textTertiary,
                  decoration:
                      event.redacted ? TextDecoration.lineThrough : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
