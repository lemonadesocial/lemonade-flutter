import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_guest.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_invited_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_invited_statistics.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventInvitedList extends StatelessWidget {
  final Event? event;
  const EventInvitedList({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Query$GetEventInvitedStatistics$Widget(
      options: Options$Query$GetEventInvitedStatistics(
        variables: Variables$Query$GetEventInvitedStatistics(
          id: event?.id ?? '',
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

        final eventInvitedList =
            (result.parsedData?.getEventInvitedStatistics.guests ?? [])
                .map((item) {
          return EventGuest.fromJson(
            item.toJson(),
          );
        }).toList();

        if (eventInvitedList.isEmpty) {
          return Center(
            child: EmptyList(
              emptyText: t.event.eventApproval.noGuestFound,
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
        );
      },
    );
  }
}
