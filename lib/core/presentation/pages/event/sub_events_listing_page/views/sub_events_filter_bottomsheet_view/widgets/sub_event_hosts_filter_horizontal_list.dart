import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_event_host_filter_item_widget.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventHostsFilterHorizontalList extends StatelessWidget {
  final ScrollController scrollController;
  const SubEventHostsFilterHorizontalList({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      builder: (context, state) {
        final allHosts = state.events
            .map((event) => event.hostExpanded)
            .whereType<User>()
            .toSet()
            .toList();
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [],
          body: SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BottomSheetGrabber(),
                SizedBox(
                  height: 200.w,
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      left: Spacing.xSmall,
                      right: Spacing.xSmall,
                      top: Spacing.xSmall,
                      bottom: Spacing.small,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final host = allHosts[index];
                      final selected =
                          state.selectedHosts.contains(host.userId);
                      return SubEventHostFilterItemWidget(
                        host: host,
                        selected: selected,
                        onTap: () {
                          final newSelectedHosts = selected
                              ? state.selectedHosts
                                  .where((element) => element != host.userId)
                                  .toList()
                              : [...state.selectedHosts, host.userId];
                          context.read<GetSubEventsByCalendarBloc>().add(
                                GetSubEventsByCalendarEvent.updateFilter(
                                  selectedHosts: newSelectedHosts,
                                ),
                              );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: Spacing.xSmall,
                    ),
                    itemCount: allHosts.length,
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
