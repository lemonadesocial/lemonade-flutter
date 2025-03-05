import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_application_page/event_join_request_application_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/view/event_join_requests_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_actions_bar.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EventPendingJoinRequestItem extends StatefulWidget {
  final EventJoinRequest eventJoinRequest;
  final void Function()? onRefetch;

  const EventPendingJoinRequestItem({
    super.key,
    required this.eventJoinRequest,
    this.onRefetch,
  });

  @override
  State<EventPendingJoinRequestItem> createState() =>
      _EventPendingJoinRequestItemState();
}

class _EventPendingJoinRequestItemState
    extends State<EventPendingJoinRequestItem> {
  bool get isPending => widget.eventJoinRequest.isPending;

  Future<void> _modifyJoinRequest({
    required eventId,
    required EventJoinRequest joinRequest,
    required ModifyJoinRequestAction action,
  }) async {
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        if (action == ModifyJoinRequestAction.approve) {
          await getIt<EventRepository>().approveUserJoinRequest(
            input: Input$DecideUserJoinRequestsInput(
              decision: Enum$EventJoinRequestState.approved,
              event: eventId,
              requests: [joinRequest.id ?? ''],
            ),
          );
        } else {
          await getIt<EventRepository>().declineUserJoinRequest(
            input: Input$DecideUserJoinRequestsInput(
              decision: Enum$EventJoinRequestState.declined,
              event: eventId,
              requests: [joinRequest.id ?? ''],
            ),
          );
        }
        context.read<GetEventDetailBloc>().add(
              GetEventDetailEvent.fetch(eventId: eventId),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final colorScheme = Theme.of(context).colorScheme;
    final eventId = event?.id ?? '';
    return InkWell(
      onTap: () {
        goToJoinRequestDetail(context, event);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.09),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(LemonRadius.medium),
                topLeft: Radius.circular(LemonRadius.medium),
              ),
            ),
            child: Row(
              children: [
                JoinRequestUserAvatar(
                  eventJoinRequest: widget.eventJoinRequest,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    openApplication(context, event);
                  },
                  child: Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(Sizing.medium),
                    ),
                    child: Center(
                      child: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icApplication.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(LemonRadius.medium),
                bottomRight: Radius.circular(LemonRadius.medium),
              ),
            ),
            child: Row(
              children: [
                const Spacer(),
                EventJoinRequestActionsBar(
                  onPressApprove: () async {
                    await _modifyJoinRequest(
                      eventId: eventId,
                      joinRequest: widget.eventJoinRequest,
                      action: ModifyJoinRequestAction.approve,
                    );
                    widget.onRefetch?.call();
                  },
                  onPressDecline: () async {
                    await _modifyJoinRequest(
                      eventId: eventId,
                      joinRequest: widget.eventJoinRequest,
                      action: ModifyJoinRequestAction.decline,
                    );
                    widget.onRefetch?.call();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> goToJoinRequestDetail(BuildContext context, Event? event) {
    return AutoRouter.of(context).push(
      EventGuestDetailRoute(
        eventId: event?.id ?? '',
        userId: widget.eventJoinRequest.user ?? '',
        email: widget.eventJoinRequest.nonLoginUser?.email ?? '',
        onRequestActionComplete: widget.onRefetch,
      ),
    );
  }

  Future<dynamic> openApplication(BuildContext context, Event? event) {
    return showCupertinoModalBottomSheet(
      expand: true,
      useRootNavigator: true,
      backgroundColor: LemonColor.atomicBlack,
      context: context,
      builder: (context) => EventJoinRequestApplicationPage(
        eventJoinRequest: widget.eventJoinRequest,
        event: event,
        onPressApprove: () async {
          await _modifyJoinRequest(
            eventId: event?.id,
            joinRequest: widget.eventJoinRequest,
            action: ModifyJoinRequestAction.approve,
          );
          Navigator.of(context, rootNavigator: true).pop();
          widget.onRefetch?.call();
        },
        onPressDecline: () async {
          await _modifyJoinRequest(
            eventId: event?.id,
            joinRequest: widget.eventJoinRequest,
            action: ModifyJoinRequestAction.decline,
          );
          Navigator.of(context, rootNavigator: true).pop();
          widget.onRefetch?.call();
        },
      ),
    );
  }
}
