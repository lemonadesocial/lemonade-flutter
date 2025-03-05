import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/data/event/dtos/event_guest_detail_dto/event_guest_detail_dto.dart';
import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/view/event_join_requests_list.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_actions_bar.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_application_questions.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_payment_info_widget.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_timeline_info_widget.dart';
import 'package:app/core/presentation/pages/event/event_guest_detail_page/widgets/event_guest_detail_user_info_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_guest_detail.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventGuestDetailPage extends StatefulWidget {
  final String eventId;
  final String userId;
  final String email;
  final VoidCallback? onRequestActionComplete;

  const EventGuestDetailPage({
    super.key,
    required this.eventId,
    required this.userId,
    required this.email,
    this.onRequestActionComplete,
  });

  @override
  State<EventGuestDetailPage> createState() => _EventGuestDetailPageState();
}

class _EventGuestDetailPageState extends State<EventGuestDetailPage> {
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
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.eventGuestDetail.eventGuestDetail,
      ),
      body: Query$GetEventGuestDetail$Widget(
        options: Options$Query$GetEventGuestDetail(
          variables: Variables$Query$GetEventGuestDetail(
            event: widget.eventId,
            user: widget.userId.isNotEmpty ? widget.userId : null,
            email: widget.email,
          ),
        ),
        builder: (
          result, {
          refetch,
          fetchMore,
        }) {
          if (result.isLoading) {
            return Center(
              child: Loading.defaultLoading(context),
            );
          }

          final applications =
              result.parsedData?.getEventGuestDetail?.application;
          final eventGuestDetail = EventGuestDetail.fromDto(
            EventGuestDetailDto.fromJson(
              result.parsedData!.getEventGuestDetail!.toJson(),
            ),
          );

          final sections = [
            (
              widget: EventGuestDetailUserInfoWidget(
                eventGuestDetail: eventGuestDetail,
              ),
              isVisible: true, // Always visible
            ),
            (
              widget: EventGuestDetailPaymentInfoWidget(
                eventGuestDetail: eventGuestDetail,
              ),
              isVisible: eventGuestDetail.payment != null,
            ),
            (
              widget: EventGuestDetailApplicationQuestionsWidget(
                eventGuestDetail: eventGuestDetail,
              ),
              isVisible: applications?.any(
                    (app) =>
                        app.answers != null &&
                        app.answers!.any((answer) => answer.isNotEmpty),
                  ) ??
                  false,
            ),
            (
              widget: EventGuestDetailTimelineInfoWidget(
                eventGuestDetail: eventGuestDetail,
              ),
              isVisible: eventGuestDetail.joinRequest != null,
            ),
          ];

          final widgets = <Widget>[];
          final visibleSections = sections.where((s) => s.isVisible).toList();

          for (var i = 0; i < visibleSections.length; i++) {
            widgets.add(visibleSections[i].widget);

            // Add divider if not the last section
            if (i < visibleSections.length - 1) {
              widgets.add(
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.medium),
                  child: Divider(
                    color: colorScheme.outline,
                    height: 1,
                  ),
                ),
              );
            }
          }

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: Spacing.small,
                        right: Spacing.small,
                        top: Spacing.small,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(widgets),
                      ),
                    ),
                  ],
                ),
              ),
              EventGuestDetailActionsBar(
                eventGuestDetail: eventGuestDetail,
                onPressApprove: () async {
                  await _modifyJoinRequest(
                    eventId: widget.eventId,
                    joinRequest: eventGuestDetail.joinRequest!,
                    action: ModifyJoinRequestAction.approve,
                  );
                  refetch?.call();
                  widget.onRequestActionComplete?.call();
                },
                onPressDecline: () async {
                  await _modifyJoinRequest(
                    eventId: widget.eventId,
                    joinRequest: eventGuestDetail.joinRequest!,
                    action: ModifyJoinRequestAction.decline,
                  );
                  refetch?.call();
                  widget.onRequestActionComplete?.call();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
