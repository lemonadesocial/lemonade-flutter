import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_checkin_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_checkins.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EventCheckInsList extends StatelessWidget {
  final Event? event;
  const EventCheckInsList({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Query$GetEventCheckins$Widget(
      options: Options$Query$GetEventCheckins(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$GetEventCheckins(
          input: Input$GetEventCheckinsInput(
            event: event?.id ?? '',
          ),
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

        final eventCheckinsList =
            (result.parsedData?.getEventCheckins ?? []).map((item) {
          return EventCheckin.fromJson(
            item.toJson(),
          );
        }).toList();

        if (eventCheckinsList.isEmpty) {
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
                  itemCount: eventCheckinsList.length,
                  itemBuilder: (context, index) {
                    final eventCheckin = eventCheckinsList[index];
                    return EventCheckInItem(
                      checkIn: eventCheckin,
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
