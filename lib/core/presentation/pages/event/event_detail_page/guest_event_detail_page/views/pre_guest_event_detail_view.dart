import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_pending_invites_bloc/get_event_pending_invites_bloc.dart';
import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/application/token_reward/list_ticket_token_rewards_bloc/list_ticket_token_rewards_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_appbar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_general_info.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_rsvp_status/guest_event_detail_rsvp_status_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_title/guest_event_detail_title.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_token_rewards_list/guest_event_detail_token_rewards_list.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_more_actions.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_programs.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_subevents.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class PreGuestEventDetailView extends StatefulWidget {
  const PreGuestEventDetailView({super.key});

  @override
  State<PreGuestEventDetailView> createState() =>
      PreGuestEventDetailViewState();
}

class PreGuestEventDetailViewState extends State<PreGuestEventDetailView> {
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
    final userId = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => '',
        );
    final getSubEventsBloc = context.watch<GetSubEventsByCalendarBloc>();
    final getEventPendingInvitesBloc =
        context.watch<GetEventPendingInvitesBloc>();
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
    final rewardSettings =
        context.watch<ListTicketTokenRewardsBloc>().state.maybeWhen(
              orElse: () => <TokenRewardSetting>[],
              success: (rewards) => rewards,
            );

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
            final coverPhoto = EventUtils.getEventThumbnailUrl(event: event);
            final isOwnEvent =
                EventUtils.isOwnEvent(event: event, userId: userId);
            final pendingCohostRequest =
                getEventPendingInvitesBloc.state.maybeWhen(
              orElse: () => null,
              fetched: (pendingInvites) =>
                  (pendingInvites.cohostRequests ?? []).firstWhereOrNull(
                (element) => element.event == event.id,
              ),
            );
            final widgets = [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  children: [
                    GuestEventDetailTitle(event: event),
                    SizedBox(height: Spacing.medium),
                    if (rewardSettings.isNotEmpty) ...[
                      GuestEventDetailTokenRewardsList(
                        rewardSettings: rewardSettings,
                        ticketTypes: event.eventTicketTypes ?? [],
                      ),
                      SizedBox(height: Spacing.medium),
                    ],
                    GuestEventDetailGeneralInfo(
                      event: event,
                      pendingCohostRequest: pendingCohostRequest,
                    ),
                  ],
                ),
              ),
              // NOTE: requirement - Hide location in pre-rsvp
              // if (event.latitude != null && event.longitude != null)
              //   Padding(
              //     padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              //     child: GuestEventLocation(event: event),
              //   ),
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
              if (event.subeventParent == null && subEvents.isNotEmpty == true)
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
                  if (!isOwnEvent)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GuestEventDetailRSVPStatusButton(
                        event: event,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
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
