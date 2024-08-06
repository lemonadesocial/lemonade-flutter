import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_event_host_filter_item_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubEventHostsFilterList extends StatelessWidget {
  const SubEventHostsFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      builder: (context, state) {
        final allHosts = state.events
            .map((event) => event.hostExpanded)
            .whereType<User>()
            .toSet()
            .toList();
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.small,
              ),
              sliver: SliverGrid.count(
                crossAxisCount: 4,
                childAspectRatio: 0.6,
                mainAxisSpacing: Spacing.xSmall,
                crossAxisSpacing: Spacing.xSmall,
                children: allHosts.map((item) {
                  final selected = state.selectedHosts.contains(item.userId);
                  return SubEventHostFilterItemWidget(
                    host: item,
                    selected: selected,
                    onTap: () {
                      final newSelectedHosts = selected
                          ? state.selectedHosts
                              .where((element) => element != item.userId)
                              .toList()
                          : [...state.selectedHosts, item.userId];
                      context.read<GetSubEventsByCalendarBloc>().add(
                            GetSubEventsByCalendarEvent.updateFilter(
                              selectedHosts: newSelectedHosts,
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
    );
  }
}
