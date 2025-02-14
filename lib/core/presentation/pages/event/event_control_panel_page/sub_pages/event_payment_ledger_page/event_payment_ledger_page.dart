import 'package:app/core/data/event/dtos/ticket_statistics_dto/ticket_statistics_dto.dart';
import 'package:app/core/data/payment/dtos/event_payment_statistics_dto/event_payment_statistics_dto.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/ticket_statistics.dart';
import 'package:app/core/domain/payment/entities/event_payment_statistics/event_payment_statistics.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_payment_ledger_page/widgets/payment_ledger_items.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_payment_ledger_page/widgets/payment_ledger_network_filter_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_payment_ledger_page/widgets/payment_ledger_ticket_filter_dropdown.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_ticket_statistics.graphql.dart';
import 'package:app/graphql/backend/payment/query/get_event_payment_statistics.graphql.dart';
import 'package:app/graphql/backend/payment/query/list_event_payments.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

@RoutePage()
class EventPaymentLedgerPage extends StatefulWidget {
  final Event? event;
  const EventPaymentLedgerPage({
    super.key,
    this.event,
  });

  @override
  State<EventPaymentLedgerPage> createState() => _EventPaymentLedgerPageState();
}

class _EventPaymentLedgerPageState extends State<EventPaymentLedgerPage> {
  final debouncer = Debouncer(milliseconds: 300);
  final searchController = TextEditingController();
  final refreshController = RefreshController();
  bool hasNextPage = true;
  int limit = 25;
  late Variables$Query$ListEventPayments _filterVariables;

  @override
  void initState() {
    super.initState();
    _filterVariables = Variables$Query$ListEventPayments(
      event: widget.event?.id ?? '',
      skip: 0,
      limit: limit,
    );
  }

  void _search(
    String searchValue, {
    Future<QueryResult<Query$ListEventPayments>> Function(FetchMoreOptions)?
        fetchMore,
    Future<QueryResult<Query$ListEventPayments>?> Function()? refetch,
  }) {
    if (searchValue.isEmpty) {
      setState(() {
        _filterVariables = _filterVariables.copyWith(
          search: null,
        );
      });
      refetch?.call();
      return;
    }

    setState(() {
      _filterVariables = _filterVariables.copyWith(
        search: searchValue,
      );
    });

    fetchMore?.call(
      FetchMoreOptions$Query$ListEventPayments(
        updateQuery: (previousResult, fetchMoreResult) {
          return fetchMoreResult;
        },
        variables: _filterVariables,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.configuration.ledger,
      ),
      body: Query$ListEventPayments$Widget(
        options: Options$Query$ListEventPayments(
          variables: _filterVariables,
          onComplete: (result, data) {
            if ((data?.listEventPayments.records ?? []).length < limit) {
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
          final payments = result.parsedData?.listEventPayments.records
                  .map(
                    (item) =>
                        Payment.fromDto(PaymentDto.fromJson(item.toJson())),
                  )
                  .toList() ??
              [];

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
                        setState(() {
                          _filterVariables = _filterVariables.copyWith(
                            skip: payments.length,
                          );
                        });

                        await fetchMore?.call(
                          FetchMoreOptions$Query$ListEventPayments(
                            updateQuery: (previousResult, fetchMoreResult) {
                              final List<dynamic> previousPayments =
                                  previousResult?['listEventPayments']
                                          ?['records'] ??
                                      [];
                              final List<dynamic> newPayments =
                                  fetchMoreResult?['listEventPayments']
                                          ?['records'] ??
                                      [];

                              fetchMoreResult?['listEventPayments']
                                  ?['records'] = [
                                ...previousPayments,
                                ...newPayments,
                              ];

                              if (newPayments.length < limit) {
                                setState(() {
                                  hasNextPage = false;
                                });
                              }
                              return fetchMoreResult;
                            },
                            variables: _filterVariables,
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
                        hintText: StringUtils.capitalize(t.common.search),
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
                      child: SizedBox(height: Spacing.xSmall),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Query$GetTicketStatistics$Widget(
                            options: Options$Query$GetTicketStatistics(
                              variables: Variables$Query$GetTicketStatistics(
                                event: widget.event?.id ?? '',
                              ),
                            ),
                            builder: (result, {fetchMore, refetch}) {
                              return PaymentLedgerTicketFilterDropdown(
                                ticketStatistics: result
                                            .parsedData?.getTicketStatistics !=
                                        null
                                    ? TicketStatistics.fromDto(
                                        TicketStatisticsDto.fromJson(
                                          result.parsedData!.getTicketStatistics
                                              .toJson(),
                                        ),
                                      )
                                    : null,
                                filterVariables: _filterVariables,
                                onChanged: (newFilterVariables) {
                                  setState(() {
                                    _filterVariables = newFilterVariables;
                                  });
                                  refetch?.call();
                                },
                              );
                            },
                          ),
                          SizedBox(width: Spacing.extraSmall),
                          Query$GetEventPaymentStatistics$Widget(
                            options: Options$Query$GetEventPaymentStatistics(
                              variables:
                                  Variables$Query$GetEventPaymentStatistics(
                                event: widget.event?.id ?? '',
                              ),
                            ),
                            builder: (result, {fetchMore, refetch}) {
                              return PaymentLedgerNetworkFilterDropdown(
                                statistics: result.parsedData
                                            ?.getEventPaymentStatistics !=
                                        null
                                    ? EventPaymentStatistics.fromDto(
                                        EventPaymentStatisticsDto.fromJson(
                                          result.parsedData!
                                              .getEventPaymentStatistics
                                              .toJson(),
                                        ),
                                      )
                                    : null,
                                filterVariables: _filterVariables,
                                onChanged: (newFilterVariables) {
                                  setState(() {
                                    _filterVariables = newFilterVariables;
                                  });
                                  refetch?.call();
                                },
                              );
                            },
                          ),
                        ],
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
                    if (payments.isEmpty && result.isLoading)
                      SliverFillRemaining(
                        child: Center(
                          child: Loading.defaultLoading(context),
                        ),
                      ),
                    if (payments.isEmpty && !result.isLoading)
                      SliverFillRemaining(
                        child: Center(
                          child: EmptyList(
                            emptyText: t.common.emptyList,
                          ),
                        ),
                      ),
                    SliverList.separated(
                      itemCount: payments.length + 1,
                      itemBuilder: (context, index) {
                        if (index == payments.length) {
                          return hasNextPage
                              ? Loading.defaultLoading(context)
                              : const SizedBox.shrink();
                        }
                        final payment = payments[index];
                        return PaymentLedgerItem(
                          payment: payment,
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
          );
        },
      ),
    );
  }
}
