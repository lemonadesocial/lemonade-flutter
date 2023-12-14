import 'package:app/core/application/vault/create_vault_verify_seed_phrase_bloc/create_vault_verify_seed_phrase_bloc.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PhraseCheckPlaceholder extends StatelessWidget {
  final CreateVaultVerifySeedPhraseState state;
  final List<String> phrases;
  const PhraseCheckPlaceholder({
    super.key,
    required this.state,
    required this.phrases,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final correctWordIndex =
        state.data.questions[state.data.currentQuestion].wordIndex;
    final correctWordOrder = correctWordIndex + 1;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: (correctWordOrder - 1).toString(),
              style: Typo.mediumPlus.copyWith(
                color: LemonColor.paleViolet,
              ),
              children: [
                WidgetSpan(
                  child: SizedBox(width: Spacing.extraSmall),
                ),
                TextSpan(
                  text: phrases[correctWordIndex - 1],
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
              text: (correctWordOrder + 1).toString(),
              style: Typo.mediumPlus.copyWith(
                color: LemonColor.paleViolet,
              ),
              children: [
                WidgetSpan(
                  child: SizedBox(width: Spacing.extraSmall),
                ),
                TextSpan(
                  text: phrases[correctWordIndex + 1],
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
