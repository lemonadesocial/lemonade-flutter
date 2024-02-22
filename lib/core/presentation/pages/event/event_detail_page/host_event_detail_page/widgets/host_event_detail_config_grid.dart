import 'package:app/core/application/event/get_event_checkins_bloc/get_event_checkins_bloc.dart';
import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/view_model/event_config_grid_view_model.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HostEventDetailConfigGrid extends StatelessWidget {
  const HostEventDetailConfigGrid({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    Event eventDetail = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => Event(),
          fetched: (eventDetail) => eventDetail,
        );
    final eventInvitedCount = eventDetail.invitedCount ?? 0;
    final eventTicketTypesCount = eventDetail.eventTicketTypes?.length ?? 0;
    final List<EventConfigGridViewModel?> listData = [
      EventConfigGridViewModel(
        title: t.event.configuration.controlPanel,
        subTitle: t.event.configuration.controlPanelDescription,
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icSettingGradient.svg(
            width: 24.w,
            height: 24.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const EventControlPanelRoute());
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.dashboard,
        subTitle: t.event.configuration.dashboardDescription,
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icDashboardGradient.svg(
            width: 24.w,
            height: 24.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.invite,
        subTitle: t.event.invitedCount(count: eventInvitedCount),
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icUserAddGradient.svg(
            width: 24.w,
            height: 24.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.tickets,
        subTitle:
            '$eventTicketTypesCount ${t.event.ticketTypesCount(n: eventTicketTypesCount)}',
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icTicketGradient.svg(
            width: 24.w,
            height: 24.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context)
              .navigate(const EventIssueTicketsSettingRoute());
        },
      ),
    ];
    final eventCohostRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              orElse: () => [],
              fetched: (eventCohostRequests) => eventCohostRequests,
            );
    final eventCheckins = context.watch<GetEventCheckinsBloc>().state.maybeWhen(
          orElse: () => [],
          fetched: (eventCheckins) => eventCheckins,
        );
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (listData[index]?.title == t.event.configuration.checkIn) {
            return GridItemWidget(
              item: EventConfigGridViewModel(
                title: listData[index]!.title,
                subTitle: eventCheckins.isNotEmpty
                    ? '${eventCheckins.length} ${t.event.scanQR.checkedIn}'
                    : '',
                icon: listData[index]!.icon,
                onTap: () {},
              ),
              onTap: listData[index]!.onTap,
            );
          }
          if (listData[index]?.title == t.event.configuration.coHosts) {
            return GridItemWidget(
              item: EventConfigGridViewModel(
                title: listData[index]!.title,
                subTitle: eventCohostRequests.isNotEmpty
                    ? '${eventCohostRequests.length} ${t.event.cohosts.cohostsCountInfo(
                        n: eventCohostRequests.length,
                      )}'
                    : '',
                icon: listData[index]!.icon,
                onTap: () {},
              ),
              onTap: listData[index]!.onTap,
            );
          }
          return GridItemWidget(
            item: listData[index],
            onTap: listData[index]!.onTap,
          );
        },
        childCount: listData.length,
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final EventConfigGridViewModel? item;
  final Function() onTap;

  const GridItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 1, left: 1, right: 1, bottom: 6),
        decoration: ShapeDecoration(
          color: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [colorScheme.secondaryContainer, Colors.black],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              item?.icon ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
