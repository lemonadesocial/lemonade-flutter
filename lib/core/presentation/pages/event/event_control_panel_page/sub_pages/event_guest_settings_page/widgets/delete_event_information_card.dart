import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class DeleteEventInformationCard extends StatelessWidget {
  const DeleteEventInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: LemonColor.chineseBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) => Assets.icons.icPeopleAlt.svg(
                      colorFilter: colorFilter,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: Text(
                    t.event.cancelEvent.notifyAllGuests,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                SizedBox(
                  width: 75,
                  child: Text(
                    '54',
                    textAlign: TextAlign.right,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: colorScheme.outline,
          ),
          Container(
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) => Assets.icons.icCashVariant.svg(
                      colorFilter: colorFilter,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: Text(
                    t.event.cancelEvent.refundAmount,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                SizedBox(
                  width: 75,
                  child: Text(
                    "132",
                    textAlign: TextAlign.right,
                    style: Typo.medium.copyWith(
                      color: LemonColor.snackBarSuccess,
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
