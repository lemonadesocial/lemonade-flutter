import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventApplicationFormSuccessView extends StatelessWidget {
  const GuestEventApplicationFormSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Spacer(),
        SuccessCircleAnimationWidget(
          successWidget: Assets.icons.icSuccessGrey.svg(),
        ),
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
                    '${t.common.submitted}!',
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.applicationForm.updatedApplicationFormDescription,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.medium),
        Container(
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
                    AutoRouter.of(context).pop();
                    AutoRouter.of(context).navigate(
                      EventBuyTicketsRoute(event: event),
                    );
                  },
                  label: t.event.reserve,
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
