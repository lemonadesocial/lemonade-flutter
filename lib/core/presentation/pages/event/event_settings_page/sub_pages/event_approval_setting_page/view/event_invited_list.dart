import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_guest.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_approval_setting_page/widgets/event_invited_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_invited_statistics.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class EventInvitedList extends StatelessWidget {
  final Event? event;
  final RefreshController refreshController = RefreshController();
  EventInvitedList({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Query$GetEventInvitedStatistics$Widget(
      options: Options$Query$GetEventInvitedStatistics(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$GetEventInvitedStatistics(
          id: event?.id ?? '',
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final eventInvitedList =
            (result.parsedData?.getEventInvitedStatistics.guests ?? [])
                .map((item) {
          return EventGuest.fromJson(
            item.toJson(),
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
                  if (result.isLoading && eventInvitedList.isEmpty)
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
                  if (!result.isLoading && eventInvitedList.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: EmptyList(
                          emptyText: t.event.eventApproval.noGuestFound,
                        ),
                      ),
                    ),
                  SliverList.separated(
                    itemCount: eventInvitedList.length,
                    itemBuilder: (context, index) {
                      final invitedGuest = eventInvitedList[index];
                      return EventInvitedItem(
                        guest: invitedGuest,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: Spacing.superExtraSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
