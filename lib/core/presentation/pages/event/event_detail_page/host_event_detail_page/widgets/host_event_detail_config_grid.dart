import 'package:app/core/application/event/event_detail_cohosts_bloc/event_detail_cohosts_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/view_model/event_config_grid_view_model.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
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
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final List<EventConfigGridViewModel?> listData = [
      EventConfigGridViewModel(
        title: t.event.configuration.invite,
        subTitle: '12/48 confirmed',
        showProgressBar: true,
        progressBarColors: [
          const Color(0xFFBCF9CE),
          const Color(0xFF68F28F),
        ],
        icon: Container(
          width: 24.w,
          height: 24.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.icUsersAdd.provider(),
            ),
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.tickets,
        subTitle: '4 ticket types \n\$12.9K total sales',
        icon: Container(
          width: 24.w,
          height: 24.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.icTicketGradient.provider(),
            ),
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.checkIn,
        subTitle: '1.2k checked in',
        showProgressBar: true,
        progressBarColors: [const Color(0xFFF9D3BC), const Color(0xFFF29A68)],
        icon: Container(
          width: 24.w,
          height: 24.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.icCheckInGradient.provider(),
            ),
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.coHosts,
        subTitle: '',
        icon: Container(
          width: 24.w,
          height: 24.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.icHostGradient.provider(),
            ),
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          // AutoRouter.of(context).navigate(const EventCohostsRoute());
          context.read<EventDetailCohostsBloc>().add(
                EventDetailCohostsEvent.fetch(
                  eventId: event.id ?? '',
                ),
              );
        },
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.controlPanel,
        subTitle: t.event.configuration.controlPanelDescription,
        icon: Container(
          width: 24.w,
          height: 24.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.icSettingsGradient.provider(),
            ),
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
        icon: Container(
          width: 24.w,
          height: 24.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.icDashboardGradient.provider(),
            ),
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
    ];
    final eventCohostRequests =
        context.watch<EventDetailCohostsBloc>().state.maybeWhen(
              orElse: () => [],
              fetched: (eventCohostRequests) => eventCohostRequests,
            );
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.95,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (listData[index]?.title == t.event.configuration.coHosts) {
            return GridItemWidget(
              item: EventConfigGridViewModel(
                title: listData[index]!.title,
                subTitle: eventCohostRequests.isNotEmpty
                    ? t.event.cohosts.cohostInfo(
                        cohostsCount: eventCohostRequests.length,
                      )
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
        childCount: 6,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item?.icon ?? const SizedBox(),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        item?.title ?? '',
                        style: Typo.small.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    item!.showProgressBar == true
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Container(
                              width: 79,
                              height: 2,
                              decoration: ShapeDecoration(
                                color: colorScheme.outline,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: -0,
                                    top: 0,
                                    child: Container(
                                      width: 57,
                                      height: 2,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: const Alignment(1.00, 0.00),
                                          end: const Alignment(-1, 0),
                                          colors: item?.progressBarColors ?? [],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: 2.h),
                    SizedBox(
                      child: Text(
                        item?.subTitle ?? '',
                        style: Typo.xSmall.copyWith(
                          fontSize: 9,
                          color: colorScheme.onSecondary,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
