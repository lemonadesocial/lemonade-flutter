import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_pending_invites_bloc/get_event_pending_invites_bloc.dart';
import 'package:app/core/application/event/get_event_votings_bloc/get_event_votings_bloc.dart';
import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_space_info/guest_event_detail_space_info.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_pending_invites_widget/guest_event_pending_invites_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_basic_info/guest_event_detail_basic_info.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_dashboard.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_programs.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_detail_social_lounge_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_poap_offers.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_animated_app_bar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_subevents.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_votings_list/guest_event_detail_votings_list.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_detail_virtual_link.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/create_sub_side_event_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_floating_menu_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_navigation_bar.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:collection/collection.dart';
import 'package:app/app_theme/app_theme.dart';

class PostGuestEventDetailView extends StatelessWidget {
  const PostGuestEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;

    return BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
      builder: (context, state) => state.when(
        failure: () => Scaffold(
          backgroundColor: appColors.pageBg,
          body: Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
        ),
        loading: () => Scaffold(
          backgroundColor: appColors.pageBg,
          body: Loading.defaultLoading(context),
        ),
        fetched: (event) {
          final getSubEventsBloc = context.watch<GetSubEventsByCalendarBloc>();
          final getMyTicketsBloc = context.watch<GetMyTicketsBloc>();
          final getEventVotingsListBloc =
              context.watch<GetEventVotingsListBloc>();
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
            (a, b) => (a.start ?? DateTime.now())
                .compareTo(b.start ?? DateTime.now()),
          );
          List<EventTicket>? myTickets = getMyTicketsBloc.state.maybeWhen(
            orElse: () => [],
            success: (tickets) => tickets,
          );
          final votings = [...getEventVotingsListBloc.state.eventVotings];
          votings.sort(
            (a, b) => (a.start ?? DateTime.now())
                .compareTo(b.start ?? DateTime.now()),
          );
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
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
              ),
              child: GuestEventDetailBasicInfo(event: event),
            ),
            if (pendingCohostRequest != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                ),
                child: const GuestEventCohostRequestWidget(),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
              ),
              child: GuestEventDetailDashboard(event: event),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                  ),
                  child: const PostGuestEventDetailSocialLoungeButton(),
                ),
                if (event.subeventEnabled == true) ...[
                  SizedBox(height: Spacing.small),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.smMedium,
                    ),
                    child: CreateSubSideEventButton(
                      event: event,
                    ),
                  ),
                ],
              ],
            ),
            if (EventUtils.hasPoapOffers(event))
              GuestEventPoapOffers(
                event: event,
              ),
            if (votings.isNotEmpty)
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
                child: GuestEventDetailVotingsList(
                  event: event,
                  votings: votings,
                  onRefetch: () {
                    getEventVotingsListBloc.add(
                      GetEventVotingsListEvent.fetch(
                        eventId: event.id ?? '',
                      ),
                    );
                  },
                ),
              ),
            if (event.latitude != null && event.longitude != null)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                      width: 0.5.w,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: Spacing.medium,
                  left: Spacing.smMedium,
                  right: Spacing.smMedium,
                ),
                child: PostGuestEventLocation(event: event),
              ),
            if (event.virtualUrl?.isNotEmpty == true)
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
                child: PostGuestEventDetailVirtualLink(event: event),
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
            if ((event.newNewPhotosExpanded ?? []).isNotEmpty &&
                (event.newNewPhotosExpanded ?? []).length > 1)
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
                child: GuestEventDetailPhotos(
                  event: event,
                  showTitle: false,
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
              child: BlocBuilder<GetSpaceDetailBloc, GetSpaceDetailState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
                  final space = state.maybeWhen(
                    success: (space) => space,
                    orElse: () => null,
                  );
                  return Column(
                    children: [
                      if (isLoading)
                        Loading.defaultLoading(context)
                      else if (space != null && space.personal != true) ...[
                        const GuestEventDetailSpaceInfo(),
                        SizedBox(height: Spacing.medium),
                      ],
                      GuestEventDetailHosts(event: event),
                    ],
                  );
                },
              ),
            ),
            if (event.description != null && event.description!.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                      width: 0.5.w,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: Spacing.smMedium,
                  right: Spacing.smMedium,
                  top: Spacing.medium,
                ),
                child: GuestEventDetailAbout(event: event),
              ),
          ];
          return Scaffold(
            floatingActionButton: EventDetailFloatingMenuButton(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: false,
                  barrierColor: Colors.black.withOpacity(0.5),
                  backgroundColor: LemonColor.atomicBlack,
                  topRadius: Radius.circular(LemonRadius.normal),
                  useRootNavigator: true,
                  builder: (context) {
                    return EventDetailNavigationBar(
                      event: event,
                      myTickets: myTickets,
                    );
                  },
                );
              },
            ),
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: PostGuestEventAnimatedAppBar(
                          event: event,
                        ),
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
                        child: SizedBox(height: Spacing.xLarge * 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
