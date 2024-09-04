import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingInvitesCard extends StatelessWidget {
  final int count;
  const PendingInvitesCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            width: 1,
            color: LemonColor.white12,
          ),
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSurface,
              builder: (filter) => Assets.icons.icErrorGradient.svg(),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Text(
                t.event.pendingInvite(n: count),
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            ThemeSvgIcon(
              color: colorScheme.onSurfaceVariant,
              builder: (colorFilter) => Assets.icons.icArrowRight.svg(
                colorFilter: colorFilter,
                width: 18.w,
                height: 18.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
