import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/scaffold/success_scaffold_page/success_scaffold_page.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class ClaimTokenRewardSuccessView extends StatelessWidget {
  final VoidCallback onTapDone;
  const ClaimTokenRewardSuccessView({
    super.key,
    required this.onTapDone,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SuccessScaffoldPage(
      title: t.event.tokenReward.rewardClaimed,
      description: t.event.tokenReward.rewardClaimedDescription,
      buttonBuilder: (context) {
        return Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: colorScheme.outline,
              ),
            ),
          ),
          child: LinearGradientButton.secondaryButton(
            mode: GradientButtonMode.light,
            label: t.common.done,
            onTap: onTapDone,
          ),
        );
      },
    );
  }
}
