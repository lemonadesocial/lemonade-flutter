import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class TicketSettingLockedItem extends StatelessWidget {
  final String label;
  const TicketSettingLockedItem({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (colorFilter) => Assets.icons.icLock.svg(
              colorFilter: colorFilter,
            ),
          ),
        ],
      ),
    );
  }
}
