import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_tags.graphql.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubEventTagsFilterList extends StatelessWidget {
  const SubEventTagsFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      buildWhen: (previous, current) =>
          previous.selectedTags != current.selectedTags,
      builder: (context, state) => Query$GetEventTags$Widget(
        options: Options$Query$GetEventTags(),
        builder: (
          result, {
          refetch,
          fetchMore,
        }) {
          final tags = result.parsedData?.getEventTags ?? [];
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.xSmall,
                  horizontal: Spacing.small,
                ),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  mainAxisSpacing: Spacing.xSmall,
                  crossAxisSpacing: Spacing.xSmall,
                  children: tags.map((item) {
                    final selected = state.selectedTags.contains(item);
                    return _TagFilterItem(
                      tag: item,
                      selected: selected,
                      onTap: () {
                        final newSelectedTags = selected
                            ? state.selectedTags
                                .where((element) => element != item)
                                .toList()
                            : [...state.selectedTags, item];
                        context.read<GetSubEventsByCalendarBloc>().add(
                              GetSubEventsByCalendarEvent.updateFilter(
                                selectedTags: newSelectedTags,
                              ),
                            );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TagFilterItem extends StatelessWidget {
  final String tag;
  final bool selected;
  final Function()? onTap;

  const _TagFilterItem({
    required this.tag,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          border: Border.all(
            color: selected ? colorScheme.onPrimary : colorScheme.onSecondary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tag),
            if (selected) Assets.icons.icChecked.svg(),
          ],
        ),
      ),
    );
  }
}
