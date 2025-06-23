import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/presentation/widgets/token_reward/token_reward_item_widget/token_reward_item_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

class TicketTokenRewardsList extends StatelessWidget {
  final List<TokenRewardSetting> tokenRewardSettings;
  final Color? titleColor;
  final BoxDecoration? containerDecoration;
  final EdgeInsets? containerPadding;
  final Widget? itemSeparator;
  final EdgeInsets? itemPadding;

  const TicketTokenRewardsList({
    super.key,
    required this.tokenRewardSettings,
    this.titleColor,
    this.containerDecoration,
    this.containerPadding,
    this.itemSeparator,
    this.itemPadding,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.rewards,
          style: appText.md.copyWith(
            color: titleColor ?? appColors.textTertiary,
          ),
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        Container(
          decoration: containerDecoration,
          padding: containerPadding,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: itemPadding ?? EdgeInsets.zero,
              child: TokenRewardItemWidget(
                tokenRewardSetting: tokenRewardSettings[index],
              ),
            ),
            separatorBuilder: (context, index) =>
                itemSeparator ??
                SizedBox(
                  height: Spacing.small,
                ),
            itemCount: tokenRewardSettings.length,
          ),
        ),
      ],
    );
  }
}
