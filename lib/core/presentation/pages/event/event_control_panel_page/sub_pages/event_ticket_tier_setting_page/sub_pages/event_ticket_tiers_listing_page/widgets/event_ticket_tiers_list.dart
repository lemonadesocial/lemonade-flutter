import 'package:app/core/data/event/dtos/event_ticket_category_dto/event_ticket_category_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_ticket_tiers_listing_page/widgets/ticket_tier_item.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/graphql/backend/event/query/get_event_ticket_categories.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EventTicketTiersList extends StatefulWidget {
  final Function() onRefreshTicketTiersList;
  final Event event;
  final List<EventTicketType> ticketTypes;

  const EventTicketTiersList({
    super.key,
    required this.onRefreshTicketTiersList,
    required this.event,
    required this.ticketTypes,
  });

  @override
  State<EventTicketTiersList> createState() => _EventTicketTiersListState();
}

class _EventTicketTiersListState extends State<EventTicketTiersList> {
  final AutoScrollController scrollController = AutoScrollController();
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Query$GetEventTicketCategories$Widget(
      options: Options$Query$GetEventTicketCategories(
        variables: Variables$Query$GetEventTicketCategories(
          event: widget.event.id ?? '',
        ),
      ),
      builder: (result, {refetch, fetchMore}) {
        final ticketCategories =
            List.from(result.parsedData?.getEventTicketCategories ?? [])
                .map(
                  (item) => EventTicketCategory.fromDto(
                    EventTicketCategoryDto.fromJson(item.toJson()),
                  ),
                )
                .toList();

        final filteredTicketTypes = widget.ticketTypes
            .where(
              (element) => selectedCategory != null
                  ? element.category?.id == selectedCategory
                  : true,
            )
            .toList();

        return MultiSliver(
          children: [
            if (ticketCategories.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Sizing.medium,
                  child: ListView.separated(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: ticketCategories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final isActive = selectedCategory == null;
                        return AutoScrollTag(
                          index: index,
                          key: const ValueKey('all'),
                          controller: scrollController,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LemonOutlineButton(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = null;
                                  });
                                  scrollController.scrollToIndex(
                                    index,
                                    preferPosition: AutoScrollPosition.middle,
                                  );
                                },
                                radius:
                                    BorderRadius.circular(LemonRadius.normal),
                                label: t.common.all,
                                textColor:
                                    isActive ? colorScheme.onPrimary : null,
                                backgroundColor: isActive
                                    ? colorScheme.onPrimary.withOpacity(0.09)
                                    : null,
                                borderColor:
                                    isActive ? Colors.transparent : null,
                              ),
                            ],
                          ),
                        );
                      }
                      final category = ticketCategories[index - 1];
                      final isActive = category.id == selectedCategory;
                      return AutoScrollTag(
                        index: index,
                        key: ValueKey(category.id ?? ''),
                        controller: scrollController,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LemonOutlineButton(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category.id;
                                });
                                scrollController.scrollToIndex(
                                  index,
                                  preferPosition: AutoScrollPosition.middle,
                                );
                              },
                              radius: BorderRadius.circular(LemonRadius.normal),
                              label: category.title,
                              textColor:
                                  isActive ? colorScheme.onPrimary : null,
                              backgroundColor: isActive
                                  ? colorScheme.onPrimary.withOpacity(0.09)
                                  : null,
                              borderColor: isActive ? Colors.transparent : null,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: Spacing.extraSmall),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.medium),
              ),
            ],
            if (filteredTicketTypes.isEmpty)
              SliverToBoxAdapter(
                child: EmptyList(
                  emptyText: t.event.ticketTierSetting.emptyTicketTypes,
                ),
              ),
            if (filteredTicketTypes.isNotEmpty)
              SliverList.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: Spacing.xSmall),
                itemBuilder: (context, index) => TicketTierItem(
                  isFirst: index == 0,
                  isLast: index == filteredTicketTypes.length - 1,
                  onRefresh: () async {
                    await widget.onRefreshTicketTiersList.call();
                  },
                  eventTicketType: filteredTicketTypes[index],
                ),
                itemCount: filteredTicketTypes.length,
              ),
          ],
        );
      },
    );
  }
}
