import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_accepted_export.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_accepted_export_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/export_event_accepted.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EventAcceptedExportList extends StatelessWidget {
  final Event? event;
  const EventAcceptedExportList({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Query$ExportEventAccepted$Widget(
      options: Options$Query$ExportEventAccepted(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$ExportEventAccepted(
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

        final eventAcceptedList = (result.parsedData?.exportEventAccepted ?? [])
            .map((item) {
              return EventAcceptedExport.fromJson(
                item.toJson(),
              );
            })
            .where(
              (element) => element.assigneeEmail != null,
            )
            .toList();

        if (eventAcceptedList.isEmpty) {
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
                  itemCount: eventAcceptedList.length,
                  itemBuilder: (context, index) {
                    final eventAccepted = eventAcceptedList[index];
                    return EventAcceptedExportItem(
                      event: event,
                      eventAccepted: eventAccepted,
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
