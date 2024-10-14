import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_buy_button.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_my_event_join_request.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailRSVPStatusButton extends StatelessWidget {
  final Event event;
  const GuestEventDetailRSVPStatusButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isLoggedIn = context
        .read<AuthBloc>()
        .state
        .maybeWhen(orElse: () => false, authenticated: (_) => true);

    if (!isLoggedIn) {
      return GuestEventDetailBuyButton(
        event: event,
        refetch: null,
      );
    }

    if (event.registrationDisabled == true) {
      return const SizedBox.shrink();
    }

    return Query$GetMyEventJoinRequest$Widget(
      options: Options$Query$GetMyEventJoinRequest(
        variables: Variables$Query$GetMyEventJoinRequest(
          event: event.id ?? '',
        ),
      ),
      builder: (result, {refetch, fetchMore}) {
        Widget? button;
        if (result.isLoading) {
          return Loading.defaultLoading(context);
        }
        if (result.hasException || result.parsedData == null) {
          return const SizedBox.shrink();
        }
        final eventJoinRequest =
            result.parsedData?.getMyEventJoinRequest != null
                ? EventJoinRequest.fromDto(
                    EventJoinRequestDto.fromJson(
                      result.parsedData!.getMyEventJoinRequest!.toJson(),
                    ),
                  )
                : null;

        if (eventJoinRequest == null) {
          return GuestEventDetailBuyButton(event: event, refetch: refetch);
        }

        if (eventJoinRequest.isPending == true) {
          button = LinearGradientButton.secondaryButton(
            label: t.event.rsvpStatus.pendingApproval,
            leading: SizedBox(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
              child: CircularProgressIndicator(
                // Loading button should be black and white and are not affected by theme
                backgroundColor: LemonColor.black.withOpacity(0.36),
                color: LemonColor.white.withOpacity(0.72),
              ),
            ),
            onTap: () {
              AutoRouter.of(context).push(
                GuestEventApprovalStatusRoute(
                  event: event,
                  eventJoinRequest: eventJoinRequest,
                ),
              );
            },
          );
        }
        if (eventJoinRequest.isApproved == true) {
          button = LinearGradientButton.primaryButton(
            label: t.common.actions.continueNext,
            onTap: () {
              AutoRouter.of(context).push(
                EventBuyTicketsRoute(
                  event: event,
                ),
              );
            },
          );
        }

        if (button == null) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline,
                  width: 1.w,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Spacing.smMedium,
              horizontal: Spacing.smMedium,
            ),
            child: button,
          ),
        );
      },
    );
  }
}
