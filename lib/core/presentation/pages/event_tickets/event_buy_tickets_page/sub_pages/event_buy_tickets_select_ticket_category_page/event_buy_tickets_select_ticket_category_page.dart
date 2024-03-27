import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_select_ticket_category_page/widgets/event_buy_tickets_category_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventBuyTicketsSelectTicketCategoryPage extends StatelessWidget {
  const EventBuyTicketsSelectTicketCategoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.read<EventProviderBloc>().event;

    return Scaffold(
      appBar: const LemonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.event.eventBuyTickets.selectCategory,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "${event.title}  •  ${DateFormatUtils.dateOnly(event.start)}",
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.large),
                ],
              ),
            ),
            BlocConsumer<GetEventTicketTypesBloc, GetEventTicketTypesState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => null,
                  success: (response, currencies) {
                    final allTickets = response.ticketTypes ?? [];
                    final allCategories = allTickets
                        .where((element) => element.categoryExpanded != null)
                        .map((e) => e.categoryExpanded!)
                        .toSet()
                        .toList();
                    if (allCategories.isEmpty || allCategories.length == 1) {
                      context.read<SelectEventTicketsBloc>().add(
                            SelectEventTicketsEvent.selectTicketCategory(
                              category: allCategories.isEmpty
                                  ? null
                                  : allCategories.first,
                            ),
                          );
                      context.router.replace(
                        const SelectTicketsRoute(),
                      );
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  loading: () => SliverToBoxAdapter(
                    child: Loading.defaultLoading(context),
                  ),
                  failure: () => SliverToBoxAdapter(
                    child: EmptyList(
                      emptyText: t.common.somethingWrong,
                    ),
                  ),
                  success: (ticketTypesResponse, currencies) {
                    final allTickets = ticketTypesResponse.ticketTypes ?? [];
                    final allCategories = allTickets
                        .where((element) => element.categoryExpanded != null)
                        .map((e) => e.categoryExpanded!)
                        .toSet()
                        .toList();

                    return SliverList.separated(
                      itemCount: allCategories.length + 1,
                      itemBuilder: (context, index) {
                        // group ticket types that have no categories
                        if (index == allCategories.length) {
                          return EventBuyTicketsCategoryItem(
                            ticketCategory: null,
                            allTicketTypes: allTickets,
                            onSelect: (category) {
                              context.read<SelectEventTicketsBloc>().add(
                                    SelectEventTicketsEvent
                                        .selectTicketCategory(
                                      category: category,
                                    ),
                                  );
                              context.router.push(
                                const SelectTicketsRoute(),
                              );
                            },
                          );
                        }

                        final category = allCategories[index];
                        return EventBuyTicketsCategoryItem(
                          ticketCategory: category,
                          allTicketTypes: allTickets,
                          onSelect: (category) {
                            context.read<SelectEventTicketsBloc>().add(
                                  SelectEventTicketsEvent.selectTicketCategory(
                                    category: category,
                                  ),
                                );
                            context.router.push(
                              const SelectTicketsRoute(),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.xSmall,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
