import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_ticket_tiers_listing_page/widgets/event_ticket_tiers_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_ticket_tiers_listing_page/widgets/payout_accounts_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/event/query/list_event_ticket_types.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class EventTicketTiersListingPage extends StatelessWidget {
  const EventTicketTiersListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: StringUtils.capitalize(
          t.event.tickets(n: 2),
        ),
      ),
      body: Query$ListEventTicketTypes$Widget(
        options: Options$Query$ListEventTicketTypes(
          variables: Variables$Query$ListEventTicketTypes(
            event: event?.id ?? '',
          ),
          fetchPolicy: FetchPolicy.networkOnly,
          onComplete: (data, parsedData) {
            if (event != null) {
              final ticketTypes = parsedData?.listEventTicketTypes.map((item) {
                    return EventTicketType.fromDto(
                      EventTicketTypeDto.fromJson(
                        item.toJson(),
                      ),
                    );
                  }).toList() ??
                  [];
              context.read<GetEventDetailBloc>().add(
                    GetEventDetailEvent.replace(
                      event: event.copyWith(
                        eventTicketTypes: ticketTypes,
                      ),
                    ),
                  );
            }
          },
        ),
        builder: (result, {refetch, fetchMore}) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                ),
                child: CustomScrollView(
                  slivers: [
                    if (event != null)
                      Builder(
                        builder: (context) {
                          if (result.isLoading) {
                            return SliverToBoxAdapter(
                              child: Loading.defaultLoading(context),
                            );
                          }
                          if (result.hasException ||
                              result.parsedData == null) {
                            return const SliverToBoxAdapter(
                              child: EmptyList(),
                            );
                          }
                          final ticketTypes = result
                                  .parsedData?.listEventTicketTypes
                                  .map((item) {
                                return EventTicketType.fromDto(
                                  EventTicketTypeDto.fromJson(
                                    item.toJson(),
                                  ),
                                );
                              }).toList() ??
                              [];
                          return EventTicketTiersList(
                            event: event,
                            onRefreshTicketTiersList: () => refetch?.call(),
                            ticketTypes: ticketTypes,
                          );
                        },
                      ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.smMedium,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: PayoutAccountsWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.xLarge * 3),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: colorScheme.background,
                  padding: EdgeInsets.all(Spacing.smMedium),
                  child: SafeArea(
                    child: LinearGradientButton.secondaryButton(
                      onTap: () {
                        AutoRouter.of(context).navigate(
                          EventCreateTicketTierRoute(
                            onRefresh: refetch,
                          ),
                        );
                      },
                      label: t.event.ticketTierSetting.newTicket,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
