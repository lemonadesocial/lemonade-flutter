import 'package:app/core/application/event/event_buy_tickets_prerequisite_check_bloc/event_buy_tickets_prerequisite_check_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventApplicationFormSuccessView extends StatelessWidget {
  const GuestEventApplicationFormSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocConsumer<EventBuyTicketsPrerequisiteCheckBloc,
        EventBuyTicketsPrerequisiteCheckState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => AutoRouter.of(context).pop(),
        );
      },
      builder: (context, state) {
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
                        t.event.applicationForm
                            .updatedApplicationFormDescription,
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
                      onTap: () async {
                        Event? eventDetail =
                            context.read<GetEventDetailBloc>().state.maybeWhen(
                                  fetched: (event) => event,
                                  orElse: () => null,
                                );
                        if (eventDetail != null) {
                          context
                              .read<EventBuyTicketsPrerequisiteCheckBloc>()
                              .add(
                                EventBuyTicketsPrerequisiteCheckEvent.check(
                                  event: eventDetail,
                                  userId: AuthUtils.getUserId(context),
                                ),
                              );
                        }
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
      },
    );
  }
}
