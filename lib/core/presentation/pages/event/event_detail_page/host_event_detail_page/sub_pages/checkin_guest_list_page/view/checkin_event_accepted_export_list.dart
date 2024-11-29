import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_export.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/checkin_guest_list_page/widgets/checkin_guest_item.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/guest_detail_bottom_sheet_view.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/export_event_tickets.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CheckinEventAcceptedExportList extends StatefulWidget {
  final Event? event;
  const CheckinEventAcceptedExportList({
    super.key,
    this.event,
  });

  @override
  State<CheckinEventAcceptedExportList> createState() =>
      _CheckinEventAcceptedExportListState();
}

class _CheckinEventAcceptedExportListState
    extends State<CheckinEventAcceptedExportList> {
  final debouncer = Debouncer(milliseconds: 300);
  final searchController = TextEditingController();
  final refreshController = RefreshController();
  bool hasNextPage = true;
  int limit = 25;

  void _search(
    String searchValue, {
    Future<QueryResult<Query$ExportEventTickets>> Function(FetchMoreOptions)?
        fetchMore,
    Future<QueryResult<Query$ExportEventTickets>?> Function()? refetch,
  }) {
    if (searchValue.isEmpty) {
      refetch?.call();
      return;
    }
    fetchMore?.call(
      FetchMoreOptions$Query$ExportEventTickets(
        updateQuery: (previousResult, fetchMoreResult) {
          return fetchMoreResult;
        },
        variables: Variables$Query$ExportEventTickets(
          id: widget.event?.id ?? '',
          searchText: searchValue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
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
        onComplete: (raw, result) {
          if ((result?.exportEventTickets.tickets ?? []).length < limit) {
            setState(() {
              hasNextPage = false;
            });
          }
        },
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final eventTicketExportsList =
            (result.parsedData?.exportEventTickets.tickets ?? []).map((item) {
          return EventTicketExport.fromJson(
            item.toJson(),
          );
        }).toList();

        return Padding(
          padding: EdgeInsets.only(
            top: Spacing.smMedium,
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
            child: SmartRefresher(
              controller: refreshController,
              onRefresh: () async {
                _search(
                  searchController.text,
                  fetchMore: fetchMore,
                  refetch: refetch,
                );
                refreshController.refreshCompleted();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: LemonTextField(
                        onChange: (value) {
                          debouncer.run(() {
                            _search(
                              value,
                              fetchMore: fetchMore,
                              refetch: refetch,
                            );
                            if (value.isEmpty) {
                              setState(() {
                                hasNextPage = true;
                              });
                            }
                          });
                        },
                        controller: searchController,
                        radius: LemonRadius.medium,
                        hintText: t.event.eventApproval.searchRegistrations,
                        placeholderStyle: Typo.medium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        leadingIcon: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ThemeSvgIcon(
                              color: colorScheme.onSecondary,
                              builder: (filter) => Assets.icons.icSearch.svg(
                                width: Sizing.mSmall,
                                height: Sizing.mSmall,
                                colorFilter: filter,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.medium),
                    ),
                    if (result.hasException)
                      SliverFillRemaining(
                        child: Center(
                          child: EmptyList(
                            emptyText: t.common.somethingWrong,
                          ),
                        ),
                      ),
                    if (eventTicketExportsList.isEmpty && result.isLoading)
                      SliverFillRemaining(
                        child: Center(
                          child: Loading.defaultLoading(context),
                        ),
                      ),
                    if (eventTicketExportsList.isEmpty && !result.isLoading)
                      SliverFillRemaining(
                        child: Center(
                          child: EmptyList(
                            emptyText: t.event.eventApproval.noGuestFound,
                          ),
                        ),
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
                        return CheckinGuestItem(
                          event: widget.event,
                          eventAccepted: eventAccepted,
                          isFirst: index == 0,
                          isLast: index == eventTicketExportsList.length - 1,
                          refetch: () {
                            _search(
                              searchController.text,
                              fetchMore: fetchMore,
                              refetch: refetch,
                            );
                          },
                          onTap: () async {
                            await showCupertinoModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              backgroundColor: LemonColor.atomicBlack,
                              builder: (context) => GuestDetailBottomSheetView(
                                shortId: eventAccepted.shortId ?? '',
                                eventId: widget.event?.id ?? '',
                              ),
                            );
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
            ),
          ),
        );
      },
    );
  }
}
