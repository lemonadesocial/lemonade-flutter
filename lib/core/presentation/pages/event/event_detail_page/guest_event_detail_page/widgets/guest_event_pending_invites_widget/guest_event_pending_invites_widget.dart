import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_pending_invites_bloc/get_event_pending_invites_bloc.dart';
import 'package:app/core/domain/event/entities/event_invite.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/decide_event_cohost_request.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventCohostRequestWidget extends StatelessWidget {
  const GuestEventCohostRequestWidget({
    super.key,
  });

  Future<void> _decideCohostRequest(
    BuildContext context, {
    required EventInvite eventInvite,
    required bool accepted,
  }) async {
    showFutureLoadingDialog(
      context: context,
      future: () async {
        await getIt<AppGQL>().client.mutate$DecideEventCohostRequest(
              Options$Mutation$DecideEventCohostRequest(
                variables: Variables$Mutation$DecideEventCohostRequest(
                  input: Input$DecideEventCohostRequestInput(
                    decision: accepted,
                    event: eventInvite.event ?? '',
                  ),
                ),
              ),
            );
        context
            .read<GetEventPendingInvitesBloc>()
            .add(const GetEventPendingInvitesEvent.fetch());
        context.read<GetEventDetailBloc>().add(
              GetEventDetailEvent.fetch(
                eventId: eventInvite.event ?? '',
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    return BlocBuilder<GetEventPendingInvitesBloc, GetEventPendingInvitesState>(
      builder: (context, state) {
        final cohostRequests = state.maybeWhen(
          orElse: () => <EventInvite>[],
          fetched: (
            pendingInivitesResponse,
          ) =>
              pendingInivitesResponse.cohostRequests ?? [],
        );

        final targetCohostRequest = cohostRequests.firstWhereOrNull(
          (invite) => invite.event == event?.id,
        );

        if (targetCohostRequest == null) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PendingCohostRequestItem(
              eventInvite: targetCohostRequest,
              onDecide: (accepted) => _decideCohostRequest(
                context,
                eventInvite: targetCohostRequest,
                accepted: accepted,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PendingCohostRequestItem extends StatelessWidget {
  final EventInvite eventInvite;
  final Function(bool) onDecide;

  const PendingCohostRequestItem({
    super.key,
    required this.eventInvite,
    required this.onDecide,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final appColors = Theme.of(context).appColors;
    final appText = context.theme.appTextTheme;
    return Card(
      margin: EdgeInsets.zero,
      color: appColors.cardBg,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appColors.cardBorder,
        ),
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Padding(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icHostOutline.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.event.eventPendingInvites.pendingCohostRequestTitle,
                    style: appText.md,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    t.event.eventPendingInvites.pendingCohostRequestDescription(
                      name: eventInvite.inviterExpanded?.name ?? '',
                    ),
                    style: appText.sm.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Spacing.small),
            LinearGradientButton.tertiaryButton(
              radius: BorderRadius.circular(LemonRadius.full),
              label: t.common.actions.accept,
              onTap: () {
                onDecide(true);
              },
            ),
            SizedBox(width: Spacing.small),
            InkWell(
              onTap: () {
                onDecide(false);
              },
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icClose.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
