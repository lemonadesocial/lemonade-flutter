import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class TicketCounter extends StatelessWidget {
  final int count;
  final Function(int newCount) onDecrease;
  final Function(int newCount) onIncrease;
  final bool disabled;

  const TicketCounter({
    super.key,
    required this.count,
    required this.onDecrease,
    required this.onIncrease,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final boxDecoration = BoxDecoration(
      color: count > 0
          ? colorScheme.onPrimary.withOpacity(0.05)
          : Colors.transparent,
      border: Border.all(
        color: count > 0
            ? colorScheme.onPrimary.withOpacity(0.005)
            : colorScheme.onPrimary.withOpacity(0.09),
        // color:  colorScheme.onPrimary.withOpacity(0.005),
      ),
      borderRadius: BorderRadius.circular(LemonRadius.xSmall),
    );
    final textColor =
        count > 0 ? colorScheme.onPrimary : colorScheme.onSurfaceVariant;

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (disabled) return;
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
                    color: textColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Container(
              width: Sizing.medium,
              height: Sizing.medium,
              decoration: boxDecoration,
              child: Center(
                child: Text(
                  "${count.toInt()}",
                  style: Typo.medium.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            InkWell(
              onTap: () {
                if (disabled) return;
                onIncrease(count + 1);
              },
              child: Container(
                width: Sizing.regular,
                height: Sizing.regular,
                decoration: boxDecoration,
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: Sizing.xSmall,
                    color: textColor,
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
