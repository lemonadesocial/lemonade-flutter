import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_event_hosts_filter_list.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_event_tags_filter_list.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_events_filter_bottomsheet_expanded_footer.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubEventsFilterBottomsheetExpandedWidget extends StatefulWidget {
  const SubEventsFilterBottomsheetExpandedWidget({
    super.key,
  });

  @override
  State<SubEventsFilterBottomsheetExpandedWidget> createState() =>
      _SubEventsFilterBottomsheetExpandedWidgetState();
}

class _SubEventsFilterBottomsheetExpandedWidgetState
    extends State<SubEventsFilterBottomsheetExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [],
        body: Stack(
          children: [
            CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BottomSheetGrabber(),
                        LemonAppBar(
                          leading: const SizedBox.shrink(),
                          title: t.common.filters,
                          backgroundColor: LemonColor.atomicBlack,
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Spacing.xSmall,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<GetSubEventsByCalendarBloc>()
                                      .add(
                                        GetSubEventsByCalendarEvent
                                            .updateFilter(
                                          selectedHosts: [],
                                          selectedTags: [],
                                        ),
                                      );
                                },
                                icon: const Icon(Icons.refresh),
                                color: colorScheme.onPrimary,
                                iconSize: Sizing.small,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    dividerColor: colorScheme.outline,
                    onTap: (index) {},
                    labelStyle: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: Typo.medium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: LemonColor.paleViolet,
                    tabs: [
                      Tab(text: StringUtils.capitalize(t.event.hosts)),
                      Tab(text: StringUtils.capitalize(t.event.tagsType)),
                    ],
                  ),
                ),
                const SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      SubEventHostsFilterList(),
                      SubEventTagsFilterList(),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SubEventsFilterBottomsheetExpandedFooter(),
            ),
          ],
        ),
      ),
    );
  }
}
