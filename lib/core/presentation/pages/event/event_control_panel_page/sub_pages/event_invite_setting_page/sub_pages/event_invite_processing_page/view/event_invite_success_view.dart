import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventInviteSuccessView extends StatelessWidget {
  const EventInviteSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Spacer(),
        const SuccessCircleAnimationWidget(),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.event.inviteEvent.inviteSuccessTitle,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.clashDisplay,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.inviteEvent.inviteSuccessDescription(
                      eventName: event?.title ?? '',
                    ),
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
                      const EventInviteSettingRoute(),
                    );
                  },
                  label: t.event.inviteEvent.inviteMore,
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
