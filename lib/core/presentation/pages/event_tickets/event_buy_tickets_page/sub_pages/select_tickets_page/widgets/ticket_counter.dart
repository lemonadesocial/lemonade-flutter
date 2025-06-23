import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

class TicketCounter extends StatelessWidget {
  final int count;
  final Function(int newCount) onDecrease;
  final Function(int newCount) onIncrease;
  final bool disabled;
  final Function()? onPressDisabled;
  final int? limit;

  const TicketCounter({
    super.key,
    required this.count,
    required this.onDecrease,
    required this.onIncrease,
    required this.disabled,
    this.limit,
    this.onPressDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final limitReached = limit != null && count == limit!;
    final boxDecoration = BoxDecoration(
      color: appColors.buttonTertiaryBg,
      border: Border.all(
        color: appColors.pageDivider,
      ),
      borderRadius: BorderRadius.circular(Sizing.regular),
    );
    final textColor = appColors.textPrimary;
    final hasCount = count > 0;
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasCount) ...[
              InkWell(
                onTap: () {
                  if (disabled) {
                    onPressDisabled?.call();
                    return;
                  }
                  if (count == 0) return;
                  onDecrease(count - 1);
                },
                child: Container(
                  width: Sizing.regular,
                  height: Sizing.regular,
                  decoration: boxDecoration,
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: Sizing.xSmall,
                      color: appColors.textTertiary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Spacing.superExtraSmall),
                child: Text(
                  "${count.toInt()}",
                  style: appText.lg.copyWith(color: textColor),
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
            ],
            InkWell(
              onTap: () {
                if (limitReached) {
                  return;
                }
                if (disabled) {
                  onPressDisabled?.call();
                  return;
                }
                onIncrease(count + 1);
              },
              child: Opacity(
                opacity: limitReached ? 0.5 : 1,
                child: Container(
                  width: Sizing.regular,
                  height: Sizing.regular,
                  decoration: boxDecoration,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: Sizing.xSmall,
                      color: appColors.textTertiary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
