import 'package:app/core/application/event/get_event_checkins_bloc/get_event_checkins_bloc.dart';
import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/view_model/event_config_grid_view_model.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HostEventDetailConfigGrid extends StatelessWidget {
  const HostEventDetailConfigGrid({
    super.key,
    required this.event,
    // required this.eventUserRole,
  });

  final Event event;
  // final EventUserRole? eventUserRole;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    Event eventDetail = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => Event(),
          fetched: (eventDetail) => eventDetail,
        );
    final eventInvitedCount = eventDetail.invitedCount ?? 0;
    final eventTicketTypesCount = eventDetail.eventTicketTypes?.length ?? 0;
    // final canShowDashboard = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [
    //       Enum$FeatureCode.DataDashboardInsights,
    //       Enum$FeatureCode.DataDashboardRevenue,
    //       Enum$FeatureCode.DataDashboardRewards,
    //     ],
    //   ),
    // ).canShowFeature;
    // final canShowEventSettings = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [
    //       Enum$FeatureCode.EventSettings,
    //       Enum$FeatureCode.PromotionCodes,
    //       Enum$FeatureCode.TicketingSettings,
    //     ],
    //   ),
    // ).canShowFeature;
    final List<EventConfigGridViewModel?> listData = [
      // if (canShowEventSettings)
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
          AutoRouter.of(context).navigate(const EventSettingsRoute());
        },
      ),
      // if (canShowDashboard)
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
          AutoRouter.of(context).push(
            EventDashboardRoute(
              eventId: event.id ?? '',
            ),
          );
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.invite,
        subTitle: t.event.invitedCount(count: eventInvitedCount),
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icChatBubbleGradient.svg(
            width: 24.w,
            height: 24.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          if (event.matrixEventRoomId == null ||
              event.matrixEventRoomId!.isEmpty) {
            return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: colorScheme.secondary,
                  title: Text(t.common.alert),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(t.chat.roomNotExistDesc),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        t.common.actions.ok,
                        style: Typo.medium.copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
          AutoRouter.of(context).navigate(
            ChatRoute(roomId: event.matrixEventRoomId ?? ''),
          );
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
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: listData.length,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.3 / (listData.length / 4),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (listData[index]?.title == t.event.configuration.checkIn) {
            // final canUseCheckIn = FeatureManager(
            //   EventRoleBasedEventFeatureVisibilityStrategy(
            //     eventUserRole: eventUserRole,
            //     featureCodes: [Enum$FeatureCode.CheckIn],
            //   ),
            // ).canShowFeature;
            const canUseCheckIn = true;
            final eventCheckins = canUseCheckIn
                ? context.watch<GetEventCheckinsBloc>().state.maybeWhen(
                      orElse: () => [],
                      fetched: (eventCheckins) => eventCheckins,
                    )
                // ignore: dead_code
                : [];
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
            // final canUseEventCohosts = FeatureManager(
            //   UserRoleFeatureVisibilityStrategy(
            //     eventUserRole: eventUserRole,
            //     roleCodes: [
            //       Enum$RoleCode.Host,
            //       Enum$RoleCode.Cohost,
            //     ],
            //   ),
            // ).canShowFeature;
            const canUseEventCohosts = true;
            final eventCohostRequests = canUseEventCohosts
                ? context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
                      orElse: () => [],
                      fetched: (eventCohostRequests) => eventCohostRequests,
                    )
                // ignore: dead_code
                : [];
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
