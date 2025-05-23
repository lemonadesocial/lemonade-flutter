import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class EventIssueTicketsSuccessView extends StatelessWidget {
  const EventIssueTicketsSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Spacer(),
        const SuccessCircleAnimationWidget(),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.event.issueTickets.ticketsIssuedSuccessTitle,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.clashDisplay,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.issueTickets.ticketIssuedSuccessDescription,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.medium),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: colorScheme.outline,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            top: Spacing.smMedium,
            left: Spacing.smMedium,
            right: Spacing.smMedium,
          ),
          child: Row(
            children: [
              Expanded(
                child: LinearGradientButton.primaryButton(
                  onTap: () {
                    AutoRouter.of(context).popAndPush(
                      const EventIssueTicketsSettingRoute(),
                    );
                  },
                  label: t.event.issueTickets.assignMore,
                  textColor: colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Expanded(
                child: LinearGradientButton.secondaryButton(
                  onTap: () => AutoRouter.of(context).pop(),
                  label: t.common.done,
                  textColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
