import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final String label;
  final Widget? leading;
  final Function()? onTap;
  const OutlineButton({super.key, required this.label, this.leading, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Sizing.medium,
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.extraSmall),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(leading != null) ...[
                leading!,
                SizedBox(width: Spacing.extraSmall)
              ],
              Text(
                label,
                style: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
