import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/select_event_page/widgets/select_event_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/graphql/backend/event/query/get_hosting_events.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SelectEventPage extends StatefulWidget {
  final Function(Event event)? onEventSelected;
  const SelectEventPage({
    super.key,
    this.onEventSelected,
  });

  @override
  State<SelectEventPage> createState() => _SelectEventPageState();
}

class _SelectEventPageState extends State<SelectEventPage>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  late final TabController _tabController;
  final Debouncer _debouncer = Debouncer(milliseconds: 300);
  bool attendingEventsHasNextPage = true;
  bool hostingEventsHasNextPage = true;
  bool searchedEventListVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _textController.clear();
      }
    });
    _textController.addListener(() {
      if (_textController.text.isEmpty) {
        setState(() {
          searchedEventListVisible = false;
        });
      } else {
        if (searchedEventListVisible) return;
        setState(() {
          searchedEventListVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      appBar: LemonAppBar(
        title: t.event.selectEvents,
        backgroundColor: LemonColor.atomicBlack,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.xSmall,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Sizing.medium,
                      child: TextField(
                        controller: _textController,
                        onChanged: (v) {},
                        cursorColor: colorScheme.onSecondary,
                        decoration: InputDecoration(
                          fillColor: LemonColor.chineseBlack,
                          hintStyle: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText: StringUtils.capitalize(t.common.search),
                          filled: true,
                          isDense: true,
                          enabledBorder: border,
                          focusedBorder: border,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (filter) => Assets.icons.icSearch.svg(
                                  colorFilter: filter,
                                  width: Sizing.mSmall,
                                  height: Sizing.mSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelStyle: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: Typo.medium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: [
                          Tab(text: StringUtils.capitalize(t.event.hosting)),
                          Tab(text: StringUtils.capitalize(t.event.attending)),
                        ],
                        indicatorColor: LemonColor.paleViolet,
                        dividerHeight: 0.5.w,
                        dividerColor: colorScheme.outline,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Query$GetHostingEvents$Widget(
                              options: Options$Query$GetHostingEvents(
                                variables: Variables$Query$GetHostingEvents(
                                  user: userId,
                                  limit: 20,
                                  skip: 0,
                                ),
                              ),
                              builder: (
                                result, {
                                refetch,
                                fetchMore,
                              }) {
                                final events = (result.parsedData?.events ?? [])
                                    .map(
                                      (item) => Event.fromDto(
                                        EventDto.fromJson(item.toJson()),
                                      ),
                                    )
                                    .toList();
                                return _EventList(
                                  onTap: widget.onEventSelected,
                                  events: events,
                                  loading: result.isLoading,
                                  hasNextPage: hostingEventsHasNextPage,
                                  onFetchMore: () {
                                    _debouncer.run(
                                      () {
                                        fetchMore?.call(
                                          FetchMoreOptions$Query$GetHostingEvents(
                                            variables:
                                                Variables$Query$GetHostingEvents(
                                              user: userId,
                                              limit: 20,
                                              skip: events.length,
                                            ),
                                            updateQuery: (prev, next) {
                                              final prevEvents =
                                                  prev?['events'] ?? [];
                                              final nextEvents =
                                                  (next?['events']
                                                          as List<dynamic>?) ??
                                                      [];
                                              next?['events'] = [
                                                ...prevEvents,
                                                ...nextEvents,
                                              ];
                                              if (nextEvents.isEmpty) {
                                                setState(() {
                                                  hostingEventsHasNextPage =
                                                      false;
                                                });
                                              }
                                              return next;
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            Query$GetEvents$Widget(
                              options: Options$Query$GetEvents(
                                variables: Variables$Query$GetEvents(
                                  accepted: userId,
                                  limit: 20,
                                  skip: 0,
                                ),
                              ),
                              builder: (result, {refetch, fetchMore}) {
                                final events = (result.parsedData?.events ?? [])
                                    .map(
                                      (item) => Event.fromDto(
                                        EventDto.fromJson(item.toJson()),
                                      ),
                                    )
                                    .toList();
                                return _EventList(
                                  onTap: widget.onEventSelected,
                                  events: events,
                                  loading: result.isLoading,
                                  hasNextPage: attendingEventsHasNextPage,
                                  onFetchMore: () {
                                    _debouncer.run(
                                      () {
                                        fetchMore?.call(
                                          FetchMoreOptions$Query$GetEvents(
                                            variables:
                                                Variables$Query$GetEvents(
                                              accepted: userId,
                                              limit: 20,
                                              skip: events.length,
                                            ),
                                            updateQuery: (prev, next) {
                                              final prevEvents =
                                                  prev?['events'] ?? [];
                                              final nextEvents =
                                                  (next?['events']
                                                          as List<dynamic>?) ??
                                                      [];
                                              next?['events'] = [
                                                ...prevEvents,
                                                ...nextEvents,
                                              ];
                                              if (nextEvents.isEmpty) {
                                                setState(() {
                                                  attendingEventsHasNextPage =
                                                      false;
                                                });
                                              }
                                              return next;
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (searchedEventListVisible)
                    _SearchedEventList(
                      textController: _textController,
                      onTap: widget.onEventSelected,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchedEventList extends StatefulWidget {
  final TextEditingController textController;
  final Function(Event event)? onTap;

  const _SearchedEventList({
    required this.textController,
    this.onTap,
  });

  @override
  State<_SearchedEventList> createState() => _SearchedEventListState();
}

class _SearchedEventListState extends State<_SearchedEventList> {
  final Debouncer _debouncer = Debouncer(milliseconds: 300);
  String searchedText = '';

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    widget.textController.removeListener(_onSearchChanged);
    super.dispose();
  }

  void _onSearchChanged() {
    _debouncer.run(
      () => setState(
        () {
          searchedText = widget.textController.text;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query$GetEvents$Widget(
      options: Options$Query$GetEvents(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$GetEvents(
          search: searchedText,
          limit: 20,
          skip: 0,
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final events = (result.parsedData?.events ?? [])
            .map(
              (item) => Event.fromDto(
                EventDto.fromJson(item.toJson()),
              ),
            )
            .toList();
        return Container(
          color: LemonColor.atomicBlack,
          child: _EventList(
            events: events,
            loading: result.isLoading,
            hasNextPage: false,
            onTap: widget.onTap,
          ),
        );
      },
    );
  }
}

class _EventList extends StatelessWidget {
  final List<Event> events;
  final bool hasNextPage;
  final bool loading;
  final Function()? onFetchMore;
  final Function(Event event)? onTap;

  const _EventList({
    required this.events,
    this.loading = true,
    this.hasNextPage = true,
    this.onFetchMore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            if (loading || !hasNextPage) return true;
            onFetchMore?.call();
          }
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          if (events.isEmpty && !loading)
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
              sliver: const SliverToBoxAdapter(
                child: EmptyList(),
              ),
            ),
          if (loading)
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
              sliver: SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              ),
            ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: Spacing.smMedium,
              left: Spacing.smMedium,
              right: Spacing.smMedium,
            ),
            sliver: SliverList.separated(
              itemCount: events.length + 1,
              itemBuilder: (context, index) {
                if (index == events.length) {
                  if (!hasNextPage) {
                    return const SizedBox.shrink();
                  }
                  if (events.length < 20) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.medium,
                    ),
                    child: Loading.defaultLoading(context),
                  );
                }
                return InkWell(
                  onTap: () {
                    onTap?.call(events[index]);
                  },
                  child: SelectEventItem(
                    event: events[index],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: Spacing.superExtraSmall);
              },
            ),
          ),
        ],
      ),
    );
  }
}
