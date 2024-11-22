import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_appbar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_general_info.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_programs.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_subevents.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_more_actions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage<(EventActionType?, Event?)>()
class EventPreviewPage extends StatelessWidget {
  final String eventId;
  final Widget Function(BuildContext context, Event event)? buttonBuilder;
  const EventPreviewPage({
    super.key,
    @PathParam('id') required this.eventId,
    this.buttonBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetEventDetailBloc()
            ..add(
              GetEventDetailEvent.fetch(
                eventId: eventId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetSubEventsByCalendarBloc(
            parentEventId: eventId,
          ),
        ),
      ],
      child: _EventPreviewView(
        buttonBuilder: buttonBuilder,
      ),
    );
  }
}

class _EventPreviewView extends StatefulWidget {
  final Widget Function(BuildContext context, Event event)? buttonBuilder;
  const _EventPreviewView({
    this.buttonBuilder,
  });

  @override
  State<_EventPreviewView> createState() => _EventPreviewViewState();
}

class _EventPreviewViewState extends State<_EventPreviewView> {
  late final ScrollController _scrollController = ScrollController();
  final reportBloc = ReportBloc();

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final getSubEventsBloc = context.watch<GetSubEventsByCalendarBloc>();
    final subEvents = [...getSubEventsBloc.state.events]
        .where(
          (e) => e.start != null
              ? e.start!.isAfter(
                  DateTime.now(),
                )
              : true,
        )
        .toList();
    subEvents.sort(
      (a, b) => a.start!.compareTo(b.start!),
    );
    return BlocConsumer<GetEventDetailBloc, GetEventDetailState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          fetched: (event) {
            context.read<GetSubEventsByCalendarBloc>().add(
                  GetSubEventsByCalendarEvent.fetch(),
                );
          },
        );
      },
      builder: (context, state) => state.when(
        failure: () => Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: const LemonAppBar(),
          body: Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
        ),
        loading: () => Scaffold(
          appBar: const LemonAppBar(),
          backgroundColor: colorScheme.primary,
          body: Center(
            child: Loading.defaultLoading(context),
          ),
        ),
        fetched: (event) {
          return Scaffold(
            backgroundColor: colorScheme.primary,
            body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
              builder: (context, state) => state.when(
                failure: () => Center(
                  child: EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                ),
                loading: () => Loading.defaultLoading(context),
                fetched: (event) {
                  final coverPhoto =
                      EventUtils.getEventThumbnailUrl(event: event);
                  final widgets = [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      child: GuestEventDetailGeneralInfo(
                        event: event,
                      ),
                    ),
                    if ((event.newNewPhotosExpanded ?? []).isNotEmpty &&
                        (event.newNewPhotosExpanded ?? []).length > 1)
                      GuestEventDetailPhotos(
                        event: event,
                        showTitle: false,
                      ),
                    if (event.sessions?.isNotEmpty == true)
                      Container(
                        padding: EdgeInsets.only(
                          top: Spacing.medium,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: colorScheme.outline,
                              width: 0.5.w,
                            ),
                          ),
                        ),
                        child: GuestEventDetailPrograms(event: event),
                      ),
                    if (event.subeventParent == null &&
                        subEvents.isNotEmpty == true)
                      Container(
                        padding: EdgeInsets.only(
                          top: Spacing.medium,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: colorScheme.outline,
                              width: 0.5.w,
                            ),
                          ),
                        ),
                        child: GuestEventDetailSubEvents(
                          event: event,
                          subEvents: subEvents,
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.only(
                        top: Spacing.medium,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: colorScheme.outline,
                            width: 0.5.w,
                          ),
                        ),
                      ),
                      child: GuestEventDetailHosts(event: event),
                    ),
                  ];
                  return SafeArea(
                    top: false,
                    child: Stack(
                      children: [
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          slivers: [
                            GuestEventDetailAppBar(
                              scrollController: _scrollController,
                              event: event,
                            ),
                            if (coverPhoto.isNotEmpty)
                              SliverPadding(
                                padding: EdgeInsets.only(top: Spacing.large),
                              ),
                            SliverList.separated(
                              itemCount: widgets.length,
                              itemBuilder: (context, index) {
                                return widgets[index];
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: Spacing.medium,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(height: 100.w),
                            ),
                          ],
                        ),
                        if (coverPhoto.isNotEmpty)
                          SafeArea(
                            child: _FloatingButtonsBar(
                              scrollController: _scrollController,
                              event: event,
                            ),
                          ),
                        if (widget.buttonBuilder != null)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.only(
                                left: Spacing.small,
                                right: Spacing.small,
                                top: Spacing.smMedium,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.background,
                                border: Border(
                                  top: BorderSide(
                                    color: colorScheme.outline,
                                    width: 1.w,
                                  ),
                                ),
                              ),
                              child: SafeArea(
                                top: false,
                                child:
                                    widget.buttonBuilder!.call(context, event),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FloatingButtonsBar extends StatefulWidget {
  final Event event;
  final ScrollController scrollController;

  const _FloatingButtonsBar({
    required this.event,
    required this.scrollController,
  });

  @override
  State<_FloatingButtonsBar> createState() => _FloatingButtonsBarState();
}

class _FloatingButtonsBarState extends State<_FloatingButtonsBar> {
  bool _isSliverAppBarCollapsed = false;
  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final mIsSliverAppBarCollapsed = widget.scrollController.hasClients &&
          widget.scrollController.offset > 150.w;
      if (_isSliverAppBarCollapsed == mIsSliverAppBarCollapsed) return;
      setState(() {
        _isSliverAppBarCollapsed = mIsSliverAppBarCollapsed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.extraSmall,
          vertical: Spacing.extraSmall,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlurCircle(
              child: LemonBackButton(
                color: _isSliverAppBarCollapsed
                    ? colorScheme.onSecondary
                    : colorScheme.onSecondary,
              ),
            ),
            GuestEventMoreActions(
              event: widget.event,
              isAppBarCollapsed: _isSliverAppBarCollapsed,
            ),
          ],
        ),
      ),
    );
  }
}
