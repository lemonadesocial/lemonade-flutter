import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventConfirmedJoinRequestItem extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final void Function()? onRefetch;

  const EventConfirmedJoinRequestItem({
    super.key,
    required this.eventJoinRequest,
    this.onRefetch,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          EventGuestDetailRoute(
            eventId: event?.id ?? '',
            userId: eventJoinRequest.user ?? '',
            email: eventJoinRequest.nonLoginUser?.email ?? '',
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: appColors.cardBg,
              borderRadius: BorderRadius.circular(
                LemonRadius.extraSmall,
              ),
            ),
            child: Row(
              children: [
                JoinRequestUserAvatar(
                  eventJoinRequest: eventJoinRequest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
