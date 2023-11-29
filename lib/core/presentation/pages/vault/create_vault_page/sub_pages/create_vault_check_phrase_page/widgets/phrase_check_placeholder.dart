import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PhraseCheckPlaceholder extends StatelessWidget {
  const PhraseCheckPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: '6',
              style: Typo.mediumPlus.copyWith(
                color: LemonColor.paleViolet,
              ),
              children: [
                WidgetSpan(
                  child: SizedBox(width: Spacing.extraSmall),
                ),
                TextSpan(
                  text: 'Hay',
                  style: Typo.mediumPlus.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.medium),
          Container(
            width: Sizing.xLarge * 2,
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(LemonRadius.small),
            ),
            child: Center(
              child: Assets.icons.icQuestionMark.svg(),
            ),
          ),
          SizedBox(width: Spacing.medium),
          RichText(
            text: TextSpan(
              text: '8',
              style: Typo.mediumPlus.copyWith(
                color: LemonColor.paleViolet,
              ),
              children: [
                WidgetSpan(
                  child: SizedBox(width: Spacing.extraSmall),
                ),
                TextSpan(
                  text: 'Beta',
                  style: Typo.mediumPlus.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
