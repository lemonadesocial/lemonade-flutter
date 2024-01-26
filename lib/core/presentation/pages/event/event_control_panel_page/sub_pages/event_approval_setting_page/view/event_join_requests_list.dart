import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_actions_bar.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_join_request.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

enum ModifyJoinRequestAction {
  approve,
  decline,
}

class EventJoinRequestList extends StatefulWidget {
  final Enum$JoinRequestState state;
  const EventJoinRequestList({
    super.key,
    required this.state,
  });

  @override
  State<EventJoinRequestList> createState() => _EventJoinRequestListState();
}

class _EventJoinRequestListState extends State<EventJoinRequestList> {
  Future<void> _modifyJoinRequest({
    required eventId,
    required EventJoinRequest joinRequest,
    required ModifyJoinRequestAction action,
  }) async {
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        if (action == ModifyJoinRequestAction.approve) {
          return await getIt<EventRepository>().approveUserJoinRequest(
            input: Input$ApproveUserJoinRequestsInput(
              event: eventId,
              requests: [joinRequest.id ?? ''],
            ),
          );
        }

        return await getIt<EventRepository>().declineUserJoinRequest(
          input: Input$DeclineUserJoinRequestsInput(
            event: eventId,
            requests: [joinRequest.id ?? ''],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final eventId = context.read<GetEventDetailBloc>().state.maybeWhen(
              orElse: () => '',
              fetched: (event) => event.id,
            ) ??
        '';
    return SizedBox(
      child: Query$GetEventJoinRequests$Widget(
        options: Options$Query$GetEventJoinRequests(
          fetchPolicy: FetchPolicy.networkOnly,
          variables: Variables$Query$GetEventJoinRequests(
            event: eventId,
            limit: 100,
            skip: 0,
            state: widget.state,
          ),
        ),
        builder: (
          result, {
          refetch,
          fetchMore,
        }) {
          if (result.isLoading) {
            return Loading.defaultLoading(context);
          }

          if (result.hasException) {
            return Center(
              child: EmptyList(
                emptyText: t.common.somethingWrong,
              ),
            );
          }

          final joinRequests =
              (result.parsedData?.getEventJoinRequests ?? []).map((item) {
            return EventJoinRequest.fromDto(
              EventJoinRequestDto.fromJson(item.toJson()),
            );
          }).toList();

          if (joinRequests.isEmpty) {
            return const Center(
              child: EmptyList(
                emptyText: '',
              ),
            );
          }

          return NotificationListener(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.smMedium),
                  ),
                  SliverList.separated(
                    itemCount: joinRequests.length,
                    itemBuilder: (context, index) {
                      final joinRequest = joinRequests[index];
                      return EventJoinRequestItem(
                        eventJoinRequest: joinRequests[index],
                        actionBarBuilder: () {
                          if (widget.state == Enum$JoinRequestState.pending) {
                            return EventJoinRequestActionsBar(
                              onPressApprove: () async {
                                await _modifyJoinRequest(
                                  eventId: eventId,
                                  joinRequest: joinRequest,
                                  action: ModifyJoinRequestAction.approve,
                                );
                                refetch?.call();
                              },
                              onPressDecline: () async {
                                await _modifyJoinRequest(
                                  eventId: eventId,
                                  joinRequest: joinRequest,
                                  action: ModifyJoinRequestAction.decline,
                                );
                                refetch?.call();
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: Spacing.small,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
