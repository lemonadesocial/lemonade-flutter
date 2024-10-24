import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_join_request.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

enum ModifyJoinRequestAction {
  approve,
  decline,
}

class EventJoinRequestList extends StatefulWidget {
  final Enum$EventJoinRequestState state;
  final Event? event;
  final Widget Function({
    required EventJoinRequest eventJoinRequest,
    void Function()? refresh,
  })? itemBuilder;
  const EventJoinRequestList({
    super.key,
    required this.state,
    this.event,
    this.itemBuilder,
  });

  @override
  State<EventJoinRequestList> createState() => _EventJoinRequestListState();
}

class _EventJoinRequestListState extends State<EventJoinRequestList> {
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final eventId = widget.event?.id ?? '';
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
          final joinRequests =
              (result.parsedData?.getEventJoinRequests.records ?? [])
                  .map((item) {
            return EventJoinRequest.fromDto(
              EventJoinRequestDto.fromJson(item.toJson()),
            );
          }).toList();

          return NotificationListener(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
              ),
              child: SmartRefresher(
                controller: refreshController,
                onRefresh: () async {
                  refetch?.call();
                  refreshController.refreshCompleted();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.smMedium),
                    ),
                    if (result.isLoading && joinRequests.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Loading.defaultLoading(
                            context,
                          ),
                        ),
                      ),
                    if (result.hasException)
                      SliverFillRemaining(
                        child: Center(
                          child: EmptyList(
                            emptyText: t.common.somethingWrong,
                          ),
                        ),
                      ),
                    if (!result.isLoading && joinRequests.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: EmptyList(
                            emptyText: t.event.eventApproval.noRequestFound,
                          ),
                        ),
                      ),
                    SliverList.separated(
                      itemCount: joinRequests.length,
                      itemBuilder: (context, index) {
                        if (widget.itemBuilder != null) {
                          return widget.itemBuilder!(
                            eventJoinRequest: joinRequests[index],
                            refresh: () => refetch?.call(),
                          );
                        }

                        return EventJoinRequestItem(
                          eventJoinRequest: joinRequests[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.small,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
