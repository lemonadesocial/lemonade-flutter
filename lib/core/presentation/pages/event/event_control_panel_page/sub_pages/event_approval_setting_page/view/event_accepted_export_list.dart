import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_export.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_accepted_export_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/graphql/backend/event/query/export_event_tickets.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EventAcceptedExportList extends StatefulWidget {
  final Event? event;
  const EventAcceptedExportList({
    super.key,
    this.event,
  });

  @override
  State<EventAcceptedExportList> createState() =>
      _EventAcceptedExportListState();
}

class _EventAcceptedExportListState extends State<EventAcceptedExportList> {
  final debouncer = Debouncer(milliseconds: 500);
  bool hasNextPage = true;
  int limit = 25;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Query$ExportEventTickets$Widget(
      options: Options$Query$ExportEventTickets(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$ExportEventTickets(
          id: widget.event?.id ?? '',
          pagination: Input$PaginationInput(
            limit: limit,
            skip: 0,
          ),
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        if (result.hasException) {
          return Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          );
        }
        final eventTicketExportsList =
            (result.parsedData?.exportEventTickets.tickets ?? []).map((item) {
          return EventTicketExport.fromJson(
            item.toJson(),
          );
        }).toList();

        if (eventTicketExportsList.isEmpty && result.isLoading) {
          return Loading.defaultLoading(context);
        }

        if (eventTicketExportsList.isEmpty && !result.isLoading) {
          return Center(
            child: EmptyList(
              emptyText: t.event.eventApproval.noGuestFound,
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent) {
                  debouncer.run(() async {
                    if (hasNextPage) {
                      await fetchMore?.call(
                        FetchMoreOptions$Query$ExportEventTickets(
                          updateQuery: (previousResult, fetchMoreResult) {
                            final previousTickets =
                                previousResult?['exportEventTickets']
                                        ['tickets'] ??
                                    [];
                            final newTickets =
                                fetchMoreResult?['exportEventTickets']
                                        ?['tickets'] ??
                                    [];
                            fetchMoreResult?['exportEventTickets']
                                ['tickets'] = [
                              ...previousTickets,
                              ...newTickets,
                            ];
                            if (newTickets.length < limit) {
                              setState(() {
                                hasNextPage = false;
                              });
                            }
                            return fetchMoreResult;
                          },
                          variables: Variables$Query$ExportEventTickets(
                            id: widget.event?.id ?? '',
                            pagination: Input$PaginationInput(
                              limit: limit,
                              skip: eventTicketExportsList.length,
                            ),
                          ),
                        ),
                      );
                    }
                  });
                }
              }
              return true;
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.smMedium),
                ),
                SliverList.separated(
                  itemCount: eventTicketExportsList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == eventTicketExportsList.length) {
                      return hasNextPage
                          ? Loading.defaultLoading(context)
                          : const SizedBox.shrink();
                    }
                    final eventAccepted = eventTicketExportsList[index];
                    return EventAcceptedExportItem(
                      event: widget.event,
                      eventAccepted: eventAccepted,
                      refetch: () => refetch?.call(),
                      onTapCancelTicket: (ticketId) async {
                        await showFutureLoadingDialog(
                          context: context,
                          future: () {
                            return getIt<EventTicketRepository>().cancelTickets(
                              eventId: widget.event?.id ?? '',
                              ticketIds: [ticketId],
                            );
                          },
                        );
                        if (refetch != null) refetch();
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: Spacing.xSmall,
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
