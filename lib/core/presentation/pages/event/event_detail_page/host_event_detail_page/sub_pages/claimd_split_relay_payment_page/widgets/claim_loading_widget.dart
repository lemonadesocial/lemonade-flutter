import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/animation/circular_loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

enum ClaimState {
  waiting,
  success,
  failure,
}

class ClaimLoadingWidget extends StatelessWidget {
  final Function()? onPressDone;
  final ClaimState state;
  const ClaimLoadingWidget({
    super.key,
    required this.state,
    this.onPressDone,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
      child: SafeArea(
        child: state == ClaimState.success
            ? _SuccessClaimView(
                onPressDone: onPressDone,
              )
            : const _WaitingClaimView(),
      ),
    );
  }
}

class _WaitingClaimView extends StatelessWidget {
  const _WaitingClaimView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      children: [
        const Spacer(),
        const CircularLoadingWidget(),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            children: [
              Text(
                t.event.relayPayment.claimSplit.claimSplitWaitingTitle,
                style: Typo.extraLarge.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.nohemiVariable,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Text(
                t.event.relayPayment.claimSplit.claimSplitWaitingDescription,
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.large),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(LemonRadius.button),
                color: colorScheme.outline,
                child: LemonOutlineButton(
                  radius: BorderRadius.circular(LemonRadius.button),
                  backgroundColor: colorScheme.surfaceVariant,
                  borderColor: Colors.transparent,
                  label: t.event.relayPayment.claimSplit.claimSplitWaitingTitle,
                  textStyle: Typo.medium.copyWith(
                    color: colorScheme.onSecondary.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SuccessClaimView extends StatelessWidget {
  final Function()? onPressDone;
  const _SuccessClaimView({
    this.onPressDone,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      children: [
        const Spacer(),
        const SuccessCircleAnimationWidget(),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            children: [
              Text(
                t.event.relayPayment.claimSplit.claimSplitSuccessTitle,
                style: Typo.extraLarge.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.nohemiVariable,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Text(
                t.event.relayPayment.claimSplit.claimSplitSuccessDescription,
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Spacing.large),
              LinearGradientButton.secondaryButton(
                onTap: onPressDone,
                label: t.common.done,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
